/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\events.gsc
***********************************************/

init() {
  var_0 = scripts\mp\utility\game::getgametype();

  if(!isDefined(var_0))
    var_0 = getDvar("_encstr_B60D0B9C840C31FA415FD7EFCB");

  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow("_encstr_B20319F0D0AF776BC095157982632AC0F308303A75E0576DB6D7D3", var_1, 0);

    if(!isDefined(var_2) || var_2 == "_encstr_B40101") {
      break;
    }

    var_3 = tablelookupbyrow("_encstr_B20319F0D0AF776BC095157982632AC0F308303A75E0576DB6D7D3", var_1, level.getallselectableattachments.game_type_col[var_0]);

    if(!isDefined(var_3) || var_3 == "_encstr_B40101") {
      var_1++;
      continue;
    }

    if(var_2 == "_encstr_91190447C232" || var_2 == "_encstr_8CAD05DB100303" || var_2 == "_encstr_8D19048EA595")
      var_3 = float(var_3);
    else
      var_3 = int(var_3);

    if(var_3 != -1)
      scripts\mp\rank::registerscoreinfo(var_2, "_encstr_BA94069D16D8ABAC", var_3);

    var_4 = tablelookuprownum("_encstr_820613E0612536534983E7C96977FDB145A6AB43C4", 0, var_2);
    scripts\mp\rank::registerscoreinfo(var_2, "_encstr_AA5B08F5B421339B1359", var_4);
    var_4 = tablelookup("_encstr_820613E0612536534983E7C96977FDB145A6AB43C4", 0, var_2, 2);
    scripts\mp\rank::registerscoreinfo(var_2, "_encstr_81EF05D156E1A3", var_4);
    var_4 = int(tablelookup("_encstr_820613E0612536534983E7C96977FDB145A6AB43C4", 0, var_2, 13));
    scripts\mp\rank::registerscoreinfo(var_2, "_encstr_978C092BB8FBFDEB302D69", var_4);
    var_4 = int(tablelookup("_encstr_820613E0612536534983E7C96977FDB145A6AB43C4", 0, var_2, 14));
    scripts\mp\rank::registerscoreinfo(var_2, "_encstr_BA9D118536DDC22F37D443BDDD6AC1638537D0", var_4);
    var_5 = tablelookuprownum("_encstr_820613E0612536534983E7C96977FDB145A6AB43C4", 0, var_2);

    if(isDefined(var_5) && var_5 != -1)
      scripts\mp\rank::registerscoreinfo(var_2, "_encstr_B6050906A27A7BDBD88F81", var_5);

    var_6 = tablelookupbyrow("_encstr_B20319F0D0AF776BC095157982632AC0F308303A75E0576DB6D7D3", var_1, 4);
    scripts\mp\rank::registerscoreinfo(var_2, "_encstr_852906B39CBD5D38", var_6);
    var_7 = tablelookupbyrow("_encstr_B20319F0D0AF776BC095157982632AC0F308303A75E0576DB6D7D3", var_1, 3);

    if(isDefined(var_7) && tolower(var_7) == "_encstr_AAEF05B83B43EB")
      scripts\mp\rank::registerscoreinfo(var_2, "_encstr_889C0B0BD88DBDBB48ED37ABB9", 1);

    var_1++;
  }

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_encstr_934D17B986DEABD832BA6E593B7BC61913164EC26ECDCA3AE6())
    level._effect["_encstr_B6930663D72D9813"] = loadfx("_encstr_A2BD333BCC3C972DDD0ED74C39F29D2CB6590E36162F79B3331EBEC439D7D9ED638CAF892C1BDA0E2C6CDAFA32B2C2478617CE661E");
  else
    level._effect["_encstr_B6930663D72D9813"] = loadfx("_encstr_B21A1BECCC1EE5389CF607DC79D816CD1AAF071BC2F2CAC9F5239CDB83");

  level.numkills = 0;
  level.prevlastkilltime = 0;
  level.lastkilltime = 0;
  level.carnage_enemydummycleanup = 2097152;
  level thread onplayerconnect();
  level thread monitorhealed();

  if(!scripts\mp\utility\game::runleanthreadmode()) {
    scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawn);
    scripts\mp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback(::updatestancetracking);
    scripts\mp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback(::events_monitorslideupdate);
  }

  scripts\mp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback(::monitoradstime);

  if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB")
    thermite_laststand_effects();
}

onplayerspawn() {
  self.jumpcur = 0;
  self.mantlecur = 0;
}

onplayerconnect() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);

    if(!scripts\mp\utility\game::lpcfeaturegated()) {
      var_0.killedplayers = [];
      var_0.killedby = [];
    }

    var_0.lastkilledby = undefined;
    var_0.greatestuniqueplayerkills = 0;
    var_0.recentkillcount = 0;
    var_0.recentdefendcount = 0;
    var_0._id_12A82 = 0;
    var_0.lastkilltime = 0;
    var_0.prevlastkilltime = 0;
    var_0.lastkilldogtime = 0;

    if(!isDefined(var_0.pers["_encstr_AA8B18016F73E101443790B8AF7058233AD31A1B854AE3492397"]))
      var_0.pers["_encstr_AA8B18016F73E101443790B8AF7058233AD31A1B854AE3492397"] = 0;

    if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB") {
      if(!isDefined(var_0.pers["_encstr_82791534AC16C837D0F6D126DBB976CD86BD3A6AC2DCB6"]))
        var_0.pers["_encstr_82791534AC16C837D0F6D126DBB976CD86BD3A6AC2DCB6"] = 0;
    }

    var_0._id_11F87 = 0;
    var_0.damagedplayers = [];
    var_0 initslidemonitor();
    var_0 initmonitoradstime();
    var_0 thread monitorreload();
    var_0.lastweaponchangetime = 0;
    var_0 initstancetracking();
  }
}

damagedplayer(var_0, var_1) {
  if(var_1 < 50 && var_1 > 10)
    level thread scripts\mp\battlechatter_mp::saytoself(self, "_encstr_9ADE129159D517D89AA1E968F3C011DB14578B9B", undefined, 0.1);
  else
    level thread scripts\mp\battlechatter_mp::saytoself(self, "_encstr_B82E1287A59B0739D11FA8A007EC96A1320E7C8B", undefined, 0.1);
}

playerworlddeath(var_0, var_1) {
  scripts\mp\potg_events::playerworlddeath(var_0, var_1);
}

killedplayernotifysys(var_0, var_1, var_2, var_3) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_848E1303BB0875E74577429ABA2D6325B8398996F3");
  self endon("_encstr_848E1303BB0875E74577429ABA2D6325B8398996F3");

  if(!isDefined(self.killsinaframecount))
    self.killsinaframecount = 0;

  self.killsinaframecount++;

  if(weaponclass(var_2) == "_encstr_A1100738A33A638123") {
    if(!isDefined(self.shotgunkillsinaframecount))
      self.shotgunkillsinaframecount = 1;
    else {
      self.shotgunkillsinaframecount++;

      if(self.shotgunkillsinaframecount >= 2)
        shotguncollateral(self.shotgunkillsinaframecount);
    }
  } else if(var_3 == "_encstr_950A12A99E887D284AD42A7A31D748AA98C4A215" || var_3 == "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9" || var_3 == "_encstr_87280E1FB705D168313D1FD197B1A799") {
    if(!isDefined(self.bulletkillsinaframecount))
      self.bulletkillsinaframecount = 1;
    else {
      self.bulletkillsinaframecount++;

      if(self.bulletkillsinaframecount >= 2)
        collateral(self.bulletkillsinaframecount);
    }
  }

  waittillframeend;
  thread notifykilledplayer(var_0, var_1, var_2, var_3, self.killsinaframecount);
  self.killsinaframecount = 0;
  self.bulletkillsinaframecount = 0;
  self.shotgunkillsinaframecount = 0;
}

notifykilledplayer(var_0, var_1, var_2, var_3, var_4) {
  var_5 = createheadicon(var_2);

  for(var_6 = 0; var_6 < var_4; var_6++) {
    self notify("_encstr_8F220B3FC7D11160D8F85169E9", var_1, var_5, var_3);
    waitframe();
  }
}

celebration_end(var_0, var_1, var_2, var_3) {
  var_4 = 1;

  if(isDefined(var_1)) {
    if(isDefined(var_1.owner))
      var_4 = var_1.owner == var_0;
    else if(cellspawns(var_2, var_1, var_3)) {} else
      var_4 = var_1 == var_0;
  }

  return var_4;
}

cellspawns(var_0, var_1, var_2) {
  var_3 = 0;

  if(isDefined(var_0) && isDefined(var_1.classname) && var_1.classname == "_encstr_BD4E0B7B104D6AD4DB384717A0" && var_2 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF") {
    var_4 = scripts\mp\utility\weapon::getweaponrootname(var_0);
    var_3 = var_4 == "_encstr_B453108C3B128FFBF07F5B077B2AC2B9FA4A" || var_4 == "_encstr_8C59102DEE0EFACDB9FA369CDB6E3713DEDD";
  }

  return var_3;
}

