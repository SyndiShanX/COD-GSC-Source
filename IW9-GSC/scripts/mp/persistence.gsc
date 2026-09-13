/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\persistence.gsc
***********************************************/

init() {
  level.persistentdatainfo = [];
  level thread updatebufferedstats();
  level thread updatebufferedstatsatgameend();
  level thread uploadglobalstatcounters();
  level thread writekdhistorystats();
}

initbufferedstats() {
  self.bufferedstats = [];
  self.squadmemberbufferedstats = [];

  if(scripts\mp\utility\game::onlinestatsenabled()) {
    self.bufferedstats["totalShots"] = self getplayerdata(level._id_5D69837CF4DB0407, "totalShots");
    self.bufferedstats["accuracy"] = self getplayerdata(level._id_5D69837CF4DB0407, "accuracy");
    self.bufferedstats["misses"] = self getplayerdata(level._id_5D69837CF4DB0407, "misses");
    self.bufferedstats["hits"] = self getplayerdata(level._id_5D69837CF4DB0407, "hits");
  }

  self.bufferedstats["timePlayedAllies"] = self getplayerdata(level._id_5D69837CF4DB0407, "timePlayedAllies");
  self.bufferedstats["timePlayedOpfor"] = self getplayerdata(level._id_5D69837CF4DB0407, "timePlayedOpfor");
  self.bufferedstats["timePlayedOther"] = self getplayerdata(level._id_5D69837CF4DB0407, "timePlayedOther");
  self.bufferedstats["timePlayedTotal"] = self getplayerdata(level._id_5D69837CF4DB0407, "timePlayedTotal");
  self.bufferedchildstats = [];
  self.bufferedchildstats["round"] = [];
  self.bufferedchildstats["round"]["timePlayed"] = self getplayerdata("common", "round", "timePlayed");

  if(scripts\mp\utility\game::onlinestatsenabled()) {
    self.bufferedchildstats["xpMultiplierTimePlayed"] = [];
    self.bufferedchildstats["xpMultiplierTimePlayed"][0] = self getplayerdata(level._id_5D69837CF4DB0407, "xpMultiplierTimePlayed", 0);
    self.bufferedchildstats["xpMultiplierTimePlayed"][1] = self getplayerdata(level._id_5D69837CF4DB0407, "xpMultiplierTimePlayed", 1);
    self.bufferedchildstats["xpMultiplierTimePlayed"][2] = self getplayerdata(level._id_5D69837CF4DB0407, "xpMultiplierTimePlayed", 2);
    self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"] = [];
    self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][0] = self getplayerdata(level._id_5D69837CF4DB0407, "xpMaxMultiplierTimePlayed", 0);
    self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][1] = self getplayerdata(level._id_5D69837CF4DB0407, "xpMaxMultiplierTimePlayed", 1);
    self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][2] = self getplayerdata(level._id_5D69837CF4DB0407, "xpMaxMultiplierTimePlayed", 2);
    self.bufferedchildstats["challengeXPMultiplierTimePlayed"] = [];
    self.bufferedchildstats["challengeXPMultiplierTimePlayed"][0] = self getplayerdata(level._id_5D69837CF4DB0407, "challengeXPMultiplierTimePlayed", 0);
    self.bufferedchildstatsmax["challengeXPMaxMultiplierTimePlayed"] = [];
    self.bufferedchildstatsmax["challengeXPMaxMultiplierTimePlayed"][0] = self getplayerdata(level._id_5D69837CF4DB0407, "challengeXPMaxMultiplierTimePlayed", 0);
    self.bufferedchildstats["weaponXPMultiplierTimePlayed"] = [];
    self.bufferedchildstats["weaponXPMultiplierTimePlayed"][0] = self getplayerdata(level._id_5D69837CF4DB0407, "weaponXPMultiplierTimePlayed", 0);
    self.bufferedchildstatsmax["weaponXPMaxMultiplierTimePlayed"] = [];
    self.bufferedchildstatsmax["weaponXPMaxMultiplierTimePlayed"][0] = self getplayerdata(level._id_5D69837CF4DB0407, "weaponXPMaxMultiplierTimePlayed", 0);
    self.bufferedstats["prestigeDoubleWeaponXp"] = self getplayerdata(level._id_5D69837CF4DB0407, "prestigeDoubleWeaponXp");
    self.bufferedstats["prestigeDoubleWeaponXpTimePlayed"] = self getplayerdata(level._id_5D69837CF4DB0407, "prestigeDoubleWeaponXpTimePlayed");
    self.bufferedstatsmax["prestigeDoubleWeaponXpMaxTimePlayed"] = self getplayerdata(level._id_5D69837CF4DB0407, "prestigeDoubleWeaponXpMaxTimePlayed");
  }

  initbestscorestatstable();
}

