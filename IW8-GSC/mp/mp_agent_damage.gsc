/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_agent_damage.gsc
***********************************************/

init() {
  scripts\cp_mp\utility\game_utility::teamwipedobituary();
  var_0 = scripts\cp\utility::getgametype();

  if(!isDefined(var_0))
    var_0 = getDvar("_encstr_B60D0B9C840C31FA415FD7EFCB");

  var_1 = 0;
  var_2 = ["_encstr_B88A1C1973CEDEE8B1139F8F3A67C995C35A3063291B07B0951D3D8F438B", "_encstr_B20319F0D0AF776BC095157982632AC0F308303A75E0576DB6D7D3"];
  var_3 = 0;

  for(;;) {
    var_4 = tablelookupbyrow(var_2[var_3], var_1, 0);

    if(!isDefined(var_4) || var_4 == "_encstr_B40101") {
      break;
    }

    var_5 = tablelookupbyrow(var_2[var_3], var_1, level.getallselectableattachments.game_type_col[var_0]);

    if(!isDefined(var_5) || var_5 == "_encstr_B40101") {
      var_1++;
      continue;
    }

    if(var_4 == "_encstr_91190447C232" || var_4 == "_encstr_8CAD05DB100303" || var_4 == "_encstr_8D19048EA595")
      var_5 = float(var_5);
    else
      var_5 = int(var_5);

    if(var_5 != -1)
      scripts\cp\drone\emp_drone::registerscoreinfo(var_4, "_encstr_BA94069D16D8ABAC", var_5);

    var_6 = tablelookuprownum("_encstr_820613E0612536534983E7C96977FDB145A6AB43C4", 0, var_4);
    scripts\cp\drone\emp_drone::registerscoreinfo(var_4, "_encstr_AA5B08F5B421339B1359", var_6);
    var_6 = tablelookup("_encstr_820613E0612536534983E7C96977FDB145A6AB43C4", 0, var_4, 2);
    scripts\cp\drone\emp_drone::registerscoreinfo(var_4, "_encstr_81EF05D156E1A3", var_6);
    var_6 = int(tablelookup("_encstr_820613E0612536534983E7C96977FDB145A6AB43C4", 0, var_4, 13));
    scripts\cp\drone\emp_drone::registerscoreinfo(var_4, "_encstr_978C092BB8FBFDEB302D69", var_6);
    var_6 = int(tablelookup("_encstr_820613E0612536534983E7C96977FDB145A6AB43C4", 0, var_4, 14));
    scripts\cp\drone\emp_drone::registerscoreinfo(var_4, "_encstr_BA9D118536DDC22F37D443BDDD6AC1638537D0", var_6);
    var_7 = tablelookuprownum("_encstr_820613E0612536534983E7C96977FDB145A6AB43C4", 0, var_4);

    if(isDefined(var_7) && var_7 != -1)
      scripts\cp\drone\emp_drone::registerscoreinfo(var_4, "_encstr_B6050906A27A7BDBD88F81", var_7);

    var_8 = tablelookupbyrow(var_2[var_3], var_1, 4);
    scripts\cp\drone\emp_drone::registerscoreinfo(var_4, "_encstr_852906B39CBD5D38", var_8);
    var_9 = tablelookupbyrow(var_2[var_3], var_1, 3);

    if(isDefined(var_9) && tolower(var_9) == "_encstr_AAEF05B83B43EB")
      scripts\cp\drone\emp_drone::registerscoreinfo(var_4, "_encstr_889C0B0BD88DBDBB48ED37ABB9", 1);

    var_1++;
  }

  level._effect["_encstr_B6930663D72D9813"] = loadfx("_encstr_B21A1BECCC1EE5389CF607DC79D816CD1AAF071BC2F2CAC9F5239CDB83");
  level.numkills = 0;
  level thread onplayerconnect();
  level thread monitorhealed();
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawn);
  scripts\cp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback(::monitoradstime);
  scripts\cp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback(::updatestancetracking);
  scripts\cp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback(::events_monitorslideupdate);
  scripts\cp\cp_modular_spawning::add_global_spawn_function("_encstr_8E8405EA382B2A", ::stoppingpower_clearhcrdata);
}

onplayerspawn() {
  self.jumpcur = 0;
  self.mantlecur = 0;
}

onplayerconnect() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    var_0.killedplayers = [];
    var_0.killedby = [];
    var_0.lastkilledby = undefined;
    var_0.greatestuniqueplayerkills = 0;
    var_0.recentkillcount = 0;
    var_0.recentdefendcount = 0;
    var_0.lastkilltime = 0;
    var_0.lastkilldogtime = 0;
    var_0.damagedplayers = [];

    if(!isDefined(var_0.pers["_encstr_84C910D248050977F8F9A49F0E236BCF4B20"]))
      var_0.pers["_encstr_84C910D248050977F8F9A49F0E236BCF4B20"] = 0;

    if(!isDefined(var_0.pers["_encstr_B80511FE9DCDD954993093EBA9331C534B3F44"]))
      var_0.pers["_encstr_B80511FE9DCDD954993093EBA9331C534B3F44"] = 0;

    var_0 initslidemonitor();
    var_0 initmonitoradstime();
    var_0 thread monitorreload();
    var_0 thread monitorweaponpickup();
    var_0.lastweaponchangetime = 0;
    var_0 initstancetracking();
  }
}

damagedplayer(var_0, var_1) {
  if(var_1 < 50 && var_1 > 10)
    level thread scripts\cp\cp_player_battlechatter::saytoself(self, "_encstr_9ADE129159D517D89AA1E968F3C011DB14578B9B", undefined, 0.1);
  else
    level thread scripts\cp\cp_player_battlechatter::saytoself(self, "_encstr_B82E1287A59B0739D11FA8A007EC96A1320E7C8B", undefined, 0.1);
}

playerworlddeath(var_0, var_1) {}

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