cargo_truck_mg_initoccupancy(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isPlayer(self)) {
    return;
  }
  self.modifiers = [];
  self.modifiers["_encstr_87A205AF10734B"] = 0;
  self.modifiers["_encstr_95A40617A8CBC38F"] = 0;
  self.modifiers["_encstr_A2A406E139973007"] = 0;
  var_6 = gettime();
  var_7 = scripts\mp\utility\weapon::getweapongroup(var_2.basename);
  var_8 = createheadicon(var_2);
  var_9 = var_1.guid;
  var_10 = scripts\cp\vehicles\vehicle_compass_cp::resetstuckthermite();
  var_11 = var_1 scripts\cp\vehicles\vehicle_compass_cp::resetstuckthermite();

  if(!scripts\mp\utility\weapon::iskillstreakweapon(var_2.basename) && !scripts\mp\utility\perk::_hasperk("_encstr_B4371B9BE0B26C5A85B1A32FD7CAE11C1B7B374B3B2B26AB361B95479B")) {
    var_12 = celebration_end(self, var_4, var_2, var_3);

    if(isDefined(var_1.attackerposition))
      var_13 = var_1.attackerposition;
    else
      var_13 = self.origin;

    var_14 = anglesToForward(self getplayerangles());
    var_15 = var_1.origin - var_13;
    var_16 = vectorNormalize(var_15);
    var_17 = vectordot(var_14, var_16);
    var_18 = scripts\engine\utility::isbulletdamage(var_3);
    var_19 = scripts\mp\supers::getcurrentsuper();

    if(isDefined(var_19) && scripts\mp\supers::issuperinuse())
      self.modifiers["_encstr_88C91516B1A34BB359D7CC4B56B18CD75D83D99C16C8B2"] = var_19.staticdata.ref;

    if(var_3 == "_encstr_AA230E8CF56CD18DB12FC7E303C8C001") {
      self.modifiers["_encstr_B1100A561EACC6AB3AB47BCD"] = 1;
      self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 256;
    }

    if(level.prevlastkilltime == 0 && self.prevlastkilltime == 0) {
      self.modifiers["_encstr_85E10B66B44E6EA3981BBDDE91"] = 1;
      self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 33554432;
    }

    if(var_2.basename == "_encstr_8BBA05185F8B99" && var_3 != "_encstr_AA230E8CF56CD18DB12FC7E303C8C001") {
      return;
    }
    if(isDefined(var_1.attackers) && var_1.attackers.size == 1 && !isDefined(var_1.attackers[var_1.guid])) {
      if(var_7 != "_encstr_8261067B1D34AC27" && var_7 != "_encstr_BDBF1277568507DEE67D0E9CED4DB21BA32DB195" && var_3 != "_encstr_8DED0A21C79B660BC7588981" && isDefined(var_1.attackerdata) && isDefined(var_1.attackerdata[self.guid].firsttimedamaged) && var_6 == var_1.attackerdata[self.guid].firsttimedamaged) {
        self.modifiers["_encstr_87B20CC852EF5FB07FBC7A638C5B"] = 1;
        self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 1;

        if(!isDefined(self.pers["_encstr_A1020D7BE659370DB7E8B5B48D36CD"]))
          self.pers["_encstr_A1020D7BE659370DB7E8B5B48D36CD"] = 1;
        else
          self.pers["_encstr_A1020D7BE659370DB7E8B5B48D36CD"]++;

        if(self.pers["_encstr_A1020D7BE659370DB7E8B5B48D36CD"] == 6)
          self.modifiers["_encstr_A2A406E139973007"] = self.modifiers["_encstr_A2A406E139973007"] | 8;
      }
    }

    if(isDefined(self.lastinsmoketime) && self.lastinsmoketime + 5000 > gettime() || isDefined(var_1.lastinsmoketime) && var_1.lastinsmoketime + 5000 > gettime()) {
      self.modifiers["_encstr_A143080B258B6358DB3F"] = 1;
      self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 512;
    }

    if(scripts\mp\utility\game::runleanthreadmode()) {
      if(isDefined(var_1.radarstrength) && var_1.radarstrength > 3) {
        self.modifiers["_encstr_BED80C7F10E3FA493C308F1F5997"] = 1;
        self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 1;
      }
    } else if(scripts\cp_mp\utility\killstreak_utility::teamhasuav(var_1.team)) {
      self.modifiers["_encstr_BED80C7F10E3FA493C308F1F5997"] = 1;
      self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 1;
    }

    if(isDefined(var_1._id_13935) && var_1._id_13935 == self) {
      self.modifiers["_encstr_BAEA0D448A6F30C31F5A88B873F6EF"] = 1;
      self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 8;
    }

    if(scripts\mp\utility\game::turret_outline_watcher(var_1)) {
      self.modifiers["_encstr_AB3508737F830710ACDB"] = 1;
      self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 1073741824;
      start_puzzle();
    }

    if(scripts\mp\utility\game::isdefending(var_1)) {
      self.modifiers["_encstr_8E460991ACCC59378C56C9"] = 1;
      self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 4194304;
      start_puzzle();
    }

    if(var_3 == "_encstr_8DED0A21C79B660BC7588981") {
      if(var_7 != "_encstr_8ACC0DEC0F42B1A0263F50189B45B9" && var_7 != "_encstr_8D200E63B9A7DBC550975D5D99600FAA") {
        self.modifiers["_encstr_928008AF7D084BE35110"] = 1;
        self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 128;
      }
    }

    if((var_7 == "_encstr_8ACC0DEC0F42B1A0263F50189B45B9" || var_7 == "_encstr_8D200E63B9A7DBC550975D5D99600FAA") && !issubstr(var_7, "_encstr_A67F06F597DFEB6A")) {
      self.modifiers["_encstr_A6C7065BACB1CA95"] = 1;
      self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 1073741824;
    }

    var_24 = var_1 getheldoffhand();

    if(var_24.basename == "_encstr_8C4A10BA936F7F31D0159D6ECB304757814B" || var_24.basename == "_encstr_8592135EB163BBE43908DF372011A6C2295D295527") {
      self.modifiers["_encstr_AB9008FE285D7F3B4BC0"] = 1;
      self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 2;
    }

    if(isDefined(self.assistedsuicide) && self.assistedsuicide)
      self.modifiers["_encstr_950310C2E637D29B8E2B32CDABD2B1D2C8AC"] = 1;

    if(self.pers["_encstr_B80511FE9DCDD954993093EBA9331C534B3F44"] > 3) {
      self.modifiers["_encstr_92DF0956DA8F69425F23C8"] = 1;
      self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 134217728;
    }

    if(var_3 == "_encstr_87280E1FB705D168313D1FD197B1A799" || vehicle_collision_handlemultievent(var_2, var_5) || turn_on_laser_vfx(var_2, var_5)) {
      self.modifiers["_encstr_848909BBD3A7526348E8E3"] = 1;
      self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 1048576;

      if(self.pers["_encstr_96D30A3468575BA3C307A128"] == 7)
        self.modifiers["_encstr_A2A406E139973007"] = self.modifiers["_encstr_A2A406E139973007"] | 16;
    }

    if(isDefined(self.wasti) && self.wasti && var_6 - self.spawntime <= 5000)
      self.modifiers["_encstr_AF1E11A277A96FE465102AF2884F98D740693C"] = 1;

    if(!scripts\mp\utility\player::isreallyalive(self) && isDefined(self.deathtime)) {
      var_25 = gettime() - self.deathtime;

      if(var_25 < 1500 && var_25 > 0) {
        self.modifiers["_encstr_93150B9B625FB5C8DBEDA79B1B"] = 1;
        self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 8388608;
      }
    }

    if(level.teambased && isDefined(var_1.lastkilltime) && var_6 - var_1.lastkilltime < 1500) {
      if(var_1.lastkilledplayer != self) {
        self.modifiers["_encstr_977C08697BE705EAA5E3"] = 1;
        self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 2097152;
      }
    }

    if(isbackkill(self, var_1, var_3)) {
      self.modifiers["_encstr_A13C0913C2C6B5CD470B31"] = 1;
      self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 4;
    }

    var_26 = isDefined(var_4) && istrue(var_4.isequipment) && isDefined(var_4.equipmentref) && var_4.equipmentref == "_encstr_952115DD01A75899A9C3C8936A7B6370578752C0618381";
    var_27 = isDefined(var_4) && isDefined(var_4.weapon_object) && scripts\mp\utility\weapon::validatefuelstability(var_4.weapon_object, var_4);

    if(var_12 || var_26 || var_27) {
      var_28 = getshotdistancetype(self, var_2, var_3, var_13, var_1);

      switch (var_28) {
        case "_encstr_A90B0B68C75085F316A022DA28":
          self.modifiers["_encstr_A90B0B68C75085F316A022DA28"] = 1;
          self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 524288;
          break;
        case "_encstr_B82009D8DBE6D9CDD0B7E8":
          self.modifiers["_encstr_B82009D8DBE6D9CDD0B7E8"] = 1;
          self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 262144;
          var_29 = scripts\engine\math::round_float(distance(var_13, var_1.origin) / 39.37, 2);
          self setclientomnvar("_encstr_888111574B7DB1DB73763786DBD1F58C96CD3A", var_29);
          self setclientomnvar("_encstr_B4A214E85A9E01D00BD716723F15291B2852818042C1", update_future_stations_track_timers(var_13, var_1, var_2));
          break;
        case "_encstr_86500EF327F03197887228922B19E053":
          self.modifiers["_encstr_B82009D8DBE6D9CDD0B7E8"] = 1;
          self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 262144;
          self.modifiers["_encstr_86500EF327F03197887228922B19E053"] = 1;
          var_29 = scripts\engine\math::round_float(distance(var_13, var_1.origin) / 39.37, 2);
          self setclientomnvar("_encstr_888111574B7DB1DB73763786DBD1F58C96CD3A", var_29);
          self setclientomnvar("_encstr_B4A214E85A9E01D00BD716723F15291B2852818042C1", update_future_stations_track_timers(var_13, var_1, var_2));
          break;
      }

      if(self _meth_87BA()) {
        self.modifiers["_encstr_8D1B0E0DBDB119B4379DC493CA588E34"] = 1;
        self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 268435456;
      }

      if(scripts\mp\class::vehicle_checkpiggybackexploit(var_2)) {
        self.modifiers["_encstr_BA870D3EB1416DAB9AD26FD7A81A2C"] = 1;
        self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 131072;
      }

      if(var_1 scripts\mp\weapons::isstunnedorblinded()) {
        self.modifiers["_encstr_845313BDF7626D100D3CC07B26E1932DEA171B015B"] = 1;
        self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 1048576;
        self.modifiers["_encstr_8C51153259A3CAC68EB28C2DB6E0C2B4395923DA5A6363"] = 1;
        self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 524288;
      }

      if(underbridge_reinforce_enemy_monitor(self, var_1)) {
        self.modifiers["_encstr_8C51153259A3CAC68EB28C2DB6E0C2B4395923DA5A6363"] = 1;
        self.modifiers["_encstr_B8D90D143F037796895379E2D449E0"] = 1;
        self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 524288;
      }

      if(isDefined(var_1.lastsnapshotgrenadetime) && var_1.lastsnapshotgrenadetime + scripts\mp\equipment\snapshot_grenade::removespawnselections() > gettime())
        self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 67108864;

      if(isDefined(self.radarstrength) && self.radarstrength > 3 && !var_1 scripts\mp\utility\perk::_hasperk("_encstr_865013A373482BFBE0426B73E90D08FF50EC608B1D")) {
        self.modifiers["_encstr_8F28080807D32F016928"] = 1;
        self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 4194304;
      }

      if(isDefined(var_5.damageflags) && var_5.damageflags &level.idflags_penetration && !(var_5.damageflags &level.ss_respawn)) {
        self.modifiers["_encstr_BDF80A4B90EBB782CF58CAC2"] = 1;
        self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 262144;
      }

      if(scripts\mp\equipment\gas_grenade::plunder_playerspawnedcallback(self, var_1)) {
        self.modifiers["_encstr_8A1A10DAA04FFC179327F9FACDF9C7048920"] = 1;
        self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 16777216;
      }

      if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatelootleadersonfixedinterval(var_1)) {
        self.modifiers["_encstr_BA800FD810CFC3B7F875D385B940C8B9BB"] = 1;
        self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 33554432;
      }

      if(scripts\mp\weapons::grenadeheldatdeath())
        self.modifiers["_encstr_BE440B3379E39B9E9160A2EA40"] = 1;

      if(issurvivorkill(self)) {
        self.modifiers["_encstr_86D81036EDEEF54356C2B13AA1BEB55A63D8"] = 1;
        self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 4096;
      }

      if(!self isonground())
        self.modifiers["_encstr_A64409C2D29C4CED93B9B2"] = 1;

      if(!var_1 isonground())
        self.modifiers["_encstr_9A93109B2818746A414F6F473DFE32CAD831"] = 1;

      if(self playermount() >= 0.5) {
        self.modifiers["_encstr_849508B2188BC58BF97D"] = 1;
        self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 32;
      }

      if(istrue(self._id_138AC))
        self.modifiers["_encstr_A2A406E139973007"] = self.modifiers["_encstr_A2A406E139973007"] | 4;

      if(var_18) {
        self.modifiers["_encstr_A6790E3AB329937F888F5C21935887FF"] = 1;
        var_30 = self getweaponammoclip(var_2);

        if(var_30 <= 0) {
          self.modifiers["_encstr_B4C8115907B3BD71F2CB1028F7CC397A4A5B21"] = 1;
          self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 64;
        }
      }

      if(scripts\mp\utility\weapon::iscacprimaryorsecondary(var_2) && var_3 != "_encstr_8DED0A21C79B660BC7588981") {
        if(scripts\mp\utility\player::isplayerads()) {
          self.modifiers["_encstr_AD1904291F7B"] = 1;
          self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 8;
        } else {
          self.modifiers["_encstr_B48408136397CAC13031"] = 1;
          self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 16;
        }
      }

      if(var_1 issprinting()) {
        self.modifiers["_encstr_AB4011F653989B2F397EABA3E3037BD390359F"] = 1;
        self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 128;
      }

      if(level.teambased) {
        foreach(var_32 in level.players) {
          if(self.team != var_32.team || self == var_32) {
            continue;
          }
          if(!scripts\mp\utility\player::isreallyalive(var_32)) {
            continue;
          }
          if(distancesquared(self.origin, var_32.origin) < 90000) {
            self.modifiers["_encstr_A7220B9A13D8E7E7A86082DAA8"] = 1;
            break;
          }
        }
      }

      if(scripts\mp\weapons::isstunnedorblinded()) {
        self.modifiers["_encstr_B2F509A8DDF8803BB30F69"] = 1;
        self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 64;
      }

      if(var_1 scripts\mp\weapons::isstunned()) {
        self.modifiers["_encstr_B2D012A590EA7BF1495B39D593A0BD2FC7EB4DA8"] = 1;
        self.modifiers["_encstr_A2A406E139973007"] = self.modifiers["_encstr_A2A406E139973007"] | 1;
      }

      if(var_1 scripts\mp\weapons::isblinded()) {
        self.modifiers["_encstr_82C31293CAD76D18152A99EB5E3F303DAF626858"] = 1;
        self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 8388608;
      }

      if(isDefined(self.tookweaponfrom[var_8]) && self.tookweaponfrom[var_8] == var_1) {
        self.modifiers["_encstr_87CC098985C65B662D4E59"] = 1;
        self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 32768;
      }
    } else if(var_7 == "_encstr_BDBF1277568507DEE67D0E9CED4DB21BA32DB195") {
      if(isDefined(var_4) && isDefined(var_4.adsfire)) {
        if(var_4.adsfire) {
          self.modifiers["_encstr_AD1904291F7B"] = 1;
          self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 8;
        } else {
          self.modifiers["_encstr_B48408136397CAC13031"] = 1;
          self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 16;
        }
      }
    }

    if(!var_1 isonground() && !var_1 iswallrunning() && (!self isonground() && !self iswallrunning())) {
      if(var_12)
        self.modifiers["_encstr_829F10A9DCFA71B562E7637B7B4972988CF5"] = 1;
    } else {
      if(var_12) {
        if(self iswallrunning())
          self.modifiers["_encstr_BD8F09036F392283C0904B"] = 1;
        else if(isdeathfromabove(self, var_2, var_3, var_13, var_1))
          self.modifiers["_encstr_92FC09FA30050B774B8C78"] = 1;
        else if(events_issliding()) {
          self.modifiers["_encstr_AD670ADCC6B423CA5B96638D"] = 1;
          self.modifiers["_encstr_8F420803FDBB8183D0DF"] = 1;
          self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 256;
        }

        var_34 = self getstance();

        switch (var_34) {
          case "_encstr_922406F1A6FD5E05":
            self.modifiers["_encstr_97080B0E397BCD2BEBDA96D8D8"] = 1;
            self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 512;
            break;
          case "_encstr_B13D076BED70539F23":
            self.modifiers["_encstr_AD5E0CB19C7B5DC60DFA6D5AD81B"] = 1;
            self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 1024;
            break;
        }
      }

      if(var_1 iswallrunning())
        self.modifiers["_encstr_8F3B0B07FCF9B9AD30574F45E4"] = 1;
      else if(isskeetshooter(self, var_2, var_3, var_13, var_1))
        self.modifiers["_encstr_81DA0AAD2D36C6A5E616D24E"] = 1;
    }

    if(isDefined(var_1.streakdata)) {
      foreach(var_36 in var_1.streakdata.streaks) {
        var_37 = var_36.currentcost - var_1.streakpoints;

        if(var_37 > 0 && var_37 <= 1) {
          self.modifiers["_encstr_ACE1097ABDCDAAFF83FCB1"] = var_1.pers["_encstr_84C910D248050977F8F9A49F0E236BCF4B20"];
          self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 67108864;
          break;
        }
      }
    }

    if(!scripts\mp\utility\game::runleanthreadmode()) {
      if(level.teambased) {
        var_39 = 0;
        var_40 = scripts\mp\utility\teams::getenemyplayers(self.team);

        foreach(var_42 in var_40) {
          if(var_42.score > 0) {
            var_39 = 1;
            break;
          }
        }

        if(var_39) {
          if(is_enemy_highest_score(var_1, var_40)) {
            self.modifiers["_encstr_B18D0B5281530117EDEAC82033"] = 1;
            self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 4;
          }
        }
      } else {
        var_39 = 0;

        foreach(var_42 in level.players) {
          if(var_42.score > 0) {
            var_39 = 1;
            break;
          }
        }

        if(var_39) {
          if(is_enemy_highest_score(var_1, level.players)) {
            self.modifiers["_encstr_B18D0B5281530117EDEAC82033"] = 1;
            self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 4;
          }
        }
      }
    }

    if(isDefined(var_4) && istrue(var_4.isequipment) && var_3 == "_encstr_A1ED0BA9FF84562B60BA073E83" && !scripts\mp\utility\weapon::isthrowingknife(var_2.basename)) {
      self.modifiers["_encstr_A1870C3ABB306819D982C9FFDE48"] = 1;
      self.modifiers["_encstr_A2A406E139973007"] = self.modifiers["_encstr_A2A406E139973007"] | 32;
    }

    if(scripts\mp\utility\damage::islauncherdirectimpactdamage(var_2, var_3))
      self.modifiers["_encstr_8BCF1098EAA3DD69AB752EB04187338B8E23"] = 1;

    if(var_17 >= 0.6428)
      self.modifiers["_encstr_9BFB183B4BD81DA5D6FAA537EB373A85CD4616C946FAEC4B2BEE"] = 1;

    if(isDefined(self.lastadsstarttime) && var_6 - self.lastadsstarttime <= 500 && (var_7 == "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33" || var_7 == "_encstr_A1710B57AD31DBCDCDF1422A60")) {
      self.modifiers["_encstr_B8720B4FAB6237809B6FA0505F"] = 1;
      self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 2048;
    }

    if(isDefined(self.lastweaponchangetime) && var_6 - self.lastweaponchangetime <= 2500) {
      self.modifiers["_encstr_ADF013B09F690BDF1A215ED386320711EF0FD8E0C3"] = 1;
      self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 8192;
    }

    if(isDefined(self.tookweaponfrom[var_8]) && self.tookweaponfrom[var_8].team != self.team || scripts\mp\utility\weapon::ispickedupweapon(var_2)) {
      self.modifiers["_encstr_85CF13E7101130B295E04A04D6A72BF87EF81773B0"] = 1;
      self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 16384;
    }

    if(isDefined(self.lastreloadtime) && var_6 - self.lastreloadtime <= 5000) {
      self.modifiers["_encstr_84460CE597C2B00B74C170083554"] = 1;
      self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 65536;
    }

    var_46 = self getvelocity();
    var_47 = var_46[0] >= 0.1 || var_46[0] <= -0.1;
    var_48 = var_46[1] >= 0.1 || var_46[1] <= -0.1;
    var_49 = var_46[2] >= 0.1 || var_46[2] <= -0.1;

    if(var_47 || var_48 || var_49) {
      self.modifiers["_encstr_BE650C1F87D443EB3BB95CFFAD70"] = 1;
      self.modifiers["_encstr_A2A406E139973007"] = self.modifiers["_encstr_A2A406E139973007"] | 2;
    }

    if(istrue(var_1.isdefusing))
      self.modifiers["_encstr_9BD90F6D4BB1C6CA46FA8C56CCD59BB227"] = 1;

    if(scripts\mp\utility\weapon::iscacsecondaryweapon(var_2) || scripts\mp\utility\perk::_hasperk("_encstr_964616CBE2F359E0193A0BB817C54BF098D340205BB0F765") && isDefined(self.secondaryweaponobj) && var_2 == self.secondaryweaponobj) {
      self.modifiers["_encstr_8C5D11B9CAC6B79B8C589C97AFBB2BB0C1B7CD"] = 1;
      self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 131072;
    }

    if(scripts\mp\utility\player::unset_relic_trex(self)) {
      self.modifiers["_encstr_8CBE0BD1BED30936AB03C0B02B"] = 1;
      self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 1024;
    }

    if(scripts\mp\utility\player::unset_relic_trex(var_1) || istrue(var_5.enemy_monitor_trialending)) {
      self.modifiers["_encstr_A14A1293CAD76D18151799FB433BE1B6D3E22859"] = 1;
      self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 2048;
    }

    if(scripts\cp_mp\utility\player_utility::isinvehicle()) {
      self.modifiers["_encstr_B1190B49FDD9BBBF1B180A82E1"] = 1;
      self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 4096;
    }

    if(var_1 scripts\cp_mp\utility\player_utility::isinvehicle()) {
      self.modifiers["_encstr_A94E123BD2B11D5AADFA2D9BEB672B1AD26CB1B2"] = 1;
      self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 8192;
    }

    if(isDefined(var_4) && isDefined(var_4.equipmentref)) {
      if(var_4.equipmentref == "_encstr_843D095F2B7D52B041D9A3" || var_4.equipmentref == "_encstr_82A70F2B3B73E33B472371FF21D7809DDF") {
        var_50 = var_4 getlinkedparent();

        if(isDefined(var_50) && isDefined(var_50.helperdronetype) && var_50.helperdronetype == "_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC") {
          self.modifiers["_encstr_A6B1168EB0FF85A09189EAFA3693E905599A35BF9BF993DD"] = 1;
          self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 32768;

          if(level.challengesallowed && isDefined(var_50.owner))
            self._id_12A9A = var_50.owner;
        } else if(isDefined(var_50) && var_50 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
          self.modifiers["_encstr_86F612D995865A1BB12BFA953C1CD87B3796B3CA"] = 1;
          self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 65536;
        }
      } else if(var_4.equipmentref == "_encstr_BAA11195B85DD20EF5DCABC1C1EDC9A309F6F0")
        self.modifiers["_encstr_A2A406E139973007"] = self.modifiers["_encstr_A2A406E139973007"] | 2048;
    }

    var_51 = scripts\cp\vehicles\vehicle_compass_cp::_encstr_B6851AEC95A3BD0E95E485A3F6E4332C677BC9A53A95EECA16E0BDB9(var_10[0]);

    if(var_51 != "_encstr_B40101") {
      if(scripts\mp\utility\weapon::getweaponrootname(var_2.basename) == var_51)
        self.modifiers["_encstr_A2A406E139973007"] = self.modifiers["_encstr_A2A406E139973007"] | 512;
    }

    if(scripts\mp\utility\perk::_hasperk("_encstr_974F126E38591BB4C2B1D12FF5B8D5A556E85939") && scripts\mp\utility\perk::_hasperk("_encstr_99241C0B7A0D70DB62CB697BEF7A1049A2965363E575D986CAE791793FE3") && scripts\mp\utility\perk::_hasperk("_encstr_99C916E638ACB1B42C8D47E5AF1B4B9D1AE8EE59D2B3D0E8"))
      self.modifiers["_encstr_A2A406E139973007"] = self.modifiers["_encstr_A2A406E139973007"] | 1024;

    if((var_10[0] == "_encstr_8E5E0AB968EB8385636B2BE4" || var_10[0] == "_encstr_81DC0BCD86AF46BD7676CA8EE8") && (var_11[0] == "_encstr_8E5E0AB968EB8385636B2BE4" || var_11[0] == "_encstr_81DC0BCD86AF46BD7676CA8EE8"))
      self.modifiers["_encstr_A2A406E139973007"] = self.modifiers["_encstr_A2A406E139973007"] | 4096;
  }

  if(scripts\mp\utility\weapon::iskillstreakweapon(var_2.basename) || scripts\mp\utility\weapon::unsetreduceregendelayonkills(var_4))
    self.modifiers["_encstr_85CE0B9770B02C73A1760F06D2"] = 1;

  if(isDefined(self.lastkilledby) && self.lastkilledby == var_1) {
    self.modifiers["_encstr_811F08C0C726E1953267"] = 1;
    self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 16777216;
  }

  var_52 = 1;
  var_53 = 0;
  var_54 = 0;

  if(isDefined(var_1.damagedplayers)) {
    var_55 = scripts\mp\utility\teams::getteamdata(self.team, "_encstr_9775086022BE1B413B8B");

    foreach(var_61, var_57 in var_1.damagedplayers) {
      if(!istrue(var_54) || !istrue(var_53)) {
        foreach(var_59 in var_55) {
          if(isDefined(var_59) && isDefined(var_59.guid) && var_59.guid == var_61) {
            if(isalive(var_59) && var_59.team == self.team && var_6 - var_57 < 1750) {
              self.modifiers["_encstr_9AD407EB275B37556D"] = 1;
              self.modifiers["_encstr_A2A406E139973007"] = self.modifiers["_encstr_A2A406E139973007"] | 8192;
              var_53 = 1;

              if(var_7 == "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33") {
                self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 134217728;
                var_54 = 1;
              }

              break;
            }
          }
        }
      }

      if(self.guid == var_61)
        var_52 = 0;
    }
  }

  if(self.health == self.maxhealth && istrue(var_52))
    self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 268435456;

  foreach(var_63 in level.decoygrenades) {
    if(isDefined(var_63.playersdebuffed)) {
      foreach(var_65 in var_63.playersdebuffed) {
        if(var_1 == var_65)
          self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 536870912;
      }
    }
  }

  var_68 = reset_map_dvars();

  if(var_68.size > 0) {
    foreach(var_61 in var_68) {
      if(var_9 == var_61) {
        self.modifiers["_encstr_A9A70EBA79A398D307C02B586A9A8333"] = 1;
        self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 16;
        break;
      }
    }
  }

  if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB") {
    if(self.modifiers["_encstr_87A205AF10734B"] & 1048576 && self.modifiers["_encstr_87A205AF10734B"] & 262144)
      getjuggdamagescale(var_2);
  }

  if(var_7 == "_encstr_8261067B1D34AC27")
    getkillstreakairstrikeheightent(var_2);
}