initbestscorestatstable() {
  table = "mp/bestscorestatsTable.csv";
  self.bestscorestats = [];
  self.bufferedbestscorestats = [];
  _id_CB89110314447B2F = 0;

  for(;;) {
    _id_629757F5C9E770D8 = tablelookupbyrow(table, _id_CB89110314447B2F, 0);

    if(_id_629757F5C9E770D8 == "") {
      break;
    }

    self.bestscorestats[_id_629757F5C9E770D8] = self getplayerdata(level._id_5D69837CF4DB0407, "bestScores", _id_629757F5C9E770D8);
    _id_CB89110314447B2F++;
  }
}

statgetchild(parent, child) {
  if(parent == "round")
    return self getplayerdata("common", parent, child);
  else
    return self getplayerdata(level._id_5D69837CF4DB0407, parent, child);
}

statsetchild(parent, child, value, ignorekdrstats) {
  if(isagent(self)) {
    return;
  }
  if(istrue(game["practiceRound"])) {
    return;
  }
  if(isDefined(ignorekdrstats) || !scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }
  if(parent == "round") {
    self setplayerdata("common", parent, child, value);
    setbestscore(child, value);
  } else
    self setplayerdata(level._id_5D69837CF4DB0407, parent, child, value);
}

stataddchild(parent, child, value) {
  if(!scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }
  _id_23FA13A8754DF71E = self getplayerdata(level._id_5D69837CF4DB0407, parent, child);
  self setplayerdata(level._id_5D69837CF4DB0407, parent, child, _id_23FA13A8754DF71E + value);
}

statgetchildbuffered(parent, child, _id_F8048727716242B0) {
  if(!scripts\mp\utility\game::onlinestatsenabled() && !istrue(_id_F8048727716242B0))
    return 0;

  return self.bufferedchildstats[parent][child];
}

statsetchildbuffered(parent, child, value, _id_F8048727716242B0) {
  if(!scripts\mp\utility\game::onlinestatsenabled() && !istrue(_id_F8048727716242B0)) {
    return;
  }
  self.bufferedchildstats[parent][child] = value;
}

stataddchildbuffered(parent, child, value, _id_F8048727716242B0) {
  if(!scripts\mp\utility\game::onlinestatsenabled() && !istrue(_id_F8048727716242B0)) {
    return;
  }
  _id_23FA13A8754DF71E = statgetchildbuffered(parent, child, _id_F8048727716242B0);
  statsetchildbuffered(parent, child, _id_23FA13A8754DF71E + value, _id_F8048727716242B0);
}

stataddchildbufferedwithmax(parent, child, value, max) {
  if(!scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }
  _id_8F617FFD000EB682 = statgetchildbuffered(parent, child) + value;

  if(_id_8F617FFD000EB682 > max)
    _id_8F617FFD000EB682 = max;

  if(_id_8F617FFD000EB682 < statgetchildbuffered(parent, child))
    _id_8F617FFD000EB682 = max;

  statsetchildbuffered(parent, child, _id_8F617FFD000EB682);
}

updatebufferedstats() {
  wait 0.15;
  _id_B123D3720D3A03A4 = 0;

  while(!level.gameended) {
    scripts\mp\hostmigration::waittillhostmigrationdone();
    _id_B123D3720D3A03A4++;

    if(_id_B123D3720D3A03A4 >= level.players.size)
      _id_B123D3720D3A03A4 = 0;

    if(isDefined(level.players[_id_B123D3720D3A03A4])) {
      level.players[_id_B123D3720D3A03A4] writebufferedstats();
      level.players[_id_B123D3720D3A03A4] updateweaponbufferedstats();
    }

    wait 2.0;
  }
}

updatebufferedstatsatgameend() {
  level endon("game_cleanup");
  level waittill("game_ended");

  foreach(player in level.players) {
    player writebufferedstats();
    player updateweaponbufferedstats();
  }

  level.disableweaponstats = 1;
}

setbestscore(_id_629757F5C9E770D8, _id_8F617FFD000EB682) {
  rankingenabled = scripts\mp\utility\game::onlinestatsenabled();

  if(!rankingenabled) {
    return;
  }
  if(isDefined(self.bestscorestats[_id_629757F5C9E770D8]) && _id_8F617FFD000EB682 > self.bestscorestats[_id_629757F5C9E770D8]) {
    self.bestscorestats[_id_629757F5C9E770D8] = _id_8F617FFD000EB682;
    self.bufferedbestscorestats[_id_629757F5C9E770D8] = _id_8F617FFD000EB682;
  }
}