vip_playerdied(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level.numkills++;
  checkkillstreakkillevents(var_2, var_3, var_4);

  if(isai(var_1) || isDefined(var_1.classname) && var_1.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56")
    var_1.guid = var_1 getentitynumber();

  var_7 = var_1.guid;
  var_8 = self.guid;
  var_9 = gettime();
  var_10 = createheadicon(var_2);
  thread killedplayernotifysys(var_0, var_1, var_2, var_3);
  thread updaterecentkills(var_0, var_1, var_2, var_10);
  thread updatequadfeedcounter(self, var_0);
  self.prevlastkilltime = self.lastkilltime;
  self.lastkilltime = var_9;
  self.lastkilledplayer = var_1;
  self.lastkillvictimpos = var_1.origin;

  if(isPlayer(self)) {
    if(self.deaths > 0) {
      var_11 = self.kills / self.deaths;

      if(var_11 > 3.0)
        level thread scripts\cp\cp_player_battlechatter::saytoself(self, "_encstr_9BEC0C72814DCF24BFA0030B64BB", undefined, 0.75);
    } else if(self.kills > 5)
      level thread scripts\cp\cp_player_battlechatter::saytoself(self, "_encstr_9BEC0C72814DCF24BFA0030B64BB", undefined, 0.75);
  }

  if(istrue(self.laststanding))
    incpersstat("_encstr_871B071B63D547B10D", 1);

  self.modifiers = [];
  self.modifiers["_encstr_87A205AF10734B"] = 0;
  self.modifiers["_encstr_95A40617A8CBC38F"] = 0;

  if(isDefined(self.damagedplayers) && isDefined(self.damagedplayers[var_7]))
    self.damagedplayers[var_7] = undefined;

  var_12 = scripts\cp\cp_weapon::getweapongroup(var_2.basename);

  if(!scripts\cp\utility::iskillstreakweapon(var_2.basename) && !scripts\cp\utility::_hasperk("_encstr_B4371B9BE0B26C5A85B1A32FD7CAE11C1B7B374B3B2B26AB361B95479B")) {
    if(var_3 == "_encstr_AA230E8CF56CD18DB12FC7E303C8C001")
      execution(var_0);

    if(var_2.basename == "_encstr_8BBA05185F8B99" && !scripts\cp_mp\utility\player_utility::isinvehicle())
      return 0;

    if(isDefined(var_1.attackerposition))
      var_13 = var_1.attackerposition;
    else
      var_13 = self.origin;

    var_14 = 1;

    if(isDefined(var_4))
      var_14 = var_4 == self;

    var_15 = anglesToForward(self getplayerangles());
    var_16 = var_1.origin - var_13;
    var_17 = vectorNormalize(var_16);
    var_18 = vectordot(var_15, var_17);
    var_19 = scripts\engine\utility::isbulletdamage(var_3);

    if(var_1.attackers.size == 1 && !isDefined(var_1.attackers[var_1.guid])) {
      if(var_12 == "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33" && var_3 != "_encstr_8DED0A21C79B660BC7588981" && var_9 == var_1.attackerdata[self.guid].firsttimedamaged) {
        self.modifiers["_encstr_87B20CC852EF5FB07FBC7A638C5B"] = 1;
        self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 1;
        thread killeventtextpopup("_encstr_82C80E2F4D3D79FBC0906BB908103C82", 1);
        thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_82C80E2F4D3D79FBC0906BB908103C82");
        incpersstat("_encstr_AC3310E07AC707A817C41088ADFFF031ED33", 1);
      }

      if(var_12 == "_encstr_87E60F77CA0BC1DB37BEE6D0DE47D9ABB9" && var_3 != "_encstr_8DED0A21C79B660BC7588981" && var_9 == var_1.attackerdata[self.guid].firsttimedamaged) {
        self.modifiers["_encstr_8707147FF8FAEB0CA89CC2ABC194F9AB336068D485BE"] = 1;
        incpersstat("_encstr_AC3310E07AC707A817C41088ADFFF031ED33", 1);
      }
    }

    if(var_3 == "_encstr_8DED0A21C79B660BC7588981") {
      if(var_12 != "_encstr_8ACC0DEC0F42B1A0263F50189B45B9" && var_12 != "_encstr_8D200E63B9A7DBC550975D5D99600FAA") {
        thread killeventtextpopup("_encstr_862509E16B2BE74B6BA8E8", 1);
        thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_862509E16B2BE74B6BA8E8");
      }

      if(var_2.basename == "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C") {
        thread killeventtextpopup("_encstr_BE690A143B833BD15F694030", 1);
        thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_BE690A143B833BD15F694030");
      }
    }

    if(isPlayer(var_1)) {
      var_20 = var_1 getheldoffhand();

      if(var_20.basename == "_encstr_8C4A10BA936F7F31D0159D6ECB304757814B" || var_20.basename == "_encstr_8592135EB163BBE43908DF372011A6C2295D295527") {
        self.modifiers["_encstr_AB9008FE285D7F3B4BC0"] = 1;
        self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 2;
      }
    }

    if(isDefined(self.assistedsuicide) && self.assistedsuicide)
      assistedsuicide(var_0, var_2);

    if(level.numkills == 1)
      firstblood(var_0);

    if(isDefined(self.pers) && self.pers["_encstr_B80511FE9DCDD954993093EBA9331C534B3F44"] > 3)
      comeback(var_0);

    if(var_3 == "_encstr_87280E1FB705D168313D1FD197B1A799" || isDefined(var_6) && (var_6 == "_encstr_81CC0586952C91" || var_6 == "_encstr_A6CC076A05751852B3" || var_6 == "_encstr_9ABA05E87F4B70")) {
      level thread scripts\cp\cp_player_battlechatter::saytoself(self, "_encstr_8CDD166B719E51CBD018951F50E005A97B8BB7B3F7CB1AAC", undefined, 0.75);
      headshot(var_0);
    }

    if(isDefined(self.wasti) && self.wasti && var_9 - self.spawntime <= 5000)
      self.modifiers["_encstr_AF1E11A277A96FE465102AF2884F98D740693C"] = 1;

    if(!scripts\cp\utility\player::isreallyalive(self) && isDefined(self.deathtime)) {
      var_21 = gettime() - self.deathtime;

      if(var_21 < 1500 && var_21 > 0)
        postdeathkill(var_0);

      if(scripts\cp\utility::issimultaneouskillenabled()) {
        if(var_21 == 0 && isDefined(self.lastattacker) && self.lastattacker == var_1) {
          thread killeventtextpopup("_encstr_9A4212B8B27DC3A0E35908F53F8F0BCFA41AF8C8", 0);
          thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_9A4212B8B27DC3A0E35908F53F8F0BCFA41AF8C8", undefined, undefined, 1);
          var_1 thread killeventtextpopup("_encstr_9A4212B8B27DC3A0E35908F53F8F0BCFA41AF8C8", 0);
          var_1 thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_9A4212B8B27DC3A0E35908F53F8F0BCFA41AF8C8", undefined, undefined, 1);
        }
      }
    }

    if(isDefined(var_1.lastkilltime) && (level.teambased && var_9 - var_1.lastkilltime < 1500)) {
      if(isDefined(var_1.lastkilledplayer) && var_1.lastkilledplayer != self)
        avengedplayer(var_0, var_1.lastkilledplayer);
    }

    foreach(var_24, var_23 in var_1.damagedplayers) {
      if(var_24 == self.guid || var_24 == scripts\engine\utility::string(var_1.guid)) {
        continue;
      }
      if(level.teambased && var_9 - var_23 < 1750)
        defendedplayer(var_0, var_24);
    }

    if(var_14) {
      var_25 = getshotdistancetype(self, var_2, var_3, var_13, var_1);

      switch (var_25) {
        case "_encstr_A90B0B68C75085F316A022DA28":
          thread pointblank(var_0);
          break;
        case "_encstr_B82009D8DBE6D9CDD0B7E8":
          thread longshot(var_0);
          var_26 = scripts\engine\math::round_float(distance(var_13, var_1.origin) / 39.37, 2);
          self setclientomnvar("_encstr_888111574B7DB1DB73763786DBD1F58C96CD3A", var_26);
          self setclientomnvar("_encstr_B4A214E85A9E01D00BD716723F15291B2852818042C1", update_future_stations_track_timers(var_13, var_1, var_2));
          break;
        case "_encstr_86500EF327F03197887228922B19E053":
          thread longshot(var_0);
          thread very_longshot(var_0);
          var_26 = scripts\engine\math::round_float(distance(var_13, var_1.origin) / 39.37, 2);
          self setclientomnvar("_encstr_888111574B7DB1DB73763786DBD1F58C96CD3A", var_26);
          self setclientomnvar("_encstr_B4A214E85A9E01D00BD716723F15291B2852818042C1", update_future_stations_track_timers(var_13, var_1, var_2));
          break;
      }
    }

    if(isbackkill(self, var_1, var_3)) {
      if(var_2.basename == "_encstr_BED80D7C9C59D95BF870DBDFA9F018") {
        thread killeventtextpopup("_encstr_A13C0913C2C6B5CD470B31", 1);
        thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_A13C0913C2C6B5CD470B31");
      }

      self.modifiers["_encstr_A13C0913C2C6B5CD470B31"] = 1;
      self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 4;
    }

    if(var_14) {
      switch (weaponclass(var_2.basename)) {
        case "_encstr_965306392D3336B2":
          incpersstat("_encstr_874F0847251A2AD4D0C3", 1);
          var_1 incpersstat("_encstr_8577097F528803E9B41B28", 1);

          if(var_3 == "_encstr_87280E1FB705D168313D1FD197B1A799")
            incpersstat("_encstr_A9E50C61184837F11940A8D573B7", 1);

          break;
        case "_encstr_BE1904DCDA9D":
          incpersstat("_encstr_AA2809F3982F54BBA09C28", 1);
          var_1 incpersstat("_encstr_8DEB0A3EE517055BCEDBE030", 1);

          if(var_3 == "_encstr_87280E1FB705D168313D1FD197B1A799")
            incpersstat("_encstr_A5A10D37B69D8459C223B91A7B1DDC", 1);

          break;
        case "_encstr_A1100738A33A638123":
          incpersstat("_encstr_A6890DB388305B573845EBC169D81A", 1);
          var_1 incpersstat("_encstr_B46F0E432830992F07FAF43957CB68EB", 1);

          if(var_3 == "_encstr_87280E1FB705D168313D1FD197B1A799")
            incpersstat("_encstr_8F79114EEC0219019D5B99F84FA4DB796A93C6", 1);

          break;
        case "_encstr_BE0703A54C":
          incpersstat("_encstr_859C09016D42A72D449380", 1);
          var_1 incpersstat("_encstr_A16A0AD86BEC44CA2C1D349B", 1);

          if(var_3 == "_encstr_87280E1FB705D168313D1FD197B1A799")
            incpersstat("_encstr_B8C80DA3CBBC886D08712AF40878A3", 1);

          break;
        case "_encstr_850707F7E5833355B8":
          incpersstat("_encstr_AFE80C9BE696E056E45A4B63B1B9", 1);
          var_1 incpersstat("_encstr_82070D105DB4B7F146C9CBDB2953DF", 1);

          if(var_3 == "_encstr_87280E1FB705D168313D1FD197B1A799")
            incpersstat("_encstr_A9BF1033C8B3CB5780894549F9A05CEF6503", 1);

          break;
        case "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0":
          incpersstat("_encstr_AF680E8C6F73630E01E0E308F871855F", 1);
          var_1 incpersstat("_encstr_920A0F7CBFA3B3DED1D0D3A8C81BD363DB", 1);

          if(var_3 == "_encstr_87280E1FB705D168313D1FD197B1A799")
            incpersstat("_encstr_922712C92F7B5E03686F7BDB6501B3F024F76B78", 1);

          break;
        case "_encstr_8D940738966ED1DB8D":
          incpersstat("_encstr_A1260C786A22E9E8BB5BA32944FF", 1);
          var_1 incpersstat("_encstr_A2840DC1D237A3DB3688AC58E81ADC", 1);

          if(var_3 == "_encstr_87280E1FB705D168313D1FD197B1A799")
            incpersstat("_encstr_A2771083B4DC8EBD8D1256B019B91A7BE8DC", 1);

          break;
      }

      if(var_3 == "_encstr_8DED0A21C79B660BC7588981") {
        incpersstat("_encstr_93500B11CD1B017B642AA0A8E3", 1);
        var_1 incpersstat("_encstr_9BF60CB62B1B5995442B853A0D37", 1);
      }

      if(scripts\cp\utility::_hasperk("_encstr_A3AB171B171072EB2259E370D10E3BB170B739673A23B32913")) {
        incpersstat("_encstr_AACD13E6D1DE831C4B9BEC14EDDD2B936996C6B1CD", 1);

        if(!isDefined(self.stoppingpowerkills))
          self.stoppingpowerkills = 0;

        self.stoppingpowerkills++;
      }

      if(scripts\cp\utility::_hasperk("_encstr_974F126E38591BB4C2B1D12FF5B8D5A556E85939")) {
        incpersstat("_encstr_994F1107B1107C21BBD19743375568B9A0387A", 1);

        if(!isDefined(self.deadsilencekills))
          self.deadsilencekills = 0;

        self.deadsilencekills++;
      }

      if(isDefined(level.supportdrones) && level.supportdrones.size > 0) {
        foreach(var_28 in level.supportdrones) {
          if(var_28.owner == self && var_28.helperdronetype == "_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60") {
            var_28.owner incpersstat("_encstr_A2C11B640B1902BB43404F67B0FF652BFF90AD1E61C368C6CCF0635B98", 1);
            break;
          }
        }
      }

      if(issurvivorkill(self))
        thread givekillreward("_encstr_86D81036EDEEF54356C2B13AA1BEB55A63D8", var_0, var_2, "_encstr_86D81036EDEEF54356C2B13AA1BEB55A63D8");

      if(scripts\cp\utility\player::isplayerads()) {
        self.modifiers["_encstr_AD1904291F7B"] = 1;
        self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 8;
        incpersstat("_encstr_A928091BA95B0A48FBE8D3", 1);
      } else if(var_19) {
        self.modifiers["_encstr_B48408136397CAC13031"] = 1;
        self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 16;
        incpersstat("_encstr_81B00D6844C3B7343A28E1194043A0", 1);
      }

      if(!self isonground())
        self.modifiers["_encstr_A64409C2D29C4CED93B9B2"] = 1;

      if(isPlayer(var_1) || isagent(var_1)) {
        if(!var_1 isonground())
          self.modifiers["_encstr_9A93109B2818746A414F6F473DFE32CAD831"] = 1;
      }

      if(self playermount() >= 0.5) {
        self.modifiers["_encstr_849508B2188BC58BF97D"] = 1;
        self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 32;
      }

      if(var_19) {
        self.modifiers["_encstr_A6790E3AB329937F888F5C21935887FF"] = 1;
        var_30 = self getweaponammoclip(var_2);

        if(var_30 <= 0) {
          self.modifiers["_encstr_B4C8115907B3BD71F2CB1028F7CC397A4A5B21"] = 1;
          self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 64;
        }
      }

      if(isPlayer(var_1) || isagent(var_1)) {
        if(var_1 issprinting()) {
          self.modifiers["_encstr_AB4011F653989B2F397EABA3E3037BD390359F"] = 1;
          self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 128;
        }
      }

      if(level.teambased) {
        foreach(var_32 in level.players) {
          if(self.team != var_32.team || self == var_32) {
            continue;
          }
          if(!scripts\cp\utility\player::isreallyalive(var_32)) {
            continue;
          }
          if(distancesquared(self.origin, var_32.origin) < 90000) {
            self.modifiers["_encstr_A7220B9A13D8E7E7A86082DAA8"] = 1;
            break;
          }
        }
      }
    } else if(var_12 == "_encstr_BDBF1277568507DEE67D0E9CED4DB21BA32DB195") {
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

    if(isPlayer(var_1) || isagent(var_1)) {
      if(!var_1 isonground() && !var_1 iswallrunning() && (!self isonground() && !self iswallrunning())) {
        if(var_14)
          thread givekillreward("_encstr_829F10A9DCFA71B562E7637B7B4972988CF5", var_0, var_2, "_encstr_829F10A9DCFA71B562E7637B7B4972988CF5");
      } else {
        if(var_14) {
          if(self iswallrunning())
            thread givekillreward("_encstr_BD8F09036F392283C0904B", var_0, var_2, "_encstr_81B40DD3BFC9D26AB350579F70C83C");
          else if(isdeathfromabove(self, var_2, var_3, var_13, var_1))
            thread givekillreward("_encstr_92FC09FA30050B774B8C78", var_0, var_2, "_encstr_B8EA091FD0D3FF127B99AD");
          else if(events_issliding()) {
            thread givekillreward("_encstr_AD670ADCC6B423CA5B96638D", var_0, var_2, "_encstr_A1B40BC35B809298A1F89089A5");
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
          thread givekillreward("_encstr_8F3B0B07FCF9B9AD30574F45E4", var_0, var_2, "_encstr_A342108A29F3C8F7934238634B2B5D400FDA");
        else if(isskeetshooter(self, var_2, var_3, var_13, var_1))
          thread givekillreward("_encstr_81DA0AAD2D36C6A5E616D24E", var_0, var_2, "_encstr_99F70C6D96B11BFA9AD5DA0759E4");
      }
    }

    if(isDefined(var_1.streakdata)) {
      foreach(var_36 in var_1.streakdata.streaks) {
        var_37 = var_36.currentcost - var_1.streakpoints;

        if(var_37 > 0 && var_37 <= 1) {
          buzzkill(var_0, var_1);
          break;
        }
      }
    }

    if(var_14 && isPlayer(self) && !isagent(self) && !isscriptedagent(self)) {
      if(self ismantling()) {
        thread killeventtextpopup("_encstr_82D10C98E26D11709757BAA34C9B", 1);
        thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_82D10C98E26D11709757BAA34C9B");
      }

      if(isDefined(self.tookweaponfrom) && isDefined(self.tookweaponfrom[var_10]) && self.tookweaponfrom[var_10] == var_1) {
        thread killeventtextpopup("_encstr_87CC098985C65B662D4E59", 1);
        thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_87CC098985C65B662D4E59");
      }
    }

    if(isDefined(var_1.stuckbygrenade))
      level thread scripts\cp\cp_player_battlechatter::saytoself(self, "_encstr_966E147BD8F39F721BF9CD4753152A577B088793786A", undefined, 0.75);

    if(scripts\cp\cp_weapons::isthrowingknife(var_2.basename)) {
      thread killeventtextpopup("_encstr_838113CBD840BFBB731D271F752BF2ED816D0455B0", 1);
      thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_838113CBD840BFBB731D271F752BF2ED816D0455B0");
    }

    if(isDefined(var_1.chopper_playfx) && isDefined(var_1.chopper_playfx.owner)) {
      if(var_1.chopper_playfx.owner != self)
        thread killeventtextpopup("_encstr_81820D2AA0DF6CFFA388447DBEE81F");
    }

    var_39 = self.pers["_encstr_84C910D248050977F8F9A49F0E236BCF4B20"] + 1;
    var_40 = 5;

    if(level.gametype == "_encstr_B81904B04E6B")
      var_40 = 10;

    if(!(var_39 % var_40)) {
      if(!isDefined(self.lastkillsplash) || var_39 != self.lastkillsplash) {
        thread scripts\cp\cp_hud_util::teamplayercardsplash("_encstr_A1AE1767379DA198DB6B774F126044CE4B298A3581A0CA38AF", self, undefined, var_39);
        self.lastkillsplash = var_39;
      }

      if(var_39 <= 30) {
        thread killeventtextpopup("_encstr_A2930837D1E4CAB0DAD7" + var_39, 1);
        thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_A2930837D1E4CAB0DAD7" + var_39);
      }
    }

    if(!(var_39 % 5)) {}

    if(var_39 > 30) {
      thread killeventtextpopup("_encstr_A2390B4EEBD33BC1839FB0D82B", 1);
      thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_A2390B4EEBD33BC1839FB0D82B");
    }

    if(isDefined(var_4) && istrue(var_4.isequipment) && var_3 == "_encstr_A1ED0BA9FF84562B60BA073E83" && !scripts\cp\cp_weapons::isthrowingknife(var_2.basename)) {
      thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_A1870C3ABB306819D982C9FFDE48");
      self.modifiers["_encstr_A1870C3ABB306819D982C9FFDE48"] = 1;
    }

    if(scripts\cp\cp_weapons::islauncherdirectimpactdamage(var_2, var_3)) {
      thread killeventtextpopup("_encstr_A2991428400D567ABC8123792A0AA31F1209D19C87CB", 1);
      thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_A2991428400D567ABC8123792A0AA31F1209D19C87CB");
      self.modifiers["_encstr_8BCF1098EAA3DD69AB752EB04187338B8E23"] = 1;
    }

    if(var_18 >= 0.6428)
      self.modifiers["_encstr_9BFB183B4BD81DA5D6FAA537EB373A85CD4616C946FAEC4B2BEE"] = 1;

    if(isDefined(self.lastadsstarttime) && var_9 - self.lastadsstarttime <= 500 && var_12 == "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33") {
      self.modifiers["_encstr_B8720B4FAB6237809B6FA0505F"] = 1;
      self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 2048;
    }

    if(self.health <= 50) {
      self.modifiers["_encstr_86D81036EDEEF54356C2B13AA1BEB55A63D8"] = 1;
      self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 4096;
    }

    if(isDefined(self.lastweaponchangetime) && var_9 - self.lastweaponchangetime <= 1500) {
      self.modifiers["_encstr_ADF013B09F690BDF1A215ED386320711EF0FD8E0C3"] = 1;
      self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 8192;
    }

    if(isDefined(self.lastweaponpickuptime) && var_9 - self.lastweaponpickuptime <= 1500) {
      self.modifiers["_encstr_85CF13E7101130B295E04A04D6A72BF87EF81773B0"] = 1;
      self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 16384;
    }

    if(isDefined(self.lastreloadtime) && var_9 - self.lastreloadtime <= 1500) {
      self.modifiers["_encstr_84460CE597C2B00B74C170083554"] = 1;
      self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 65536;
    }

    if(scripts\cp_mp\utility\player_utility::isinvehicle()) {
      self.modifiers["_encstr_B1190B49FDD9BBBF1B180A82E1"] = 1;
      self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 4096;
    }

    if(var_1 scripts\cp_mp\utility\player_utility::isinvehicle()) {
      self.modifiers["_encstr_A94E123BD2B11D5AADFA2D9BEB672B1AD26CB1B2"] = 1;
      self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 8192;
    }

    if(istrue(var_1.isdefusing))
      self.modifiers["_encstr_9BD90F6D4BB1C6CA46FA8C56CCD59BB227"] = 1;

    if(scripts\cp\cp_weapon::iscacsecondaryweapon(var_2)) {
      self.modifiers["_encstr_8C5D11B9CAC6B79B8C589C97AFBB2BB0C1B7CD"] = 1;
      self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 131072;
    }

    thread checkmatchdatakills(var_0, var_1);
  }

  if(!isDefined(self.killedplayers[var_7]))
    self.killedplayers[var_7] = 0;

  if(!isDefined(var_1.killedby[var_8]))
    var_1.killedby[var_8] = 0;

  self.killedplayers[var_7]++;
  var_1.killedby[var_8]++;
  var_1.lastkilledby = self;

  if(isPlayer(var_1)) {
    if(!var_1 scripts\cp\utility::isusingremote() && (!var_1 scripts\cp\utility::_hasperk("_encstr_A6B5137F3019DB2A03F1D388700FA372C350F387D8") || istrue(var_1.inlaststand)))
      var_1 thread scripts\cp\utility::setdof_killer();
  }

  scripts\asm\soldier\mp\melee::bufferednotify("_encstr_A3EC145383B883F9E3904AF2A8BF6E3F11FCA5C22D01", var_1, var_10, var_3, self.modifiers);
}

unsetreduceregendelayonkills(var_0) {
  return isDefined(var_0) && isDefined(var_0.vehiclename) && isDefined(var_0.streakinfo);
}

checkkillstreakkillevents(var_0, var_1, var_2) {
  var_3 = scripts\cp\utility::iskillstreakweapon(var_0.basename) || unsetreduceregendelayonkills(var_2);
  var_4 = scripts\cp\agents\gametype_cp_wave_sv::unset_relic_doomslayer(var_0);

  if(var_3 && !var_4) {
    var_5 = level.killstreakweaponmap[var_0.basename];
    var_6 = 0;
    var_7 = 0;
    var_8 = 0;
    var_9 = 0;

    if(!isDefined(var_5)) {
      return;
    }
    switch (var_5) {
      case "_encstr_8CC008133958C81BACCB":
        incpersstat("_encstr_B46814FA7070B16FFBBEA3BA4AE94F08B25C78ED993B", 1);
        var_7 = 1;
        var_9 = 1;
        break;
      case "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A":
        incpersstat("_encstr_BDA01D9F534A81BF83C26831CFD1F828B7637FFA11DB0E800F4BC8436150CF", 1);
        var_7 = 1;
        var_8 = 1;
        break;
      case "_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3":
        incpersstat("_encstr_BE091E244BD9C27B83808FA7705D28BAB95F2F1A3E43BBA00868C30708D014A3", 1);
        var_7 = 1;
        var_8 = 1;
        break;
      case "_encstr_B270105ECB28E94BC5CFABAB937D524C5053":
        incpersstat("_encstr_87981DAFDFBA4918FC1239B17CF3287D422F3B9BB7138E4B0C2FE488A5B468", 1);
        var_7 = 1;
        var_8 = 1;
        break;
      case "_encstr_BA910F9957CA63EBB02D9C373A93B4B5CA":
        var_7 = 1;
        break;
      case "_encstr_86FD08B775CD07DC1338":
        incpersstat("_encstr_95281764AFD21093A313920F5A27DF731A5853E9FF5F39BC7B", 1);
        var_7 = 1;
        var_8 = 1;
        break;
      case "_encstr_8C980A867B3B569CFAA659E8":
        incpersstat("_encstr_A19A177BBB80BBDAE968A2FAB875DBFF3C82FDFCD248E325CF", 1);
        var_7 = 1;
        var_8 = 1;
        break;
      case "_encstr_8BFC0BC2CBD4F737E0A5E1FD79":
        incpersstat("_encstr_9AFA1A708AAB2188137ACB3B9B74707C5FE2EB5892A765116C4CD117", 1);
        var_7 = 1;
        var_9 = 1;
        break;
      case "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4":
        incpersstat("_encstr_BD731CA31BA8D51FED93B2FA9856AB4C08E924048BE01A0F95AC4A32809E", 1);
        var_7 = 1;
        var_9 = 1;
        break;
      case "_encstr_9688105BBAB1A32D7D0BD2E4373A4E96AD2B":
        var_7 = 1;
        break;
      case "_encstr_B1B30B51D176511E377A1BC313":
        incpersstat("_encstr_8265185B5A368D371D4ECAC26DAE8659B21BDCED7396A5D88D6E", 1);
        var_7 = 1;
        var_9 = 1;
        break;
      case "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895":
        incpersstat("_encstr_974519BC48630C6B6DB5DFC7EF8FB26A90737284A090E30249B19F", 1);
        var_7 = 1;
        var_8 = 1;
        break;
      case "_encstr_AA060B6EB2731DE4BCFAEC57E6":
        incpersstat("_encstr_A94919B64B1B36CDA339CA16ADA656E63A9C2F8EAE735A4BC663E6", 1);
        var_7 = 1;
        var_9 = 1;
        break;
      case "_encstr_A2E60C6BC099B7E1A0A93A398F48":
        incpersstat("_encstr_AFEF1C9B5B605B3A094882DA983FB577FB350A3B6D0B97C4C3A94A02C877", 1);
        var_7 = 1;
        var_8 = 1;
        break;
      case "_encstr_8161113BE8A8948A78316B7F5F9722F718D3B2":
        incpersstat("_encstr_8E2427DA5AD863E63A27560BAD5D345A1DAC41D07B9B1CD0B7E4B75D9B694BD8D8DC826E37B4CD3A37", 1);
        var_7 = 1;
        var_8 = 1;
        break;
      default:
        thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("_encstr_8118166DACE9731F4B4EB9899079D75399A2AE3F5F28166F", var_0);
        break;
    }

    if(isDefined(var_2.streakinfo)) {
      if(!isDefined(var_2.streakinfo.kills))
        var_2.streakinfo.kills = 0;

      var_2.streakinfo.kills++;
    }

    incpersstat("_encstr_9AB11072A17B4037CBFBC8E0422CDB989343", 1);

    if(var_8)
      incpersstat("_encstr_AD8D13A31A30ADC3A583BA30AF0384922F2B90C35B", 1);

    if(var_9)
      incpersstat("_encstr_954016DA2DB16337E8935916DA8E39DEEA73322DB48DC6CD", 1);

    if(var_7)
      thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_96BD09ABF3BF0AF0ADDC17" + var_5, undefined, undefined, undefined, undefined, undefined, var_6);

    level thread scripts\cp\cp_player_battlechatter::saytoself(self, "_encstr_95EC18EF28138F38B3A1C13DB39317862F8818B38033D31519DF", undefined, 0.75);
  }
}

killedkillstreak(var_0, var_1, var_2) {
  if(scripts\cp\utility::iskillstreakweapon(var_2.basename))
    thread checkkillstreakkillevents(var_2, undefined, var_1);
  else {
    var_3 = "_encstr_87D5095BD2C6C6F5DCDCEB" + var_0;
    var_1 thread scripts\cp_mp\xmike109::givemidmatchaward(var_3);
    var_1 incpersstat("_encstr_99EF15628773796E90C3B3726123C8B063817DA7A6E257", 1);
    level thread scripts\cp\cp_player_battlechatter::saytoself(var_1, "_encstr_968B17C18DC9D7D62D1B36DC472756586DAFC8CACD4727DB97", undefined, 0.75);
  }

  if(isDefined(var_1.perk_data) && var_1 scripts\cp\utility::_hasperk("_encstr_AF821CB938956CD285363ACB7DB1D0C24B37D76D961BD89B47C9952CDADC")) {
    var_4 = 10;
    var_5 = var_4 * var_1.perk_data["_encstr_A70F123AFB9BF1921E6B70E95DB963A6F083BE13"];
    var_1 scripts\cp\coop_super::increase_super_progress(var_5);
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
  if(isalive(var_0) && !var_0 scripts\cp\utility::isusingremote() && (var_2 == "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9" || var_2 == "_encstr_950A12A99E887D284AD42A7A31D748AA98C4A215" || var_2 == "_encstr_87280E1FB705D168313D1FD197B1A799") && !scripts\cp\utility::iskillstreakweapon(var_1.basename) && !istrue(var_0.assistedsuicide)) {
    var_5 = distancesquared(var_3, var_4.origin);

    if(var_5 < 9216)
      return "_encstr_A90B0B68C75085F316A022DA28";

    if(var_5 > 4000000)
      return "_encstr_86500EF327F03197887228922B19E053";

    var_6 = scripts\cp\cp_weapon::getweapongroup(var_1.basename);
    var_7 = undefined;

    switch (var_6) {
      case "_encstr_ABC90E77AC5883F6DCBE38A5CD1D7B36":
        var_7 = 800;
        break;
      case "_encstr_82EF0C97EDA73962101FCEFF0171":
      case "_encstr_AF710BF4355A9195B0FF0AEAD0":
        var_7 = 1200;
        break;
      case "_encstr_8E250FDD59C283DE37F5169BCD85BA1B1D":
      case "_encstr_A1710B57AD31DBCDCDF1422A60":
      case "_encstr_A3710BEEACC2E0B737EB36B676":
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
  var_4 = scripts\cp\cp_weapon::getweapongroup(var_2.basename);
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
    case "_encstr_8E250FDD59C283DE37F5169BCD85BA1B1D":
    case "_encstr_A3710BEEACC2E0B737EB36B676":
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
  return var_0.health > 0 && var_0.health < var_0.maxhealth * 0.2;
}

checkmatchdatakills(var_0, var_1) {
  if(isDefined(self.lastkilledby) && self.lastkilledby == var_1) {
    self.lastkilledby = undefined;
    revenge(var_0, var_1);
  }
}

givekillreward(var_0, var_1, var_2, var_3) {
  self.modifiers[var_0] = 1;

  if(isDefined(var_3))
    thread scripts\cp_mp\xmike109::givemidmatchaward(var_3);
  else
    thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints(var_0, var_2);
}

proximityassist(var_0) {
  self.modifiers["_encstr_950E10B96D8A514B0F8FDD384DDFF7E94760"] = 1;
  thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("_encstr_950E10B96D8A514B0F8FDD3849DFF7E94760");
}

proximitykill(var_0) {
  self.modifiers["_encstr_8A220E8393F60F4BB6B4A35EA5961BC6"] = 1;
  thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("_encstr_8A220E8393F60F4BB6B4A35EB5961BC6");
}

longshot(var_0) {
  self.modifiers["_encstr_B82009D8DBE6D9CDD0B7E8"] = 1;
  self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 262144;
  thread scripts\cp\agents\agents::logattackerkillevent(var_0, "_encstr_B82009D8DBE6D9CDD0B7E8");
  incpersstat("_encstr_87610E36EDE63BE6347BA32DA51BB1E6", 1);
  thread killeventtextpopup("_encstr_B82009D8DBE6D9CDD0B7E8", 1);
  thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_B82009D8DBE6D9CDD0B7E8");
}

very_longshot(var_0) {
  self.modifiers["_encstr_86500EF327F03197887228922B19E053"] = 1;
}

pointblank(var_0) {
  self.modifiers["_encstr_A90B0B68C75085F316A022DA28"] = 1;
  self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 524288;
  thread scripts\cp\agents\agents::logattackerkillevent(var_0, "_encstr_A90B0B68C75085F316A022DA28");
  thread killeventtextpopup("_encstr_A90B0B68C75085F316A022DA28", 1);
  thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_A90B0B68C75085F316A022DA28");
  incpersstat("_encstr_9BE4105B208BCD83057121569A4CBF15D968", 1);
}

headshot(var_0) {
  self.modifiers["_encstr_848909BBD3A7526348E8E3"] = 1;
  self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 1048576;
  thread scripts\cp\agents\agents::logattackerkillevent(var_0, "_encstr_848909BBD3A7526348E8E3");
  thread killeventtextpopup("_encstr_848909BBD3A7526348E8E3", 1);
  thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_848909BBD3A7526348E8E3");
}

avengedplayer(var_0, var_1) {
  self.modifiers["_encstr_977C08697BE705EAA5E3"] = 1;
  self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 2097152;
  thread scripts\cp\agents\agents::logattackerkillevent(var_0, "_encstr_977C08697BE705EAA5E3");
  incpersstat("_encstr_812B0DE153B5A0648A2B7F234BC2B6", 1);
  thread killeventtextpopup("_encstr_977C08697BE705EAA5E3", 1);
  thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_977C08697BE705EAA5E3");
}

assistedsuicide(var_0, var_1) {
  self.modifiers["_encstr_950310C2E637D29B8E2B32CDABD2B1D2C8AC"] = 1;
  thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("_encstr_950310C2E637D29B8E2B32CDABD2B1D2C8AC", var_1);
  thread scripts\cp\agents\agents::logattackerkillevent(var_0, "_encstr_950310C2E637D29B8E2B32CDABD2B1D2C8AC");
  thread killeventtextpopup("_encstr_950310C2E637D29B8E2B32CDABD2B1D2C8AC", 1);
  thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_950310C2E637D29B8E2B32CDABD2B1D2C8AC");
}

defendedplayer(var_0, var_1) {
  self.modifiers["_encstr_8E460991ACCC59378C56C9"] = 1;
  self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 4194304;
  thread scripts\cp\agents\agents::logattackerkillevent(var_0, "_encstr_8E460991ACCC59378C56C9");
  incpersstat("_encstr_92090E74BDC19F9DC9D0D358A801D50F", 1);
  var_2 = scripts\cp\utility::getplayerforguid(var_1);
  thread killeventtextpopup("_encstr_9AD407EB275B37556D", 0);
  thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_95840E3FB94BF8601B9291187A27ADA0");
}

postdeathkill(var_0) {
  self.modifiers["_encstr_93150B9B625FB5C8DBEDA79B1B"] = 1;
  self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 8388608;
  thread scripts\cp\agents\agents::logattackerkillevent(var_0, "_encstr_93150B9B625FB5C8DBEDA79B1B");
  thread killeventtextpopup("_encstr_93150B9B625FB5C8DBEDA79B1B", 1);
  thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_93150B9B625FB5C8DBEDA79B1B");
}

revenge(var_0, var_1) {
  self.modifiers["_encstr_811F08C0C726E1953267"] = 1;
  self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 16777216;
  thread scripts\cp\agents\agents::logattackerkillevent(var_0, "_encstr_811F08C0C726E1953267");
  incpersstat("_encstr_8F8C0D850513CA55CFEB67C95A4D13", 1);
  thread killeventtextpopup("_encstr_811F08C0C726E1953267", 1);
  thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_811F08C0C726E1953267");
}

multikill(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.inneurotoxintimestamp))
    self.inneurotoxintimestamp = var_1;

  if(var_1 < self.inneurotoxintimestamp) {
    return;
  }
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

  thread scripts\cp\agents\agents::logmultikill(var_0, var_1);

  if(isDefined(var_4)) {
    thread killeventtextpopup(var_4, scripts\engine\utility::ter_op(isDefined(var_2), var_2, 1), istrue(var_3));

    if(!istrue(var_3))
      thread scripts\cp_mp\xmike109::givemidmatchaward(var_4, undefined, undefined, undefined, undefined, undefined, undefined, undefined, self getcurrentweapon());
  }

  if(isDefined(var_5)) {
    if(!istrue(var_3))
      thread playbattlechattersoundsplitscreen(self, var_5, undefined, self);
    else
      thread scripts\cp\cp_hud_util::teamplayercardsplash(var_5, self, self.team, undefined, 1);
  }
}

playbattlechattersoundsplitscreen(var_0, var_1, var_2, var_3) {
  var_0 thread scripts\cp\cp_hud_message::showsplash(var_1, var_2, var_3);
}

firstblood(var_0) {
  self.modifiers["_encstr_85E10B66B44E6EA3981BBDDE91"] = 1;
  self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 33554432;
  thread scripts\cp\agents\agents::logattackerkillevent(var_0, "_encstr_85E10B66B44E6EA3981BBDDE91");
  thread scripts\cp\cp_hud_util::teamplayercardsplash("_encstr_95E8136C58D8B1F6AB1DEB3396399B3A4C8DB7BD19", self);
  thread killeventtextpopup("_encstr_85E10B66B44E6EA3981BBDDE91", 1);
  thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_85E10B66B44E6EA3981BBDDE91");
}

winningshot(var_0) {}

buzzkill(var_0, var_1) {
  self.modifiers["_encstr_ACE1097ABDCDAAFF83FCB1"] = var_1.pers["_encstr_84C910D248050977F8F9A49F0E236BCF4B20"];
  self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 67108864;
  thread scripts\cp\agents\agents::logattackerkillevent(var_0, "_encstr_ACE1097ABDCDAAFF83FCB1");
  thread killeventtextpopup("_encstr_ACE1097ABDCDAAFF83FCB1", 1);
  thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_ACE1097ABDCDAAFF83FCB1");
}

comeback(var_0) {
  self.modifiers["_encstr_92DF0956DA8F69425F23C8"] = 1;
  self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 134217728;
  thread scripts\cp\agents\agents::logattackerkillevent(var_0, "_encstr_92DF0956DA8F69425F23C8");
  thread killeventtextpopup("_encstr_92DF0956DA8F69425F23C8", 1);
  thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_92DF0956DA8F69425F23C8");
  incpersstat("_encstr_BA3D0E73B8A09F9EC3E04258A801D50F", 1);
}

collateral(var_0) {
  if(var_0 == 2) {
    level thread scripts\cp\cp_player_battlechatter::saytoself(self, "_encstr_88D2140EC639F5D65A8D36CC2D39DAD7D1DD7B332B39", undefined, 0.75);
    thread killeventtextpopup("_encstr_B63E13D8F53AD70B08E7F0B1934FC09FA25CC1D10A", 1);
    thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_B63E13D8F53AD70B08E7F0B1934FC09FA25CC1D10A");
  }

  if(var_0 == 3)
    level thread scripts\cp\cp_player_battlechatter::saytoself(self, "_encstr_A3CA165BD0661FBC20A914E65B93C5D78DC8F3B259348FB2", undefined, 0.75);
}

shotguncollateral(var_0) {}

quadfeed(var_0, var_1) {
  self.modifiers["_encstr_B4CE09E2D50BC8CC56CA91"] = 1;
  self.modifiers["_encstr_87A205AF10734B"] = self.modifiers["_encstr_87A205AF10734B"] | 536870912;
  thread killeventtextpopup("_encstr_A74E0A83F3D19018DA570319", 1);
  thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_A74E0A83F3D19018DA570319");
}

disconnected() {
  var_0 = self.guid;

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    if(isDefined(level.players[var_1].killedplayers[var_0]))
      level.players[var_1].killedplayers[var_0] = undefined;

    if(isDefined(level.players[var_1].killedby[var_0]))
      level.players[var_1].killedby[var_0] = undefined;
  }
}

monitorhealed() {
  level endon("_encstr_A3AF090768A9910F4118EF");

  for(;;) {
    level waittill("_encstr_8FB50718DD41DB3FA9", var_0);
    var_0 thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("_encstr_8FB50718DD41DB3FA9");
  }
}

updaterecentkills(var_0, var_1, var_2, var_3) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_850C125B73F20718A55261B98786505A9AABF1DF");
  self endon("_encstr_850C125B73F20718A55261B98786505A9AABF1DF");

  if(!isDefined(self.recentkillcount))
    self.recentkillcount = 0;

  self.recentkillcount++;

  if(!isDefined(self.recentkillsperweapon))
    self.recentkillsperweapon = [];

  if(!isDefined(self.recentkillsperweapon[var_3]))
    self.recentkillsperweapon[var_3] = 1;
  else
    self.recentkillsperweapon[var_3]++;

  var_4 = scripts\cp\utility::getequipmenttype(var_2.basename);

  if(isDefined(var_4) && var_4 == "_encstr_B116071BCAD186858D" && var_2.basename != "_encstr_8AF511A30D4EDEDDB4CDB35BE6A5CC2BFA5B83") {
    level thread scripts\cp\cp_player_battlechatter::saytoself(self, "_encstr_BACE15F9748AE9BAAFC270397A2B613167C26B4DE17770", undefined, 0.75);
    level thread scripts\cp\cp_player_battlechatter::saytoself(self, "_encstr_A91511DB78537F92FB192DA7F3B58A3759E80B", undefined, 0.75);

    if(self.recentkillsperweapon[var_3] > 0 && self.recentkillsperweapon[var_3] % 2 == 0) {
      thread killeventtextpopup("_encstr_97AB0FAF3285E5C3ACE7D91AE2B73D9A72", 1);
      thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_97AB0FAF3285E5C3ACE7D91AE2B73D9A72");
    }
  }

  scripts\asm\soldier\mp\melee::bufferednotify("_encstr_92FB1BA870FADEE4054823C2E74B9D214FEB3260C71EC5E1A19595F873", self.recentkillcount, var_3);

  if(self.recentkillcount > 1)
    thread multikill(var_0, self.recentkillcount, 0);

  wait 2.5;

  if(self.recentkillcount > 1) {
    thread multikill(var_0, self.recentkillcount, 1, 1);

    if(self.recentkillcount > 2) {}
  }

  incpersstat("_encstr_8D6F0F08D7A6D5454B3A2C9757C3036B5B", 1);
  self.recentkillcount = 0;
  self.recentdefendcount = 0;
  self.recentkillsperweapon = undefined;
}

monitorcratejacking() {
  level endon("_encstr_A3AF090768A9910F4118EF");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_A3E00911A924B0061FFAEB", var_0, var_1);
    thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_992317E6DC7D5DDC597DACB9CAB5BCBE91E4DB9BB291C97B07");
    var_2 = "_encstr_81231110F73A618FF26705807E8AF5898A5758";

    if(isDefined(var_1))
      var_1 scripts\cp\cp_hud_message::showsplash(var_2, undefined, self);
  }
}

updatequadfeedcounter(var_0, var_1) {
  if(isDefined(level.quadfeedinfo) && gettime() - level.quadfeedinfo.starttime > 5000)
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
  if(scripts\cp\utility\player::isreallyalive(self)) {
    var_0 = self issprintsliding();

    if(istrue(self.eventswassliding) && !var_0)
      self.eventsslideendtime = gettime();

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
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.lastreloadtime = 0;

  for(;;) {
    self waittill("_encstr_AF4D07932B1BDE5846");
    self.lastreloadtime = gettime();
    incpersstat("_encstr_B8EE0853B010CFB26116", 1);
  }
}

monitorweaponpickup() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.lastweaponpickuptime = 0;

  for(;;) {
    self waittill("_encstr_914C0EDDB20B837BB97D38D2365BAB83");
    self.lastweaponpickuptime = gettime();
    incpersstat("_encstr_81880EE74DE64B58D361CBB76C286B73", 1);
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

  if(!istrue(var_0) && self.mantlecur) {}

  var_1 = self.jumpcur;
  self.jumpcur = self isjumping();

  if(!istrue(var_1) && self.jumpcur) {}

  var_2 = self getstance();

  if(var_2 != self.laststance) {
    if(self.laststance == "_encstr_B13D076BED70539F23") {
      var_3 = self.laststancechangetime;
      var_4 = (gettime() - var_3) / 1000;
      incpersstat("_encstr_82440D73BB3BADE18A902B2F882D19", var_4);
    }

    if(self.laststance == "_encstr_922406F1A6FD5E05") {
      var_3 = self.laststancechangetime;
      var_4 = (gettime() - var_3) / 1000;
      incpersstat("_encstr_9AFB0A938AAFA5919267DD33", var_4);
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

predatormissileimpact(var_0) {}

largevehicleexplosion(var_0) {}

vehiclekilled(var_0) {}

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

missilewhizby(var_0, var_1) {}

bombdefused(var_0) {
  var_1 = 0;
  var_2 = 0;

  if(!var_1) {
    var_3 = scripts\cp\utility::getplayersinradius(var_0.origin, 600);

    foreach(var_5 in var_3) {
      if(var_5.team != var_0.team) {
        var_2 = 1;
        break;
      }
    }
  }

  if(var_1)
    var_0 thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_864314B5BD19CAFAB923AF63B0B91DD746B233576EB2");
  else
    var_0 thread scripts\cp_mp\xmike109::givemidmatchaward("_encstr_8B6D0F5040346FC7534AD94AE3F6EB3FA9");

  var_0 incpersstat("_encstr_817B0812789D1387E986", 1);

  if(isPlayer(var_0))
    var_0 thread scripts\cp\agents\agents::loggameevent("_encstr_830C078CCA33ABB959", var_0.origin);
}

revivedplayer(var_0, var_1) {
  if(scripts\cp\utility::getgametype() == "_encstr_839E0CBFD1801B5DB0D34C932998")
    return;
}

doorused(var_0, var_1) {
  if(var_1)
    var_0.lastdooropentime = gettime();
}

shothit() {}

shotmissed() {}

killeventtextpopup(var_0, var_1, var_2) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(!scripts\cp\drone\emp_drone::scoreeventhastext(var_0)) {
    return;
  }
  if(!scripts\cp\utility::turn_off_sniper_laser() && isDefined(self.totalxpearned) && isDefined(self._id_11B7F)) {
    if(self.totalxpearned >= self._id_11B7F)
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
  var_6.priority = scripts\cp\drone\emp_drone::getscoreeventpriority(var_0);
  var_6.alwaysshowsplash = scripts\cp\drone\emp_drone::scoreeventalwaysshowassplash(var_0);
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
  var_9 = 0;

  foreach(var_4 in self.splashpriorityqueue) {
    if(var_4._id_128AC) {
      continue;
    }
    if(!istrue(level.removekilleventsplash) && istrue(var_4.showassplash) && (!var_9 || var_4.alwaysshowsplash)) {
      var_9 = 1;
      thread scripts\cp\cp_hud_message::showsplash(var_4.scoreeventref);
    }

    var_4._id_128AC = 1;
  }

  foreach(var_4 in self.splashpriorityqueue) {
    if(var_4._id_128AB || var_4.matchdata_logplayerlife) {
      continue;
    }
    thread scripts\cp\drone\emp_drone::scoreeventpopup(var_4.scoreeventref);
    var_4._id_128AB = 1;
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

initpersstat(var_0) {
  if(!isDefined(self.pers[var_0]))
    self.pers[var_0] = 0;
}

getpersstat(var_0) {
  return self.pers[var_0];
}

incpersstat(var_0, var_1) {
  if(istrue(game["_encstr_B4A90E9ACB88E33BC3B7FF2B87F5A25C"])) {
    return;
  }
  if(isDefined(self) && isDefined(self.pers) && isDefined(self.pers[var_0]))
    self.pers[var_0] = self.pers[var_0] + var_1;
}

setextrascore0(var_0) {
  if(istrue(game["_encstr_B4A90E9ACB88E33BC3B7FF2B87F5A25C"])) {
    return;
  }
  self.extrascore0 = var_0;
  self.pers["_encstr_8A220C2BC3474E0BB9B17B9CB203"] = var_0;
}

setextrascore1(var_0) {
  if(istrue(game["_encstr_B4A90E9ACB88E33BC3B7FF2B87F5A25C"])) {
    return;
  }
  self.extrascore1 = var_0;
  self.pers["_encstr_84220CB23C8E9CC2CD36DB27AC4C"] = var_0;
}

setextrascore2(var_0) {
  if(istrue(game["_encstr_B4A90E9ACB88E33BC3B7FF2B87F5A25C"])) {
    return;
  }
  self.extrascore2 = var_0;
  self.pers["_encstr_AD220CACE18E93C2B98DEDE4B223"] = var_0;
}

setextrascore3(var_0) {
  if(istrue(game["_encstr_B4A90E9ACB88E33BC3B7FF2B87F5A25C"])) {
    return;
  }
  self.extrascore3 = var_0;
  self.pers["_encstr_85220C92C329223FDB1EC7D225EB"] = var_0;
}

getplayerdataloadoutgroup() {
  if(level.rankedmatch)
    return "_encstr_B8A30FC8463D282A65B07FF929C89DD3F0";

  return "_encstr_A6DC101B53ABFB7E88FB542F8B7085BF4DEB";
}

setplayerdatagroups() {
  level.loadoutsgroup = getplayerdataloadoutgroup();
}

canrecordcombatrecordstats() {
  return level.rankedmatch && !istrue(level.ignorescoring) && scripts\cp\utility::getgametype() != "_encstr_AAE507E8423F63C163";
}

getstreakrecordtype(var_0) {
  if(isenumvaluevalid("_encstr_8C07031599", "_encstr_9ABE1BAC7F5C689FF27787979B0ADED0F2D7B1C06AA4E8CD98F3F38BA7", var_0))
    return "_encstr_97C417B1ED5B80538DA9B8D093E72F5B2B954FBA73E369B1B2";

  if(isenumvaluevalid("_encstr_8C07031599", "_encstr_B2D31C69F367A3BDF8992BE35793C7678D8B82F298AECB76E0CB04ED7B20", var_0))
    return "_encstr_81671883BB2BDF9842AC770FAF2A802643A3D949E20F15101B83";

  return undefined;
}

execution(var_0) {
  self.modifiers["_encstr_B1100A561EACC6AB3AB47BCD"] = 1;
  self.modifiers["_encstr_95A40617A8CBC38F"] = self.modifiers["_encstr_95A40617A8CBC38F"] | 256;
  thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("_encstr_B1100A561EACC6AB3AB47BCD");
}

stoppingpower_clearhcrdata() {
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
  self.pers["_encstr_84C910D248050977F8F9A49F0E236BCF4B20"] = 0;
  self.pers["_encstr_B80511FE9DCDD954993093EBA9331C534B3F44"] = 0;
  self.pers["_encstr_8305198D5D93D7AD5AD8B1F5B93A9C5616D6BE33BD937DE6ABB6CA"] = 0;
  self.tookweaponfrom = [];
  self.guid = scripts\cp\utility\player::getuniqueid();
  thread _id_1445A();
}

_id_1445A() {
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_93530B91C713410FAFEAC86852");

  if(isDefined(self.attackers) && self.attackers.size > 0) {
    foreach(var_2, var_1 in self.attackers) {
      if(isPlayer(var_1)) {
        if(isDefined(self.attackerdata) && self.attackerdata.size > 0) {
          if(!isDefined(var_1._id_119D4))
            var_1._id_119D4 = [];

          var_1 thread vip_playerdied(undefined, self, self.attackerdata[var_2].objweapon, self.attackerdata[var_2].smeansofdeath, var_1, 0);
          thread scripts\mp\ammorestock::onplayerkilled(var_1, var_1, self.maxhealth, undefined, self.attackerdata[var_2].smeansofdeath, self.attackerdata[var_2].objweapon, self.attackerdata[var_2]._id_13417, var_1.modifiers);
          var_1 thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("_encstr_ABD70578F3D02C", self.attackerdata[var_2].objweapon);
          var_1._id_119D4[self getentitynumber()] = 1;
        }
      }
    }
  }
}