registerhints(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0;
  return var_5;
}

registerleveldataforvehicle(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0;

  if(scripts\mp\class::vehicle_checkpiggybackexploit(var_2))
    var_5 = var_5 | 131072;

  if(scripts\mp\equipment\gas_grenade::plunder_playerspawnedcallback(self, var_1))
    var_5 = var_5 | 16777216;

  if(var_1 scripts\mp\weapons::isblinded())
    var_5 = var_5 | 8388608;

  if(scripts\mp\utility\player::unset_relic_trex(var_1))
    var_5 = var_5 | 2048;

  if(scripts\cp_mp\utility\killstreak_utility::teamhasuav(var_1.team))
    var_5 = var_5 | 1;

  if(scripts\cp_mp\utility\player_utility::isinvehicle())
    var_5 = var_5 | 4096;

  if(isDefined(self.radarstrength) && self.radarstrength > 3 && !var_1 scripts\mp\utility\perk::_hasperk("_encstr_865013A373482BFBE0426B73E90D08FF50EC608B1D"))
    var_5 = var_5 | 4194304;

  return var_5;
}

killedplayer(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = gettime();

  if(isDefined(var_2._id_121D9))
    var_2 = var_2._id_121D9;

  level.numkills++;

  if(level.lastkilltime != var_6) {
    level.prevlastkilltime = level.lastkilltime;
    level.lastkilltime = var_6;
  }

  cargo_truck_mg_initoccupancy(var_0, var_1, var_2, var_3, var_4, var_5);
  checkkillstreakkillevents(var_2, var_3, var_4);
  thread getgulagclosedcircleindex(var_1);
  var_7 = var_1.guid;
  var_8 = self.guid;
  var_9 = createheadicon(var_2);
  thread killedplayernotifysys(var_0, var_1, var_2, var_3);
  thread updaterecentkills(var_0, var_1, var_2, var_9);
  thread _id_13FE5(var_3, var_4, var_1);
  thread updatequadfeedcounter(self, var_0);
  self.prevlastkilltime = self.lastkilltime;
  self.lastkilltime = var_6;
  self.lastkilledplayer = var_1;
  self.lastkillvictimpos = var_1.origin;

  if(self.deaths > 0) {
    var_10 = self.kills / self.deaths;

    if(var_10 > 3.0)
      level thread scripts\mp\battlechatter_mp::saytoself(self, "_encstr_9BEC0C72814DCF24BFA0030B64BB", undefined, 0.75);
  } else if(self.kills > 5)
    level thread scripts\mp\battlechatter_mp::saytoself(self, "_encstr_9BEC0C72814DCF24BFA0030B64BB", undefined, 0.75);

  if(istrue(self.laststanding))
    scripts\mp\utility\stats::incpersstat("_encstr_871B071B63D547B10D", 1);

  self.damagedplayers[var_7] = undefined;
  var_11 = scripts\mp\utility\weapon::getweapongroup(var_2.basename);

  if(istrue(self.modifiers["_encstr_85E10B66B44E6EA3981BBDDE91"]))
    firstblood(var_0);

  if(istrue(self.modifiers["_encstr_B1100A561EACC6AB3AB47BCD"]))
    execution(var_0);

  if(!scripts\mp\utility\weapon::iskillstreakweapon(var_2.basename) && !scripts\mp\utility\perk::_hasperk("_encstr_B4371B9BE0B26C5A85B1A32FD7CAE11C1B7B374B3B2B26AB361B95479B")) {
    if(var_2.basename == "_encstr_8BBA05185F8B99" && var_3 != "_encstr_AA230E8CF56CD18DB12FC7E303C8C001")
      return 0;

    var_12 = celebration_end(self, var_4, var_2, var_3);

    if(istrue(self.modifiers["_encstr_87B20CC852EF5FB07FBC7A638C5B"])) {
      thread killeventtextpopup("_encstr_82C80E2F4D3D79FBC0906BB908103C82", 1);
      thread scripts\mp\awards::givemidmatchaward("_encstr_82C80E2F4D3D79FBC0906BB908103C82");
      scripts\mp\utility\stats::incpersstat("_encstr_AC3310E07AC707A817C41088ADFFF031ED33", 1);
    }

    if(istrue(self.modifiers["_encstr_928008AF7D084BE35110"])) {
      thread killeventtextpopup("_encstr_862509E16B2BE74B6BA8E8", 1);
      thread scripts\mp\awards::givemidmatchaward("_encstr_862509E16B2BE74B6BA8E8");
    }

    if(var_3 == "_encstr_8DED0A21C79B660BC7588981") {
      if(var_2.basename == "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C") {
        thread killeventtextpopup("_encstr_BE690A143B833BD15F694030", 1);
        thread scripts\mp\awards::givemidmatchaward("_encstr_BE690A143B833BD15F694030");
      }
    }

    if(istrue(self.modifiers["_encstr_950310C2E637D29B8E2B32CDABD2B1D2C8AC"]))
      assistedsuicide(var_0, var_2);

    if(istrue(self.modifiers["_encstr_92DF0956DA8F69425F23C8"]))
      comeback(var_0);

    if(istrue(self.modifiers["_encstr_848909BBD3A7526348E8E3"])) {
      level thread scripts\mp\battlechatter_mp::saytoself(self, "_encstr_8CDD166B719E51CBD018951F50E005A97B8BB7B3F7CB1AAC", undefined, 0.75);
      headshot(var_0);
    }

    if(istrue(self.modifiers["_encstr_93150B9B625FB5C8DBEDA79B1B"]))
      postdeathkill(var_0);

    if(!scripts\mp\utility\player::isreallyalive(self) && isDefined(self.deathtime)) {
      var_13 = gettime() - self.deathtime;

      if(scripts\mp\utility\game::issimultaneouskillenabled()) {
        if(var_13 == 0 && isDefined(self.lastattacker) && self.lastattacker == var_1) {
          thread killeventtextpopup("_encstr_9A4212B8B27DC3A0E35908F53F8F0BCFA41AF8C8", 0);
          thread scripts\mp\awards::givemidmatchaward("_encstr_9A4212B8B27DC3A0E35908F53F8F0BCFA41AF8C8", undefined, undefined, 1);
          var_1 thread killeventtextpopup("_encstr_9A4212B8B27DC3A0E35908F53F8F0BCFA41AF8C8", 0);
          var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_9A4212B8B27DC3A0E35908F53F8F0BCFA41AF8C8", undefined, undefined, 1);
        }
      }
    }

    if(istrue(self.modifiers["_encstr_977C08697BE705EAA5E3"]))
      avengedplayer(var_0, var_1.lastkilledplayer);

    var_14 = undefined;

    if(var_1 isinexecutionattack()) {
      var_15 = scripts\common\utility::playersnear(var_1.origin, 300);

      foreach(var_17 in var_15) {
        if(var_17.team == self.team && var_17 isinexecutionvictim()) {
          var_14 = var_17.guid;
          defendedplayer(var_0, var_17.guid);
          break;
        }
      }
    }

    foreach(var_21, var_20 in var_1.damagedplayers) {
      if(var_21 == self.guid || var_21 == var_1.guid) {
        continue;
      }
      if(isDefined(var_14) && var_21 == var_14) {
        continue;
      }
      if(level.teambased && var_6 - var_20 < 1750)
        defendedplayer(var_0, var_21);
    }

    if(istrue(self.modifiers["_encstr_A90B0B68C75085F316A022DA28"]))
      thread pointblank(var_0);

    if(istrue(self.modifiers["_encstr_B82009D8DBE6D9CDD0B7E8"]))
      thread longshot(var_0);

    if(istrue(self.modifiers["_encstr_86500EF327F03197887228922B19E053"]))
      thread very_longshot(var_0);

    if(istrue(self.modifiers["_encstr_A13C0913C2C6B5CD470B31"])) {
      if(var_2.basename == "_encstr_BED80D7C9C59D95BF870DBDFA9F018") {
        thread killeventtextpopup("_encstr_A13C0913C2C6B5CD470B31", 1);
        thread scripts\mp\awards::givemidmatchaward("_encstr_A13C0913C2C6B5CD470B31");
      }
    }

    if(var_12) {
      switch (weaponclass(var_2.basename)) {
        case "_encstr_965306392D3336B2":
          scripts\mp\utility\stats::incpersstat("_encstr_874F0847251A2AD4D0C3", 1);
          var_1 scripts\mp\utility\stats::incpersstat("_encstr_8577097F528803E9B41B28", 1);

          if(var_3 == "_encstr_87280E1FB705D168313D1FD197B1A799")
            scripts\mp\utility\stats::incpersstat("_encstr_A9E50C61184837F11940A8D573B7", 1);

          break;
        case "_encstr_BE1904DCDA9D":
          scripts\mp\utility\stats::incpersstat("_encstr_AA2809F3982F54BBA09C28", 1);
          var_1 scripts\mp\utility\stats::incpersstat("_encstr_8DEB0A3EE517055BCEDBE030", 1);

          if(var_3 == "_encstr_87280E1FB705D168313D1FD197B1A799")
            scripts\mp\utility\stats::incpersstat("_encstr_A5A10D37B69D8459C223B91A7B1DDC", 1);

          if(istrue(self.modifiers["_encstr_AD1904291F7B"])) {
            if(!isDefined(self.pers["_encstr_A7FF0C03DD3410080F51C1C0C437"]))
              self.pers["_encstr_A7FF0C03DD3410080F51C1C0C437"] = 1;
            else
              self.pers["_encstr_A7FF0C03DD3410080F51C1C0C437"]++;
          }

          break;
        case "_encstr_A1100738A33A638123":
          scripts\mp\utility\stats::incpersstat("_encstr_A6890DB388305B573845EBC169D81A", 1);
          var_1 scripts\mp\utility\stats::incpersstat("_encstr_B46F0E432830992F07FAF43957CB68EB", 1);

          if(var_3 == "_encstr_87280E1FB705D168313D1FD197B1A799")
            scripts\mp\utility\stats::incpersstat("_encstr_8F79114EEC0219019D5B99F84FA4DB796A93C6", 1);

          break;
        case "_encstr_BE0703A54C":
          scripts\mp\utility\stats::incpersstat("_encstr_859C09016D42A72D449380", 1);
          var_1 scripts\mp\utility\stats::incpersstat("_encstr_A16A0AD86BEC44CA2C1D349B", 1);

          if(var_3 == "_encstr_87280E1FB705D168313D1FD197B1A799")
            scripts\mp\utility\stats::incpersstat("_encstr_B8C80DA3CBBC886D08712AF40878A3", 1);

          break;
        case "_encstr_850707F7E5833355B8":
          scripts\mp\utility\stats::incpersstat("_encstr_AFE80C9BE696E056E45A4B63B1B9", 1);
          var_1 scripts\mp\utility\stats::incpersstat("_encstr_82070D105DB4B7F146C9CBDB2953DF", 1);

          if(var_3 == "_encstr_87280E1FB705D168313D1FD197B1A799")
            scripts\mp\utility\stats::incpersstat("_encstr_A9BF1033C8B3CB5780894549F9A05CEF6503", 1);

          if(istrue(self.modifiers["_encstr_87B20CC852EF5FB07FBC7A638C5B"])) {
            if(!isDefined(self.pers["_encstr_ACF81397CBE24F50F25540394AC0C885787F3121C7"]))
              self.pers["_encstr_ACF81397CBE24F50F25540394AC0C885787F3121C7"] = 1;
            else
              self.pers["_encstr_ACF81397CBE24F50F25540394AC0C885787F3121C7"]++;
          }

          break;
        case "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0":
          scripts\mp\utility\stats::incpersstat("_encstr_AF680E8C6F73630E01E0E308F871855F", 1);
          var_1 scripts\mp\utility\stats::incpersstat("_encstr_920A0F7CBFA3B3DED1D0D3A8C81BD363DB", 1);

          if(var_3 == "_encstr_87280E1FB705D168313D1FD197B1A799")
            scripts\mp\utility\stats::incpersstat("_encstr_922712C92F7B5E03686F7BDB6501B3F024F76B78", 1);

          break;
        case "_encstr_8D940738966ED1DB8D":
          scripts\mp\utility\stats::incpersstat("_encstr_A1260C786A22E9E8BB5BA32944FF", 1);
          var_1 scripts\mp\utility\stats::incpersstat("_encstr_8E920DA7E166F320DB91DB73730AAB", 1);

          if(var_3 == "_encstr_87280E1FB705D168313D1FD197B1A799")
            scripts\mp\utility\stats::incpersstat("_encstr_A2771083B4DC8EBD8D1256B019B91A7BE8DC", 1);

          break;
      }

      if(var_2 hasattachment("_encstr_AD9C07E0478148252A", 1))
        self.modifiers["_encstr_A2A406E139973007"] = self.modifiers["_encstr_A2A406E139973007"] | 256;

      if(var_3 == "_encstr_8DED0A21C79B660BC7588981") {
        scripts\mp\utility\stats::incpersstat("_encstr_93500B11CD1B017B642AA0A8E3", 1);
        var_1 scripts\mp\utility\stats::incpersstat("_encstr_9BF60CB62B1B5995442B853A0D37", 1);
      } else if(var_3 == "_encstr_9B0D099AD3887D91252954" || isDefined(var_2) && isDefined(var_2.basename) && var_2.basename == "_encstr_BA730BF8AFF178988293F158B9") {
        if(!isDefined(self.pers["_encstr_B2F50A49DCFAA02A022B794F"]))
          self.pers["_encstr_B2F50A49DCFAA02A022B794F"] = 1;
        else
          self.pers["_encstr_B2F50A49DCFAA02A022B794F"]++;

        self.modifiers["_encstr_A2A406E139973007"] = self.modifiers["_encstr_A2A406E139973007"] | 128;
      }

      if(isDefined(level.supportdrones) && level.supportdrones.size > 0) {
        foreach(var_23 in level.supportdrones) {
          if(var_23.owner == self && var_23.helperdronetype == "_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60") {
            var_23.owner scripts\mp\utility\stats::incpersstat("_encstr_A2C11B640B1902BB43404F67B0FF652BFF90AD1E61C368C6CCF0635B98", 1);
            break;
          }
        }
      }

      if(istrue(self.modifiers["_encstr_86D81036EDEEF54356C2B13AA1BEB55A63D8"])) {
        thread givekillreward("_encstr_86D81036EDEEF54356C2B13AA1BEB55A63D8", var_0, var_2, "_encstr_86D81036EDEEF54356C2B13AA1BEB55A63D8");
        level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "_encstr_99DB1566D9089BB736FEFA72010ED317508110E34BC8A5", undefined, 1);
      }

      if(istrue(self.modifiers["_encstr_AD1904291F7B"]))
        scripts\mp\utility\stats::incpersstat("_encstr_A928091BA95B0A48FBE8D3", 1);
      else if(istrue(self.modifiers["_encstr_B48408136397CAC13031"]))
        scripts\mp\utility\stats::incpersstat("_encstr_81B00D6844C3B7343A28E1194043A0", 1);

      if(istrue(self.modifiers["_encstr_BE650C1F87D443EB3BB95CFFAD70"])) {
        if(!isDefined(self.pers["_encstr_92B50CDABDB3D2DCEC695A8D8D37"]))
          self.pers["_encstr_92B50CDABDB3D2DCEC695A8D8D37"] = 1;
        else
          self.pers["_encstr_92B50CDABDB3D2DCEC695A8D8D37"]++;
      }

      if(self ismantling())
        _id_11ABE(var_0);

      if(istrue(self.modifiers["_encstr_87CC098985C65B662D4E59"]))
        chopper_boss_players_connect_monitor(var_0);
    }

    if(istrue(self.modifiers["_encstr_829F10A9DCFA71B562E7637B7B4972988CF5"]))
      thread givekillreward("_encstr_829F10A9DCFA71B562E7637B7B4972988CF5", var_0, var_2, "_encstr_829F10A9DCFA71B562E7637B7B4972988CF5");

    if(istrue(self.modifiers["_encstr_BD8F09036F392283C0904B"]))
      thread givekillreward("_encstr_BD8F09036F392283C0904B", var_0, var_2, "_encstr_81B40DD3BFC9D26AB350579F70C83C");

    if(istrue(self.modifiers["_encstr_92FC09FA30050B774B8C78"]))
      thread givekillreward("_encstr_92FC09FA30050B774B8C78", var_0, var_2, "_encstr_B8EA091FD0D3FF127B99AD");

    if(istrue(self.modifiers["_encstr_8F420803FDBB8183D0DF"])) {
      thread givekillreward("_encstr_AD670ADCC6B423CA5B96638D", var_0, var_2, "_encstr_A1B40BC35B809298A1F89089A5");
      thread killeventtextpopup("_encstr_A1B40BC35B809298A1F89089A5", 1);

      if(!isDefined(self.pers["_encstr_929E0B1F4C129278AC8BE42A63"]))
        self.pers["_encstr_929E0B1F4C129278AC8BE42A63"] = 1;
      else
        self.pers["_encstr_929E0B1F4C129278AC8BE42A63"]++;
    }

    if(istrue(self.modifiers["_encstr_8F3B0B07FCF9B9AD30574F45E4"]))
      thread givekillreward("_encstr_8F3B0B07FCF9B9AD30574F45E4", var_0, var_2, "_encstr_A342108A29F3C8F7934238634B2B5D400FDA");

    if(istrue(self.modifiers["_encstr_81DA0AAD2D36C6A5E616D24E"]))
      thread givekillreward("_encstr_81DA0AAD2D36C6A5E616D24E", var_0, var_2, "_encstr_99F70C6D96B11BFA9AD5DA0759E4");

    if(istrue(self.modifiers["_encstr_ACE1097ABDCDAAFF83FCB1"]))
      buzzkill(var_0, var_1);

    if(istrue(self.modifiers["_encstr_B2F509A8DDF8803BB30F69"]))
      start_conceal_add(var_0);

    if(isDefined(var_1.stuckbygrenade))
      level thread scripts\mp\battlechatter_mp::saytoself(self, "_encstr_966E147BD8F39F721BF9CD4753152A577B088793786A", undefined, 0.75);

    if(scripts\mp\utility\weapon::isthrowingknife(var_2.basename) || scripts\mp\utility\weapon::isaxeweapon(var_2) && isDefined(var_4.classname) && var_4.classname == "_encstr_8C8D08671D451291C849") {
      thread killeventtextpopup("_encstr_838113CBD840BFBB731D271F752BF2ED816D0455B0", 1);
      thread scripts\mp\awards::givemidmatchaward("_encstr_838113CBD840BFBB731D271F752BF2ED816D0455B0");
    }

    if(scripts\mp\gamescore::isdebuffedbyweaponandplayer(self, var_1, "_encstr_BE8B116725FA28FB5178B2CF85017912618763"))
      scripts\mp\rank::scoreeventpopup("_encstr_8B130CEA4BC09307A576123A3889");

    if(istrue(self.modifiers["_encstr_B18D0B5281530117EDEAC82033"])) {
      voting(var_0);

      if(scripts\mp\utility\game::getgametype() == "_encstr_8A1804DAAB75" && var_3 == "_encstr_8DED0A21C79B660BC7588981") {
        thread killeventtextpopup("_encstr_92D21943F78FB82017D3B09EBAF76160676F43F7743958F137AA29", 1);
        thread scripts\mp\awards::givemidmatchaward("_encstr_92D21943F78FB82017D3B09EBAF76160676F43F7743958F137AA29");
      }
    }

    if(self.score < var_1.score)
      scripts\mp\utility\stats::incpersstat("_encstr_99D91268D3381C9F365F0AC24085D39C10B114FB", 1);
    else
      scripts\mp\utility\stats::incpersstat("_encstr_8A51113065B7E8FEE95705377FB25A40743D5B", 1);

    var_25 = self.pers["_encstr_84C910D248050977F8F9A49F0E236BCF4B20"] + 1;
    var_26 = 5;

    if(level.gametype == "_encstr_B81904B04E6B" || level.gametype == "_encstr_931D068662634370")
      var_26 = 10;

    if(!(var_25 % var_26)) {
      if(!isDefined(self.lastkillsplash) || var_25 != self.lastkillsplash) {
        thread scripts\mp\hud_util::teamplayercardsplash("_encstr_A1AE1767379DA198DB6B774F126044CE4B298A3581A0CA38AF", self, undefined, var_25);
        self.lastkillsplash = var_25;
      }

      if(var_25 <= 30) {
        thread killeventtextpopup("_encstr_A2930837D1E4CAB0DAD7" + var_25, 1);
        thread scripts\mp\awards::givemidmatchaward("_encstr_A2930837D1E4CAB0DAD7" + var_25);
      }
    }

    if(!(var_25 % 5))
      scripts\mp\utility\game::setmlgannouncement(13, self.team, self getentitynumber(), var_25);

    if(var_25 > 30) {
      thread killeventtextpopup("_encstr_A2390B4EEBD33BC1839FB0D82B", 1);
      thread scripts\mp\awards::givemidmatchaward("_encstr_A2390B4EEBD33BC1839FB0D82B");
    }

    if(istrue(self.modifiers["_encstr_A1870C3ABB306819D982C9FFDE48"]))
      thread scripts\mp\awards::givemidmatchaward("_encstr_A1870C3ABB306819D982C9FFDE48");

    if(istrue(self.modifiers["_encstr_8BCF1098EAA3DD69AB752EB04187338B8E23"]))
      linkedsaw(var_0);

    if(scripts\mp\utility\game::getgametypenumlives() >= 1) {
      if(var_1.pers["_encstr_8CAA06DB20A31543"] == 0)
        thread scripts\mp\awards::givemidmatchaward("_encstr_8BC4110DBF403F17539E2A42A0210735B021BD", undefined, undefined, undefined, undefined, var_1);

      var_27 = scripts\mp\utility\game::_id_13E13();

      if(isDefined(var_27) && var_27 == self)
        thread scripts\mp\awards::givemidmatchaward("_encstr_8DF912C268D957770A5094915E53AF9E61E0FBDA", undefined, undefined, undefined, undefined, var_1);
    }

    if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
      if(self ispcplayer())
        self setclientomnvar("_encstr_A621183B31A8EC1A53B3C47F9B6152B7D048377730E325B281C6", 25);

      if(var_1 ispcplayer())
        var_1 setclientomnvar("_encstr_A621183B31A8EC1A53B3C47F9B6152B7D048377730E325B281C6", 26);
    }

    checksuperkillevents(var_1, var_4, var_2, var_3, var_9);
    checksupershutdownevents(var_1, var_2, var_3);
  }

  if(istrue(self.modifiers["_encstr_811F08C0C726E1953267"])) {
    self.lastkilledby = undefined;
    revenge(var_0, var_1);
  }

  if(!scripts\mp\utility\game::lpcfeaturegated()) {
    if(!isDefined(self.killedplayers[var_7]))
      self.killedplayers[var_7] = 0;

    if(!isDefined(var_1.killedby[var_8]))
      var_1.killedby[var_8] = 0;

    self.killedplayers[var_7]++;
    var_1.killedby[var_8]++;
  }

  var_1.lastkilledby = self;

  if(!scripts\mp\utility\game::lpcfeaturegated() && !level.multiteambased) {
    var_28 = 0;

    if(level.teambased)
      var_28 = scripts\mp\utility\teams::getenemycount(self.team);
    else
      var_28 = level.players.size - 1;

    if(var_28 > 3 && self.killedplayers.size == var_28) {
      var_29 = 0;

      if(isDefined(self.pers["_encstr_A9F70E8A64FAE19D5EBF48D0436DD12B"]))
        var_29 = self.pers["_encstr_A9F70E8A64FAE19D5EBF48D0436DD12B"];

      var_30 = 1;

      foreach(var_17, var_32 in self.killedplayers) {
        if(var_32 <= var_29) {
          var_30 = 0;
          break;
        }
      }

      if(var_30)
        viphud_deletehud(var_0);
    }
  }

  if(!var_1 scripts\mp\utility\player::isusingremote() && (!var_1 scripts\mp\utility\perk::_hasperk("_encstr_A6B5137F3019DB2A03F1D388700FA372C350F387D8") || istrue(var_1.inlaststand)))
    var_1 thread scripts\mp\utility\player::setdof_killer();

  scripts\mp\utility\script::bufferednotify("_encstr_A3EC145383B883F9E3904AF2A8BF6E3F11FCA5C22D01", var_1, var_9, var_3, self.modifiers);
  thread scripts\mp\potg_events::onplayerkilled(self, var_4, var_1, var_3, var_2, var_5.psoffsettime);
}