writebestscores() {
  foreach(player in level.players) {
    if(isDefined(player) && player scripts\mp\utility\game::onlinestatsenabled()) {
      foreach(_id_629757F5C9E770D8, _id_B1F473A47E479CC2 in player.bufferedbestscorestats)
      player setplayerdata(level._id_5D69837CF4DB0407, "bestScores", _id_629757F5C9E770D8, _id_B1F473A47E479CC2);
    }
  }
}

writebufferedstats() {
  rankingenabled = scripts\mp\utility\game::onlinestatsenabled();

  if(rankingenabled) {
    foreach(_id_629757F5C9E770D8, _id_B1F473A47E479CC2 in self.bufferedstats)
    self setplayerdata(level._id_5D69837CF4DB0407, _id_629757F5C9E770D8, _id_B1F473A47E479CC2);

    if(!isai(self)) {
      foreach(_id_629757F5C9E770D8, _id_B1F473A47E479CC2 in self.squadmemberbufferedstats)
      self setplayerdata(level.loadoutsgroup, "squadMembers", _id_629757F5C9E770D8, _id_B1F473A47E479CC2);
    }
  }

  foreach(_id_629757F5C9E770D8, _id_B1F473A47E479CC2 in self.bufferedchildstats) {
    foreach(_id_AF5410E8AACB5FE8, _id_74224FE98D0679D2 in _id_B1F473A47E479CC2) {
      if(_id_629757F5C9E770D8 == "round") {
        self setplayerdata("common", _id_629757F5C9E770D8, _id_AF5410E8AACB5FE8, _id_74224FE98D0679D2);
        setbestscore(_id_AF5410E8AACB5FE8, _id_74224FE98D0679D2);
        continue;
      }

      if(rankingenabled)
        self setplayerdata(level._id_5D69837CF4DB0407, _id_629757F5C9E770D8, _id_AF5410E8AACB5FE8, _id_74224FE98D0679D2);
    }
  }
}

writekdhistorystats() {
  if(!scripts\mp\utility\game::matchmakinggame()) {
    return;
  }
  level waittill("game_ended");
  wait 0.1;

  if(scripts\mp\utility\game::waslastround() || !scripts\mp\utility\game::isroundbased() && scripts\mp\utility\game::hittimelimit()) {
    foreach(player in level.players) {
      accuracy = 0;

      if(isDefined(player.pers["shotsFired"]) && player.pers["shotsFired"] > 0) {
        _id_C1480A81B0387196 = player.pers["shotsFired"];
        hits = 0;

        if(isDefined(player.pers["shotsHit"]))
          hits = player.pers["shotsHit"];

        accuracy = int(100 * (hits / _id_C1480A81B0387196));
      }

      player incrementrankedreservedhistory(player.kills, player.deaths, player.pers["headshots"], accuracy, player.pers["damage"]);
    }
  }
}

incrementrankedreservedhistory(kills, deaths, headshots, accuracy, damage) {
  if(!scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
    _id_D4145D9E255225DC = self getplayerdata(level._id_5D69837CF4DB0407, "kdHistoryK", _id_AC0E594AC96AA3A8 + 1);
    self setplayerdata(level._id_5D69837CF4DB0407, "kdHistoryK", _id_AC0E594AC96AA3A8, _id_D4145D9E255225DC);
    _id_D4145D9E255225DC = self getplayerdata(level._id_5D69837CF4DB0407, "kdHistoryD", _id_AC0E594AC96AA3A8 + 1);
    self setplayerdata(level._id_5D69837CF4DB0407, "kdHistoryD", _id_AC0E594AC96AA3A8, _id_D4145D9E255225DC);
    _id_D4145D9E255225DC = self getplayerdata(level._id_5D69837CF4DB0407, "headshotHistory", _id_AC0E594AC96AA3A8 + 1);
    self setplayerdata(level._id_5D69837CF4DB0407, "headshotHistory", _id_AC0E594AC96AA3A8, _id_D4145D9E255225DC);
    _id_D4145D9E255225DC = self getplayerdata(level._id_5D69837CF4DB0407, "accuracyHistory", _id_AC0E594AC96AA3A8 + 1);
    self setplayerdata(level._id_5D69837CF4DB0407, "accuracyHistory", _id_AC0E594AC96AA3A8, _id_D4145D9E255225DC);
    _id_D4145D9E255225DC = self getplayerdata(level._id_5D69837CF4DB0407, "damageHistory", _id_AC0E594AC96AA3A8 + 1);
    self setplayerdata(level._id_5D69837CF4DB0407, "damageHistory", _id_AC0E594AC96AA3A8, _id_D4145D9E255225DC);
  }

  self setplayerdata(level._id_5D69837CF4DB0407, "kdHistoryK", 4, int(clamp(kills, 0, 255)));
  self setplayerdata(level._id_5D69837CF4DB0407, "kdHistoryD", 4, int(clamp(deaths, 0, 255)));
  self setplayerdata(level._id_5D69837CF4DB0407, "headshotHistory", 4, int(clamp(headshots, 0, 255)));
  self setplayerdata(level._id_5D69837CF4DB0407, "accuracyHistory", 4, int(accuracy));
  self setplayerdata(level._id_5D69837CF4DB0407, "damageHistory", 4, damage);
}

incrementweaponstat(weaponname, _id_D0F001B1761FBF53, _id_A1D4E7D5EF9DA660) {
  if(_id_2669878CF5A1B6BC::iskillstreakweapon(weaponname)) {
    return;
  }
  if(istrue(level.disableweaponstats)) {
    return;
  }
  if(scripts\mp\utility\game::onlinestatsenabled()) {
    _id_9DD650BC2F7C8A01 = self getplayerdata(level._id_5D69837CF4DB0407, "playerStats", "weaponStats", weaponname, _id_D0F001B1761FBF53);
    self setplayerdata(level._id_5D69837CF4DB0407, "playerStats", "weaponStats", weaponname, _id_D0F001B1761FBF53, _id_9DD650BC2F7C8A01 + _id_A1D4E7D5EF9DA660);

    if(_id_D0F001B1761FBF53 == "kills") {
      foreach(scope in ["lifetimeStats", "seasonalStats"]) {
        _id_9DD650BC2F7C8A01 = 0;

        if(self hasplayerdata(level._id_5D69837CF4DB0407, "playerStats", scope, scripts\mp\utility\game::_id_F6BAD1D33AD22078(), "weaponStats", weaponname, "kills"))
          _id_9DD650BC2F7C8A01 = self getplayerdata(level._id_5D69837CF4DB0407, "playerStats", scope, scripts\mp\utility\game::_id_F6BAD1D33AD22078(), "weaponStats", weaponname, "kills");

        self setplayerdata(level._id_5D69837CF4DB0407, "playerStats", scope, scripts\mp\utility\game::_id_F6BAD1D33AD22078(), "weaponStats", weaponname, "kills", _id_9DD650BC2F7C8A01 + _id_A1D4E7D5EF9DA660);
      }
    }
  }
}

incrementattachmentstat(_id_659F734FC2A248FF, _id_D0F001B1761FBF53, _id_A1D4E7D5EF9DA660, weapon) {
  if(istrue(level.disableweaponstats)) {
    return;
  }
  if(!scripts\mp\utility\weapon::attachmentlogsstats(_id_659F734FC2A248FF, weapon)) {
    return;
  }
  if(scripts\mp\utility\game::onlinestatsenabled())
    return;
}

updateweaponbufferedstats() {
  if(!isDefined(self.trackingweapon)) {
    return;
  }
  if(isnullweapon(self.trackingweapon)) {
    return;
  }
  if(scripts\mp\utility\weapon::issuperweapon(self.trackingweapon)) {
    if(!istrue(scripts\mp\supers::shouldtracksuperweaponstats(self.trackingweapon)))
      return;
  }

  if(_id_2669878CF5A1B6BC::iskillstreakweapon(self.trackingweapon) || scripts\mp\utility\weapon::isenvironmentweapon(self.trackingweapon) || scripts\mp\utility\weapon::isbombsiteweapon(self.trackingweapon)) {
    return;
  }
  weapon = self.trackingweapon;
  _id_0FE4FF31502B2826 = undefined;

  if(weapon.isalternate) {
    _id_1439F86640D42E34 = _func_7C612AC92BA98DCB(weapon, weapon.underbarrel);

    if(_id_1439F86640D42E34 == "altfire") {
      _id_0FE4FF31502B2826 = weapon.underbarrel;
      perslog_attachmentstats(_id_0FE4FF31502B2826, weapon);
      persclear_stats();
      return;
    }
  }

  if(!isDefined(_id_0FE4FF31502B2826)) {
    weaponname = weapon.basename;
    _id_33802B6339AD8B00 = getsubstr(weaponname, 0, 4);

    if(_id_33802B6339AD8B00 == "iw8_" || _id_33802B6339AD8B00 == "iw9_" || _id_33802B6339AD8B00 == "t10_" || _id_33802B6339AD8B00 == "jup_")
      _id_0FE4FF31502B2826 = _id_2669878CF5A1B6BC::getweaponrootname(weapon);
  }

  if(!scripts\mp\utility\weapon::iscacprimaryweapon(_id_0FE4FF31502B2826) && !scripts\mp\utility\weapon::iscacsecondaryweapon(_id_0FE4FF31502B2826)) {
    return;
  }
  variantid = getweaponvariantindex(weapon);
  persincrement_weaponstats(_id_0FE4FF31502B2826, variantid);
  fullweaponname = getcompleteweaponname(weapon);
  perslog_weaponstats(_id_0FE4FF31502B2826, fullweaponname, variantid);
  attachments = getweaponattachments(weapon);

  foreach(_id_FF180C307F2BAFD3 in attachments) {
    if(!scripts\mp\utility\weapon::attachmentlogsstats(_id_FF180C307F2BAFD3, weapon)) {
      continue;
    }
    _id_1439F86640D42E34 = _func_7C612AC92BA98DCB(weapon, _id_FF180C307F2BAFD3);

    if(_id_1439F86640D42E34 == "altfire") {
      continue;
    }
    perslog_attachmentstats(_id_FF180C307F2BAFD3, weapon);
  }

  persclear_stats();
}