checkkillstreakkillevents(var_0, var_1, var_2) {
  var_3 = scripts\mp\utility\weapon::iskillstreakweapon(var_0.basename) || scripts\mp\utility\weapon::unsetreduceregendelayonkills(var_2);
  var_4 = scripts\mp\utility\points::unset_relic_doomslayer(var_0);

  if(var_3 && !var_4) {
    if(isDefined(var_2) && isDefined(var_2.streakinfo)) {
      var_5 = 1;

      if(isDefined(var_2.streakinfo.mpstreaksysteminfo)) {
        var_6 = var_2.streakinfo.mpstreaksysteminfo.streaklifeid;
        var_7 = self.lifeid;

        if(!isDefined(var_6) || var_6 != var_7)
          var_5 = 0;

        if(var_2.streakinfo.mpstreaksysteminfo._id_121B0 != self getxuid())
          var_5 = 0;
      }

      if(isDefined(var_2.streakinfo.streakname)) {
        var_8 = 0;
        var_9 = 0;
        var_10 = 0;
        var_11 = var_2.streakinfo.streakname;

        switch (var_11) {
          case "_encstr_8CC008133958C81BACCB":
            scripts\mp\utility\stats::incpersstat("_encstr_B46814FA7070B16FFBBEA3BA4AE94F08B25C78ED993B", 1);
            var_8 = 1;
            var_10 = 1;
            break;
          case "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A":
            scripts\mp\utility\stats::incpersstat("_encstr_BDA01D9F534A81BF83C26831CFD1F828B7637FFA11DB0E800F4BC8436150CF", 1);
            var_8 = 1;
            var_9 = 1;
            break;
          case "_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3":
            scripts\mp\utility\stats::incpersstat("_encstr_BE091E244BD9C27B83808FA7705D28BAB95F2F1A3E43BBA00868C30708D014A3", 1);
            var_8 = 1;
            var_9 = 1;
            break;
          case "_encstr_B270105ECB28E94BC5CFABAB937D524C5053":
            scripts\mp\utility\stats::incpersstat("_encstr_87981DAFDFBA4918FC1239B17CF3287D422F3B9BB7138E4B0C2FE488A5B468", 1);
            var_8 = 1;
            var_9 = 1;
            break;
          case "_encstr_BA910F9957CA63EBB02D9C373A93B4B5CA":
            var_8 = 1;
            break;
          case "_encstr_86FD08B775CD07DC1338":
            scripts\mp\utility\stats::incpersstat("_encstr_95281764AFD21093A313920F5A27DF731A5853E9FF5F39BC7B", 1);
            var_8 = 1;
            var_9 = 1;
            break;
          case "_encstr_8C980A867B3B569CFAA659E8":
            scripts\mp\utility\stats::incpersstat("_encstr_A19A177BBB80BBDAE968A2FAB875DBFF3C82FDFCD248E325CF", 1);
            var_8 = 1;
            var_9 = 1;
            break;
          case "_encstr_8BFC0BC2CBD4F737E0A5E1FD79":
            scripts\mp\utility\stats::incpersstat("_encstr_9AFA1A708AAB2188137ACB3B9B74707C5FE2EB5892A765116C4CD117", 1);
            var_8 = 1;
            var_10 = 1;
            break;
          case "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4":
            scripts\mp\utility\stats::incpersstat("_encstr_BD731CA31BA8D51FED93B2FA9856AB4C08E924048BE01A0F95AC4A32809E", 1);
            var_8 = 1;
            var_10 = 1;
            break;
          case "_encstr_9688105BBAB1A32D7D0BD2E4373A4E96AD2B":
            var_8 = 1;
            break;
          case "_encstr_B1B30B51D176511E377A1BC313":
            scripts\mp\utility\stats::incpersstat("_encstr_8265185B5A368D371D4ECAC26DAE8659B21BDCED7396A5D88D6E", 1);
            var_8 = 1;
            var_10 = 1;
            break;
          case "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895":
            scripts\mp\utility\stats::incpersstat("_encstr_974519BC48630C6B6DB5DFC7EF8FB26A90737284A090E30249B19F", 1);
            var_8 = 1;
            var_9 = 1;
            break;
          case "_encstr_AA060B6EB2731DE4BCFAEC57E6":
            scripts\mp\utility\stats::incpersstat("_encstr_A94919B64B1B36CDA339CA16ADA656E63A9C2F8EAE735A4BC663E6", 1);
            var_8 = 1;
            var_10 = 1;
            break;
          case "_encstr_A2E60C6BC099B7E1A0A93A398F48":
            scripts\mp\utility\stats::incpersstat("_encstr_AFEF1C9B5B605B3A094882DA983FB577FB350A3B6D0B97C4C3A94A02C877", 1);
            var_8 = 1;
            var_9 = 1;
            break;
          case "_encstr_8161113BE8A8948A78316B7F5F9722F718D3B2":
            scripts\mp\utility\stats::incpersstat("_encstr_8E2427DA5AD863E63A27560BAD5D345A1DAC41D07B9B1CD0B7E4B75D9B694BD8D8DC826E37B4CD3A37", 1);
            var_8 = 1;
            var_9 = 1;
            break;
          case "_encstr_8C950E2F42AB5B3BFC5B7958BB07909B":
            scripts\mp\utility\stats::incpersstat("_encstr_88E51C805268E0E77326E788DFB8A3379340206D85202F501FC88C23E05B", 1);
            var_8 = 1;
            var_9 = 1;
            break;
          default:
            thread scripts\mp\utility\points::giveunifiedpoints("_encstr_8118166DACE9731F4B4EB9899079D75399A2AE3F5F28166F", var_0);
            break;
        }

        if(isDefined(var_2.streakinfo.kills)) {
          var_2.streakinfo.kills++;

          if(!istrue(var_2.streakinfo._id_11E04) && var_2.streakinfo.kills > 1) {
            scripts\cp\vehicles\vehicle_compass_cp::_id_12C3F("_encstr_AA552DD9C871388B1FDA2270CA875A40B7A717D6BB13E80A5B6042B1D8FA028DBF9D0FB0CFDAE3B17F30FB1BBE0ACE", 1);
            var_2.streakinfo._id_11E04 = 1;
          }
        }

        scripts\mp\utility\stats::incpersstat("_encstr_9AB11072A17B4037CBFBC8E0422CDB989343", 1);

        if(var_9)
          scripts\mp\utility\stats::incpersstat("_encstr_AD8D13A31A30ADC3A583BA30AF0384922F2B90C35B", 1);

        if(var_10)
          scripts\mp\utility\stats::incpersstat("_encstr_954016DA2DB16337E8935916DA8E39DEEA73322DB48DC6CD", 1);

        if(var_8) {
          var_12 = "_encstr_96BD09ABF3BF0AF0ADDC17" + var_11;
          var_13 = undefined;

          if(var_5 && scripts\mp\utility\perk::_hasperk("_encstr_AF821CB938956CD285363ACB7DB1D0C24B37D76D961BD89B47C9952CDADC")) {
            var_14 = level.awards[var_12].xpscoreevent;
            var_13 = scripts\mp\rank::getscoreinfovalue(var_14);
          }

          var_15 = 1;
          thread scripts\mp\awards::givemidmatchaward(var_12, var_13, undefined, undefined, var_15, undefined, var_5, var_2);
        }

        level thread scripts\mp\battlechatter_mp::saytoself(self, "_encstr_95EC18EF28138F38B3A1C13DB39317862F8818B38033D31519DF", undefined, 0.75);
      }
    }
  }
}