persclear_stats() {
  self.trackingweapon = nullweapon();
  self.trackingweaponshots = 0;
  self.trackingweaponkills = 0;
  self._id_E16D751A51153A7B = 0;
  self._id_2BF7B072E416002A = 0;
  self._id_1FE884779E5F4DBE = 0;
  self.trackingweaponhits = 0;
  self._id_A00EDDCF879BDBC3 = 0;
  self._id_CA6E0D389C0CA0A7 = 0;
  self.trackingweaponheadshots = 0;
  self._id_9A2FD6F8771F2E58 = 0;
  self._id_5FAC5778FE3FDC1C = 0;
  self.trackingweapondeaths = 0;
  self._id_F00517AA8F668932 = 0;
  self._id_14CEC2BA65099256 = 0;
  self._id_883957B1C1EF6745 = 0;
  self._id_7B522BF6F7AECA98 = 0;
  self._id_BF617879DEF40524 = 0;
}

persincrement_weaponstats(weaponname, variantid) {
  if(isDefined(self.trackingweaponshots) && self.trackingweaponshots > 0)
    incrementweaponstat(weaponname, "shots", self.trackingweaponshots);

  if(isDefined(self.trackingweaponkills) && self.trackingweaponkills > 0)
    incrementweaponstat(weaponname, "kills", self.trackingweaponkills);

  if(isDefined(self.trackingweaponhits) && self.trackingweaponhits > 0)
    incrementweaponstat(weaponname, "hits", self.trackingweaponhits);

  if(isDefined(self.trackingweaponheadshots) && self.trackingweaponheadshots > 0)
    incrementweaponstat(weaponname, "headShots", self.trackingweaponheadshots);

  if(isDefined(self.trackingweapondeaths) && self.trackingweapondeaths > 0)
    incrementweaponstat(weaponname, "deaths", self.trackingweapondeaths);
}

perslog_weaponstats(weaponname, fullweaponname, variantid) {
  _id_7E2C53B0BCF117D9 = spawnStruct();

  if(scripts\engine\utility::_id_53C4C53197386572(self.trackingweaponshots, 0) > 0) {
    _id_7E2C53B0BCF117D9.weaponname = weaponname;
    _id_7E2C53B0BCF117D9.fullweaponname = fullweaponname;
    _id_7E2C53B0BCF117D9._id_629757F5C9E770D8 = "shots";
    _id_7E2C53B0BCF117D9._id_A1D4E7D5EF9DA660 = self.trackingweaponshots;
    _id_7E2C53B0BCF117D9.variantid = variantid;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_update_weapon_stats", _id_7E2C53B0BCF117D9);
  }

  if(scripts\engine\utility::_id_53C4C53197386572(self.trackingweaponkills, 0) > 0) {
    _id_7E2C53B0BCF117D9.weaponname = weaponname;
    _id_7E2C53B0BCF117D9.fullweaponname = fullweaponname;
    _id_7E2C53B0BCF117D9._id_629757F5C9E770D8 = "kills";
    _id_7E2C53B0BCF117D9._id_A1D4E7D5EF9DA660 = self.trackingweaponkills;
    _id_7E2C53B0BCF117D9.variantid = variantid;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_update_weapon_stats", _id_7E2C53B0BCF117D9);
  }

  if(scripts\engine\utility::_id_53C4C53197386572(self._id_E16D751A51153A7B, 0) > 0) {
    _id_7E2C53B0BCF117D9.weaponname = weaponname;
    _id_7E2C53B0BCF117D9.fullweaponname = fullweaponname;
    _id_7E2C53B0BCF117D9._id_629757F5C9E770D8 = "ads_kills";
    _id_7E2C53B0BCF117D9._id_A1D4E7D5EF9DA660 = self._id_E16D751A51153A7B;
    _id_7E2C53B0BCF117D9.variantid = variantid;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_update_weapon_stats", _id_7E2C53B0BCF117D9);
  }

  if(scripts\engine\utility::_id_53C4C53197386572(self._id_2BF7B072E416002A, 0) > 0) {
    _id_7E2C53B0BCF117D9.weaponname = weaponname;
    _id_7E2C53B0BCF117D9.fullweaponname = fullweaponname;
    _id_7E2C53B0BCF117D9._id_629757F5C9E770D8 = "ai_ads_kills";
    _id_7E2C53B0BCF117D9._id_A1D4E7D5EF9DA660 = self._id_2BF7B072E416002A;
    _id_7E2C53B0BCF117D9.variantid = variantid;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_update_weapon_stats", _id_7E2C53B0BCF117D9);
  }

  if(scripts\engine\utility::_id_53C4C53197386572(self._id_1FE884779E5F4DBE, 0) > 0) {
    _id_7E2C53B0BCF117D9.weaponname = weaponname;
    _id_7E2C53B0BCF117D9.fullweaponname = fullweaponname;
    _id_7E2C53B0BCF117D9._id_629757F5C9E770D8 = "player_ads_kills";
    _id_7E2C53B0BCF117D9._id_A1D4E7D5EF9DA660 = self._id_1FE884779E5F4DBE;
    _id_7E2C53B0BCF117D9.variantid = variantid;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_update_weapon_stats", _id_7E2C53B0BCF117D9);
  }

  if(scripts\engine\utility::_id_53C4C53197386572(self.trackingweaponhits, 0) > 0) {
    _id_7E2C53B0BCF117D9.weaponname = weaponname;
    _id_7E2C53B0BCF117D9.fullweaponname = fullweaponname;
    _id_7E2C53B0BCF117D9._id_629757F5C9E770D8 = "hits";
    _id_7E2C53B0BCF117D9._id_A1D4E7D5EF9DA660 = self.trackingweaponhits;
    _id_7E2C53B0BCF117D9.variantid = variantid;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_update_weapon_stats", _id_7E2C53B0BCF117D9);
  }

  if(scripts\engine\utility::_id_53C4C53197386572(self._id_A00EDDCF879BDBC3, 0) > 0) {
    _id_7E2C53B0BCF117D9.weaponname = weaponname;
    _id_7E2C53B0BCF117D9.fullweaponname = fullweaponname;
    _id_7E2C53B0BCF117D9._id_629757F5C9E770D8 = "ai_hits";
    _id_7E2C53B0BCF117D9._id_A1D4E7D5EF9DA660 = self._id_A00EDDCF879BDBC3;
    _id_7E2C53B0BCF117D9.variantid = variantid;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_update_weapon_stats", _id_7E2C53B0BCF117D9);
  }

  if(scripts\engine\utility::_id_53C4C53197386572(self._id_CA6E0D389C0CA0A7, 0) > 0) {
    _id_7E2C53B0BCF117D9.weaponname = weaponname;
    _id_7E2C53B0BCF117D9.fullweaponname = fullweaponname;
    _id_7E2C53B0BCF117D9._id_629757F5C9E770D8 = "player_hits";
    _id_7E2C53B0BCF117D9._id_A1D4E7D5EF9DA660 = self._id_CA6E0D389C0CA0A7;
    _id_7E2C53B0BCF117D9.variantid = variantid;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_update_weapon_stats", _id_7E2C53B0BCF117D9);
  }

  if(scripts\engine\utility::_id_53C4C53197386572(self.trackingweaponheadshots, 0) > 0) {
    _id_7E2C53B0BCF117D9.weaponname = weaponname;
    _id_7E2C53B0BCF117D9.fullweaponname = fullweaponname;
    _id_7E2C53B0BCF117D9._id_629757F5C9E770D8 = "headshots";
    _id_7E2C53B0BCF117D9._id_A1D4E7D5EF9DA660 = self.trackingweaponheadshots;
    _id_7E2C53B0BCF117D9.variantid = variantid;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_update_weapon_stats", _id_7E2C53B0BCF117D9);
  }

  if(scripts\engine\utility::_id_53C4C53197386572(self._id_9A2FD6F8771F2E58, 0) > 0) {
    _id_7E2C53B0BCF117D9.weaponname = weaponname;
    _id_7E2C53B0BCF117D9.fullweaponname = fullweaponname;
    _id_7E2C53B0BCF117D9._id_629757F5C9E770D8 = "ai_headshots";
    _id_7E2C53B0BCF117D9._id_A1D4E7D5EF9DA660 = self._id_9A2FD6F8771F2E58;
    _id_7E2C53B0BCF117D9.variantid = variantid;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_update_weapon_stats", _id_7E2C53B0BCF117D9);
  }

  if(scripts\engine\utility::_id_53C4C53197386572(self._id_5FAC5778FE3FDC1C, 0) > 0) {
    _id_7E2C53B0BCF117D9.weaponname = weaponname;
    _id_7E2C53B0BCF117D9.fullweaponname = fullweaponname;
    _id_7E2C53B0BCF117D9._id_629757F5C9E770D8 = "player_headshots";
    _id_7E2C53B0BCF117D9._id_A1D4E7D5EF9DA660 = self._id_5FAC5778FE3FDC1C;
    _id_7E2C53B0BCF117D9.variantid = variantid;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_update_weapon_stats", _id_7E2C53B0BCF117D9);
  }

  if(scripts\engine\utility::_id_53C4C53197386572(self.trackingweapondeaths, 0) > 0) {
    _id_7E2C53B0BCF117D9.weaponname = weaponname;
    _id_7E2C53B0BCF117D9.fullweaponname = fullweaponname;
    _id_7E2C53B0BCF117D9._id_629757F5C9E770D8 = "deaths";
    _id_7E2C53B0BCF117D9._id_A1D4E7D5EF9DA660 = self.trackingweapondeaths;
    _id_7E2C53B0BCF117D9.variantid = variantid;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_update_weapon_stats", _id_7E2C53B0BCF117D9);
  }

  if(scripts\engine\utility::_id_53C4C53197386572(self._id_F00517AA8F668932, 0) > 0) {
    _id_7E2C53B0BCF117D9.weaponname = weaponname;
    _id_7E2C53B0BCF117D9.fullweaponname = fullweaponname;
    _id_7E2C53B0BCF117D9._id_629757F5C9E770D8 = "ai_deaths";
    _id_7E2C53B0BCF117D9._id_A1D4E7D5EF9DA660 = self._id_F00517AA8F668932;
    _id_7E2C53B0BCF117D9.variantid = variantid;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_update_weapon_stats", _id_7E2C53B0BCF117D9);
  }

  if(scripts\engine\utility::_id_53C4C53197386572(self._id_14CEC2BA65099256, 0) > 0) {
    _id_7E2C53B0BCF117D9.weaponname = weaponname;
    _id_7E2C53B0BCF117D9.fullweaponname = fullweaponname;
    _id_7E2C53B0BCF117D9._id_629757F5C9E770D8 = "player_deaths";
    _id_7E2C53B0BCF117D9._id_A1D4E7D5EF9DA660 = self._id_14CEC2BA65099256;
    _id_7E2C53B0BCF117D9.variantid = variantid;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_update_weapon_stats", _id_7E2C53B0BCF117D9);
  }

  if(scripts\engine\utility::_id_53C4C53197386572(self._id_883957B1C1EF6745, 0) > 0) {
    _id_7E2C53B0BCF117D9.weaponname = weaponname;
    _id_7E2C53B0BCF117D9.fullweaponname = fullweaponname;
    _id_7E2C53B0BCF117D9._id_629757F5C9E770D8 = "damage";
    _id_7E2C53B0BCF117D9._id_A1D4E7D5EF9DA660 = self._id_883957B1C1EF6745;
    _id_7E2C53B0BCF117D9.variantid = variantid;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_update_weapon_stats", _id_7E2C53B0BCF117D9);
  }

  if(scripts\engine\utility::_id_53C4C53197386572(self._id_7B522BF6F7AECA98, 0) > 0) {
    _id_7E2C53B0BCF117D9.weaponname = weaponname;
    _id_7E2C53B0BCF117D9.fullweaponname = fullweaponname;
    _id_7E2C53B0BCF117D9._id_629757F5C9E770D8 = "ai_damage";
    _id_7E2C53B0BCF117D9._id_A1D4E7D5EF9DA660 = self._id_7B522BF6F7AECA98;
    _id_7E2C53B0BCF117D9.variantid = variantid;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_update_weapon_stats", _id_7E2C53B0BCF117D9);
  }

  if(scripts\engine\utility::_id_53C4C53197386572(self._id_BF617879DEF40524, 0) > 0) {
    _id_7E2C53B0BCF117D9.weaponname = weaponname;
    _id_7E2C53B0BCF117D9.fullweaponname = fullweaponname;
    _id_7E2C53B0BCF117D9._id_629757F5C9E770D8 = "player_damage";
    _id_7E2C53B0BCF117D9._id_A1D4E7D5EF9DA660 = self._id_BF617879DEF40524;
    _id_7E2C53B0BCF117D9.variantid = variantid;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_update_weapon_stats", _id_7E2C53B0BCF117D9);
  }
}