checksuperkillevents(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\mp\supers::issuperinuse();
  var_6 = scripts\mp\supers::getcurrentsuperref();
  var_7 = scripts\mp\supers::getcurrentsuper();
  var_8 = scripts\mp\utility\weapon::issuperweapon(var_2.basename);
  var_9 = undefined;

  if(!isDefined(var_6)) {
    return;
  }
  if(var_8) {
    thread killedplayerwithsuperweapon(var_0, var_1, var_2, var_3, var_4);

    if(var_3 != "_encstr_8DED0A21C79B660BC7588981")
      scripts\mp\utility\script::bufferednotify("_encstr_9B7E149BEA0E56E4FA6DD28DB1EB13BA9999564E9519");
  }

  var_10 = 0;

  if(isDefined(var_6)) {
    switch (var_6) {
      default:
        break;
    }

    if(var_10) {
      thread superkill(var_6, var_3);
      scripts\mp\supers::combatrecordsuperkill(var_6);

      if(isDefined(var_9))
        thread scripts\mp\utility\points::giveunifiedpoints(var_9);

      scripts\mp\utility\script::bufferednotify("_encstr_9B7E149BEA0E56E4FA6DD28DB1EB13BA9999564E9519");
    }
  }
}

checksupershutdownevents(var_0, var_1, var_2) {
  var_3 = var_0 scripts\mp\supers::issuperinuse();
  var_4 = var_0 scripts\mp\supers::getcurrentsuperref();
  var_5 = var_0 scripts\mp\supers::getcurrentsuper();

  if(!isDefined(var_4)) {
    return;
  }
  switch (var_4) {
    default:
      if(var_3 == 1)
        thread supershutdown(var_0);

      break;
  }
}

killedplayerwithsuperweapon(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\mp\supers::getsuperrefforsuperweapon(var_2);
  var_6 = self.recentkillsperweapon[var_4];

  if(isDefined(var_6) && var_6 > 0 && var_6 % 2 == 0)
    superkill(var_5, var_3);
  else {
    var_7 = scripts\mp\supers::getcurrentsuper();
    var_7.numkills++;
  }

  scripts\cp\vehicles\vehicle_compass_cp::updatesuperweaponkills(var_2, var_1);
  scripts\mp\supers::combatrecordsuperkill(var_5);
}

superkill(var_0, var_1) {
  var_2 = scripts\mp\supers::getrootsuperref(var_0);
  var_3 = "_encstr_9AB10C7EBD0B6135016AA8883229" + var_2;

  switch (var_3) {
    case "_encstr_A1271660ABE2CB4B777BA329444F51990E4348A8427D7161":
      var_3 = "_encstr_A99817DE1DABC195A1CAC8E852496D1B73BC705E68976BF717";
      break;
  }

  if(isDefined(level.awards[var_3]))
    thread scripts\mp\awards::givemidmatchaward(var_3);

  var_4 = scripts\mp\supers::getcurrentsuper();
  var_4.numkills++;
  scripts\cp\vehicles\vehicle_compass_cp::updatesuperkills(var_0, var_1, var_4.numkills);
  self.modifiers["_encstr_AF5911E775E2D0CE8F5AC85012B70998BFF951"] = var_0;
}

killedkillstreak(var_0, var_1, var_2) {
  var_3 = "_encstr_87D5095BD2C6C6F5DCDCEB" + var_0;

  if(isDefined(var_2) && weaponclass(var_2) != "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0" && var_2.basename != "_encstr_AD5210B0D388CF9573E1A8CF58B33C4120CA")
    var_2 = undefined;

  var_1 thread killeventtextpopup(var_3, 1);
  var_1 thread scripts\mp\awards::givemidmatchaward(var_3, undefined, undefined, undefined, undefined, undefined, undefined, undefined, var_2);
  var_1 scripts\mp\utility\stats::incpersstat("_encstr_99EF15628773796E90C3B3726123C8B063817DA7A6E257", 1);
  level thread scripts\mp\battlechatter_mp::saytoself(var_1, "_encstr_968B17C18DC9D7D62D1B36DC472756586DAFC8CACD4727DB97", undefined, 0.75);
}

_id_128B3(var_0) {
  var_1 = scripts\mp\killstreaks\killstreaks::rocket_internal(var_0);

  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_3 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_B28B0DB91B4E85C1AFC26EE62DCD3A");
  }
}

is_enemy_highest_score(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(var_3.score > var_0.score)
      return 0;
  }

  return 1;
}

getshotdistancetype(var_0, var_1, var_2, var_3, var_4) {
  if(isalive(var_0) && var_2 != "_encstr_8DED0A21C79B660BC7588981" && !var_0 scripts\mp\utility\player::isusingremote() && (scripts\mp\utility\weapon::isprimaryweapon(var_1) || scripts\mp\utility\weapon::iscacsecondaryweapon(var_1)) && !scripts\mp\utility\weapon::iskillstreakweapon(var_1.basename) && !istrue(var_0.assistedsuicide)) {
    var_5 = distancesquared(var_3, var_4.origin);

    if(var_5 < 9216)
      return "_encstr_A90B0B68C75085F316A022DA28";

    if(var_5 > 4000000)
      return "_encstr_86500EF327F03197887228922B19E053";

    var_6 = scripts\mp\utility\weapon::getweapongroup(var_1.basename);
    var_7 = undefined;

    switch (var_6) {
      case "_encstr_ABC90E77AC5883F6DCBE38A5CD1D7B36":
        var_7 = 800;
        break;
      case "_encstr_82EF0C97EDA73962101FCEFF0171":
      case "_encstr_AF710BF4355A9195B0FF0AEAD0":
        var_7 = 1200;
        break;
      case "_encstr_A3710BEEACC2E0B737EB36B676":
      case "_encstr_A1710B57AD31DBCDCDF1422A60":
      case "_encstr_8E250FDD59C283DE37F5169BCD85BA1B1D":
      case "_encstr_9B65109F23E0F24FC016431A79258FEE4889":
        var_7 = 1500;
        break;
      case "_encstr_88670C4077366F270E071EC9720C":
      case "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33":
        var_7 = 2000;
        break;
      case "_encstr_87E60F77CA0BC1DB37BEE6D0DE47D9ABB9":
        var_7 = 500;
        break;
      case "_encstr_BDBF1277568507DEE67D0E9CED4DB21BA32DB195":
        var_7 = 1200;
        break;
      case "_encstr_8D200E63B9A7DBC550975D5D99600FAA":
      case "_encstr_8261067B1D34AC27":
        var_7 = 1969;
        break;
      default:
        var_7 = 1536;
        break;
    }

    var_8 = var_7 * var_7;

    if(var_5 > var_8)
      return "_encstr_B82009D8DBE6D9CDD0B7E8";
  }

  return "_encstr_8BBA05185F8B99";
}