perslog_attachmentstats(_id_FF180C307F2BAFD3, weapon) {
  if(!scripts\mp\utility\weapon::attachmentlogsstats(_id_FF180C307F2BAFD3, weapon)) {
    return;
  }
  if(self.trackingweaponshots > 0 && _id_FF180C307F2BAFD3 != "tactical") {
    incrementattachmentstat(_id_FF180C307F2BAFD3, "shots", self.trackingweaponshots, weapon);
    scripts\common\utility::trycall(level.matchdata_logattachmentstat, _id_FF180C307F2BAFD3, "shots", self.trackingweaponshots, weapon);
  }

  if(self.trackingweaponkills > 0 && _id_FF180C307F2BAFD3 != "tactical") {
    incrementattachmentstat(_id_FF180C307F2BAFD3, "kills", self.trackingweaponkills, weapon);
    scripts\common\utility::trycall(level.matchdata_logattachmentstat, _id_FF180C307F2BAFD3, "kills", self.trackingweaponkills, weapon);
  }

  if(self._id_E16D751A51153A7B > 0 && _id_FF180C307F2BAFD3 != "tactical")
    scripts\common\utility::trycall(level.matchdata_logattachmentstat, _id_FF180C307F2BAFD3, "ads_kills", self._id_E16D751A51153A7B, weapon);

  if(self.trackingweaponhits > 0 && _id_FF180C307F2BAFD3 != "tactical") {
    incrementattachmentstat(_id_FF180C307F2BAFD3, "hits", self.trackingweaponhits, weapon);
    scripts\common\utility::trycall(level.matchdata_logattachmentstat, _id_FF180C307F2BAFD3, "hits", self.trackingweaponhits, weapon);
  }

  if(self.trackingweaponheadshots > 0 && _id_FF180C307F2BAFD3 != "tactical") {
    incrementattachmentstat(_id_FF180C307F2BAFD3, "headShots", self.trackingweaponheadshots, weapon);
    scripts\common\utility::trycall(level.matchdata_logattachmentstat, _id_FF180C307F2BAFD3, "headShots", self.trackingweaponheadshots, weapon);
  }

  if(self.trackingweapondeaths > 0) {
    incrementattachmentstat(_id_FF180C307F2BAFD3, "deaths", self.trackingweapondeaths, weapon);
    scripts\common\utility::trycall(level.matchdata_logattachmentstat, _id_FF180C307F2BAFD3, "deaths", self.trackingweapondeaths, weapon);
  }
}