update_future_stations_track_timers(var_0, var_1, var_2) {
  var_3 = distancesquared(var_0, var_1.origin);
  var_4 = scripts\mp\utility\weapon::getweapongroup(var_2.basename);
  var_5 = undefined;

  switch (var_4) {
    case "_encstr_ABC90E77AC5883F6DCBE38A5CD1D7B36":
      var_5 = 1500;
      break;
    case "_encstr_82EF0C97EDA73962101FCEFF0171":
    case "_encstr_AF710BF4355A9195B0FF0AEAD0":
      var_5 = 2000;
      break;
    case "_encstr_A1710B57AD31DBCDCDF1422A60":
      var_5 = 4000;
      break;
    case "_encstr_A3710BEEACC2E0B737EB36B676":
    case "_encstr_8E250FDD59C283DE37F5169BCD85BA1B1D":
    case "_encstr_9B65109F23E0F24FC016431A79258FEE4889":
      var_5 = 3000;
      break;
    case "_encstr_88670C4077366F270E071EC9720C":
    case "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33":
      var_5 = 8000;
      break;
    case "_encstr_87E60F77CA0BC1DB37BEE6D0DE47D9ABB9":
      var_5 = 1000;
      break;
    case "_encstr_BDBF1277568507DEE67D0E9CED4DB21BA32DB195":
      var_5 = 4000;
      break;
    default:
      var_5 = 4000;
      break;
  }

  var_6 = var_5 * var_5;
  return var_3 > var_6;
}

isdeathfromabove(var_0, var_1, var_2, var_3, var_4) {
  if(isalive(var_0) && var_0 isjumping() && scripts\engine\utility::isbulletdamage(var_2)) {
    var_5 = var_0.origin[2] - var_4.origin[2];
    return var_5 > 60;
  }

  return 0;
}

isskeetshooter(var_0, var_1, var_2, var_3, var_4) {
  return isalive(var_0) && var_4 isjumping() && scripts\engine\utility::isbulletdamage(var_2);
}

isbackkill(var_0, var_1, var_2) {
  if(!isPlayer(var_0) || !isPlayer(var_1))
    return 0;

  if(var_2 != "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9" && var_2 != "_encstr_950A12A99E887D284AD42A7A31D748AA98C4A215" && var_2 != "_encstr_8DED0A21C79B660BC7588981" && var_2 != "_encstr_87280E1FB705D168313D1FD197B1A799")
    return 0;

  var_3 = var_1 getplayerangles();
  var_4 = var_0 getplayerangles();
  var_5 = angleclamp180(var_3[1] - var_4[1]);

  if(abs(var_5) < 80)
    return 1;

  return 0;
}

issurvivorkill(var_0) {
  return var_0.health > 0 && var_0.health < var_0.maxhealth * 0.5;
}

underbridge_reinforce_enemy_monitor(var_0, var_1) {
  var_2 = isDefined(var_1.lastsnapshotgrenadetime) && var_1.lastsnapshotgrenadetime + scripts\mp\equipment\snapshot_grenade::removespawnselections() > gettime();
  var_3 = isDefined(var_0.radarstrength) && var_0.radarstrength > 3 && !var_1 scripts\mp\utility\perk::_hasperk("_encstr_865013A373482BFBE0426B73E90D08FF50EC608B1D");
  var_4 = istrue(var_1.update_bomb_vest_lua);
  return var_2 || var_3 || var_4;
}

givekillreward(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3))
    thread scripts\mp\awards::givemidmatchaward(var_3);
  else
    thread scripts\mp\utility\points::giveunifiedpoints(var_0, var_2);
}

proximityassist(var_0) {
  self.modifiers["_encstr_950E10B96D8A514B0F8FDD384DDFF7E94760"] = 1;
  thread scripts\mp\utility\points::giveunifiedpoints("_encstr_950E10B96D8A514B0F8FDD3849DFF7E94760");
}

proximitykill(var_0) {
  self.modifiers["_encstr_8A220E8393F60F4BB6B4A35EA5961BC6"] = 1;
  thread scripts\mp\utility\points::giveunifiedpoints("_encstr_8A220E8393F60F4BB6B4A35EB5961BC6");
}

longshot(var_0) {
  thread scripts\common\utility::_id_13E0A(level._id_11B26, var_0, "_encstr_B82009D8DBE6D9CDD0B7E8");
  scripts\mp\utility\stats::incpersstat("_encstr_87610E36EDE63BE6347BA32DA51BB1E6", 1);
  thread killeventtextpopup("_encstr_B82009D8DBE6D9CDD0B7E8", 1);
  thread scripts\mp\awards::givemidmatchaward("_encstr_B82009D8DBE6D9CDD0B7E8");

  if(self.currentweapon hasattachment("_encstr_A6F914D2FD3D934F7BBCB697B973CDE2BE400D6F9FFB") || self.currentweapon hasattachment("_encstr_8A90189FBDE8E03A9B336829420FAB6833C110F4DD850106206A"))
    thread scripts\mp\perks\perkfunctions::_id_13121();
}

very_longshot(var_0) {
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "_encstr_B847147C555AA5A83247702BA77C63D102FBE1702DD2", undefined, 1);
}

pointblank(var_0) {
  thread scripts\common\utility::_id_13E0A(level._id_11B26, var_0, "_encstr_A90B0B68C75085F316A022DA28");
  thread killeventtextpopup("_encstr_A90B0B68C75085F316A022DA28", 1);
  thread scripts\mp\awards::givemidmatchaward("_encstr_A90B0B68C75085F316A022DA28");
  scripts\mp\utility\stats::incpersstat("_encstr_9BE4105B208BCD83057121569A4CBF15D968", 1);
}

headshot(var_0) {
  thread scripts\common\utility::_id_13E0A(level._id_11B26, var_0, "_encstr_848909BBD3A7526348E8E3");
  thread killeventtextpopup("_encstr_848909BBD3A7526348E8E3", 1);
  thread scripts\mp\awards::givemidmatchaward("_encstr_848909BBD3A7526348E8E3");
}

avengedplayer(var_0, var_1) {
  thread scripts\common\utility::_id_13E0A(level._id_11B26, var_0, "_encstr_977C08697BE705EAA5E3");
  scripts\mp\utility\stats::incpersstat("_encstr_812B0DE153B5A0648A2B7F234BC2B6", 1);
  thread killeventtextpopup("_encstr_977C08697BE705EAA5E3", 1);
  thread scripts\mp\awards::givemidmatchaward("_encstr_977C08697BE705EAA5E3");
}

assistedsuicide(var_0, var_1) {
  thread scripts\mp\utility\points::giveunifiedpoints("_encstr_950310C2E637D29B8E2B32CDABD2B1D2C8AC", var_1);
  thread scripts\common\utility::_id_13E0A(level._id_11B26, var_0, "_encstr_950310C2E637D29B8E2B32CDABD2B1D2C8AC");
  thread killeventtextpopup("_encstr_950310C2E637D29B8E2B32CDABD2B1D2C8AC", 1);
  thread scripts\mp\awards::givemidmatchaward("_encstr_950310C2E637D29B8E2B32CDABD2B1D2C8AC");
}

defendedplayer(var_0, var_1) {
  thread scripts\common\utility::_id_13E0A(level._id_11B26, var_0, "_encstr_8E460991ACCC59378C56C9");
  scripts\mp\utility\stats::incpersstat("_encstr_92090E74BDC19F9DC9D0D358A801D50F", 1);
  thread killeventtextpopup("_encstr_9AD407EB275B37556D", 0);
  thread scripts\mp\awards::givemidmatchaward("_encstr_95840E3FB94BF8601B9291187A27ADA0");
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "_encstr_A3B90C4750D0AE22F6770F3F5D15", undefined, 1);
}

postdeathkill(var_0) {
  thread scripts\common\utility::_id_13E0A(level._id_11B26, var_0, "_encstr_93150B9B625FB5C8DBEDA79B1B");
  thread killeventtextpopup("_encstr_93150B9B625FB5C8DBEDA79B1B", 1);
  thread scripts\mp\awards::givemidmatchaward("_encstr_93150B9B625FB5C8DBEDA79B1B");
}

revenge(var_0, var_1) {
  thread scripts\common\utility::_id_13E0A(level._id_11B26, var_0, "_encstr_811F08C0C726E1953267");
  scripts\mp\utility\stats::incpersstat("_encstr_8F8C0D850513CA55CFEB67C95A4D13", 1);
  thread killeventtextpopup("_encstr_811F08C0C726E1953267", 1);
  thread scripts\mp\awards::givemidmatchaward("_encstr_811F08C0C726E1953267");
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "_encstr_B2F20F499DE93838B3E745636BEAF0E885", undefined, 1);
  playFX(scripts\engine\utility::getfx("_encstr_B6930663D72D9813"), var_1.origin + (0, 0, 64));
}

multikill(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.inneurotoxintimestamp))
    self.inneurotoxintimestamp = var_1;

  if(var_1 < self.inneurotoxintimestamp) {
    return;
  }
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_BE950ABAC359A32C2153E4FC");
  self endon("_encstr_BE950ABAC359A32C2153E4FC");
  waitframe();
  var_4 = undefined;
  var_5 = undefined;

  switch (var_1) {
    case 2:
      var_4 = "_encstr_8E9C0791DB5D26632B";
      break;
    case 3:
      var_4 = "_encstr_8DA3073A27B483C6CA";
      var_5 = "_encstr_B8ED0F179010CC5243956172FB074A8478";
      break;
    case 4:
      var_4 = "_encstr_927905C387ED73";
      var_5 = "_encstr_977D0F6B0AA5856AB5FBF9C23A7887F913";
      break;
    case 5:
      var_4 = "_encstr_B17805B857A37A";
      var_5 = "_encstr_84350F0EA17348179393214A6B2CD380AB";
      break;
    case 6:
      var_4 = "_encstr_9A19049B2D3C";
      var_5 = "_encstr_A5630FC685631BDE5747F563E1D64B8DB1";
      break;
    case 7:
      var_4 = "_encstr_9730063321C665C6";
      var_5 = "_encstr_97860FC1BA1B91D8C3EC2FE7F8AC2069E3";
      break;
    case 8:
      var_4 = "_encstr_A19506DD035913B3";
      var_5 = "_encstr_8CF20F801FF4184FDB9BD06B70D28BC02C";
      break;
    default:
      var_4 = "_encstr_AF4006A12DF490AB";
      var_5 = "_encstr_959E0FFFB359AA07C8D3814E4A6059E221";
      break;
  }

  if(isDefined(self.pers["_encstr_848411BBCBA49275908BADAB6040B17A0B6913"]) && var_1 > self.pers["_encstr_848411BBCBA49275908BADAB6040B17A0B6913"])
    self.pers["_encstr_848411BBCBA49275908BADAB6040B17A0B6913"] = var_1;

  thread scripts\common\utility::_id_13E0A(level._id_11B2B, var_0, var_1);

  if(isDefined(var_4)) {
    thread killeventtextpopup(var_4, scripts\engine\utility::ter_op(isDefined(var_2), var_2, 1), istrue(var_3));

    if(!istrue(var_3))
      thread scripts\mp\awards::givemidmatchaward(var_4);
  }

  if(isDefined(var_5))
    thread scripts\mp\hud_util::teamplayercardsplash(var_5, self);
}

firstblood(var_0) {
  scripts\mp\utility\game::setmlgannouncement(11, self.team, self getentitynumber());
  thread scripts\common\utility::_id_13E0A(level._id_11B26, var_0, "_encstr_85E10B66B44E6EA3981BBDDE91");
  thread scripts\mp\hud_util::teamplayercardsplash("_encstr_95E8136C58D8B1F6AB1DEB3396399B3A4C8DB7BD19", self);
  thread killeventtextpopup("_encstr_85E10B66B44E6EA3981BBDDE91", 1);
  thread scripts\mp\awards::givemidmatchaward("_encstr_85E10B66B44E6EA3981BBDDE91");
}

buzzkill(var_0, var_1) {
  thread scripts\common\utility::_id_13E0A(level._id_11B26, var_0, "_encstr_ACE1097ABDCDAAFF83FCB1");
  thread killeventtextpopup("_encstr_ACE1097ABDCDAAFF83FCB1", 1);
  thread scripts\mp\awards::givemidmatchaward("_encstr_ACE1097ABDCDAAFF83FCB1");
}

start_conceal_add(var_0) {
  thread killeventtextpopup("_encstr_B8910DCD8E5DDC9B56C8F5B596C6D8", 1);
  thread scripts\mp\awards::givemidmatchaward("_encstr_B8910DCD8E5DDC9B56C8F5B596C6D8");
}

comeback(var_0) {
  thread scripts\common\utility::_id_13E0A(level._id_11B26, var_0, "_encstr_92DF0956DA8F69425F23C8");
  thread killeventtextpopup("_encstr_92DF0956DA8F69425F23C8", 1);
  thread scripts\mp\awards::givemidmatchaward("_encstr_92DF0956DA8F69425F23C8");
  scripts\mp\utility\stats::incpersstat("_encstr_BA3D0E73B8A09F9EC3E04258A801D50F", 1);
}

supershutdown(var_0) {
  var_1 = scripts\mp\supers::getrootsuperref(var_0.super.staticdata.ref);
  self.modifiers["_encstr_85940E5A3D69DAE2FFD8777B9050BF32"] = var_0.super.staticdata.ref;
  var_2 = "_encstr_A927103F8B3B1D2B370BB097C40C27C8604F" + var_1;

  switch (var_1) {
    case "_encstr_97B50B2FE089DADA7B0165DF7D":
      var_2 = "_encstr_BD801BAB9BB8E0F62117310323BAB0A84EF971E3451C79262A473D3F9F";
      break;
  }

  if(isDefined(level.awards[var_2]))
    thread scripts\mp\awards::givemidmatchaward(var_2);
}

collateral(var_0) {
  if(var_0 == 2) {
    level thread scripts\mp\battlechatter_mp::saytoself(self, "_encstr_88D2140EC639F5D65A8D36CC2D39DAD7D1DD7B332B39", undefined, 0.75);
    thread killeventtextpopup("_encstr_B63E13D8F53AD70B08E7F0B1934FC09FA25CC1D10A", 1);
    thread scripts\mp\awards::givemidmatchaward("_encstr_B63E13D8F53AD70B08E7F0B1934FC09FA25CC1D10A");
  }

  if(var_0 == 3)
    level thread scripts\mp\battlechatter_mp::saytoself(self, "_encstr_A3CA165BD0661FBC20A914E65B93C5D78DC8F3B259348FB2", undefined, 0.75);

  if(var_0 > 1) {
    self.modifiers["_encstr_B49B0B6CDEC68DC28EAC4E168D"] = 1;
    self.modifiers["_encstr_A2A406E139973007"] = self.modifiers["_encstr_A2A406E139973007"] | 64;
  }

  thread scripts\mp\potg_events::collateral(self, var_0);
}

shotguncollateral(var_0) {
  thread scripts\mp\potg_events::shotguncollateral(self, var_0);
}

_id_11ABE(var_0) {
  thread killeventtextpopup("_encstr_82D10C98E26D11709757BAA34C9B", 1);
  thread scripts\mp\awards::givemidmatchaward("_encstr_82D10C98E26D11709757BAA34C9B");
}

chopper_boss_players_connect_monitor(var_0) {
  thread killeventtextpopup("_encstr_87CC098985C65B662D4E59", 1);
  thread scripts\mp\awards::givemidmatchaward("_encstr_87CC098985C65B662D4E59");
}

quadfeed(var_0, var_1) {
  self.modifiers["_encstr_B4CE09E2D50BC8CC56CA91"] = 1;
  self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 536870912;
  thread killeventtextpopup("_encstr_A74E0A83F3D19018DA570319", 1);
  thread scripts\mp\awards::givemidmatchaward("_encstr_A74E0A83F3D19018DA570319");
  thread scripts\mp\potg_events::quadfeed(self, var_1.starttime, gettime());
}

viphud_deletehud(var_0) {
  self.modifiers["_encstr_A9F70E8A64FAE19D5EBF48D0436DD12B"] = 1;
  self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 2;
  scripts\mp\utility\stats::incpersstat("_encstr_A9F70E8A64FAE19D5EBF48D0436DD12B", 1);
}

voting(var_0) {
  thread killeventtextpopup("_encstr_977411D0727A0F638F88C9B7738FCEE7648A38", 1);
  thread scripts\mp\awards::givemidmatchaward("_encstr_977411D0727A0F638F88C9B7738FCEE7648A38");
  scripts\mp\utility\stats::incpersstat("_encstr_82F313721FF7CA7343232F6138307F551808F20138", 1);
}

linkedsaw(var_0) {
  thread killeventtextpopup("_encstr_A2991428400D567ABC8123792A0AA31F1209D19C87CB", 1);
  thread scripts\mp\awards::givemidmatchaward("_encstr_A2991428400D567ABC8123792A0AA31F1209D19C87CB");
}

_id_13DD1(var_0) {
  self.modifiers["_encstr_AC0D13230AA738B82B13706958B834D53AD8E4D1E0"] = 1;
  self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 32;
}

execution(var_0) {
  scripts\mp\utility\stats::incpersstat("_encstr_82B30BB521F80E0FE5C81A1293", 1);
  thread scripts\mp\utility\points::giveunifiedpoints("_encstr_B1100A561EACC6AB3AB47BCD");
}

disconnected() {
  var_0 = self.guid;

  if(!scripts\mp\utility\game::lpcfeaturegated()) {
    for(var_1 = 0; var_1 < level.players.size; var_1++) {
      if(isDefined(level.players[var_1].killedplayers[var_0]))
        level.players[var_1].killedplayers[var_0] = undefined;

      if(isDefined(level.players[var_1].killedby[var_0]))
        level.players[var_1].killedby[var_0] = undefined;
    }
  }
}

monitorhealed() {
  level endon("_encstr_A3AF090768A9910F4118EF");

  for(;;) {
    level waittill("_encstr_8FB50718DD41DB3FA9", var_0);
    var_0 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_8FB50718DD41DB3FA9");
  }
}

_id_1400F(var_0) {
  if(!isDefined(self.modifiers)) {
    return;
  }
  if(!isDefined(self._id_12A85))
    self._id_12A85 = [];

  if(istrue(self.modifiers[var_0])) {
    if(istrue(self._id_12A85[var_0]) && self.recentkillcount > 1)
      self._id_11E03[var_0] = 1;

    self._id_12A85[var_0] = 1;
  } else
    self._id_12A85[var_0] = undefined;
}

updaterecentkills(var_0, var_1, var_2, var_3) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_850C125B73F20718A55261B98786505A9AABF1DF");
  self endon("_encstr_850C125B73F20718A55261B98786505A9AABF1DF");
  var_4 = weaponclass(var_2.basename);
  self.recentkillcount++;
  _id_1400F("_encstr_849508B2188BC58BF97D");

  if(var_4 == "_encstr_BE1904DCDA9D") {
    if(!isDefined(self._id_12A89))
      self._id_12A89 = 1;
    else
      self._id_12A89++;
  }

  var_5 = scripts\mp\utility\weapon::getweapongroup(var_2.basename);

  if(isDefined(self.radarstrength) && self.radarstrength > 3 && !var_1 scripts\mp\utility\perk::_hasperk("_encstr_865013A373482BFBE0426B73E90D08FF50EC608B1D")) {
    if(!isDefined(self._id_12A8B))
      self._id_12A8B = 1;
    else
      self._id_12A8B++;
  }

  if(scripts\mp\utility\game::isdefending(var_1)) {
    self.recentdefendcount++;

    if(scripts\mp\utility\script::isnumbermultipleof(self.recentdefendcount, 2))
      thread scripts\mp\awards::givemidmatchaward("_encstr_A5340F12B809E7C7BAAFDFC9AF213F2B81");
  }

  if(scripts\mp\utility\game::turret_outline_watcher(var_1)) {
    self._id_12A82++;

    if(scripts\mp\utility\script::isnumbermultipleof(self._id_12A82, 3))
      _id_13DD1(var_0);
  }

  if(!isDefined(self.recentkillsperweapon))
    self.recentkillsperweapon = [];

  if(!isDefined(self._id_12A86))
    self._id_12A86 = [];

  if(!isDefined(self.recentkillsperweapon[var_3]))
    self.recentkillsperweapon[var_3] = 1;
  else
    self.recentkillsperweapon[var_3]++;

  if(!isDefined(self._id_12A86[var_2.basename]))
    self._id_12A86[var_2.basename] = 1;
  else
    self._id_12A86[var_2.basename]++;

  var_6 = scripts\mp\utility\weapon::getequipmenttype(var_2.basename);

  if(isDefined(var_6) && var_6 == "_encstr_B116071BCAD186858D" && !scripts\mp\utility\weapon::isthrowingknife(var_2)) {
    level thread scripts\mp\battlechatter_mp::saytoself(self, "_encstr_BACE15F9748AE9BAAFC270397A2B613167C26B4DE17770", undefined, 0.75);
    level thread scripts\mp\battlechatter_mp::saytoself(self, "_encstr_A91511DB78537F92FB192DA7F3B58A3759E80B", undefined, 0.75);

    if(self.recentkillsperweapon[var_3] > 0 && self.recentkillsperweapon[var_3] % 2 == 0) {
      thread killeventtextpopup("_encstr_97AB0FAF3285E5C3ACE7D91AE2B73D9A72", 1);
      thread scripts\mp\awards::givemidmatchaward("_encstr_97AB0FAF3285E5C3ACE7D91AE2B73D9A72");
    }
  }

  scripts\mp\utility\script::bufferednotify("_encstr_92FB1BA870FADEE4054823C2E74B9D214FEB3260C71EC5E1A19595F873", self.recentkillcount, var_3);

  if(!isDefined(self.recentkillcount))
    self.recentkillcount = 0;

  if(self.recentkillcount > 1) {
    thread multikill(var_0, self.recentkillcount, 0);
    scripts\cp\vehicles\vehicle_compass_cp::init_silo_elevator(self, self._id_11E03, var_2, self.recentkillcount);
  }

  wait 4.0;

  if(self.recentkillcount > 1) {
    thread multikill(var_0, self.recentkillcount, 1, 1);

    if(self.recentkillcount > 2)
      scripts\mp\utility\game::setmlgannouncement(12, self.team, self getentitynumber(), self.recentkillcount);
  }

  scripts\mp\utility\stats::incpersstat("_encstr_8D6F0F08D7A6D5454B3A2C9757C3036B5B", 1);
  self.recentkillcount = 0;
  self.recentdefendcount = 0;
  self._id_12A89 = 0;
  self._id_12A8A = undefined;
  self.recentkillsperweapon = undefined;
  self._id_12A86 = undefined;
  self._id_11E04 = 0;
  self._id_12A85 = [];
  self._id_11E03 = [];
}

_id_13FE5(var_0, var_1, var_2) {
  if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB" || !isDefined(level._encstr_A3A71A984E7D1B340BB18D959B3B5656EC58B1BA2C3A7BE4CCEADCD8)) {
    return;
  }
  var_3 = spawnStruct();
  var_3.meansofdeath = var_0;
  var_3.inflictor = var_1;
  var_3.victim = var_2;
  var_3._id_11A6C = 1;
  self[[level._encstr_A3A71A984E7D1B340BB18D959B3B5656EC58B1BA2C3A7BE4CCEADCD8]]("_encstr_BAB1164BFD11D5F1DBC5F7D860011B2E017B7D4897EF1BD5", var_3);
  self[[level._encstr_A3A71A984E7D1B340BB18D959B3B5656EC58B1BA2C3A7BE4CCEADCD8]]("_encstr_8E071D064A4790839A0B78C8F3B9BF03CBC59B0BB353599343F2E839EA8D69", var_3);
  self[[level._encstr_A3A71A984E7D1B340BB18D959B3B5656EC58B1BA2C3A7BE4CCEADCD8]]("_encstr_A7311980D01767F9A33B0F22D37F2F54A5D37B764B3F1F81CC51C2", var_3);
}

monitorcratejacking() {
  level endon("_encstr_A3AF090768A9910F4118EF");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_A3E00911A924B0061FFAEB", var_0, var_1);
    thread scripts\mp\awards::givemidmatchaward("_encstr_992317E6DC7D5DDC597DACB9CAB5BCBE91E4DB9BB291C97B07");
    var_2 = "_encstr_81231110F73A618FF26705807E8AF5898A5758";

    if(isDefined(var_1))
      var_1 scripts\mp\hud_message::showsplash(var_2, undefined, self);
  }
}

updatequadfeedcounter(var_0, var_1) {
  if(isDefined(level.quadfeedinfo) && gettime() - level.quadfeedinfo.starttime > 10000)
    level.quadfeedinfo = undefined;

  if(!isDefined(level.quadfeedinfo) || level.quadfeedinfo.player != var_0) {
    var_2 = spawnStruct();
    var_2.player = var_0;
    var_2.starttime = gettime();
    var_2.feedcount = 1;
    level.quadfeedinfo = var_2;
  } else {
    var_2 = level.quadfeedinfo;
    var_2.feedcount++;

    if(var_2.feedcount == 4) {
      var_2.player quadfeed(var_1, var_2);
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
    var_0 = self issprintsliding();

    if(istrue(self.eventswassliding) && !var_0) {
      self.eventsslideendtime = gettime();
      scripts\mp\potg::processevent("_encstr_AC870D1BF8B9BD3A094832ED4BC142");
    }

    self.eventswassliding = var_0;
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
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.lastreloadtime = 0;

  for(;;) {
    self waittill("_encstr_AF4D07932B1BDE5846");
    self.lastreloadtime = gettime();
    scripts\mp\utility\stats::incpersstat("_encstr_B8EE0853B010CFB26116", 1);
  }
}

monitorweaponpickup() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.lastweaponpickuptime = 0;

  for(;;) {
    self waittill("_encstr_914C0EDDB20B837BB97D38D2365BAB83");
    self.lastweaponpickuptime = gettime();
    scripts\mp\utility\stats::incpersstat("_encstr_81880EE74DE64B58D361CBB76C286B73", 1);
  }
}

monitorweaponswitch() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.lastweaponchangetime = 0;

  for(;;) {
    self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
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
  self.laststancetimes["_encstr_922406F1A6FD5E05"] = 0;
  self.laststancetimes["_encstr_B13D076BED70539F23"] = 0;
  self.laststancetimes["_encstr_A5AD069B231F0BAF"] = 0;
}

updatestancetracking() {
  if(!isalive(self)) {
    return;
  }
  var_0 = self.mantlecur;
  self.mantlecur = self ismantling();

  if(!istrue(var_0) && self.mantlecur)
    scripts\mp\potg::processevent("_encstr_8BBD0E1655BF99E523B12058BA7BA9D1");

  var_1 = self.jumpcur;
  self.jumpcur = self isjumping();

  if(!istrue(var_1) && self.jumpcur)
    scripts\mp\potg::processevent("_encstr_9BE70C7B709F0FEBC3E82A4D992B");

  var_2 = self getstance();

  if(var_2 != self.laststance) {
    scripts\mp\potg_events::playerstancechanged(var_2);

    if(self.laststance == "_encstr_B13D076BED70539F23") {
      var_3 = self.laststancechangetime;
      var_4 = (gettime() - var_3) / 1000;
      scripts\mp\utility\stats::incpersstat("_encstr_82440D73BB3BADE18A902B2F882D19", var_4);
    }

    if(self.laststance == "_encstr_922406F1A6FD5E05") {
      var_3 = self.laststancechangetime;
      var_4 = (gettime() - var_3) / 1000;
      scripts\mp\utility\stats::incpersstat("_encstr_9AFB0A938AAFA5919267DD33", var_4);
    }

    self.laststancechangetime = gettime();

    if(!isDefined(self.pers["_encstr_A1710F532531A3CEDBA923EAE83F846B29"])) {
      self.pers["_encstr_A1710F532531A3CEDBA923EAE83F846B29"] = [];
      self.pers["_encstr_A1710F532531A3CEDBA923EAE83F846B29"]["_encstr_922406F1A6FD5E05"] = 0;
      self.pers["_encstr_A1710F532531A3CEDBA923EAE83F846B29"]["_encstr_B13D076BED70539F23"] = 0;
      self.pers["_encstr_A1710F532531A3CEDBA923EAE83F846B29"]["_encstr_A5AD069B231F0BAF"] = 0;
    }

    if(var_2 == "_encstr_922406F1A6FD5E05" || var_2 == "_encstr_B13D076BED70539F23" || var_2 == "_encstr_A5AD069B231F0BAF")
      self.pers["_encstr_A1710F532531A3CEDBA923EAE83F846B29"][var_2]++;
  }

  self.laststancetimes[var_2] = gettime();
  self.laststance = var_2;
}

predatormissileimpact(var_0) {
  scripts\mp\potg_events::predatormissileimpact(var_0);
}

largevehicleexplosion(var_0) {
  scripts\mp\potg_events::largevehicleexplosion(var_0);
}

vehiclekilled(var_0) {
  scripts\mp\potg_events::vehiclekilled(var_0);
}

missilefired(var_0) {
  thread trackmissile(var_0);
}

trackmissile(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");
  var_0.whizbyplayers = [];

  for(;;) {
    var_1 = scripts\common\utility::playersnear(var_0.origin, 220);

    foreach(var_3 in var_1) {
      if(isDefined(var_0.owner) && var_3 == var_0.owner) {
        continue;
      }
      missilewhizby(var_3, var_0);
      var_0.whizbyplayers[var_3.guid] = 1;
    }

    wait 0.1;
  }
}

missilewhizby(var_0, var_1) {
  scripts\mp\potg_events::missilewhizby(var_0);
}

bombdefused(var_0) {
  var_1 = 0;

  if(scripts\mp\utility\game::getgametypenumlives() >= 1) {
    var_2 = scripts\mp\utility\game::getpotentiallivingplayers();

    if(var_2.size == 1 && var_2[0] == var_0)
      var_1 = 1;
  }

  var_3 = 0;

  if(!var_1 && scripts\mp\utility\game::getgametype() != "_encstr_B60703EACA") {
    var_4 = scripts\mp\utility\player::getplayersinradius(var_0.origin, 600);

    foreach(var_6 in var_4) {
      if(var_6.team != var_0.team) {
        var_3 = 1;
        break;
      }
    }
  }

  if(isDefined(level.bombowner) && level.bombowner.bombplantedtime + 3000 + level.defusetime * 1000 > gettime() && scripts\mp\utility\player::isreallyalive(level.bombowner)) {
    var_0 thread scripts\mp\rank::scoreeventpopup("_encstr_AF6F0D7833AAA51639898F5A40F28D");
    var_0 thread scripts\mp\hud_message::showsplash("_encstr_AF6F0D7833AAA51639898F5A40F28D", scripts\mp\rank::getscoreinfovalue("_encstr_830C078CCA33ABB959"));

    if(scripts\mp\utility\game::getgametype() != "_encstr_B60703EACA")
      var_3 = 1;
  } else {
    var_0 thread scripts\mp\hud_message::showsplash("_encstr_83190BF38F4B1735371E1B8761", scripts\mp\rank::getscoreinfovalue("_encstr_830C078CCA33ABB959"));
    var_0 thread scripts\mp\rank::scoreeventpopup("_encstr_830C078CCA33ABB959");
  }

  if(var_1)
    var_0 thread scripts\mp\awards::givemidmatchaward("_encstr_864314B5BD19CAFAB923AF63B0B91DD746B233576EB2");
  else
    var_0 thread scripts\mp\awards::givemidmatchaward("_encstr_8B6D0F5040346FC7534AD94AE3F6EB3FA9");

  var_0 scripts\mp\utility\stats::incpersstat("_encstr_817B0812789D1387E986", 1);
  var_0 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_817B0812789D1387E986", var_0.pers["_encstr_817B0812789D1387E986"]);

  if(scripts\mp\utility\game::getgametype() != "_encstr_9B0703CD93")
    var_0 scripts\mp\utility\stats::setextrascore1(var_0.pers["_encstr_817B0812789D1387E986"]);

  if(isPlayer(var_0))
    var_0 thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_830C078CCA33ABB959", var_0.origin);

  if(var_1)
    scripts\mp\utility\game::_id_119AC(var_0, undefined, "_encstr_8B340DC89851363EDD173ED70725A8", var_0.origin, "_encstr_B6420BE367A3B0A1F7EB43C33F");
  else
    scripts\mp\utility\game::_id_119AC(var_0, undefined, "_encstr_8B340DC89851363EDD173ED70725A8", var_0.origin);

  scripts\mp\potg_events::bombdefused(var_0, var_1, var_3);
}

revivedplayer(var_0, var_1) {
  if(var_0 == var_1) {
    return;
  }
  scripts\mp\potg_events::revivedplayer(var_0, var_1);
  var_0 scripts\cp\vehicles\vehicle_compass_cp::_id_12C3F("_encstr_850833EB4B980258D1C905CD41089419E61B1B174D3D3A37F0917E5558D0B4F228A5F7E3B750C3C5E87933DD9349E5CA96E7771FAD", 1);

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && isDefined(level._encstr_BA3A1A5DFBA9FD5D6F65B08429A1986AC329FB3323C8FB92A897151B)) {
    self[[level._encstr_BA3A1A5DFBA9FD5D6F65B08429A1986AC329FB3323C8FB92A897151B]](var_0, var_1);

    if(getdvarint("_encstr_8F220B17E59FF1E9D15C692997", 0) && var_0 scripts\mp\utility\game::onlinestatsenabled())
      var_0 setplayerdata("_encstr_8C07031599", "_encstr_9240139B0337915EF73B788312471B68CA7C270DA1", 0, 1);
  }
}