uploadglobalstatcounters() {
  level waittill("game_ended");

  if(!scripts\mp\utility\game::matchmakinggame()) {
    return;
  }
  _id_77F3CA6D2F0AAE12 = 0;
  _id_EDDAA68A3A7FE3DE = 0;
  _id_74BA9CC277CBE543 = 0;
  _id_6E9E8ACAE1C9B574 = 0;
  _id_43390B25454AFA28 = 0;
  _id_80B0D2AC8AEDF18B = 0;

  foreach(player in level.players)
  _id_80B0D2AC8AEDF18B = _id_80B0D2AC8AEDF18B + player.timeplayed["total"];

  dlog_recordevent("dlog_event_global_minutes", ["increment", int(_id_80B0D2AC8AEDF18B / 60)]);

  if(scripts\mp\utility\game::isroundbased() && !scripts\mp\utility\game::waslastround()) {
    return;
  }
  waitframe();

  foreach(player in level.players) {
    _id_77F3CA6D2F0AAE12 = _id_77F3CA6D2F0AAE12 + player.kills;
    _id_EDDAA68A3A7FE3DE = _id_EDDAA68A3A7FE3DE + player.deaths;
    _id_74BA9CC277CBE543 = _id_74BA9CC277CBE543 + player.assists;
    _id_6E9E8ACAE1C9B574 = _id_6E9E8ACAE1C9B574 + player scripts\mp\utility\stats::getpersstat("headshots");
    _id_43390B25454AFA28 = _id_43390B25454AFA28 + player scripts\mp\utility\stats::getpersstat("suicides");
  }

  dlog_recordevent("dlog_event_global_kills", ["increment", _id_77F3CA6D2F0AAE12]);
  dlog_recordevent("dlog_event_global_deaths", ["increment", _id_EDDAA68A3A7FE3DE]);
  dlog_recordevent("dlog_event_global_headshots", ["increment", _id_6E9E8ACAE1C9B574]);
  dlog_recordevent("dlog_event_global_suicides", ["increment", _id_43390B25454AFA28]);
  dlog_recordevent("dlog_event_global_games", ["increment", 1]);

  if(!isDefined(level.assists_disabled))
    dlog_recordevent("dlog_event_global_assists", ["increment", _id_74BA9CC277CBE543]);
}