doorused(var_0, var_1) {
  scripts\mp\potg_events::doorused(var_0, var_1);

  if(var_1)
    var_0.lastdooropentime = gettime();
}

shothit() {
  if(!isDefined(self.pers["_encstr_826D099BD308330249988B"]))
    scripts\mp\utility\stats::initpersstat("_encstr_826D099BD308330249988B");

  scripts\mp\utility\stats::incpersstat("_encstr_826D099BD308330249988B", 1);
  scripts\mp\potg_events::shothit();
}

shotmissed() {
  scripts\mp\potg_events::shotmissed();
}

killeventtextpopup(var_0, var_1, var_2) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(!scripts\mp\rank::scoreeventhastext(var_0)) {
    return;
  }
  if(!isDefined(self.killeventqueue))
    self.killeventqueue = [];

  foreach(var_4 in self.killeventqueue) {
    if(var_4.scoreeventref == var_0)
      return;
  }

  var_6 = spawnStruct();
  var_6.scoreeventref = var_0;
  var_6.showassplash = istrue(var_1);
  var_6.priority = scripts\mp\rank::getscoreeventpriority(var_0);
  var_6.alwaysshowsplash = scripts\mp\rank::scoreeventalwaysshowassplash(var_0);
  var_6._id_128AC = 0;
  var_6._id_128AB = 0;
  var_6.matchdata_logplayerlife = istrue(var_2);
  self.killeventqueue[self.killeventqueue.size] = var_6;
  self notify("_encstr_86E8130FE828C4F85D0525DBE5136384F770DBFFB8");
  self endon("_encstr_86E8130FE828C4F85D0525DBE5136384F770DBFFB8");
  waitframe();

  if(!isDefined(self.splashpriorityqueue))
    self.splashpriorityqueue = [];

  foreach(var_4 in self.killeventqueue)
  insertbypriority(var_4);

  self.killeventqueue = undefined;
  thread _id_128B4();
}

_id_128B4() {
  self notify("_encstr_95F71BC14EB71B5937DC9A388DB0DC860AC9B4F6394B475E54AB595DCA");
  self endon("_encstr_95F71BC14EB71B5937DC9A388DB0DC860AC9B4F6394B475E54AB595DCA");
  self._id_12464 = 1;

  if(!isDefined(self.splashpriorityqueue))
    self._id_12464 = 0;

  foreach(var_1 in self.splashpriorityqueue) {
    if(var_1._id_128AC) {
      continue;
    }
    if(!istrue(level.removekilleventsplash) && istrue(var_1.showassplash) && (!self._id_12464 || var_1.alwaysshowsplash)) {
      var_2 = 1;
      thread scripts\mp\hud_message::showsplash(var_1.scoreeventref);
    }

    var_1._id_128AC = 1;
  }

  foreach(var_1 in self.splashpriorityqueue) {
    if(var_1._id_128AB || var_1.matchdata_logplayerlife) {
      continue;
    }
    thread scripts\mp\rank::scoreeventpopup(var_1.scoreeventref);
    var_1._id_128AB = 1;
    wait(getdvarfloat("_encstr_95551736F35B7E7F8262A0283A1107F05B94A8265DA381ABEA", 0.25));
  }

  self.splashpriorityqueue = undefined;
}

insertbypriority(var_0) {
  if(self.splashpriorityqueue.size == 0) {
    self.splashpriorityqueue[self.splashpriorityqueue.size] = var_0;
    return;
  }

  foreach(var_2 in self.splashpriorityqueue) {
    if(var_2.scoreeventref == var_0.scoreeventref)
      return;
  }

  for(var_4 = 0; var_4 < self.splashpriorityqueue.size; var_4++) {
    if(var_0.priority > self.splashpriorityqueue[var_4].priority) {
      self.splashpriorityqueue = scripts\engine\utility::array_insert(self.splashpriorityqueue, var_0, var_4);
      return;
    }
  }

  self.splashpriorityqueue[self.splashpriorityqueue.size] = var_0;
}

reset_map_dvars() {
  var_0 = [];

  if(!scripts\mp\utility\game::lpcfeaturegated() && isDefined(self.killedby)) {
    var_1 = 0;

    foreach(var_4, var_3 in self.killedby) {
      if(var_3 > var_1) {
        var_0 = [];
        var_0[var_0.size] = var_4;
      }

      if(var_3 == var_1)
        var_0[var_0.size] = var_4;
    }
  }

  return var_0;
}

vehicle_collision_handlemultievent(var_0, var_1) {
  if(isDefined(var_0) && scripts\mp\utility\weapon::getweaponrootname(var_0.basename) == "_encstr_B453108C3B128FFBF07F5B077B2AC2B9FA4A" && isDefined(var_1.hitloc) && (var_1.hitloc == "_encstr_81CC0586952C91" || var_1.hitloc == "_encstr_A6CC076A05751852B3"))
    return 1;
  else
    return 0;
}

turn_on_laser_vfx(var_0, var_1) {
  if(isDefined(var_0) && scripts\mp\utility\weapon::getweaponrootname(var_0.basename) == "_encstr_A6AE10032092892E28FFF91A34B95007CB0A" && isDefined(var_1.hitloc) && (var_1.hitloc == "_encstr_81CC0586952C91" || var_1.hitloc == "_encstr_A6CC076A05751852B3"))
    return 1;
  else
    return 0;
}

getkillstreakairstrikeheightent(var_0) {
  if(!level.challengesallowed) {
    return;
  }
  var_1 = scripts\mp\equipment::getequipmentreffromweapon(var_0);

  if(!isDefined(var_1) || !isDefined(level.weapon_xp_iw8_pi_papa320[var_1])) {
    return;
  }
  if(self.pers["_encstr_AA8B18016F73E101443790B8AF7058233AD31A1B854AE3492397"] &level.weapon_xp_iw8_pi_papa320[var_1])
    return;
  else
    self.pers["_encstr_AA8B18016F73E101443790B8AF7058233AD31A1B854AE3492397"] = self.pers["_encstr_AA8B18016F73E101443790B8AF7058233AD31A1B854AE3492397"] | level.weapon_xp_iw8_pi_papa320[var_1];

  var_2 = 0;

  foreach(var_5, var_4 in level.weapon_xp_iw8_pi_papa320) {
    if(self.pers["_encstr_AA8B18016F73E101443790B8AF7058233AD31A1B854AE3492397"] &var_4) {
      var_2++;

      if(var_2 >= 6) {
        self reportchallengeuserevent("_encstr_B8F30D48A24D81F1EF1CC0C3F41F38", "_encstr_8B011378C5E1C8EBD8496E1E50602AF5DDA8A7084B");
        break;
      }
    }
  }
}

thermite_laststand_effects() {
  level.showquestcircletoall = [];
  var_0 = ["_encstr_ABC90E77AC5883F6DCBE38A5CD1D7B36", "_encstr_AF710BF4355A9195B0FF0AEAD0", "_encstr_8E250FDD59C283DE37F5169BCD85BA1B1D", "_encstr_A1710B57AD31DBCDCDF1422A60", "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33", "_encstr_87E60F77CA0BC1DB37BEE6D0DE47D9ABB9", "_encstr_A3710BEEACC2E0B737EB36B676", "_encstr_9B65109F23E0F24FC016431A79258FEE4889"];
  var_1 = 0;

  foreach(var_3 in var_0) {
    level.showquestcircletoall[var_3] = 1 << var_1;
    var_1++;
  }
}

getjuggdamagescale(var_0) {
  if(!level.challengesallowed) {
    return;
  }
  var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);

  if(!isDefined(var_1) || !isDefined(level.showquestcircletoall[var_1])) {
    return;
  }
  if(self.pers["_encstr_82791534AC16C837D0F6D126DBB976CD86BD3A6AC2DCB6"] &level.showquestcircletoall[var_1])
    return;
  else
    self.pers["_encstr_82791534AC16C837D0F6D126DBB976CD86BD3A6AC2DCB6"] = self.pers["_encstr_82791534AC16C837D0F6D126DBB976CD86BD3A6AC2DCB6"] | level.showquestcircletoall[var_1];

  var_2 = 0;

  foreach(var_5, var_4 in level.showquestcircletoall) {
    if(self.pers["_encstr_82791534AC16C837D0F6D126DBB976CD86BD3A6AC2DCB6"] &var_4) {
      var_2++;

      if(var_2 >= 5) {
        self reportchallengeuserevent("_encstr_B8F30D48A24D81F1EF1CC0C3F41F38", "_encstr_999D111823F2AA0898CFCB04127365FD85BD98");
        break;
      }
    }
  }
}

start_puzzle() {
  if(!level.challengesallowed) {
    return;
  }
  if(self._id_11F87 == -1) {
    return;
  }
  self._id_11F87++;
  var_0 = undefined;

  switch (level.mapname) {
    case "_encstr_A5110B50E25F68A83BD3D3EBBB":
    case "_encstr_A2200CDA13D6CBC897E1A0EBAA93":
      var_0 = 50;
      break;
    default:
      var_0 = 30;
  }

  if(self._id_11F87 >= var_0) {
    self reportchallengeuserevent("_encstr_B8F30D48A24D81F1EF1CC0C3F41F38", "_encstr_AAC31D3860584F57FC28D4CF1EBAB46643C572297240245F88240DA587EBC3");
    self._id_11F87 = -1;
  }
}

getgulagclosedcircleindex(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = 0;

  if(!level.challengesallowed || !isDefined(var_0)) {
    self._id_12A9A = undefined;
    return;
  }

  if(isPlayer(var_0) && isDefined(self._id_12A9A)) {
    if(self.modifiers["_encstr_95A40617A8CBC38F"] & 32768)
      var_1 = 1;
  }

  level scripts\engine\utility::_id_143B9(1, "_encstr_9B1D0BC7932875276230426AA1");

  if(level.gameended) {
    if(var_1) {
      self reportchallengeuserevent("_encstr_B8F30D48A24D81F1EF1CC0C3F41F38", "_encstr_958318C995C6EDDC7D32E4DEE6CA7DC21B86A5CAEC95AD2BB9D1");

      if(isDefined(self._id_12A9A))
        self._id_12A9A reportchallengeuserevent("_encstr_B8F30D48A24D81F1EF1CC0C3F41F38", "_encstr_958318C995C6EDDC7D32E4DEE6CA7DC21B86A5CAEC95AD2BB9D1");
    }

    if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && isDefined(level._encstr_A3A71A984E7D1B340BB18D959B3B5656EC58B1BA2C3A7BE4CCEADCD8)) {
      var_2 = spawnStruct();
      var_2.player = self;
      self[[level._encstr_A3A71A984E7D1B340BB18D959B3B5656EC58B1BA2C3A7BE4CCEADCD8]]("_encstr_954C1C2639EB5B58DC3A59C9F27D93F6EAE68C695A1B1B8AC32BC6EAE895", var_2);
    }
  }

  self._id_12A9A = undefined;
}