/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\playerlogic.gsc
***********************************************/

init() {
  level scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::onversusdone);
}

timeuntilwavespawn(var_0) {
  if(!self.hasspawned)
    return 0;

  var_1 = gettime() + var_0 * 1000;
  var_2 = level.lastwave[self.pers["_encstr_8AEF05472BC2D6"]];
  var_3 = level.wavedelay[self.pers["_encstr_8AEF05472BC2D6"]] * 1000;
  var_4 = (var_1 - var_2) / var_3;
  var_5 = ceil(var_4);
  var_6 = var_2 + var_5 * var_3;

  if(isDefined(self.respawntimerstarttime)) {
    var_7 = (gettime() - self.respawntimerstarttime) / 1000.0;

    if(self.respawntimerstarttime < var_2)
      return 0;
  }

  if(isDefined(self.wavespawnindex))
    var_6 = var_6 + 50 * self.wavespawnindex;

  return (var_6 - gettime()) / 1000;
}

teamkilldelay() {
  var_0 = self.pers["_encstr_AA9C0A1555B798EF648228C8"];

  if(!isDefined(var_0) || level.maxallowedteamkills < 0 || var_0 <= level.maxallowedteamkills)
    return 0;

  var_1 = var_0 - level.maxallowedteamkills;
  return scripts\mp\tweakables::gettweakablevalue("_encstr_8AEF05472BC2D6", "_encstr_93D513E05BBF6FF84878800380F9440388CD23506F") * var_1;
}

timeuntilspawn(var_0) {
  if(level.ingraceperiod && !self.hasspawned || level.gameended)
    return 0;

  var_1 = 0;

  if(self.hasspawned) {
    var_2 = self[[level.onrespawndelay]]();

    if(isDefined(var_2))
      var_1 = var_2;
    else
      var_1 = getdvarfloat("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_96131449B3894798E035AA850F70A6D720A9628279DB");

    if(var_0 && isDefined(self.pers["_encstr_8CED0F31BD8EB86A6F0230BFFB1B231064"]) && self.pers["_encstr_8CED0F31BD8EB86A6F0230BFFB1B231064"])
      var_1 = var_1 + teamkilldelay();

    if(isDefined(self.suicidespawndelay))
      var_1 = var_1 + getdvarfloat("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_91B613AFE65D4BD85A2356CD382CEEE68CCA1B0B2F");

    if(isDefined(self.respawntimerstarttime) && !isDefined(level.spawndelay)) {
      var_3 = (gettime() - self.respawntimerstarttime) / 1000.0;
      var_1 = var_1 - var_3;

      if(var_1 < 0)
        var_1 = 0;
    }

    if(isDefined(self.setspawnpoint))
      var_1 = var_1 + level.tispawndelay;
  }

  var_4 = getdvarint("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_829F126E5BE9383DB30F474937CBF0F085F5D122") > 0;

  if(var_4)
    var_1 = timeuntilwavespawn(var_1);

  if(level.ingraceperiod && !self.hasspawned || level.gameended)
    var_1 = 0;
  else if(getdvarint("_encstr_840915A357F6079890B74927DF90C38B995FA7D30ABB17", 0) == 1)
    var_1 = 999.0;

  if(!isDefined(self.tiers))
    self.tiers = var_1;

  return var_1;
}

isdevelopmentspawningofbotclient(var_0) {
  return 0;
}

mayspawn() {
  if(istrue(level.nukegameover))
    return 0;

  if(scripts\mp\utility\game::getgametypenumlives() || isDefined(level.disablespawning)) {
    if(isDefined(level.teamswithplayers) && level.teamswithplayers.size == 1)
      return 1;

    if(istrue(level.disablespawning)) {
      if(!isdevelopmentspawningofbotclient(self))
        return 0;
    }

    if(istrue(self.pers["_encstr_8CED0F31BD8EB86A6F0230BFFB1B231064"]))
      return 0;

    if(self.pers["_encstr_8CAA06DB20A31543"] <= 0 && scripts\mp\utility\game::gamehasstarted())
      return 0;
    else if(scripts\mp\utility\game::gamehasstarted()) {
      if(level.ingraceperiod && !self.hasspawned)
        return 1;

      if(!level.ingraceperiod && !self.hasspawned && (isDefined(level.allowlatecomers) && !level.allowlatecomers)) {
        if(isDefined(self.siegelatecomer) && !self.siegelatecomer)
          return 1;

        if(isdevelopmentspawningofbotclient(self))
          return 1;

        return 0;
      }
    }
  }

  if(isDefined(level.loadoutdrop) && [[level.loadoutdrop]](self))
    return 0;

  return 1;
}

spawnclient(var_0) {
  self endon("_encstr_B6A41013CA3658DA95A6E059B11D0B8EF639");

  if(isDefined(level._id_11C84)) {
    self[[level._id_11C84]](var_0);
    return;
  }

  if(isDefined(self.pers["_encstr_954311604208F1F6EB479537243739B9364B10"]) && !self.hasspawned)
    self.class = self.pers["_encstr_954311604208F1F6EB479537243739B9364B10"];

  if(isDefined(self.waitingtoselectclass) && self.waitingtoselectclass)
    self waittill("_encstr_B6490A92A03C30911B037F70");

  if(isDefined(self.addtoteam)) {
    scripts\mp\menus::addtoteam(self.addtoteam);
    self.addtoteam = undefined;
  }

  if(!mayspawn()) {
    waitframe();
    var_1 = self.origin;
    var_2 = self.angles;
    self notify("_encstr_976B10EF14B3C9B3723350A0794A418167A6");

    if(istrue(self.pers["_encstr_8CED0F31BD8EB86A6F0230BFFB1B231064"])) {
      self.pers["_encstr_AA9C0A1555B798EF648228C8"] = max(self.pers["_encstr_AA9C0A1555B798EF648228C8"] - 1, 0);
      scripts\mp\utility\lower_message::setlowermessageomnvar(24);

      if(!self.hasspawned && self.pers["_encstr_AA9C0A1555B798EF648228C8"] <= level.maxallowedteamkills)
        self.pers["_encstr_8CED0F31BD8EB86A6F0230BFFB1B231064"] = 0;
    } else if(scripts\mp\utility\game::isroundbased() && game["_encstr_96DF0BCC92723B8A59E7F338A1"] == 0 || scripts\mp\utility\game::getgametypenumlives() != 0 && game["_encstr_96DF0BCC92723B8A59E7F338A1"] == 0 || istrue(level.disablespawning)) {
      var_3 = undefined;

      if(scripts\mp\utility\game::getgametype() != "_encstr_A9B606B0C956B916" && isDefined(self.tagavailable) && self.tagavailable)
        scripts\mp\utility\lower_message::setlowermessageomnvar(8);
      else if(istrue(self.revivetriggerblockedinremote) && level.teamdata[self.team]["_encstr_8A2A0B936CCCC3078547970A8B"] > 0)
        scripts\mp\utility\lower_message::setlowermessageomnvar(64);
      else if(istrue(self.revivetriggeravailable)) {
        if(isDefined(self.timeuntilbleedout)) {
          if(isDefined(self.rallypoint))
            scripts\mp\utility\lower_message::setlowermessageomnvar(25, int(gettime() + self.timeuntilbleedout * 1000));
          else if(!istrue(self.eliminated))
            scripts\mp\utility\lower_message::setlowermessageomnvar(6, int(gettime() + self.timeuntilbleedout * 1000));
        } else if(level.teamdata[self.team]["_encstr_8A2A0B936CCCC3078547970A8B"] > 0)
          scripts\mp\utility\lower_message::setlowermessageomnvar(64);
        else
          scripts\mp\utility\lower_message::setlowermessageomnvar(2);
      } else if(scripts\mp\utility\game::getgametype() == "_encstr_A54F06D32A2F0498") {
        scripts\mp\utility\lower_message::setlowermessageomnvar(4);
        var_3 = 10;
      } else if(istrue(level.exfilstarted))
        scripts\mp\utility\lower_message::setlowermessageomnvar(26);
      else if(scripts\mp\utility\game::isroundbased())
        scripts\mp\utility\lower_message::setlowermessageomnvar(2);
      else if(scripts\mp\utility\game::getgametype() == "_encstr_831904E79F07" && scripts\mp\utility\game::matchmakinggame()) {
        scripts\mp\utility\lower_message::setlowermessageomnvar(78);
        var_3 = 30;
      } else {
        scripts\mp\utility\lower_message::setlowermessageomnvar(18);
        var_3 = 10;
      }

      if(!isDefined(self.revivetriggeravailable))
        thread removespawnmessageshortly(scripts\engine\utility::ter_op(isDefined(var_3), var_3, 6.0));
    }

    if(self.sessionstate != "_encstr_AF8C0A1B6A1D6045925B4F7D")
      var_1 = var_1 + (0, 0, 60);

    if(scripts\mp\utility\player::isusingremote()) {
      self.spawningafterremotedeath = 1;
      self.deathposition = self.origin;
      self waittill("_encstr_A5D2156EE8DEE0C15646F5EACD96E6D9FA9359B5DED1CA");
    }

    if(!istrue(level.nukegameover)) {
      if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
        logstring("_encstr_99F73B2975214B994CD46493CC740488A798821294721D04C62C7372D140CD072C779B02C4573A021CE4B2B52C8E6C86084BCD37938E01DECE954EA304" + self.name);

      thread spawnspectator(var_1, var_2);
    }

    return;
  }

  if(self.waitingtospawn) {
    return;
  }
  self.waitingtospawn = 1;
  waitandspawnclient(var_0);

  if(isDefined(self))
    self.waitingtospawn = 0;
}

waittillcanspawnclient(var_0) {
  self endon("_encstr_8716143EFC0FC379CFDA5930B3E62718A39C4FB345FB");

  for(;;) {
    waitframe();

    if(self.team == "_encstr_AF8C0A1B6A1D6045925B4F7D" || self.team == "_encstr_933E090A10B17DDFB3E522") {
      return;
    }
    if(isDefined(self) && (self.sessionstate == "_encstr_AF8C0A1B6A1D6045925B4F7D" || !scripts\mp\utility\player::isreallyalive(self))) {
      if(istrue(var_0))
        self.pers["_encstr_8CED0F31BD8EB86A6F0230BFFB1B231064"] = 0;

      self.pers["_encstr_8CAA06DB20A31543"] = 1;
      thread spawnclient(var_0);
      continue;
    }

    return;
  }
}

waitandspawnclient(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8CBF0C557DA25F93BD1F48C867DE");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_976B10EF14B3C9B3723350A0794A418167A6");

  if(isDefined(level._id_12888))
    [[level._id_12888]](var_0);

  _id_1437C();
  var_1 = 0;

  if(istrue(self.pers["_encstr_8CED0F31BD8EB86A6F0230BFFB1B231064"])) {
    var_2 = teamkilldelay();

    if(var_2 > 0) {
      scripts\mp\utility\lower_message::setlowermessageomnvar(65, int(gettime() + var_2 * 1000));
      thread respawn_asspectator(self.origin + (0, 0, 60), self.angles);
      var_1 = 1;
      wait(var_2);
      scripts\mp\utility\lower_message::setlowermessageomnvar(0);
      self.respawntimerstarttime = gettime();
    }

    self.pers["_encstr_8CED0F31BD8EB86A6F0230BFFB1B231064"] = 0;
  } else if(teamkilldelay())
    self.pers["_encstr_AA9C0A1555B798EF648228C8"] = max(self.pers["_encstr_AA9C0A1555B798EF648228C8"] - 1, 0);

  if(!isDefined(self.wavespawnindex) && isDefined(level.waveplayerspawnindex[self.team])) {
    self.wavespawnindex = level.waveplayerspawnindex[self.team];
    level.waveplayerspawnindex[self.team]++;
  }

  if(isDefined(self.setspawnpoint) && !tivalidationcheck())
    scripts\mp\equipment\tac_insert::_id_13681(1);

  var_3 = timeuntilspawn(0);
  var_4 = 0.0;

  if(!istrue(level.loadoutdefaultfiresalediscount))
    var_4 = scripts\engine\utility::ter_op(istrue(level.snaptospawncamera), 1.25, 2.0);

  if(istrue(level.usespawnselection))
    var_4 = 0.5;

  if(level.ingraceperiod && !self.hasspawned || level.gameended) {
    var_4 = 0;
    var_3 = 0;
  }

  var_5 = 0;

  if(scripts\mp\utility\game::getgametype() == "_encstr_8E07030349" && isDefined(level.zone) && level.zone.ownerteam == self.team)
    var_5 = 1;

  if(!istrue(self.skippedkillcam) && isDefined(self.killcamwatchtime) && !var_5) {
    if(isDefined(self.tiers))
      var_3 = max(self.tiers - self.killcamwatchtime, 0);
    else
      var_3 = max(var_3 - self.killcamwatchtime, 0);

    self.killcamwatchtime = undefined;
  }

  if(isDefined(self.setspawnpoint)) {
    var_4 = 0;
    var_3 = 0;
  }

  var_3 = max(var_3, var_4);

  if(scripts\mp\arbitrary_up::isinarbitraryup()) {
    var_6 = self getworldupreferenceangles();
    var_7 = anglestoup(var_6);
    var_8 = var_7 * 60;
  } else
    var_8 = (0, 0, 60);

  var_9 = istrue(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"));
  var_10 = scripts\mp\flags::gameflag("_encstr_B27F0F4BB9CC96B1AFDD2D8D1BAF39579B") && !istrue(scripts\mp\flags::gameflag("_encstr_8C0D0E8410E8B112602F133F559DCAF4"));

  if(scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B" && !var_10 && !var_9) {
    var_11 = _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::getmissedinfilcamerapositions(self.team);
    var_12 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_11.startorigin);
    var_12 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_12.angles = var_11.startangles;
    self cameralinkTo(var_12, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_12 moveTo(var_11.endorigin, 18);
    var_12 rotateTo(var_11.endangles, 18);
    scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
    var_9 = 1;
    self cameraunlink();
  }

  if(!istrue(level.loadoutdefaultfiresalediscount) && var_9 && !istrue(self.skipspawncamera) && !istrue(level.usespawnselection) && var_3 > 0)
    thread scripts\mp\spawncamera::startspawncamera();

  if(istrue(level.usespawnselection) && !isDefined(self.setspawnpoint))
    scripts\mp\spawnselection::waitforspawnselection(var_3, !istrue(var_9));
  else if(var_3 > 0) {
    var_13 = 9;

    if(scripts\mp\utility\game::getgametype() == "_encstr_8E07030349") {
      if(isDefined(level.zone)) {
        if(level.zone.ownerteam == self.team) {
          scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_8CEB0809A801F07D4F82");
          var_13 = 30;

          if(isDefined(self.suicidespawndelay)) {
            var_3 = var_3 - getdvarfloat("_encstr_8A4619F8F698771A477FBB38F47F2F5CFFE652E7DB83916DB31EF2");
            var_3 = max(0, var_3);
          }
        } else if(isDefined(self.suicidespawndelay) && getdvarfloat("_encstr_8A4619F8F698771A477FBB38F47F2F5CFFE652E7DB83916DB31EF2") > 0 && level.zone.ownerteam == "_encstr_A7A408B9CA5D1D4E2C63") {
          var_13 = 31;
          self.suicidespawndelay = undefined;
        }
      }
    } else if(isDefined(self.suicidespawndelay) && getdvarfloat("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_91B613AFE65D4BD85A2356CD382CEEE68CCA1B0B2F") > 0) {
      var_13 = 31;
      self.suicidespawndelay = undefined;
    }

    scripts\mp\utility\lower_message::setlowermessageomnvar(var_13, int(gettime() + var_3 * 1000));

    if(!var_1)
      thread respawn_asspectator(self.origin + var_8, self.angles);

    var_1 = 1;
    scripts\engine\utility::_id_143BF(var_3, "_encstr_A3D50C33DE93B159EBCD1CB0DDB9");

    if(!istrue(self.waitingtoselectclass))
      self notify("_encstr_BACC1CFF6CCD90A0D712D07B192F67F8E7EF4771E1B328E8BB4B8B632203");
  }

  if(needsbuttontorespawn()) {
    if(!istrue(self.waitingtoselectclass))
      scripts\mp\utility\lower_message::setlowermessageomnvar(1);

    if(!var_1)
      thread respawn_asspectator(self.origin + var_8, self.angles);

    var_1 = 1;
    waitrespawnbutton();
  }

  if(!istrue(level.loadoutdefaultfiresalediscount) || scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B")
    thread scripts\mp\spawncamera::endspawncamera();

  waitclassselected();

  if(isbot(self)) {
    if(!scripts\mp\bots\bots::bot_is_ready_to_spawn())
      self waittill("_encstr_BDEA1396B8F9E16AB128BBD7C1CB3FA98F4FDE4B90");
  }

  self.waitingtospawn = 0;
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  self.wavespawnindex = undefined;
  thread spawnplayer(undefined, var_0);
}

_id_1437C() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(scripts\mp\utility\player::isusingremote()) {
    self.spawningafterremotedeath = 1;
    self.deathposition = self.origin;
    self waittill("_encstr_A5D2156EE8DEE0C15646F5EACD96E6D9FA9359B5DED1CA");

    if(istrue(level.nukegameover))
      return;
  }
}

shouldwaitforsquadspawn() {
  return 0;
}

queueclientforsquadspawn() {
  while(!level.squaddata[self.team][self.squadindex].isfull && !level.squaddata[self.team][self.squadindex].isstale)
    waitframe();
}

waitclassselected() {
  while(istrue(self.waitingtoselectclass))
    waitframe();
}

needsbuttontorespawn() {
  if(scripts\mp\tweakables::gettweakablevalue("_encstr_8BB007E03658CBCAE4", "_encstr_B86B0D2570C53FAA82811F4872C4E2") != 0)
    return 0;

  if(!self.hasspawned)
    return 0;

  var_0 = getdvarint("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_829F126E5BE9383DB30F474937CBF0F085F5D122") > 0;

  if(var_0)
    return 0;

  if(self.wantsafespawn)
    return 0;

  return 1;
}

waitrespawnbutton() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8CBF0C557DA25F93BD1F48C867DE");

  for(;;) {
    if(self useButtonPressed()) {
      break;
    }

    wait 0.05;
  }
}

removespawnmessageshortly(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  waittillframeend;
  self endon("_encstr_8CBF0C557DA25F93BD1F48C867DE");
  wait(var_0);
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
}

tivalidationcheck() {
  if(!isDefined(self.setspawnpoint))
    return 0;

  if(isDefined(level.get_br_jugg_setting) && ![[level.get_br_jugg_setting]](self))
    return 0;

  var_0 = getEntArray("_encstr_BAE50DE60E739BA638C72068AF47B9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    if(distancesquared(var_2.origin, self.setspawnpoint.playerspawnpos) > 4096) {
      continue;
    }
    if(isDefined(var_2.owner))
      scripts\mp\hud_message::showsplash("_encstr_83C4148C2B9BA34EEDCBB2C8F52D73CDCA4E1DB4B7CD", undefined, var_2.owner);

    scripts\mp\equipment\tac_insert::_id_13681();
    return 0;
  }

  var_4 = (30, 30, 80);
  var_5 = self.setspawnpoint.playerspawnpos - var_4;
  var_6 = self.setspawnpoint.playerspawnpos + var_4;
  var_7 = physics_createcontents(["_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA"]);
  var_8 = [];
  var_9 = physics_aabbbroadphasequery(var_5, var_6, var_7, var_8);

  if(isDefined(var_9) && var_9.size > 0) {
    var_10 = 1;

    foreach(var_12 in var_9) {
      var_13 = var_12.code_classname == "_encstr_96010BDCD8392D073A164C1B2B" || var_12.code_classname == "_encstr_BD4E0B7B104D6AD4DB384717A0";

      if(!var_13) {
        var_10 = 0;
        break;
      }
    }

    if(!var_10)
      return 0;
  }

  var_15 = self.setspawnpoint.playerspawnpos + (0, 0, 60);
  var_16 = self.setspawnpoint.playerspawnpos + (0, 0, 1);
  var_17 = [];
  var_17[0] = self;
  var_17[1] = self.setspawnpoint;
  var_18 = physics_createcontents(["_encstr_925717EBF99B13491B7BD6DD30508D3AF527CF6349CFFB3DD0", "_encstr_8E411B07D05E9B5AB1E6C6B7DCD1ACB947CD7D831B162F599CB136A51C", "_encstr_B2741680E3403FEBF1A319E7C24393FD73AB51792F157763", "_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B"]);

  if(!scripts\engine\trace::ray_trace_passed(var_15, var_16, var_17, var_18))
    return 0;

  var_19 = self.setspawnpoint.playerspawnpos + (0, 0, 1);
  var_20 = playerphysicstrace(var_19, self.setspawnpoint.playerspawnpos + (0, 0, -16));

  if(var_19[2] == var_20[2])
    return 0;

  return 1;
}

revivespawnvalidationcheck() {
  if(!isDefined(self.forcespawnorigin))
    return 0;

  var_0 = spawnStruct();
  var_0._id_1368A = self.forcespawnorigin;
  var_0.vandalize_spotlight_speed = 1;
  var_1 = [];
  var_1[0] = self;
  var_2 = scripts\engine\trace::create_contents(1, 1, 1, 0, 0, 1, 1);

  if(!scripts\engine\trace::ray_trace_passed(self.forcespawnorigin + (0, 0, 60), self.forcespawnorigin, var_1, var_2)) {
    var_0.vandalize_spotlight_speed = 0;
    return var_0;
  }

  var_3 = anglesToForward(self.angles);
  var_4 = vectorNormalize(var_3) * 5;

  if(!scripts\engine\trace::ray_trace_passed(self.forcespawnorigin + var_4, self.forcespawnorigin + var_4 - (0, 0, 16), var_1, var_2)) {
    var_0.vandalize_spotlight_speed = 0;
    return var_0;
  }

  var_5 = self.forcespawnorigin + (0, 0, 1);
  var_6 = playerphysicstrace(var_5, self.forcespawnorigin + (0, 0, -16));

  if(var_5[2] == var_6[2]) {
    var_0.vandalize_spotlight_speed = 0;
    return var_0;
  } else {
    var_0._id_1368A = var_6;
    var_0.vandalize_spotlight_speed = 0;
  }

  self.faux_spawn_stance = "_encstr_B13D076BED70539F23";
  var_0.vandalize_spotlight_speed = 1;
  return var_0;
}

spawningclientthisframereset() {
  self notify("_encstr_86281D632A17CF7BAA78701D4C48AAC8ED0354B7C6459261D2F2AA709EA201");
  self endon("_encstr_86281D632A17CF7BAA78701D4C48AAC8ED0354B7C6459261D2F2AA709EA201");
  waitframe();
  level.numplayerswaitingtospawn--;
}

getplayerassets(var_0) {
  var_1 = spawnStruct();

  if(isDefined(var_0.loadoutprimaryfullname) && var_0.loadoutprimaryfullname != "_encstr_8BBA05185F8B99")
    var_1.primaryweapon = var_0.loadoutprimaryfullname;

  if(isDefined(var_0.loadoutsecondaryfullname) && var_0.loadoutsecondaryfullname != "_encstr_8BBA05185F8B99")
    var_1.secondaryweapon = var_0.loadoutsecondaryfullname;

  var_2 = scripts\mp\teams::getcustomization();

  if(isDefined(var_2["_encstr_AD9B0589ED9197"]))
    var_1.body = var_2["_encstr_AD9B0589ED9197"];

  if(isDefined(var_2["_encstr_81CC0586952C91"]))
    var_1.head = var_2["_encstr_81CC0586952C91"];

  return var_1;
}

loadplayerassets(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in var_0) {
    if(isDefined(var_5.primaryweapon))
      var_3[var_3.size] = var_5.primaryweapon;

    if(isDefined(var_5.secondaryweapon))
      var_3[var_3.size] = var_5.secondaryweapon;

    if(!istrue(var_2))
      self loadcustomization(var_5.body, var_5.head, var_1);
  }

  if(var_3.size > 0)
    self loadweaponsforplayer(var_3, var_1);
}

allplayershaveassetsloaded(var_0) {
  var_1 = [];

  if(isDefined(var_0.primaryweapon))
    var_1[var_1.size] = var_0.primaryweapon;

  if(isDefined(var_0.secondaryweapon))
    var_1[var_1.size] = var_0.secondaryweapon;

  if(!self hasloadedviewweapons(var_1))
    return 0;

  if(!self hasloadedcustomizationviewmodels(var_0.body))
    return 0;

  return 1;
}

getspawnpoint() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  self.ti_spawn = 0;

  if(getdvarint("_encstr_BD6714A643EBCEC3F262B9D0BACFB3E0EFDBAF17CF73", 0) != 0) {
    var_3 = getspawnarray("_encstr_A1C01A915857A3F96DC9D8C84283B59E07FCA91BA51F0E1F1332A8F0");
    var_0 = var_3[0];
    var_1 = var_0.origin;
    var_2 = var_0.angles;
  } else if(isDefined(self.forcespawnorigin)) {
    var_4 = revivespawnvalidationcheck();

    if(!var_4.vandalize_spotlight_speed && isDefined(self.prevrevivepos) && !isDefined(self.rallypoint))
      var_1 = self.prevrevivepos;
    else {
      var_1 = self.forcespawnorigin;
      self.forcespawnorigin = undefined;
    }

    if(isDefined(self.forcespawnangles)) {
      var_2 = self.forcespawnangles;
      self.forcespawnangles = undefined;
    } else
      var_2 = (0, randomfloatrange(0, 360), 0);

    if(isDefined(self.reviver)) {
      if(positionwouldtelefrag(var_1) || !var_4.vandalize_spotlight_speed) {
        var_0 = scripts\mp\spawnscoring::findteammatebuddyspawn(self.reviver);
        self.reviver = undefined;

        if(isDefined(var_0)) {
          var_1 = var_0.origin;
          var_2 = var_0.angles;
        }
      } else
        var_1 = var_4._id_1368A;
    }
  } else if(isDefined(self.setspawnpoint)) {
    var_0 = self.setspawnpoint;

    if(!istrue(self.setspawnpoint.notti)) {
      if(istrue(level.unset_relic_laststandmelee) && level.mapname != "_encstr_93FB0A6B1C7D2CB92D5EB00D") {
        self._id_11D9E = undefined;
        var_5 = scripts\engine\utility::ter_op(istrue(level.brmini_playerwelcomesplashes), 1, istrue(self.setspawnpoint.issuper));

        if(var_5) {
          var_6 = min(level.steam_fx_on - self.setspawnpoint.playerspawnpos[2], level.steam_fx_on);

          if(var_6 < level.steam_fx_on - 950)
            var_6 = var_6 + 950;

          self.setspawnpoint.playerspawnpos = self.setspawnpoint.playerspawnpos + (0, 0, var_6);
          self.updatearenaomnvardata = 1;
        }
      }

      self.ti_spawn = 1;
      self playlocalsound("_encstr_83B70F9BD01FCB77A177ACE716AB1F535D");

      if(level.teambased) {
        foreach(var_8 in level.teamnamelist) {
          if(var_8 != self.team)
            self playsoundtoteam("_encstr_83B70F9BD01FCB77A177ACE716AB1F535D", var_8);
        }
      } else
        self playSound("_encstr_83B70F9BD01FCB77A177ACE716AB1F535D");
    }

    foreach(var_11 in level.ugvs) {
      if(distancesquared(var_11.origin, var_0.playerspawnpos) < 1024)
        var_11 notify("_encstr_B2BE0788BAF573592F", 5000, var_11.owner, (0, 0, 0), (0, 0, 0), "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_B40101", "_encstr_B40101", "_encstr_B40101", undefined, getcompleteweaponname("_encstr_8EA815EF512D5096FB03B139BA7FC2E085BD0B55FFD5F8"));
    }

    var_1 = self.setspawnpoint.playerspawnpos;
    var_2 = self.setspawnpoint.playerspawnangles;
    scripts\mp\equipment\tac_insert::_id_13681(0, 1);
    var_0 = undefined;
  } else if(istrue(level.usespawnselection) && istrue(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))) {
    var_0 = scripts\mp\spawnselection::getspawnpoint();
    var_1 = var_0.origin;
    var_2 = var_0.angles;
  } else {
    var_0 = self[[level.getspawnpoint]]();
    var_1 = var_0.origin;
    var_2 = var_0.angles;
  }

  var_13 = spawnStruct();
  var_13.spawnpoint = var_0;
  var_13.spawnorigin = var_1;

  if(!isDefined(var_2))
    var_2 = (0, 0, 0);

  var_13.spawnangles = (0, var_2[1], 0);
  return var_13;
}

spawnplayer(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  self notify("_encstr_BA350853C128FB939DB9");
  self notify("_encstr_8CBF0C557DA25F93BD1F48C867DE");
  self notify("_encstr_8716143EFC0FC379CFDA5930B3E62718A39C4FB345FB");

  if(!isDefined(var_0))
    var_0 = 0;

  if(!isDefined(var_1))
    var_1 = 0;

  if(scripts\mp\utility\game::teamhasinfil(self.team) && !scripts\mp\flags::gameflag("_encstr_8C0D0E8410E8B112602F133F559DCAF4") && !isDefined(level.bypassclasschoicefunc)) {
    if(getdvarint("_encstr_AF121CB812BA97E18F4A8EF50FD749B7A9BB088049162378BB530DFF0B2F", 0) == 1 && scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_BE180419DAE9" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_8AE1099A0B999F2D28AF15" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_9B1F05BE4B9B52" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_9936086E0BB9324CDBC3" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_816E079685517D0975" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_866209ECEDB1197DEE0B4E") {
      var_2 = scripts\mp\utility\game::teamhasinfil(self.team);
      var_3 = scripts\mp\flags::gameflag("_encstr_8C0D0E8410E8B112602F133F559DCAF4");
      var_4 = isDefined(level.bypassclasschoicefunc);
      scripts\mp\utility\script::laststand_dogtags("_encstr_ABAB0E8A6F9B2B0E6F08F79FA8C3B036" + self.name + "_encstr_8D232216BBA367C5A0C159579DD081D7DDB0DB9E0AAF1AEDFAC14933CB73170FF1E1D726" + var_2 + "_encstr_BE9F12E7AC123DC0849F40704FB23B63DA86E17F" + var_3 + "_encstr_A62E19CEEBB94A130B71C3FF18E3DB226F0B1687CCEBF24B39BAEA" + var_4);
    }

    self setclientomnvar("_encstr_83FB10572DFADB0ED196B7736EF5D6CACD5D", 2);
  } else if(!isDefined(game["_encstr_A1AD062E09D98338"]) || game["_encstr_A1AD062E09D98338"] != "_encstr_877508C1D8C22F2DDC3B")
    self setclientomnvar("_encstr_83FB10572DFADB0ED196B7736EF5D6CACD5D", 0);

  scripts\mp\utility\game::checkrealismhudsettings();
  self setclientomnvar("_encstr_BA2A0D5D4BD743AE32EB6E340BB559", 0);
  self.lastkillsplash = undefined;
  self._id_1363E = undefined;
  self.scorestreakvariantattackerinfo = undefined;
  self.cratemantle = undefined;

  if(getdvarint("_encstr_9A2112B98D39F53B2CB695EB667B938DCABA859D") > 1)
    level thread scripts\cp_mp\killstreaks\uav::setforceradars(self);

  level.numplayerswaitingtospawn++;

  if(level.numplayerswaitingtospawn > 1) {
    self.waitingtospawnamortize = 1;
    wait(level.framedurationseconds * (level.numplayerswaitingtospawn - 1));
  }

  thread spawningclientthisframereset();
  self.waitingtospawnamortize = 0;

  if(!isDefined(self.pers["_encstr_8D460CEF80FBE4FA6946A00323C3"]))
    var_6 = scripts\mp\class::preloadandqueueclass(self.class, 1);
  else {
    var_7 = scripts\mp\class::loadout_getorbuildclassstruct(self.class);
    scripts\mp\class::zombiesdamagezombies(self.pers["_encstr_8D460CEF80FBE4FA6946A00323C3"], var_7);

    if(isDefined(self.pers["_encstr_B1BD0B15A70BFB576312500202"])) {
      _id_119CB(self.pers["_encstr_B1BD0B15A70BFB576312500202"]);
      self.pers["_encstr_B1BD0B15A70BFB576312500202"] = undefined;
    }

    scripts\mp\class::preloadandqueueclassstruct(self.pers["_encstr_8D460CEF80FBE4FA6946A00323C3"], 1);
    var_6 = self.pers["_encstr_8D460CEF80FBE4FA6946A00323C3"];
    self.pers["_encstr_8D460CEF80FBE4FA6946A00323C3"] = undefined;
  }

  var_8 = gettime();
  self.spawndata = getspawnpoint();
  setspawnvariables();
  var_9 = self.hasspawned;
  self.suicidespawndelay = undefined;
  self.fauxdead = undefined;
  self vehiclepinonminimap(0);

  if(!var_0) {
    self.killsthislife = [];

    if(!istrue(self.inspawncamera))
      scripts\mp\utility\player::updatesessionstate("_encstr_877508C1D8C22F2DDC3B");

    scripts\mp\utility\player::clearkillcamstate();
    self.cancelkillcam = undefined;
    self.maxhealth = scripts\mp\tweakables::gettweakablevalue("_encstr_8BB007E03658CBCAE4", "_encstr_B19F0A5BC2F01A2BC2B1D11A");

    if(istrue(var_1)) {
      var_10 = scripts\mp\utility\dvars::getwatcheddvar("_encstr_9B251672990E6B6A600BBEBC45C06BA734B1A86A6169A39C");

      if(!isDefined(var_10))
        self.health = getdvarint("_encstr_AB602116D37B5E59A5D2CBF8FB3129D1C76C8E0D29E3E125CFCB8868A21CE369D3F4AB", 50);
      else
        self.health = var_10;

      thread notifyreviveregen();
    } else
      self.health = self.maxhealth;

    if(istrue(self.playersetarenaomnvarwithloadout)) {
      self.playersetarenaomnvarwithloadout = undefined;
      thread _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::ffmessageonspawn();
    }

    self.friendlydamage = undefined;
    self.spawntime = gettime();
    self.wasti = self.ti_spawn;
    self.damagedplayers = [];
    self.objectivescaler = 1;
    self.shieldbullethits = 0;
    self.recentshieldxp = 0;
    self.respawntimerstarttime = undefined;
    self.tiers = undefined;
    self.lastgastouchtime = undefined;
    self.lastsnapshotgrenadetime = undefined;
    self.lastinsmoketime = undefined;
    self.lastburntime = undefined;
    self.lastdamagetime = undefined;
    self.lasttimedamaged = undefined;

    if(isDefined(self.should_hide_buried_mother_corpse))
      self.should_hide_buried_mother_corpse = 0;

    if(isDefined(self.stuckbygrenade) && self.stuckbygrenade.stuckenemyentity == self)
      self.stuckbygrenade.stuckenemyentity = undefined;

    self.stuckbygrenade = undefined;
    self._id_13935 = undefined;
    self.lifeid = 0;

    if(isDefined(self.pers["_encstr_8E0607055DBFB3919A"]))
      self.lifeid = self.pers["_encstr_8E0607055DBFB3919A"];

    scripts\cp_mp\utility\damage_utility::cleardamagemodifiers();
    scripts\mp\killcam::clearkillcamomnvars();
  }

  self.movespeedscaler = 1;

  if(!var_0) {
    self.avoidkillstreakonspawntimer = 5.0;
    var_11 = self.pers["_encstr_8CAA06DB20A31543"];

    if(var_11 == scripts\mp\utility\game::getgametypenumlives())
      addtolivescount();

    if(var_11)
      self.pers["_encstr_8CAA06DB20A31543"]--;

    if(!istrue(self.gulag) && !istrue(self.respawningfromtoken) && !istrue(self._id_12CA8) || istrue(self._encstr_9316179BB30739809BE3A9BB06477875AB7A31819A4FEB68B2)) {
      addtoalivecount("_encstr_95790C33D33F63FAB95DE73A9773");
      self._encstr_9316179BB30739809BE3A9BB06477875AB7A31819A4FEB68B2 = undefined;
    }

    if(!var_9 || scripts\mp\utility\game::gamehasstarted() || scripts\mp\utility\game::gamehasstarted() && level.ingraceperiod && self.hasdonecombat)
      removefromlivescount();

    if(!self.wasaliveatmatchstart) {
      var_12 = 20;

      if(scripts\mp\utility\game::gettimelimit() > 0 && var_12 < scripts\mp\utility\game::gettimelimit() / 4)
        var_12 = scripts\mp\utility\game::gettimelimit() / 4;

      if(level.ingraceperiod || scripts\mp\utility\game::gettimepassed() < var_12 * 1000)
        self.wasaliveatmatchstart = 1;
    }
  }

  thread scripts\cp\vehicles\vehicle_compass_cp::onspawn();
  var_13 = getDvar("_encstr_86F410DCC627F5DB6759E4E42D8CCA8CA7CA", "_encstr_B40703B3C3");

  if(self isconsoleplayer())
    self setclientdvar("_encstr_B14A0A4545A9412AC9133D26", var_13);

  if(isDefined(self.spawndata.spawnpoint)) {
    if(!istrue(self._id_132FF))
      scripts\mp\spawnlogic::finalizespawnpointchoice(self.spawndata.spawnpoint);

    self.lastspawntime = gettime();
  } else if(!isDefined(self.faux_spawn_infected))
    self.lastspawntime = gettime();

  self.spawnpos = self.spawndata.spawnorigin;

  if(var_0 && scripts\mp\gameobjects::touchingarbitraryuptrigger()) {
    if(self isonground()) {
      self normalizeworldupreferenceangles();
      self.spawndata.spawnorigin = self.spawndata.spawnorigin - (0, 0, 80);
    }

    var_14 = self getworldupreferenceangles();
  }

  scripts\mp\spectating::setspectatepermissions();
  self spawn(self.spawndata.spawnorigin, self.spawndata.spawnangles);
  self setplayerangles((0, self.spawndata.spawnangles[1], 0));
  scripts\mp\utility\player::_id_12898("_encstr_B6C52E527993C33D1363D7EF30E9AA3F4F8F9E0BD059CA411A60ABDADAA9E9F643BEED4FDDE1F1B825896306A2F12028" + self.spawndata.spawnorigin);

  if(!isDefined(level.was_seq3_gassed))
    level.was_seq3_gassed = [];

  level.was_seq3_gassed[self.team] = self.spawndata.spawnorigin;
  self.death_timer_length = 1023;

  if((var_0 || var_1) && isDefined(self.faux_spawn_stance)) {
    self setstance(self.faux_spawn_stance);
    self.faux_spawn_stance = undefined;
  }

  if(isai(self))
    scripts\mp\utility\player::_freezecontrols(1, undefined, "_encstr_8E8A06F7D987435E");

  self motionblurhqenable();

  if(!var_0 && !(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB"))
    self painvisionon();

  scripts\mp\utility\game::get_allowed_vehicle_types_from_spawnpoint(self);
  [[level.onspawnplayer]]();
  self clearpredictedstreampos();
  var_15 = !var_0 || istrue(self.faux_spawn_infected);

  if(var_15) {
    if(isai(self) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23"]))
      self[[level.bot_funcs["_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23"]]]();

    if(isDefined(level.matchrecording_logevent))
      [[level.matchrecording_logevent]](self.clientid, self.team, "_encstr_8E8A06779997417E", self.spawnpos[0], self.spawnpos[1], self.spawntime);

    if(!isai(self)) {
      if(!isDefined(self.pers["_encstr_8D0C13FAB3EED8345297D2E0FF98D789E9BE07BFF8"]))
        thread totaldisttracking(self.spawndata.spawnorigin, 1);
      else {
        var_16 = _id_1331C();

        if(var_16) {
          var_17 = scripts\mp\persistence::statgetchildbuffered("_encstr_8C4606C9DBD5CD46", "_encstr_881A0B47B4B6B2286316E59532", 0);

          if(var_17 - self.pers["_encstr_A7350D98707F9B79A37F4B04F34D27"] > 240) {
            self.pers["_encstr_A7350D98707F9B79A37F4B04F34D27"] = var_17;
            self.pers["_encstr_8D0C13FAB3EED8345297D2E0FF98D789E9BE07BFF8"] = undefined;
            self.pers["_encstr_91FF1555B52BABE824FFC8E8134A01CD421D45D586A027"] = undefined;
            thread totaldisttracking(self.spawndata.spawnorigin, 1);
          }
        } else
          thread totaldisttracking(self.spawndata.spawnorigin, 0);
      }
    }
  }

  if(!var_0) {
    self.matchdatalifeindex = scripts\common\utility::_id_13E0A(level._id_11B2E);
    self.lastmatchdatakillstreakindex = -1;

    if(getdvarint("_encstr_A5B60A1F499D8F973153F986") != 0)
      setmatchdata("_encstr_87720AB1D2CCAC68DEABB91D", game["_encstr_A97F0BA8D3305737C2502325DC"]);
  }

  if(isDefined(self.selectedspawnarea))
    scripts\mp\analyticslog::_id_119BA(self, self.selectedspawnarea);

  if(!istrue(self._id_132FF))
    self.selectedspawnarea = undefined;

  scripts\mp\equipment::clearallequipment();
  scripts\mp\class::setclass(self.class);

  if(isDefined(level.custom_giveloadout))
    self[[level.custom_giveloadout]](var_0);
  else
    scripts\mp\class::giveloadout(self.team, self.class, undefined, undefined, var_1);

  if(getomnvar("_encstr_A1431305E44959FBD51FA8381FE0969132CAF3803F"))
    thread showgamemodeobjectivetext();

  if(!istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"])) {
    thread logstartingloadout();

    if(level.codcasterenabled && !self ismlgspectator())
      thread _id_13FFB(self);
  }

  if(isDefined(game["_encstr_8DC30DAA0285FD69FAE113371B1934"]) && game["_encstr_8DC30DAA0285FD69FAE113371B1934"] > 0) {
    if(!isDefined(self.classrefreshed) || !self.classrefreshed) {
      if(isDefined(self.class_num))
        self.classrefreshed = 1;
    }
  }

  if(getdvarint("_encstr_82570B397A4D3192935192A562"))
    scripts\mp\utility\player::setthirdpersondof(1);

  if(isai(self))
    scripts\mp\utility\player::_freezecontrols(0, undefined, "_encstr_8E8A06F7D987435E");

  if(istrue(game["_encstr_95810CA5B9982DEC9526DEC426F2"]) || scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && !scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {} else if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    allowprematchlook(self);
  else {
    var_18 = !self.hasspawned;
    scripts\mp\utility\player::_freezecontrols(0, var_18, "_encstr_8E8A06F7D987435E");
    scripts\mp\utility\player::_freezelookcontrols(0, var_18);
  }

  if(!istrue(self.hasspawned))
    scripts\mp\gamelogic::updatematchhasmorethan1playeromnvaronplayersfirstspawn();

  self.hasspawned = 1;
  self.pers["_encstr_A1310B432F9BDEFBEF4393B0F1"] = 1;
  waittillframeend;
  self.spawningafterremotedeath = undefined;
  self.delayedspawnedplayernotify = undefined;

  if(!istrue(level.loadoutdefaultfiresalediscount) && isDefined(self.spawncameraent) || istrue(level.loadoutdefaultfiresalediscount) && isDefined(self.spawncameraent) && scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B") {
    self.wasrevivespawn = var_1;
    self.delayedspawnedplayernotify = 1;
    self notify("_encstr_8291127AABA8D77A26533F179DDF912BE811B203");
  }

  if(!istrue(self.delayedspawnedplayernotify)) {
    self notify("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
    level notify("_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23", self, var_1);
    thread setspawnnotifyomnvar();
  }

  if(game["_encstr_A1AD062E09D98338"] == "_encstr_ACE709DA22939BA8075060")
    scripts\mp\gamelogic::freezeplayerforroundend();

  if(scripts\mp\analyticslog::analyticsspawnlogenabled() && !var_0) {
    if(scripts\mp\analyticslog::analyticsdoesspawndataexist())
      level.spawncount = level.spawncount + 1;
    else
      scripts\mp\analyticslog::analyticsinitspawndata();

    if(scripts\mp\analyticslog::analyticssend_shouldsenddata(level.spawncount)) {
      if(isDefined(level.spawnglobals.spawnpointslist)) {
        scripts\mp\analyticslog::analyticssend_spawnfactors(self, self.spawnpointslist, level.spawncount, self.spawndata.spawnpoint);
        scripts\mp\analyticslog::analyticssend_spawntype(self.spawndata.spawnpoint.origin, self.team, self.lifeid, level.spawncount);
        scripts\mp\analyticslog::analyticssend_spawnplayerdetails(self, self.spawndata.spawnpoint.origin, level.spawncount);
      }
    }

    self.lastspawnpoint = self.spawndata.spawnpoint;
  }

  if(!istrue(self.delayedspawnedplayernotify))
    self.spawndata = undefined;

  if(!isDefined(self.revive_chosenclass))
    thread scripts\mp\class::updateinstantclassswapallowed();

  var_19 = 0;

  if((var_19 || scripts\mp\utility\game::gametypesupportsbasejumping() && scripts\mp\utility\game::mapsupportsbasejumping()) && !istrue(level.client_activate)) {
    self skydive_setbasejumpingstatus(1);
    self skydive_setdeploymentstatus(1);
  }
}

_id_119CB(var_0) {
  if(isDefined(var_0))
    self dlog_recordplayerevent("_encstr_878E187B315092BFF01B975D3349C46A3F49CFB7B9901A7780C2", ["_encstr_87C61A03037692A90819327193F0E9EBDD852FCFE9AB5A964026EC87", self.clientid, "_encstr_8C83123BD8999D6AEDB592C1ACEBE22503F8EFE7", self.name, "_encstr_BA4817E75330DF43209B5AB282050B19C031916DC588E9F755", var_0.clientid, "_encstr_86890F9D4B9DB293EB9D2C6BB29C3A163B", var_0.name]);
}

logstartingloadout() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    return;
  }
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  if(isDefined(self.curclass) && self.curclass != "_encstr_8BFC0BC2CBD4F737E0A5E1FD79")
    scripts\mp\class::loadout_lognewlygivenloadout(self.select_bridge_two_spawners, self.classstruct, self.curclass);
}

notifyreviveregen() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  waitframe();
  self notify("_encstr_8BCA133EF0500E3B31E6FD2F326DA09D1F73F14FD5");
}

setspawnnotifyomnvar() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  waitframe();
  self setclientomnvar("_encstr_8108196B214730C1B95089B288C3F3A9AF6DE751CFE66873BF5370", gettime());
}

playerprematchallow(var_0) {
  self allowmovement(var_0);
  scripts\common\utility::allow_fire(var_0, "_encstr_B2D5095B13EDD73EC8B710");
  scripts\mp\equipment::allow_equipment(var_0, "_encstr_B2D5095B13EDD73EC8B710");
  scripts\common\utility::allow_supers(var_0, "_encstr_B2D5095B13EDD73EC8B710");
  scripts\common\utility::allow_jump(var_0, "_encstr_B2D5095B13EDD73EC8B710");
  scripts\common\utility::allow_melee(var_0, "_encstr_B2D5095B13EDD73EC8B710");
  scripts\common\utility::allow_sprint(var_0, "_encstr_B2D5095B13EDD73EC8B710");
  scripts\common\utility::allow_killstreaks(var_0, "_encstr_B2D5095B13EDD73EC8B710");

  if(!istrue(level.loadout_updateammo)) {
    scripts\common\utility::allow_mount_top(var_0, "_encstr_B2D5095B13EDD73EC8B710");
    scripts\common\utility::allow_mount_side(var_0, "_encstr_B2D5095B13EDD73EC8B710");
  }
}

allowprematchlook(var_0) {
  var_0[[level.prematchallowfunc]](0);
  var_0.prematchlook = 1;
}

clearprematchlook(var_0) {
  if(istrue(var_0.prematchlook) && !level.gameended) {
    var_0[[level.prematchallowfunc]](1);
    var_0.prematchlook = undefined;
  }
}

waitforversusmenudone() {
  level endon("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  self endon("_encstr_A11C11EC2B399B57DCF5ADACCD57BE8CB7E695");

  for(;;) {
    self waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_0, var_1);

    if(var_0 == "_encstr_A1390CC35A137BE30891D9701EB7")
      self notify("_encstr_A11C11EC2B399B57DCF5ADACCD57BE8CB7E695");
  }
}

_id_13FFB(var_0) {
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  for(;;) {
    var_0 getbeingrevived();
    var_0 getmid2damage();
    wait 0.05;
  }
}

spawnspectatormapcam(var_0) {
  var_1 = 6;
  var_2 = 4;
  var_3 = 4;
  var_4 = 0;
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isai(self)) {
    return;
  }
  if(level.splitscreen || self issplitscreenplayer())
    self setclientdvars("_encstr_A11E0A5D8FF1E1519E04D72C", "_encstr_91F90518B8D8A9");
  else
    self setclientdvars("_encstr_A11E0A5D8FF1E1519E04D72C", "_encstr_A34C02BB");

  self setclientomnvar("_encstr_9341123B20D73DE753EE382705DEA746CB28D3F2", 1);
  self lerpfovbypreset("_encstr_91D50B90AF42CAC3110FC4F7DB");
  var_5 = scripts\engine\utility::getStructArray("_encstr_A1430D0EE66A73FBD1D7E8E843FA90", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  switch (level.mapname) {
    case "_encstr_A9940CCB60D9B8B3B33AD901B212":
      var_5[0].origin = (1606.95, 2238.61, 958.77);
      var_5[0].angles = (17, 215, -4.14);
      break;
    case "_encstr_8E2D0CDA88B79E8791429C87E593":
      var_5[0].origin = (310, -627, 279);
      var_5[0].angles = (4, 196, 0);
      break;
    case "_encstr_ACF70BABB3814330E4DF603B83":
      var_5[0].origin = (1867, -2487, 664);
      var_5[0].angles = (15, 118, 0);
      break;
    case "_encstr_82670A6D9FF7A9AAD022B0CA":
      var_5[0].origin = (-856, 2771, 1030);
      var_5[0].angles = (18, 313, 0);
      break;
    case "_encstr_A6990AD8730FD991BC09859F":
      var_5[0].origin = (691, -536, 223);
      var_5[0].angles = (9, 159, 0);
      var_5[1] = spawnStruct();
      var_5[1].origin = (428, 508, 14);
      var_5[1].angles = (0, 182, 0);
      var_4 = 1;
      break;
    case "_encstr_AAD50ADAE0D7ADAF385ADC59":
      var_5[0].origin = (1260, 203, 239);
      var_5[0].angles = (15, 189, 0);
      var_5[1] = spawnStruct();
      var_5[1].origin = (-582, -154, 64);
      var_5[1].angles = (0, 137, 0);
      var_4 = 1;
      break;
    case "_encstr_8FD60D2D6829B511E32BDF83200323":
      var_5[0].origin = (2446, 19, 377);
      var_5[0].angles = (24, 178, 0);
      var_5[1] = spawnStruct();
      var_5[1].origin = (435, 11, 15);
      var_5[1].angles = (0, 0, 0);
      var_4 = 1;
      break;
    case "_encstr_8A8F0ABBA391D191182CF008":
      var_5[0].origin = (254, 1651, 353);
      var_5[0].angles = (10, 253, 0);
      var_5[1] = spawnStruct();
      var_5[1].origin = (231, -1024, 37);
      var_5[1].angles = (353, 89, 0);
      var_4 = 1;
      break;
  }

  if(var_5.size == 0 || scripts\mp\flags::gameflag("_encstr_B27F0F4BB9CC96B1AFDD2D8D1BAF39579B")) {
    self visionsetfadetoblackforplayer("_encstr_B40101", 0.75);
    return;
  }

  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  setspawnvariables();
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  scripts\mp\utility\player::updatesessionstate("_encstr_AF8C0A1B6A1D6045925B4F7D");
  self.pers["_encstr_8AEF05472BC2D6"] = "_encstr_AF8C0A1B6A1D6045925B4F7D";
  self.team = "_encstr_AF8C0A1B6A1D6045925B4F7D";
  scripts\mp\utility\player::clearkillcamstate();
  self.friendlydamage = undefined;
  resetuidvarsonspectate();

  foreach(var_10 in level.teamnamelist)
  self allowspectateteam(var_10, 0);

  self allowspectateteam("_encstr_818709A35AE71A38D792CF", 0);
  self allowspectateteam("_encstr_8BBA05185F8B99", 0);

  if(isDefined(var_5) && var_5.size > 1 && !istrue(var_4)) {
    var_12 = randomintrange(0, var_5.size - 1);
    var_6 = var_5[var_12];
  } else if(isDefined(var_5)) {
    var_6 = var_5[0];

    if(istrue(var_4))
      var_8 = var_5[1];
  } else {}

  var_6.fil = 1;
  scripts\mp\utility\player::_freezecontrols(1, undefined, "_encstr_ABE310C7E3729688512BD00B1D39E0CE6A3F");
  self setspectatedefaults(var_6.origin, var_6.angles);
  self spawn(var_6.origin, var_6.angles);
  scripts\mp\utility\player::_id_12898("_encstr_8C0E37C250D0A182F6117F2763163FAA187B3E8B88A9505A46094F634746B029A865B695A8C248568FBBDF9709F52E53518DA3D531EA917E67" + var_6.origin);
  var_13 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_6.origin);
  var_13 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_13.angles = var_6.angles;
  var_14 = undefined;

  if(istrue(var_4)) {
    var_14 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_8.origin);
    var_14 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_14.angles = var_8.angles;
  }

  thread waitforversusmenudone();

  if(isDefined(var_0) && var_0 == 99)
    var_15 = "_encstr_8E75065022EE9391";
  else if(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    var_15 = "_encstr_8FF80EBBE8D1ED92613E8C49105DEABA";
  else if(self.versusdone)
    var_15 = "_encstr_A11C11EC2B399B57DCF5ADACCD57BE8CB7E695";
  else
    var_15 = scripts\engine\utility::_id_143BA(2, "_encstr_A11C11EC2B399B57DCF5ADACCD57BE8CB7E695", "_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");

  if(var_15 == "_encstr_995408F398012F656821") {
    if(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
      var_15 = "_encstr_8FF80EBBE8D1ED92613E8C49105DEABA";
    else
      var_15 = "_encstr_A11C11EC2B399B57DCF5ADACCD57BE8CB7E695";
  }

  if(var_15 == "_encstr_8FF80EBBE8D1ED92613E8C49105DEABA") {
    self visionsetfadetoblackforplayer("_encstr_B40101", 0.75);
    return;
  }

  if(self issplitscreenplayer() && self issplitscreenplayerprimary()) {
    var_16 = self getothersplitscreenplayer();
    var_16 notify("_encstr_A11C11EC2B399B57DCF5ADACCD57BE8CB7E695");
    waitframe();
  }

  self cameralinkTo(var_13, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1);
  var_17 = scripts\cp_mp\utility\game_utility::getmapname();
  self notify("_encstr_8884106B161C862CAD954E16F59B8EC24E1D");

  switch (var_17) {
    case "_encstr_824D0B772110BBD920C07DC3DB":
      var_13 scriptmodelplayanimdeltamotion("_encstr_B2AA1CACC767FF1FA16760E8A3FD2F99C0D2C5873373F93351CA8FB81D66");
      self visionsetfadetoblackforplayer("_encstr_B40101", 0.75);
      self playlocalsound("_encstr_832F1758C301F86EF52A660BA0B0089992DA586B58471873AA");
      wait(var_1 - 0.25);
      return;
    default:
      break;
  }

  wait 0.25;
  self visionsetfadetoblackforplayer("_encstr_B40101", 0.75);
  self playlocalsound("_encstr_832F1758C301F86EF52A660BA0B0089992DA586B58471873AA");
  var_18 = var_6;
  var_7[0] = spawnStruct();
  var_7[0] = scripts\engine\utility::getStruct(var_6.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  switch (level.mapname) {
    case "_encstr_A9940CCB60D9B8B3B33AD901B212":
      var_7[0].origin = (1925, -857, 1033);
      var_7[0].angles = (362, 127, 0);
      break;
    case "_encstr_8E2D0CDA88B79E8791429C87E593":
      var_7[0].origin = (-399, -1457, 667);
      var_7[0].angles = (15, 57, 0);
      break;
    case "_encstr_ACF70BABB3814330E4DF603B83":
      var_7[0].origin = (1422, 2073, 464);
      var_7[0].angles = (6, 236, 0);
      break;
    case "_encstr_82670A6D9FF7A9AAD022B0CA":
      var_7[0].origin = (1559, 1586, 1030);
      var_7[0].angles = (30, 234, 0);
      break;
    case "_encstr_A6990AD8730FD991BC09859F":
      var_7[0].origin = (921, 300, 223);
      var_7[0].angles = (8, 202, 0);
      var_7[1] = spawnStruct();
      var_7[1].origin = (415, 372, 14);
      var_7[1].angles = (3, 179, 0);
      break;
    case "_encstr_AAD50ADAE0D7ADAF385ADC59":
      var_7[0].origin = (714, 440, 167);
      var_7[0].angles = (13, 205, 0);
      var_7[1] = spawnStruct();
      var_7[1].origin = (-859, -349, 75);
      var_7[1].angles = (7, 104, 0);
      break;
    case "_encstr_8FD60D2D6829B511E32BDF83200323":
      var_7[0].origin = (1952, 354, 77);
      var_7[0].angles = (6, 208, 0);
      var_7[1] = spawnStruct();
      var_7[1].origin = (906, 9, 15);
      var_7[1].angles = (0, 0, 0);
      var_4 = 1;
      break;
    case "_encstr_8A8F0ABBA391D191182CF008":
      var_7[0].origin = (-1332, 483, 252);
      var_7[0].angles = (11, 313, 0);
      var_7[1] = spawnStruct();
      var_7[1].origin = (65, -547, 351);
      var_7[1].angles = (16, 83, 0);
      break;
  }

  var_19 = 0;

  for(;;) {
    if(isDefined(var_18.speedadjust)) {
      var_20 = 1 / var_18.speedadjust;
      var_21 = var_20 * distance(var_18.origin, var_7[0].origin);
    } else
      var_21 = distance(var_18.origin, var_7[0].origin);

    var_19 = var_19 + var_21;
    var_18.distancetotarg = var_21;
    var_18 = var_7[0];

    if(isDefined(var_18.target)) {
      var_7[0] = scripts\engine\utility::getStruct(var_18.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      continue;
    }

    break;
  }

  var_18.eol = 1;
  var_18 = var_6;
  var_7[0] = scripts\engine\utility::getStruct(var_6.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(;;) {
    var_22 = var_18.distancetotarg / var_19;
    var_23 = scripts\engine\utility::ter_op(istrue(var_4), var_22 * var_2, var_22 * var_1);

    if(isDefined(var_7[0].eol))
      var_24 = var_23 / 2;
    else
      var_24 = 0;

    if(isDefined(var_18.fil))
      var_25 = var_23 / 2;
    else
      var_25 = 0;

    var_13 moveTo(var_7[0].origin, var_23, var_25, var_24);
    var_13 rotateTo(var_7[0].angles, var_23, var_25, var_24);

    if(isDefined(var_7[0].eol)) {
      var_26 = int(var_23 / 2);
      wait(var_26);
      wait(var_26);
    } else
      wait(var_23);

    var_18 = var_7[0];

    if(isDefined(var_18.target)) {
      var_7[0] = scripts\engine\utility::getStruct(var_18.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      continue;
    }

    break;
  }

  if(istrue(var_4)) {
    var_19 = 0;
    var_27 = var_8;
    self spawn(var_8.origin, var_8.angles);
    self cameralinkTo(var_14, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1);
    wait 0.25;
    self visionsetfadetoblackforplayer("_encstr_B40101", 0.75);
    self playlocalsound("_encstr_832F1758C301F86EF52A660BA0B0089992DA586B58471873AA");

    for(;;) {
      if(isDefined(var_27.speedadjust)) {
        var_20 = 1 / var_27.speedadjust;
        var_21 = var_20 * distance(var_27.origin, var_7[1].origin);
      } else
        var_21 = distance(var_27.origin, var_7[1].origin);

      var_19 = var_19 + var_21;
      var_27.distancetotarg = var_21;

      if(isDefined(var_27.target)) {
        var_7[1] = scripts\engine\utility::getStruct(var_18.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
        continue;
      }

      break;
    }

    var_27.eol = 1;
    var_27.fil = 1;
    var_7[1].eol = 1;

    for(;;) {
      var_22 = var_27.distancetotarg / var_19;
      var_23 = scripts\engine\utility::ter_op(istrue(var_4), var_22 * var_3, var_22 * var_1);

      if(isDefined(var_7[1].eol))
        var_24 = var_23 / 2;
      else
        var_24 = 0;

      if(isDefined(var_27.fil))
        var_25 = var_23 / 2;
      else
        var_25 = 0;

      var_14 moveTo(var_7[1].origin, var_23, var_25, var_24);
      var_14 rotateTo(var_7[1].angles, var_23, var_25, var_24);

      if(isDefined(var_7[1].eol)) {
        var_26 = int(var_23 / 2);
        wait(var_26);
        wait(var_26);
      } else
        wait(var_23);

      var_27 = var_7[1];

      if(isDefined(var_27.target)) {
        var_7[1] = scripts\engine\utility::getStruct(var_27.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
        continue;
      }

      break;
    }
  }

  scripts\mp\utility\player::_freezecontrols(0, undefined, "_encstr_ABE310C7E3729688512BD00B1D39E0CE6A3F");
  self.startcament = var_13;
  self setclientomnvar("_encstr_9341123B20D73DE753EE382705DEA746CB28D3F2", 0);
}

spawnspectator(var_0, var_1, var_2) {
  self notify("_encstr_BA350853C128FB939DB9");
  self notify("_encstr_8CBF0C557DA25F93BD1F48C867DE");
  self notify("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  level notify("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B", self);
  self._id_1363E = 1;

  if(isDefined(self.deathspectatepos)) {
    var_0 = self.deathspectatepos;
    var_1 = vectortoangles(self.origin - self.deathspectatepos);
  }

  if(isDefined(self.startcament) && !isDefined(var_0)) {
    var_0 = self.startcament.origin;
    var_1 = self.startcament.angles;
    self.startcament delete();
  }

  in_spawnspectator(var_0, var_1, var_2);
}

respawn_asspectator(var_0, var_1) {
  if(isDefined(self.deathspectatepos)) {
    var_0 = self.deathspectatepos;

    if(isDefined(self.deathspectateangles))
      var_1 = self.deathspectateangles;
    else
      var_1 = vectortoangles(self.origin - self.deathspectatepos);
  }

  in_spawnspectator(var_0, var_1);
}

in_spawnspectator(var_0, var_1, var_2) {
  setspawnvariables();
  var_3 = self.pers["_encstr_8AEF05472BC2D6"];

  if(isDefined(var_3) && (var_3 == "_encstr_AF8C0A1B6A1D6045925B4F7D" || var_3 == "_encstr_933E090A10B17DDFB3E522") && !level.gameended)
    scripts\mp\utility\lower_message::setlowermessageomnvar(0);

  scripts\mp\class::loadout_clearperks();
  scripts\mp\utility\player::updatesessionstate("_encstr_AF8C0A1B6A1D6045925B4F7D");
  scripts\mp\utility\player::clearkillcamstate();
  self.friendlydamage = undefined;
  resetuidvarsonspectate();
  scripts\mp\spectating::setspectatepermissions();
  onspawnspectator(var_0, var_1, var_2);

  if(level.teambased && !level.splitscreen && !self issplitscreenplayer())
    scripts\mp\utility\player::setdof_spectator();
}

getplayerfromclientnum(var_0) {
  if(var_0 < 0)
    return undefined;

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    if(level.players[var_1] getentitynumber() == var_0)
      return level.players[var_1];
  }

  return undefined;
}

onspawnspectator(var_0, var_1, var_2) {
  if(isDefined(var_0) && isDefined(var_1)) {
    self setspectatedefaults(var_0, var_1);
    self spawn(var_0, var_1);
    scripts\mp\utility\player::_id_12898("_encstr_A99B335F04EF42BBEABAF8B00246DDF27FBE76D761CFE89F52326030BADB3FB3BA1147E7B93EB59F37187201C1BEB78CF6815FEF70" + var_0);
    return;
  }

  var_3 = getspectatepoint();

  if(istrue(level.usespawnselection)) {
    if(self.sessionteam == "_encstr_9A8507BA4040188D08")
      var_3 = level.spawncameras["_encstr_B4B9103B4BE98DA8C30FE76904D7D16F84B1"]["_encstr_9A8507BA4040188D08"];
    else if(self.sessionteam == "_encstr_8E8405EA382B2A")
      var_3 = level.spawncameras["_encstr_B16B0EDFCFE1246042F1013A643B11F7"]["_encstr_8E8405EA382B2A"];
  }

  var_4 = 8;

  if(isDefined(level.camerapos) && level.camerapos.size) {
    for(var_5 = 0; var_5 < level.camerahighestindex + 1 && var_5 < var_4; var_5++) {
      if(!isDefined(level.camerapos[var_5]) || !isDefined(level.cameraang[var_5])) {
        continue;
      }
      self setmlgcameradefaults(var_5, level.camerapos[var_5], level.cameraang[var_5]);
      level.cameramapobjs[var_5].origin = level.camerapos[var_5];
      level.numbermapobjs[var_5].origin = level.camerapos[var_5];
      level.cameramapobjs[var_5].angles = level.cameraang[var_5];
      level.numbermapobjs[var_5].angles = level.cameraang[var_5];
    }
  } else {
    for(var_5 = 0; var_5 < var_4; var_5++)
      self setmlgcameradefaults(var_5, var_3.origin, var_3.angles);
  }

  self setspectatedefaults(var_3.origin, var_3.angles);

  if(isDefined(var_2)) {
    self allowspectateteam("_encstr_818709A35AE71A38D792CF", 1);
    self allowspectateteam("_encstr_8BBA05185F8B99", 1);
  }

  if(scripts\mp\utility\game::unset_relic_landlocked() && !self.hasspawned)
    self predictstreampos(var_3.origin);

  self spawn(var_3.origin, var_3.angles);
  scripts\mp\utility\player::_id_12898("_encstr_A99B335F04EF42BBEABAF8B00246DDF27FBE76D761CFE89F52326030BADB3FB3BA1147E7B93EB59F37187201C1BEB78CF6815FEF70" + var_3.origin);
}

getspectatepoint() {
  var_0 = getEntArray("_encstr_B4D317B607EBB336DE4C0B63FAA5CDD12BE4DA4BDC6E2DBD37", "_encstr_AC110A7F14873B5B3D073009");
  var_1 = [];

  if(scripts\mp\utility\game::getgametype() == "_encstr_931D068662634370")
    return level.endsuperdisableweaponbr._id_136DC;

  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
    if(level.localeid == "_encstr_8A34097127C761890FA9D2") {
      var_2 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (25642, -26550, 1818));
      var_2.angles = (14, 101, 0);
      return var_2;
    } else if(level.localeid == "_encstr_A63409881A3633786F5F9E") {
      var_2 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (34440, -18522, 995));
      var_2.angles = (10, 281, 0);
      return var_2;
    }

    var_2 = undefined;

    foreach(var_4 in var_0) {
      if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == level.localeid)
        var_2 = var_4;
    }

    if(isDefined(var_2))
      return var_2;
    else {
      foreach(var_4 in var_0) {
        if(!isDefined(var_4.script_noteworthy) || !issubstr(var_4.script_noteworthy, "_encstr_82E007C2104628C1CF")) {
          var_1[var_1.size] = var_4;
          continue;
        }

        var_4 delete();
      }
    }
  } else if(var_0.size != 1) {
    foreach(var_4 in var_0) {
      if(!isDefined(var_4.script_noteworthy) || !issubstr(var_4.script_noteworthy, "_encstr_82E007C2104628C1CF")) {
        var_1[var_1.size] = var_4;
        continue;
      }

      var_4 delete();
    }
  } else
    var_1 = var_0;

  var_4 = scripts\mp\spawnlogic::getspawnpoint_random(var_1);
  return var_4;
}

spawnintermission(var_0, var_1, var_2) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_BA350853C128FB939DB9");
  self notify("_encstr_8CBF0C557DA25F93BD1F48C867DE");

  if(!isDefined(var_1))
    var_1 = "_encstr_A3BC0D2DB544180EEAE7AFB7FF9258";

  if(!isDefined(var_2))
    var_2 = 1;

  setspawnvariables();
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  scripts\mp\utility\lower_message::clearlowermessages();
  scripts\mp\utility\player::_freezecontrols(1, undefined, "_encstr_A37012E60EC2EE37A4CD3AB2276BB437374BDB73");

  if(var_2)
    self setclientdvar("_encstr_A3D20B62A25A2854A94194A839", 1);

  if(isDefined(level.finalkillcam_winner) && level.finalkillcam_winner != "_encstr_8BBA05185F8B99" && isDefined(level.match_end_delay) && scripts\mp\utility\game::waslastround() && !istrue(level.doingbroshot))
    wait(level.match_end_delay);

  if(!istrue(level.doingbroshot))
    scripts\mp\utility\player::updatesessionstate(var_1);

  scripts\mp\utility\player::clearkillcamstate();
  self.friendlydamage = undefined;

  if(!isDefined(var_0)) {
    if(!isDefined(level.localeid)) {
      var_3 = getEntArray("_encstr_B4D317B607EBB336DE4C0B63FAA5CDD12BE4DA4BDC6E2DBD37", "_encstr_AC110A7F14873B5B3D073009");
      var_3 = scripts\mp\spawnscoring::checkdynamicspawns(var_3);
      var_0 = var_3[0];
    } else
      var_0 = getspectatepoint();
  }

  if(!isDefined(level.custom_ending)) {
    self spawn(var_0.origin, var_0.angles);
    scripts\mp\utility\player::_id_12898("_encstr_AF1C34E3F9AF8B7D8080DD27D8F0DA777E592F4755D38224106B55ACB358C17A58019692B35FBECB19B547E6AF19313130AB3E0E1907" + var_0.origin);
    scripts\mp\utility\player::setdof_spectator();
  }

  scripts\mp\utility\player::_freezecontrols(1, undefined, "_encstr_A37012E60EC2EE37A4CD3AB2276BB437374BDB73");
}

spawnendofgame() {
  if(isDefined(level._id_11C85) && self[[level._id_11C85]]()) {
    return;
  }
  if(isDefined(level.custom_ending) && scripts\mp\utility\game::waslastround())
    level notify("_encstr_8B5E14DC1DB0938EBE1BEACD1DDEADEB95DC32B49B9D");

  if(!istrue(self.controlsfrozen))
    scripts\mp\utility\player::_freezecontrols(1, undefined, "_encstr_8AA00F577927E3FEA14867A5A159399A8D");

  if(istrue(level.doingbroshot)) {
    self notify("_encstr_BA350853C128FB939DB9");
    scripts\mp\utility\player::clearkillcamstate();
  } else
    spawnspectator();
}

setspawnvariables() {
  scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
  self stoprumble("_encstr_B4BE0D8C58DAB09DCA7D342BB03BCB");
  self.deathposition = undefined;
}

callback_playerdisconnect(var_0) {
  if(!isDefined(self.connected)) {
    return;
  }
  self.locationtriggersetpaused = 1;

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && self isinexecutionvictim() && isalive(self)) {
    var_1 = self scriptablecanbepinged();

    if(!isbot(self)) {
      var_2 = self.health;

      if(scripts\mp\damage::_id_1331E(self)) {
        var_1 scripts\mp\utility\stats::incpersstat("_encstr_B2BE0788BAF573592F", var_2);

        if(!isDefined(var_1.isbecomingzombie))
          var_1.isbecomingzombie = var_2;
        else
          var_1.isbecomingzombie = var_1.isbecomingzombie + var_2;
      } else if(isDefined(level._id_12001))
        var_1[[level._id_12001]](var_2);

      var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat("_encstr_A7B10CF1BFEA8F782D5FF9717D04", var_1.pers["_encstr_B2BE0788BAF573592F"]);
      self kill(self.origin, var_1, var_1, "_encstr_AA230E8CF56CD18DB12FC7E303C8C001");
      self notify("_encstr_8D820B49520F0EC02DDE6367EC");
    }
  }

  if(getdvarint("_encstr_A5B60A1F499D8F973153F986") != 0) {
    var_3 = getmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_921912F1DC500A03934FB31D5362BBC118DB174B");
    var_3++;
    setmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_921912F1DC500A03934FB31D5362BBC118DB174B", var_3);
  }

  var_4 = undefined;

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
    if(istrue(self.pers["_encstr_8ED5113B4F634B98558FDD4AF3BFA74056A763"]) || istrue(self.pers["_encstr_BED60EFF9EE32990DB1728A84BF968A5"]))
      var_4 = "_encstr_A6EB0BEB4C4470A3AB1A8B51B2";

    if(scripts\mp\utility\game::round_vehicle_logic() == "_encstr_B607038AAB") {
      var_5 = [];

      foreach(var_7 in scripts\mp\utility\teams::getenemyteams(self.team)) {
        if(scripts\mp\utility\teams::getteamdata(var_7, "_encstr_8A2A0B936CCCC3078547970A8B"))
          var_5[var_5.size] = var_7;
      }

      var_9 = var_5.size + 1;
      scripts\cp_mp\utility\game_utility::_id_13168(var_9);
    }
  }

  if(isDefined(level.music_timer_10seconds))
    var_4 = level.music_timer_10seconds;

  scripts\cp_mp\utility\game_utility::stopkeyearning(var_4);

  if(scripts\mp\utility\killstreak::iscontrollingproxyagent())
    self restorecontrolagent();

  removeplayerondisconnect();
  scripts\mp\spawnlogic::removefromparticipantsarray();
  scripts\mp\spawnlogic::removefromcharactersarray();
  scripts\cp_mp\utility\player_utility::_id_12C03();
  var_10 = self getentitynumber();

  if(!level.teambased)
    game["_encstr_B81B0A39EDABE69137D5BDCD"][self.guid] = undefined;

  if(level.splitscreen) {
    var_11 = level.players;

    if(var_11.size <= 1)
      level thread scripts\mp\gamelogic::forceend();
  }

  if(isDefined(self.kills) && isDefined(self.deaths)) {
    if(scripts\mp\utility\game::getgametype() == "_encstr_A9B606B0C956B916" && 3 > self.timeplayed["_encstr_BE7D0633C08849E2"]) {
      if(!isDefined(self.arenadamage)) {
        return;
      }
      var_12 = self.arenadamage;
      setplayerteamrank(self, self.clientid, var_12);
    } else if(120 < self.timeplayed["_encstr_BE7D0633C08849E2"]) {
      var_13 = (self.kills - self.deaths) / (self.timeplayed["_encstr_BE7D0633C08849E2"] / 60);
      setplayerteamrank(self, self.clientid, var_13);
    }
  } else {}

  var_14 = self getentitynumber();
  var_15 = self.guid;
  logprint("_encstr_8507037F4F" + var_15 + "_encstr_A54C02F2" + var_14 + "_encstr_A54C02F2" + self.name + "_encstr_AD4C02A0");

  if(drawentitybounds())
    analyticsstreamerlogfiletagplayer("_encstr_8507037F4F" + var_15 + "_encstr_A54C02F2" + var_14 + "_encstr_A54C02F2" + self.name + "_encstr_AD4C02A0");

  thread scripts\mp\events::disconnected();

  if(level.gameended)
    scripts\mp\gamescore::removedisconnectedplayerfromplacement();

  if(isDefined(self.team))
    removefromteamcount();

  scripts\cp_mp\utility\weapon_utility::clearlockedonondisconnect(self);

  if(isDefined(self.team) && isDefined(self.squadindex) && self.team != "_encstr_AF8C0A1B6A1D6045925B4F7D" && self.team != "_encstr_933E090A10B17DDFB3E522")
    scripts\mp\menus::leavesquad(self.team, self.squadindex);

  if(self.sessionstate == "_encstr_877508C1D8C22F2DDC3B" && !(isDefined(self.fauxdead) && self.fauxdead))
    removefromalivecount(1, "_encstr_92AA0C7973A3FF606E764FBE8042");
  else if(self.sessionstate != "_encstr_877508C1D8C22F2DDC3B" && scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && (_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::iswaitingtoentergulag(self) || _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::update_current_solution(self) || _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::use_csm(self)))
    removefromalivecount(1, "_encstr_82AA0C4770C03BA27895D7B7D93E");
  else if(self.sessionstate == "_encstr_A3BC0D2DB544180EEAE7AFB7FF9258" && isDefined(self.team) && scripts\engine\utility::array_contains(level.teamdata[self.team]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"], self))
    removefromalivecount(1, "_encstr_BDAA0CBDD4BB4F68EEC35870B36B");
  else if(self.sessionstate == "_encstr_AF8C0A1B6A1D6045925B4F7D" || self.sessionstate == "_encstr_84670547C3E9F4") {
    if(isDefined(self.team) && scripts\engine\utility::array_contains(level.teamdata[self.team]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"], self))
      removefromalivecount(1, "_encstr_91AA0CADC4AB5F78FE33A860A35C");

    level thread[[level.updategameevents]]();
  }

  if(isDefined(self.team))
    scripts\mp\utility\teams::_id_140C9("_encstr_8D820B49520F0EC02DDE6367EC", self.team, self);

  scripts\mp\utility\disconnect_event_aggregator::rundisconnectcallbacks(self);
  scripts\mp\gamelogic::updatematchhasmorethan1playeromnvaronplayerdisconnect();
  scripts\common\utility::_id_13E0A(level._id_11B2C, var_0);

  if(level.players.size == 0)
    level thread mp_oilrig_patches();
}

mp_oilrig_patches() {
  level notify("_encstr_867814E530259DF11B187787FFAA61B391CD31438F4D");
  level endon("_encstr_867814E530259DF11B187787FFAA61B391CD31438F4D");
  level endon("_encstr_AA940A6CB7DC9B2B6C3ACA91");
  var_0 = getdvarfloat("_encstr_A5992553E632B975DA9F9FBFD392CD90EC71DBC88B9CD8B85383EFAB377A05488450C6C334FD98", 30.0);
  wait(var_0);

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && getdvarint("_encstr_B10F3237D84EBE23B03A0BEB997BC98D59AFCD95738CD7B6C2471B1A8C58E8B0D766F64EF5E6DED7076316BCCA39DC7D63CACC47", 1) == 1 && istrue(level.br_prematchstarted))
    scripts\mp\gamelogic::_id_1301F();

  thread scripts\mp\gamelogic::endgame(undefined, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B84D100B771EE3FFB05897DFF1890F4AF98B"]);
}

removeplayerondisconnect() {
  var_0 = 0;

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    if(level.players[var_1] == self) {
      for(var_0 = 1; var_1 < level.players.size - 1; var_1++)
        level.players[var_1] = level.players[var_1 + 1];

      level.players[var_1] = undefined;
      break;
    }
  }

  if(!isbot(self))
    level.playercustomizationdata[self getentitynumber()] = undefined;

  level.playersbyentitynumber[self getentitynumber()] = undefined;
}

initclientdvarssplitscreenspecific() {
  if(level.splitscreen || self issplitscreenplayer()) {
    self setclientdvars("_encstr_A11E0A5D8FF1E1519E04D72C", "_encstr_99F90506E2DC4D");
    setDvar("_encstr_87642439EBD60BE8B2934B85B190B1DEDBB6212A356C39A5E0D19AB06E47AC4E51372CC4D8AC", 0);
  } else
    self setclientdvars("_encstr_A11E0A5D8FF1E1519E04D72C", "_encstr_A34C02BB");
}

initclientdvars() {
  setDvar("_encstr_9B550B98A728B4D494395151A6", 1);
  setDvar("_encstr_97E60BFB592484E17DF6B2BD5F", 1);

  if(level.hardcoremode) {
    setDvar("_encstr_9B550B98A728B4D494395151A6", 0);
    setDvar("_encstr_97E60BFB592484E17DF6B2BD5F", 1);
  }

  if(isDefined(level.alwaysdrawfriendlynames) && level.alwaysdrawfriendlynames)
    setDvar("_encstr_92290B8D3A757F3039B7F3594F", 1);
  else
    setDvar("_encstr_92290B8D3A757F3039B7F3594F", 0);

  self setclientdvars("_encstr_B61F197138F9AD4D2940EFBF3FCE2B31CC35C64D1BB0B6E19F5757", 1);
  initclientdvarssplitscreenspecific();

  if(scripts\mp\utility\game::getgametypenumlives()) {
    if(level.teambased)
      self setclientdvars("_encstr_925F0A2169ABFA674F39485B", 0, "_encstr_8BCD0A61486DA76C4F44BF36", 1, "_encstr_AF040B29631B07D5B0AA918872", 1, "_encstr_AA660B9B0924E1812F96149A71", 0);
    else
      self setclientdvars("_encstr_925F0A2169ABFA674F39485B", 1, "_encstr_8BCD0A61486DA76C4F44BF36", 0, "_encstr_AF040B29631B07D5B0AA918872", 0, "_encstr_AA660B9B0924E1812F96149A71", 0);
  } else
    self setclientdvars("_encstr_925F0A2169ABFA674F39485B", 0, "_encstr_8BCD0A61486DA76C4F44BF36", 1, "_encstr_AF040B29631B07D5B0AA918872", 1, "_encstr_AA660B9B0924E1812F96149A71", 0);

  if(level.teambased)
    self setclientdvars("_encstr_A3D20B62A25A2854A94194A839", 0);

  self setclientdvar("_encstr_9B6B0C8B6B6949BD435E5FAD85A2", 0);

  if(getdvarint("_encstr_A58711937A8A77FCA823D9378EAF30186825AF")) {
    for(var_0 = 0; var_0 < 6; var_0++)
      self setclientdvar("_encstr_B8260BF3E81F843F1BB9E7E3D8" + var_0, "_encstr_B40101");

    self.hitlocinited = 1;
  }
}

connect_validateplayerteam() {
  if(!isDefined(self)) {
    return;
  }
  if(self.sessionteam == "_encstr_8BBA05185F8B99" && scripts\mp\utility\game::matchmakinggame() && level.teambased && !isbot(self) && !initmaxspeedforpathlengthtable(self) && !self ismlgspectator() && scripts\mp\utility\game::getgametype() != "_encstr_AAE507E8423F63C163") {
    getentitylessscriptablearray("_encstr_9AA516D6C1D72DE6CE8563A58CF5E85985D6BE95E4397B27", ["_encstr_84E90C90A37122C32329CB55BC9A", self getxuid(), "_encstr_AC6B07202B50B7EAC9", self ishost()]);
    wait 1.5;
    kick(self getentitynumber(), "_encstr_AF2A1DE7616520A80B6593D7162A4FCEFA57410E13183D3099E411C5A819F4");
  }
}

queueconnectednotify() {
  for(;;) {
    if(!isDefined(level.players_waiting_for_callback)) {
      waitframe();
      continue;
    }

    break;
  }

  for(;;) {
    for(var_0 = 0; var_0 < level.players_waiting_for_callback.size; var_0++) {
      var_1 = level.players_waiting_for_callback[var_0];

      if(isDefined(var_1)) {
        level notify("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_1);
        var_1 notify("_encstr_AAB513B1F69BCDB2C6E8598CAF36EDB91DA573EA56");
        level.players_waiting_for_callback[var_0] = undefined;
        break;
      }
    }

    var_2 = scripts\engine\utility::array_removeundefined(level.players_waiting_for_callback);
    level.players_waiting_for_callback = var_2;
    waitframe();
  }
}

onversusdone(var_0, var_1) {
  if(var_0 != "_encstr_A1390CC35A137BE30891D9701EB7") {
    return;
  }
  self.versusdone = 1;
}

initsegmentstats() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level thread recordplayersegmentdata();

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    level thread createplayersegmentstats(var_0);
  }
}

recordplayersegmentdata() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  wait 4;

  for(;;) {
    wait 1;

    foreach(var_1 in level.players) {
      if(istrue(var_1.get_baseaccuracy))
        var_1 thread updateplayersegmentdata();
    }
  }
}

createplayersegmentstats(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  var_0.segments = [];
  var_0.segments["_encstr_93060EB111AAD0DFD352F1DFBA938748"] = 0;
  var_0.segments["_encstr_A2900CD6BDECD237D9157B8E161B"] = 0;
  var_0.segments["_encstr_993F14DA70E55FB751C084BDE7594FA37BB962D37389"] = 0;
  var_0.savedsegmentposition = var_0.origin;
  var_0.positionptm = var_0.origin;
  var_0.get_baseaccuracy = 1;
}

updateplayersegmentdata() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(self.savedsegmentposition)) {
    self.savedsegmentposition = self.origin;
    self.positionptm = self.origin;
  }

  if(scripts\mp\utility\player::isusingremote()) {
    self waittill("_encstr_A5D2156EE8DEE0C15646F5EACD96E6D9FA9359B5DED1CA");
    self.savedsegmentposition = self.origin;
    self.positionptm = self.origin;
    return;
  }

  self.segments["_encstr_993F14DA70E55FB751C084BDE7594FA37BB962D37389"]++;
  self.segments["_encstr_93060EB111AAD0DFD352F1DFBA938748"] = self.segments["_encstr_93060EB111AAD0DFD352F1DFBA938748"] + distance2d(self.savedsegmentposition, self.origin);
  self.savedsegmentposition = self.origin;

  if(self.segments["_encstr_993F14DA70E55FB751C084BDE7594FA37BB962D37389"] % 5 == 0) {
    var_0 = distance2d(self.positionptm, self.origin);
    self.positionptm = self.origin;

    if(var_0 > 16)
      self.segments["_encstr_A2900CD6BDECD237D9157B8E161B"]++;
  }
}

shouldshowwidemapshot(var_0) {
  return scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB" && scripts\mp\utility\game::getgametype() != "_encstr_B81904B04E6B" && var_0 < level.prematchperiod && !istrue(self.btestclient) && !scripts\mp\flags::gameflag("_encstr_B27F0F4BB9CC96B1AFDD2D8D1BAF39579B");
}

setuipregamefadeup(var_0) {
  var_1 = newclienthudelem(self);
  var_1.x = 0;
  var_1.y = 0;
  var_1.alignx = "_encstr_A5AD056A019C63";
  var_1.aligny = "_encstr_AC190479FF92";
  var_1.sort = 1;
  var_1.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_1.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_1.foreground = 1;
  var_2 = 0.0;
  var_3 = 0.5;

  if(isDefined(var_2) && var_2 > 0)
    var_1.alpha = 0;
  else
    var_1.alpha = 1;

  var_1 setshader("_encstr_83AB065EE1391A7B", 640, 480);

  if(isDefined(var_2) && var_2 > 0) {
    if(isDefined(self))
      self notify("_encstr_B60B0FCA9A60EFF8603C7D2137E1E7EBA9");

    var_1 fadeovertime(var_2);
    var_1.alpha = 1.0;
    wait(var_2);
  }

  if(isDefined(self))
    self waittill(var_0);

  var_1 fadeovertime(var_3);
  var_1.alpha = 0.0;
  wait(var_3);

  if(isDefined(var_1))
    var_1 destroy();
}

friendlystatuschangedcallback() {
  self.pers["_encstr_BDA8133693AB43A9ED37B818EF1BA09B333DA53DAF"] = 1;
  self notify("_encstr_96DE0EC7C2820B1A5B27F650A30ACB57");

  if(isDefined(self.team) && scripts\mp\utility\teams::isgameplayteam(self.team)) {
    var_0 = scripts\mp\teams::getoperatorcustomization();
    var_1 = var_0[0];
    var_2 = var_0[1];
    self setcustomization(var_1, var_2);

    if(!isDefined(var_1) || var_1 == "_encstr_B40101") {
      var_3 = scripts\mp\teams::lookupcurrentoperator(self.team);
      var_4 = scripts\mp\teams::lookupcurrentoperatorskin(self.team);
      scripts\mp\utility\script::laststand_dogtags("_encstr_BE4E3B2AC74BF702E5D0F751EF92F04B2673FFA888BA414132623AD0AE3E058BF3AB755015EBA70AFF73235319985F64772ED5F048075B909891A9FA2A" + self getentitynumber() + "_encstr_BED1084D57A11A31F85A" + self.team + "_encstr_A95D110B10ED0ECA270B1DDB2725DC8C56E101" + var_3 + "_encstr_8D06158580BD0EAC27C23AB7934D6DB473949B46593C10" + var_4);
    } else if(!isDefined(var_2) || var_2 == "_encstr_B40101") {
      var_3 = scripts\mp\teams::lookupcurrentoperator(self.team);
      var_4 = scripts\mp\teams::lookupcurrentoperatorskin(self.team);
      scripts\mp\utility\script::laststand_dogtags("_encstr_8FEB3B6FA8AC4F405DCD479CCDFB68FB709875A5B45BB031606FA3E646EE1A9D9B53E8B30973F009A00F0D3B0ED32DDEB16E53A8CACE97059FE0ED48AE" + self getentitynumber() + "_encstr_BED1084D57A11A31F85A" + self.team + "_encstr_A95D110B10ED0ECA270B1DDB2725DC8C56E101" + var_3 + "_encstr_8D06158580BD0EAC27C23AB7934D6DB473949B46593C10" + var_4);
    }
  }
}

_id_119CD() {
  var_0 = isbot(self) || initmaxspeedforpathlengthtable(self) || isai(self);

  if(scripts\mp\utility\game::rankingenabled()) {
    var_1 = self getplayerdata("_encstr_927C07D787E1823F38", "_encstr_8CFD0EDD51312A070C8B9AE3B3534F65", "_encstr_95A30C63C089D1FA5591E75B7D01", "_encstr_B607032B8B");
    var_2 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_8E8D0697EB01F243");
    var_3 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_8E0607055DBFB3919A");
    var_4 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_AA270B12190951B94784B87C6B", "_encstr_A9F6058464DADF");
    var_5 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_AA270B12190951B94784B87C6B", "_encstr_956807294FC34ED073");
    var_6 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_88CC0521F3A13B");
    var_7 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_8EDA07FF229707BB77");
    var_8 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_AC410A68C2CD019167865C4E");
    var_9 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_8FD00BB9B22C27A6A5CDCDB2DC");
    var_10 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_AA270B12190951B94784B87C6B", "_encstr_95B80C17DA7BF867C7ED6BC84D94");
    var_11 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_AA270B12190951B94784B87C6B", "_encstr_8893104796DA2B14B185E5B2198A7BE80B36");
    var_12 = self getplayerdata("_encstr_8C07031599", "_encstr_A7A20CC1D8585EAC4E9AE80B1D9B", "_encstr_AA270B12190951B94784B87C6B", "_encstr_82FB06EB26785BD7");
    var_13 = self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_83250C68679183370209EE7F5D0A");
  } else {
    var_1 = 0;
    var_2 = 0;
    var_3 = 0;
    var_4 = 0;
    var_5 = 0;
    var_6 = 0;
    var_7 = 0;
    var_8 = 0;
    var_9 = 0;
    var_10 = 0;
    var_11 = 0;
    var_12 = 0;
    var_13 = 0;
  }

  var_14 = self updatelastcovertime();
  var_15[0] = "_encstr_B40101";
  var_15[1] = "_encstr_B40101";
  var_16[0] = -1;
  var_16[1] = -1;
  var_17[0] = "_encstr_8BBA05185F8B99";
  var_17[1] = "_encstr_8BBA05185F8B99";

  if(!istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"]) && !isbot(self)) {
    if(level.teambased) {
      var_15[0] = scripts\mp\teams::lookupcurrentoperator("_encstr_9A8507BA4040188D08");
      var_15[1] = scripts\mp\teams::lookupcurrentoperator("_encstr_8E8405EA382B2A");
      var_16[0] = scripts\mp\teams::lookupcurrentoperatorskin("_encstr_9A8507BA4040188D08");
      var_16[1] = scripts\mp\teams::lookupcurrentoperatorskin("_encstr_8E8405EA382B2A");
      var_18 = scripts\mp\teams::getoperatorexecution(var_15[0]);

      if(isDefined(var_18))
        var_17[0] = var_18;

      var_18 = scripts\mp\teams::getoperatorexecution(var_15[1]);

      if(isDefined(var_18))
        var_17[1] = var_18;
    } else {
      var_15[0] = scripts\mp\teams::lookupcurrentoperator("_encstr_9A8507BA4040188D08");
      var_16[0] = scripts\mp\teams::lookupcurrentoperatorskin("_encstr_9A8507BA4040188D08");
      var_18 = scripts\mp\teams::getoperatorexecution(var_15[0]);

      if(isDefined(var_18))
        var_17[0] = var_18;
    }
  }

  var_19 = 0;

  if(level.onlinegame)
    var_19 = self isfireteamleader();

  self.pers["_encstr_8390136DF11BC9AF90E0D26A2975277B385BF5FF57"] = getsystemtime();
  var_20 = _func_042D();
  self dlog_recordplayerevent("_encstr_97DB1E4769BF1237C1C0EF3B287ED06A7B7B8F7A58D30A4429180F47A391AAB3", ["_encstr_8390136DF11BC9AF90E0D26A2975277B385BF5FF57", self.pers["_encstr_8390136DF11BC9AF90E0D26A2975277B385BF5FF57"], "_encstr_BA060957A1E0EDA345BBEF", self.name, "_encstr_8AEF05472BC2D6", self.sessionteam, "_encstr_A50B0A35BD969BEB47F283AC", self getjointype(), "_encstr_AFC0076727109AD710", var_0, "_encstr_814106BF330C3079", self getskill(), "_encstr_97410978B74BD3A047B8AA", self getmissilevelocity(), "_encstr_AA530E629B81B84F10738B2993971351", var_19, "_encstr_8DC5056CF390E3", var_14[0], "_encstr_8CC5054B38D7C4", var_14[1], "_encstr_9AC5054B07BE8D", var_14[2], "_encstr_BAC5053CA291E9", var_14[3], "_encstr_B4E409701329CF0B199B39", self scriptablesetparententity(), "_encstr_ACB009AFBB96ABD858C363", var_1, "_encstr_8D510CB3F35FC23051B778B12933", var_2, "_encstr_ABB90D568B4F862B9F29BF703B0DE7", var_3, "_encstr_ADAD0B871406C86D2F3B68F003", var_4, "_encstr_A2E60D1BA39FFB2BC1992723BF48B2", var_5, "_encstr_85300BC8833103A1B1248315FA", var_6, "_encstr_85250DB91D859C3AEBAD4B6ECD2BE6", var_7, "_encstr_B13511B3FDBAC52B2F58E940701F7E79280FB0", var_8, "_encstr_B1AB117FC8CFA3DB71706F6B082BD897A3078B", var_9, "_encstr_922213B9D158C91DBEEC16B5B29BEB83C60B2F5991", var_10, "_encstr_B438189BE8B04E1D7DD14BAD59BEC11B58CB5623AFA3F6A3B01B", var_11, "_encstr_965F0CE647B093E8D7DCB1B7C995", var_12, "_encstr_AB360F927593732CB6E0A3E7E00BF9EA63", var_13, "_encstr_91EC10ED8356930B8EBD4EFAC2C63696B2B9", var_15[0], "_encstr_87F30E601B47C509FB5F0E9029B3708F", var_15[1], "_encstr_B4FB1528DAAD587F93670557773A315845F2D6238419F0", var_16[0], "_encstr_97A413F63856930BD1F64EAFB0E14BE6AF37AD5A9B", var_16[1], "_encstr_ADD71EEFC9C8558729309388CF9851736F83B71318E20783C3DBBFD3D043DD12", var_17[0], "_encstr_B6801C5AA31D7BEE181FBA8F1B20B437A8B9A36229EDBB24E8759FAA3B38", var_17[1], "_encstr_B6900C6BCB61F01D2FE21039BB4F", self calloutmarkerping_getEnt(), "_encstr_87D40E83D81697C65ADC8EFAB9B0DAAC", var_20, "_encstr_96640CC5114E63C67D301B7130B9", self _meth_87C4()]);
}

repair_grill_fixing_long_sfx() {
  if(level.gametype != "_encstr_B607038AAB")
    return 30;
  else
    return 200;
}

callback_playerconnect() {
  self.versusdone = 0;
  self.pers["_encstr_A7350D98707F9B79A37F4B04F34D27"] = 0;
  self.statusicon = "_encstr_8BD81654E368177305FBE3FFC7B83A6F80288F1E3BE8FE0A";
  self waittill("_encstr_845E066177577837");
  self.statusicon = "_encstr_B40101";

  if(isai(self) || getdvarint("_encstr_965C0BEAE6B0A3E8599B32B291", 0) == 1)
    friendlystatuschangedcallback();

  self.connecttime = undefined;
  self clearpredictedstreampos();

  if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB")
    self clearadditionalstreampos();

  var_0 = 1;

  if(isDefined(level._id_12065))
    var_0 = self thread[[level._id_12065]]();

  if(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B") && istrue(level.usespawnselection) && isDefined(self.sessionteam)) {
    if(self.sessionteam == "_encstr_9A8507BA4040188D08") {
      var_1 = level.spawncameras["_encstr_B4B9103B4BE98DA8C30FE76904D7D16F84B1"]["_encstr_9A8507BA4040188D08"];
      self setadditionalstreampos(var_1.origin, 1);
    } else if(self.sessionteam == "_encstr_8E8405EA382B2A") {
      var_1 = level.spawncameras["_encstr_B16B0EDFCFE1246042F1013A643B11F7"]["_encstr_8E8405EA382B2A"];
      self setadditionalstreampos(var_1.origin, 1);
    }
  }

  self visionsetfadetoblackforplayer("_encstr_BA07031663", 0);
  var_2 = "_encstr_AAB513B1F69BCDB2C6E8598CAF36EDB91DA573EA56";
  var_3 = scripts\mp\utility\game::gettimepassed() / 1000 + 6;

  if(!isDefined(self.pers["_encstr_BDA8133693AB43A9ED37B818EF1BA09B333DA53DAF"]) && (shouldshowwidemapshot(var_3) || level.gametype == "_encstr_B81904B04E6B"))
    var_2 = "_encstr_96DE0EC7C2820B1A5B27F650A30ACB57";

  thread setuipregamefadeup(var_2);
  scripts\mp\utility\game::checkrealismhudsettings();
  level.players_waiting_for_callback[level.players_waiting_for_callback.size] = self;
  self waittill("_encstr_AAB513B1F69BCDB2C6E8598CAF36EDB91DA573EA56");
  self.connected = 1;

  if(!isDefined(level.uniqueplayersconnected))
    level.uniqueplayersconnected = 1;
  else
    level.uniqueplayersconnected++;

  initinputtypewatcher();
  self setclientomnvar("_encstr_8CF415303FC7FB577A1ACD46B572BDC11FABB038978A71", 0);

  if(self ishost())
    level.player = self;

  if(!level.splitscreen && !isDefined(self.pers["_encstr_82FB06EB26785BD7"])) {
    var_4 = 0;
    var_5 = getdvarint("_encstr_A5C622CF79D0F73BD2FF4B406FEF284625190C6DE379312B17A0051E9BD7C4D98BCA0AA5", 0);

    if(var_5 > 0) {
      if(isDefined(level.starttime)) {
        var_6 = (gettime() - level.starttime) / 1000;

        if(var_6 <= var_5)
          var_4 = 1;
      } else
        var_4 = 1;
    }

    if(var_4 == 0) {}
  }

  self.usingonlinedataoffline = self isusingonlinedataoffline();
  initclientdvars();
  initplayerstats();
  scripts\mp\accolades::applyaccoladestructtoplayerpers();

  if(getDvar("_encstr_8F7A0BD1E5E15304B8CF7989FF") == "_encstr_A34C02BB")
    level waittill("_encstr_9140093575E183DD9398A3");

  self.guid = scripts\mp\utility\player::getuniqueid();
  var_7 = 0;

  if(!isDefined(self.pers["_encstr_A3D2091BD84BB29B8EA519"])) {
    self.pers["_encstr_A3D2091BD84BB29B8EA519"] = game["_encstr_A3D2091BD84BB29B8EA519"];
    game["_encstr_A3D2091BD84BB29B8EA519"]++;
    var_8 = repair_grill_fixing_long_sfx();

    if(game["_encstr_A3D2091BD84BB29B8EA519"] >= var_8) {
      game["_encstr_A3D2091BD84BB29B8EA519"] = var_8 - 1;
      self.pers["_encstr_A3D2091BD84BB29B8EA519"] = var_8 - 1;
    }

    var_7 = 1;
    self.pers["_encstr_99A415B5B0E8B1D046583A2CAB2B85C1B7B94DE885A39B"] = [];
    self.pers["_encstr_8DE31AAD161D1B4391B0470B6A8DDE4ECA8AD995DC3A347B579BD137"] = [];
    self.pers["_encstr_BE4F0EDB82ED810DE1D87D31FB8183E8"] = 0;
    self.pers["_encstr_8A2F11B7634DD307C52B73FA97CDE7A933B4C8"] = 0;
  }

  if(istrue(level.flashpointactive))
    thread scripts\mp\flashpoint::flashpoint_trackplayerevents(self);

  if(var_7) {
    scripts\mp\persistence::statsetchildbuffered("_encstr_8C4606C9DBD5CD46", "_encstr_881A0B47B4B6B2286316E59532", 0, 1);
    self setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_AA36085CF78876831B33", 0);
    scripts\cp_mp\utility\game_utility::startkeyearning();

    if(!isDefined(game["_encstr_935612AB73A5B8EAACA01BB0BCB22786EDBA373A"]))
      game["_encstr_935612AB73A5B8EAACA01BB0BCB22786EDBA373A"] = 1;
    else
      game["_encstr_935612AB73A5B8EAACA01BB0BCB22786EDBA373A"]++;
  }

  self.clientid = self.pers["_encstr_A3D2091BD84BB29B8EA519"];
  self.pers["_encstr_8CED0F31BD8EB86A6F0230BFFB1B231064"] = 0;
  logprint("_encstr_8F0703997F" + self.guid + "_encstr_A54C02F2" + self getentitynumber() + "_encstr_A54C02F2" + self.name + "_encstr_AD4C02A0");

  if(drawentitybounds())
    analyticsstreamerlogfiletagplayer("_encstr_8F0703997F" + self.guid + "_encstr_A54C02F2" + self getentitynumber() + "_encstr_A54C02F2" + self.name + "_encstr_AD4C02A0");

  self logstatmatchguid();

  if(getdvarint("_encstr_A5B60A1F499D8F973153F986") != 0) {
    var_9 = getmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_A7E60D8363F85FA2B6F17737DDA0C8");

    if(var_7) {
      var_9++;
      setmatchdata("_encstr_8298108F5DD8BD5880878BF8B1F1C179E3B1", "_encstr_A7E60D8363F85FA2B6F17737DDA0C8", var_9);
    }

    if(isbot(self) || initmaxspeedforpathlengthtable(self) || isai(self))
      var_10 = 1;
    else
      var_10 = 0;

    if(scripts\mp\utility\game::matchmakinggame() && !scripts\mp\utility\game::denysystemicteamchoice() && !var_10) {}
  }

  if(var_7)
    _id_119CD();

  if(level.uniqueplayersconnected <= repair_grill_fixing_long_sfx()) {
    if(var_7 && isDefined(level.matchrecording_logeventplayername))
      [[level.matchrecording_logeventplayername]](self.clientid, self.team, self.name);
  }

  if(!level.teambased)
    game["_encstr_B81B0A39EDABE69137D5BDCD"][self.guid] = 0;

  if(!isDefined(self.pers["_encstr_84C910D248050977F8F9A49F0E236BCF4B20"]))
    self.pers["_encstr_84C910D248050977F8F9A49F0E236BCF4B20"] = 0;

  if(!isDefined(self.pers["_encstr_B80511FE9DCDD954993093EBA9331C534B3F44"]))
    self.pers["_encstr_B80511FE9DCDD954993093EBA9331C534B3F44"] = 0;

  if(level.onlinestatsenabled)
    self.bestlifetimekillstreak = scripts\mp\playerstats_interface::getplayerstat("_encstr_AC7F0AE8AA22E96FDB712DA6", "_encstr_85CE0B9770B02C71A1760F06D2");

  self.lastgrenadesuicidetime = -1;
  self.hasspawned = 0;
  self.waitingtospawn = 0;
  self.wantsafespawn = 0;
  self.wasaliveatmatchstart = 0;
  self.movespeedscaler = 1;
  self.objectivescaler = 1;
  self.killcountthislife = 0;
  self.intel_guys = 0;
  self._id_11BC2 = 0;
  self.show_balloon_deploy_hint = undefined;
  self.shouldxmike109hitmarker = undefined;
  self.lifeid = 0;

  if(isDefined(self.pers["_encstr_8E0607055DBFB3919A"]))
    self.lifeid = self.pers["_encstr_8E0607055DBFB3919A"];

  resetuidvarsonconnect();
  waittillframeend;
  level.players[level.players.size] = self;
  level.playersbyentitynumber[self getentitynumber()] = self;
  scripts\mp\spawnlogic::addtoparticipantsarray();
  scripts\mp\spawnlogic::addtocharactersarray();
  scripts\cp_mp\utility\player_utility::being_kicked_from_inactivity();

  if(game["_encstr_A1AD062E09D98338"] == "_encstr_ACE709DA22939BA8075060") {
    self.connectedpostgame = 1;
    self setclientdvars("_encstr_B61F197138F9AD4D2940EFBF3FCE2B31CC35C64D1BB0B6E19F5757", 0);
    self visionsetfadetoblackforplayer("_encstr_B40101", 0.25);
    spawnintermission();
    return;
  }

  if(var_7 && (scripts\mp\utility\game::gettimepassed() >= 60000 || game["_encstr_8DC30DAA0285FD69FAE113371B1934"] > 0))
    self.joinedinprogress = 1;

  if(isai(self) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["_encstr_B672066D30FF90B7"]))
    self thread[[level.bot_funcs["_encstr_B672066D30FF90B7"]]]();

  if(drawentitybounds() && !isai(self))
    analyticsstreamerislogfilestreamingenabled(self.guid);

  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(level.hostmigrationtimer))
    thread scripts\mp\hostmigration::hostmigrationtimerthink();

  if(isDefined(level.onplayerconnectaudioinit))
    [[level.onplayerconnectaudioinit]]();

  thread scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_monitorplayerusability(self);
  thread abilityleft::claymore_crate_update_hint_logic_alt(self);
  thread scripts\mp\perks\perkfunctions::markedentities_think();

  if(!isDefined(self.pers["_encstr_8AEF05472BC2D6"])) {
    var_3 = scripts\mp\utility\game::gettimepassed() / 1000 + 6;

    if(shouldshowwidemapshot(var_3)) {
      spawnspectatormapcam();
      self lerpfovbypreset("_encstr_8B1608EC43B8D647A113");
      self setclientomnvar("_encstr_9341123B20D73DE753EE382705DEA746CB28D3F2", 0);
      initclientdvarssplitscreenspecific();
      self.pers["_encstr_8AEF05472BC2D6"] = "_encstr_B40101";
      self.team = "_encstr_BD78059C33C543";
    } else
      self visionsetfadetoblackforplayer("_encstr_B40101", 0.5);

    connect_validateplayerteam();

    if(self ismlgspectator()) {
      if(self ismlgfollower())
        thread scripts\mp\menus::setfollower();
      else
        thread scripts\mp\menus::setspectator();
    } else if(dotournamentendgame() && (self.sessionteam == "_encstr_AF8C0A1B6A1D6045925B4F7D" || self.sessionteam == "_encstr_933E090A10B17DDFB3E522")) {
      self.pers["_encstr_8AEF05472BC2D6"] = self.sessionteam;
      self.team = self.sessionteam;
      thread spawnspectator();
    } else if((scripts\mp\utility\game::matchmakinggame() || scripts\mp\utility\game::lobbyteamselectenabled() || isgamebattlematch()) && self.sessionteam != "_encstr_8BBA05185F8B99") {
      if(var_0)
        thread spawnspectator();

      if((getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_BE180419DAE9" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_8AE1099A0B999F2D28AF15" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_9B1F05BE4B9B52" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_866209ECEDB1197DEE0B4E") && getdvarint("_encstr_8D4E1EB3AF1389801ADFF8372D35C9D0F14BEFC352362967F0F2CFBD9728E5D8", 0) == 1)
        thread scripts\mp\teams::_id_12304();
      else {
        if(scripts\mp\menus::brking_updateteamscore())
          self.sessionteam = "_encstr_9A8507BA4040188D08";

        thread scripts\mp\menus::setteam(self.sessionteam);
      }

      if(scripts\mp\utility\game::allowclasschoice() || scripts\mp\utility\game::showfakeloadout() && !isai(self)) {
        if(getdvarint("_encstr_AF121CB812BA97E18F4A8EF50FD749B7A9BB088049162378BB530DFF0B2F", 0) == 1 && scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_BE180419DAE9" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_8AE1099A0B999F2D28AF15" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_9B1F05BE4B9B52" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_816E079685517D0975" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_9936086E0BB9324CDBC3" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_866209ECEDB1197DEE0B4E") {
          var_14 = isDefined(level.allowclasschoicefunc) && istrue(self[[level.allowclasschoicefunc]]());
          scripts\mp\utility\script::laststand_dogtags("_encstr_960725A9D8D241DA8942DA2041E8E3FFE5E68840505A487E38DE93AFF7882271623BDA0C752F41" + self.name + "_encstr_862F2E56E5B3910763D0DF3FF8FBFF7A73F08BEE69493F1C4150C33BD8539B32D39692BEBB6F429BB171BF2BA0E12D3E" + var_14);
        }

        self setclientomnvar("_encstr_83FB10572DFADB0ED196B7736EF5D6CACD5D", 2);
      }

      if(!scripts\mp\utility\game::runleanthreadmode() && scripts\mp\utility\game::matchmakinggame() && !isgamebattlematch())
        thread kickifdontspawn();

      clearpinnedobjectives();
      return;
    } else {
      if(var_0)
        thread spawnspectator();

      scripts\mp\menus::autoassign();

      if(scripts\mp\utility\game::allowclasschoice() || scripts\mp\utility\game::showfakeloadout() && !isai(self)) {
        if(getdvarint("_encstr_AF121CB812BA97E18F4A8EF50FD749B7A9BB088049162378BB530DFF0B2F", 0) == 1 && scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_BE180419DAE9" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_8AE1099A0B999F2D28AF15" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_9B1F05BE4B9B52" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_816E079685517D0975" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_9936086E0BB9324CDBC3" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_866209ECEDB1197DEE0B4E") {
          var_14 = isDefined(level.allowclasschoicefunc) && istrue(self[[level.allowclasschoicefunc]]());
          scripts\mp\utility\script::laststand_dogtags("_encstr_86341F3438E935A309AE734F2F7077B81358885AE8552FEFC32309285D5877C7C1" + self.name + "_encstr_862F2E56E5B3910763D0DF3FF8FBFF7A73F08BEE69493F1C4150C33BD8539B32D39692BEBB6F429BB171BF2BA0E12D3E" + var_14);
        }

        self setclientomnvar("_encstr_83FB10572DFADB0ED196B7736EF5D6CACD5D", 2);
      }

      if(!scripts\mp\utility\game::runleanthreadmode() && scripts\mp\utility\game::matchmakinggame())
        thread kickifdontspawn();

      clearpinnedobjectives();
      return;
    }
  } else {
    self visionsetfadetoblackforplayer("_encstr_B40101", 0.5);
    connect_validateplayerteam();
    var_15 = self.pers["_encstr_8AEF05472BC2D6"];

    if(scripts\mp\utility\game::matchmakinggame() && !isbot(self) && !initmaxspeedforpathlengthtable(self) && !self ismlgspectator() && getdvarint("_encstr_877B0AB97436B14E34B73FA9"))
      var_15 = self.sessionteam;

    scripts\mp\menus::addtoteam(var_15, 1);

    if(scripts\mp\menus::shouldmodesetsquads())
      thread scripts\mp\menus::setsquad(var_15);

    if(isDefined(level._id_12065))
      self thread[[level._id_12065]]();

    if(self ismlgspectator()) {
      thread spawnspectator();
      clearpinnedobjectives();
      return;
    }

    if(scripts\mp\class::isvalidclass(self.pers["_encstr_959506B911C79707"]) && var_15 != "_encstr_AF8C0A1B6A1D6045925B4F7D") {
      thread spawnclient();
      clearpinnedobjectives();
      return;
    }

    if(var_0)
      thread spawnspectator();

    if(self.pers["_encstr_8AEF05472BC2D6"] == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
      if(scripts\mp\utility\game::doesmodesupportplayerteamchoice() && !istrue(self.pers["_encstr_BE0819E2C9C3936D4309BB9FB099134B93D66BDEAD779B8449F0A7"]))
        scripts\mp\menus::beginteamchoice();
    } else
      scripts\mp\menus::beginclasschoice();
  }

  clearpinnedobjectives();
}

callback_playermigrated() {
  if(isDefined(self.connected) && self.connected)
    scripts\mp\utility\game::updateobjectivetext();

  if(self ishost())
    initclientdvarssplitscreenspecific();

  var_0 = 0;

  foreach(var_2 in level.players) {
    if(!isbot(var_2) && !initmaxspeedforpathlengthtable(var_2))
      var_0++;
  }

  if(!isbot(self) && !initmaxspeedforpathlengthtable(self)) {
    level.hostmigrationreturnedplayercount++;

    if(level.hostmigrationreturnedplayercount >= var_0 * 2 / 3)
      level notify("_encstr_8E3E1C86DEDCA35BB4CEE4B0E8A5EDB9F595B97B5D760D1C1BB0BC959CB9");
  }
}

addlevelstoexperience(var_0, var_1) {
  var_2 = scripts\mp\rank::getrankforxp(var_0);
  var_3 = scripts\mp\rank::getrankinfominxp(var_2);
  var_4 = scripts\mp\rank::getrankinfomaxxp(var_2);
  var_2 = var_2 + (var_0 - var_3) / (var_4 - var_3);
  var_2 = var_2 + var_1;

  if(var_2 < 0) {
    var_2 = 0;
    var_5 = 0.0;
  } else if(var_2 >= level.maxrank + 1.0) {
    var_2 = level.maxrank;
    var_5 = 1.0;
  } else {
    var_5 = var_2 - floor(var_2);
    var_2 = int(floor(var_2));
  }

  var_3 = scripts\mp\rank::getrankinfominxp(var_2);
  var_4 = scripts\mp\rank::getrankinfomaxxp(var_2);
  return int(var_5 * (var_4 - var_3)) + var_3;
}

forcespawn() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_BA350853C128FB939DB9");
  wait 60.0;

  if(self.hasspawned) {
    return;
  }
  if(self.pers["_encstr_8AEF05472BC2D6"] == "_encstr_AF8C0A1B6A1D6045925B4F7D" || self.pers["_encstr_8AEF05472BC2D6"] == "_encstr_933E090A10B17DDFB3E522") {
    return;
  }
  if(!scripts\mp\class::isvalidclass(self.pers["_encstr_959506B911C79707"])) {
    self.pers["_encstr_959506B911C79707"] = "_encstr_B88F0E1DB077C6F1AD23F3F71CED59BF";
    self.class = self.pers["_encstr_959506B911C79707"];
  }

  thread spawnclient();
}

kickifdontspawn() {
  if(getdvarint("_encstr_955E13729906EFE7B9AF24378161E7AF2E90FA8AA0", 0) == 1) {
    return;
  }
  if(istrue(self._id_1363E) && !mayspawn()) {
    return;
  }
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_BA350853C128FB939DB9");
  self endon("_encstr_976B10EF14B3C9B3723350A0794A418167A6");
  var_0 = getdvarfloat("_encstr_ACBF0EF3CE3307ACA370D2A9F09B65A7", 90);
  var_1 = getdvarfloat("_encstr_8F3A11677EC5DFAC08074A89E5E8DD4147FAAF", 45);
  var_2 = getdvarfloat("_encstr_B2FD12CB7F28696F73A16229E858371BB0F35D25", 120);
  var_3 = gettime();

  if(self ishost())
    kickwait(var_2);
  else
    kickwait(var_0);

  var_4 = (gettime() - var_3) / 1000;

  if(var_4 < var_0 - 0.1 && var_4 < var_1) {
    return;
  }
  if(self.hasspawned) {
    return;
  }
  if(self.pers["_encstr_8AEF05472BC2D6"] == "_encstr_AF8C0A1B6A1D6045925B4F7D" || self.pers["_encstr_8AEF05472BC2D6"] == "_encstr_933E090A10B17DDFB3E522") {
    return;
  }
  kick(self getentitynumber(), "_encstr_A6CC1AB8383F0A01305921294D57CBBB789D75196328214621BF17D3", 1);
  level thread[[level.updategameevents]]();
}

kickwait(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
}

monitorvotekick() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(self.votestokick = 0; self.votestokick < 2; self.votestokick++)
    self waittill("_encstr_95DE0BCEDEA359A8DB96B41BB6");

  kick(self getentitynumber(), "_encstr_AA731BA8B02A79A06250952A94A59286968A22F5158AA09AA59289624D");
}

fakevote() {
  wait 1.0;
  self notify("_encstr_95DE0BCEDEA359A8DB96B41BB6");
  wait 3.0;
  self notify("_encstr_95DE0BCEDEA359A8DB96B41BB6");
  wait 2.0;
  self notify("_encstr_95DE0BCEDEA359A8DB96B41BB6");
}

totaldisttracking(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_BA350853C128FB939DB9");
  self notify("_encstr_BD0C16A79020CCD0967717D771370B1EC11B1EEE48586E9A");
  self endon("_encstr_BD0C16A79020CCD0967717D771370B1EC11B1EEE48586E9A");
  var_2 = var_0;

  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
    var_2 = self.origin;
  }

  var_3 = 0;
  var_4 = 0;
  var_5 = 0;

  for(;;) {
    var_6 = scripts\engine\utility::_id_143BE(5.0, "_encstr_AD75063D571AE108", "_encstr_911C0E46025264AE3098DF12985BA553", "_encstr_A68614E329B32F56F053FFCB61B05D4F6D06CB5A3115", "_encstr_A9130DC330104912F19DE1677B831B", "_encstr_86B214E08A344F7B3361B6BA719BC187DA02F8D852CF", "_encstr_8D0118DCDAE523A59DB27D19CA0763DE5E0785270BC6435DA359");

    if(var_6 == "_encstr_A9130DC330104912F19DE1677B831B" && !isDefined(self.lastvehicleseatchangetime)) {
      continue;
    }
    if(!isDefined(self.pers["_encstr_B1A81263104592BBB74837413915989D6123EAE5"]))
      scripts\mp\utility\stats::initpersstat("_encstr_B1A81263104592BBB74837413915989D6123EAE5");

    if(!isDefined(self.pers["_encstr_8A0F18B9308BB6C1B53A7B93753B51E32D80BFE29319175738E3"]))
      scripts\mp\utility\stats::initpersstat("_encstr_8A0F18B9308BB6C1B53A7B93753B51E32D80BFE29319175738E3");

    if(!isDefined(var_2))
      var_2 = self.origin;

    var_7 = distance(var_2, self.origin);
    scripts\mp\utility\stats::incpersstat("_encstr_B1A81263104592BBB74837413915989D6123EAE5", var_7);
    scripts\cp\vehicles\vehicle_compass_cp::_encstr_BA0411A5DC1BD8A1B01BD8B27376B237471647("_encstr_B1A81263104592BBB74837413915989D6123EAE5", var_7);

    if(getdvarint("_encstr_83021FCDD893D7D959E89527BA37DCF536D0C263B12BB9762BF5CAE65889362B23", 0)) {
      if(!isDefined(self.vehicle) && var_6 != "_encstr_A9130DC330104912F19DE1677B831B" || var_6 == "_encstr_911C0E46025264AE3098DF12985BA553") {
        var_8 = 0;

        if(self isjumping()) {
          var_9 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifytriggerlocation(self.origin, 0, -100000);
          var_10 = self.origin[2] - var_9["_encstr_BD260953AA97E3F014279D"][2];
          var_8 = var_10 <= getdvarfloat("_encstr_9301243BD848DC59598EE61E7A0B029716609FCBC1230D6251A961545DDB1B675858372F907B", 100) && var_10 > 0 && !isDefined(var_9["_encstr_850E077B0BF30318B9"]);
        }

        var_9 = self getgroundentity();
        var_11 = isDefined(var_9) && var_9.classname == "_encstr_BD4E0B7B104D6AD4DB384717A0" || var_8;

        if(var_11 && var_5 && var_7 <= getdvarfloat("_encstr_AF39243D4F02CD01749A2179C441408CB9EFAB89F7CA9340BD368BB12F0F4833931323DDAF12", 10000)) {
          scripts\mp\utility\stats::incpersstat("_encstr_8A0F18B9308BB6C1B53A7B93753B51E32D80BFE29319175738E3", var_7);
          scripts\cp\vehicles\vehicle_compass_cp::_encstr_BA0411A5DC1BD8A1B01BD8B27376B237471647("_encstr_8A0F18B9308BB6C1B53A7B93753B51E32D80BFE29319175738E3", var_7);
        }

        var_5 = var_11 && var_6 != "_encstr_8D0118DCDAE523A59DB27D19CA0763DE5E0785270BC6435DA359";
      }
    }

    if(isDefined(scripts\mp\utility\stats::getpersstat("_encstr_AAF01AFBF06F6816DE36A85DF881835D6119883C2B5B8A71189F8562")) && (var_6 == "_encstr_A9130DC330104912F19DE1677B831B" || isDefined(self.vehicle)))
      scripts\mp\utility\stats::incpersstat("_encstr_AAF01AFBF06F6816DE36A85DF881835D6119883C2B5B8A71189F8562", var_7);

    if(var_6 == "_encstr_911C0E46025264AE3098DF12985BA553") {
      var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(self);
      self.lastvehicleseatchangetime = gettime();
    }

    if(var_6 == "_encstr_A68614E329B32F56F053FFCB61B05D4F6D06CB5A3115")
      var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(self);

    if(var_3 != var_4 || var_6 == "_encstr_A9130DC330104912F19DE1677B831B") {
      var_12 = self.lastvehicleseatchangetime;
      var_13 = (gettime() - var_12) / 1000;

      if(var_3) {
        if(isDefined(scripts\mp\utility\stats::getpersstat("_encstr_B28E123A4BAD954D38CACDE828CD224E96675993")))
          scripts\mp\utility\stats::incpersstat("_encstr_B28E123A4BAD954D38CACDE828CD224E96675993", var_13);
      } else if(isDefined(scripts\mp\utility\stats::getpersstat("_encstr_86A315E388113F7A3073AEBC5340F27746634ACAD1FDAB")))
        scripts\mp\utility\stats::incpersstat("_encstr_86A315E388113F7A3073AEBC5340F27746634ACAD1FDAB", var_13);
    }

    if(var_6 == "_encstr_911C0E46025264AE3098DF12985BA553" || var_6 == "_encstr_A68614E329B32F56F053FFCB61B05D4F6D06CB5A3115")
      var_3 = var_4;

    if(var_6 == "_encstr_A68614E329B32F56F053FFCB61B05D4F6D06CB5A3115")
      self.lastvehicleseatchangetime = gettime();

    var_2 = self.origin;
    scripts\mp\utility\stats::incpersstat("_encstr_8F691085CECA3985D9B250C6A35A3AAB4695", self.origin[2]);
    scripts\mp\utility\stats::incpersstat("_encstr_977C15697BE7028AA7BF0963BB38F37533BA69B7433889", 1);

    if(var_1 && !istrue(self.stack_patch_waittill_node)) {
      if(var_6 == "_encstr_86B214E08A344F7B3361B6BA719BC187DA02F8D852CF") {
        continue;
      }
      if(!isDefined(self.pers["_encstr_91FF1555B52BABE824FFC8E8134A01CD421D45D586A027"]))
        scripts\mp\utility\stats::initpersstat("_encstr_91FF1555B52BABE824FFC8E8134A01CD421D45D586A027");

      scripts\mp\utility\stats::incpersstat("_encstr_91FF1555B52BABE824FFC8E8134A01CD421D45D586A027", var_7);

      if(scripts\mp\utility\game::getgametype() == "_encstr_A9B606B0C956B916") {
        if(self.pers["_encstr_91FF1555B52BABE824FFC8E8134A01CD421D45D586A027"] > 50) {
          self.pers["_encstr_8D0C13FAB3EED8345297D2E0FF98D789E9BE07BFF8"] = 1;
          self.pers["_encstr_88600A5A789FD2FF9337545B"] = 0;
        }

        continue;
      }

      if(!istrue(self.pers["_encstr_8D0C13FAB3EED8345297D2E0FF98D789E9BE07BFF8"])) {
        if(self.pers["_encstr_91FF1555B52BABE824FFC8E8134A01CD421D45D586A027"] > 300)
          self.pers["_encstr_8D0C13FAB3EED8345297D2E0FF98D789E9BE07BFF8"] = 1;

        continue;
      }

      var_14 = _id_1331C();

      if(var_14) {
        var_15 = scripts\mp\persistence::statgetchildbuffered("_encstr_8C4606C9DBD5CD46", "_encstr_881A0B47B4B6B2286316E59532", 0);

        if(var_15 - self.pers["_encstr_A7350D98707F9B79A37F4B04F34D27"] > 240) {
          self.pers["_encstr_A7350D98707F9B79A37F4B04F34D27"] = var_15;
          self.pers["_encstr_8D0C13FAB3EED8345297D2E0FF98D789E9BE07BFF8"] = undefined;
          self.pers["_encstr_91FF1555B52BABE824FFC8E8134A01CD421D45D586A027"] = undefined;
        }
      }
    }
  }
}

initleanplayerstats() {
  if(!isDefined(self.pers["_encstr_8E0607055DBFB3919A"])) {
    scripts\mp\utility\stats::initpersstat("_encstr_8E0607055DBFB3919A");
    scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_8E0607055DBFB3919A", 0);
  }

  self.deaths = scripts\mp\utility\stats::getpersstat("_encstr_8E0607055DBFB3919A");
  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_8E0607055DBFB3919A");

  if(!isDefined(self.pers["_encstr_82FB06EB26785BD7"])) {
    scripts\mp\utility\stats::initpersstat("_encstr_82FB06EB26785BD7");
    scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_82FB06EB26785BD7", 0);
  }

  self.score = scripts\mp\utility\stats::getpersstat("_encstr_82FB06EB26785BD7");
  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_82FB06EB26785BD7");

  if(!isDefined(self.pers["_encstr_8E8D0697EB01F243"])) {
    scripts\mp\utility\stats::initpersstat("_encstr_8E8D0697EB01F243");
    scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_8E8D0697EB01F243", 0);
  }

  self.kills = scripts\mp\utility\stats::getpersstat("_encstr_8E8D0697EB01F243");
  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_8E8D0697EB01F243");
}

initplayerstats() {
  scripts\mp\playerstats::initplayer();
  scripts\mp\persistence::initbufferedstats();

  if(!isDefined(self.watchvehicleingas))
    self.watchvehicleingas = [];

  initleanplayerstats();

  if(!isDefined(self.pers["_encstr_A68209DFE7B79AEC5BF76E"]))
    scripts\mp\utility\stats::initpersstat("_encstr_A68209DFE7B79AEC5BF76E");

  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_A68209DFE7B79AEC5BF76E");

  if(!isDefined(self.pers["_encstr_96D30A3468575BA3C307A128"]))
    scripts\mp\utility\stats::initpersstat("_encstr_96D30A3468575BA3C307A128");

  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_96D30A3468575BA3C307A128");

  if(!isDefined(self.pers["_encstr_82B30BB521F80E0FE5C81A1293"]))
    scripts\mp\utility\stats::initpersstat("_encstr_82B30BB521F80E0FE5C81A1293");

  if(!isDefined(self.pers["_encstr_A1F308589BCD96CD476E"])) {
    scripts\mp\utility\stats::initpersstat("_encstr_A1F308589BCD96CD476E");
    scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_A1F308589BCD96CD476E", 0);
  }

  self.assists = scripts\mp\utility\stats::getpersstat("_encstr_A1F308589BCD96CD476E");
  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_A1F308589BCD96CD476E");

  if(!isDefined(self.pers["_encstr_81CF0936850ED1D54EACCD"])) {
    scripts\mp\utility\stats::initpersstat("_encstr_81CF0936850ED1D54EACCD");
    scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_81CF0936850ED1D54EACCD", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_81CF0936850ED1D54EACCD");

  if(!isDefined(self.pers["_encstr_A9F70806677BD37B5EE7"])) {
    scripts\mp\utility\stats::initpersstat("_encstr_A9F70806677BD37B5EE7");
    scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_A9F70806677BD37B5EE7", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_A9F70806677BD37B5EE7");

  if(!isDefined(self.pers["_encstr_B1F7085B03F492AE98DB"])) {
    scripts\mp\utility\stats::initpersstat("_encstr_B1F7085B03F492AE98DB");
    scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_B1F7085B03F492AE98DB", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_B1F7085B03F492AE98DB");

  if(!isDefined(self.pers["_encstr_8FB00783D8C2CDE8DC"])) {
    scripts\mp\utility\stats::initpersstat("_encstr_8FB00783D8C2CDE8DC");
    scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_8FB00783D8C2CDE8DC", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_8FB00783D8C2CDE8DC");

  if(!isDefined(self.pers["_encstr_817B0812789D1387E986"])) {
    scripts\mp\utility\stats::initpersstat("_encstr_817B0812789D1387E986");
    scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_817B0812789D1387E986", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_817B0812789D1387E986");

  if(!isDefined(self.pers["_encstr_8B460D8A6176034A70279C992770D2"])) {
    scripts\mp\utility\stats::initpersstat("_encstr_8B460D8A6176034A70279C992770D2");
    scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_8B460D8A6176034A70279C992770D2", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_8B460D8A6176034A70279C992770D2");

  if(!isDefined(self.pers["_encstr_820E0A2AE8981DBA528588DC"])) {
    scripts\mp\utility\stats::initpersstat("_encstr_820E0A2AE8981DBA528588DC");
    scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_820E0A2AE8981DBA528588DC", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_820E0A2AE8981DBA528588DC");

  if(!isDefined(self.pers["_encstr_B64E070F391562989D"])) {
    scripts\mp\utility\stats::initpersstat("_encstr_B64E070F391562989D");
    scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_B64E070F391562989D", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_B64E070F391562989D");

  if(!isDefined(self.pers["_encstr_8294083A0938C3CB2577"])) {
    scripts\mp\utility\stats::initpersstat("_encstr_8294083A0938C3CB2577");
    scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_8294083A0938C3CB2577", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_8294083A0938C3CB2577");

  if(!isDefined(self.pers["_encstr_95F70BD1EDBA1B1A46DBBB376E"])) {
    scripts\mp\utility\stats::initpersstat("_encstr_95F70BD1EDBA1B1A46DBBB376E");
    scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_95F70BD1EDBA1B1A46DBBB376E", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_95F70BD1EDBA1B1A46DBBB376E");

  if(!isDefined(self.pers["_encstr_8B980B9996591B19D9DE168D9B"])) {
    scripts\mp\utility\stats::initpersstat("_encstr_8B980B9996591B19D9DE168D9B");
    scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_8B980B9996591B19D9DE168D9B", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_8B980B9996591B19D9DE168D9B");

  if(!isDefined(self.pers["_encstr_8B560B62B16B5067FCFAB88833"])) {
    scripts\mp\utility\stats::initpersstat("_encstr_8B560B62B16B5067FCFAB88833");
    scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_8B560B62B16B5067FCFAB88833", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_8B560B62B16B5067FCFAB88833");

  if(!isDefined(self.pers["_encstr_ABEC10F2089925F71D967B552EC3A76B3748"])) {
    scripts\mp\utility\stats::initpersstat("_encstr_ABEC10F2089925F71D967B552EC3A76B3748");
    scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_ABEC10F2089925F71D967B552EC3A76B3748", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_ABEC10F2089925F71D967B552EC3A76B3748");

  if(!isDefined(self.pers["_encstr_B270105CA8E0EC4BD7974FDB95FD724C2B91"])) {
    scripts\mp\utility\stats::initpersstat("_encstr_B270105CA8E0EC4BD7974FDB95FD724C2B91");
    scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_B270105CA8E0EC4BD7974FDB95FD724C2B91", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_B270105CA8E0EC4BD7974FDB95FD724C2B91");

  if(!isDefined(self.pers["_encstr_AA9C0A1555B798EF648228C8"]))
    scripts\mp\utility\stats::initpersstat("_encstr_AA9C0A1555B798EF648228C8");

  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_AA9C0A1555B798EF648228C8");

  if(!isDefined(self.pers["_encstr_8A220C2BC3474E0BB9B17B9CB203"]))
    scripts\mp\utility\stats::initpersstat("_encstr_8A220C2BC3474E0BB9B17B9CB203");

  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_8A220C2BC3474E0BB9B17B9CB203");

  if(!isDefined(self.pers["_encstr_84220CB23C8E9CC2CD36DB27AC4C"]))
    scripts\mp\utility\stats::initpersstat("_encstr_84220CB23C8E9CC2CD36DB27AC4C");

  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_84220CB23C8E9CC2CD36DB27AC4C");

  if(!isDefined(self.pers["_encstr_AAAD06703BB2590B"])) {
    scripts\mp\utility\stats::initpersstat("_encstr_AAAD06703BB2590B");
    scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_AAAD06703BB2590B", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_AAAD06703BB2590B");

  if(!isDefined(self.pers["_encstr_AD7F0937568E890B1B6D37"])) {
    scripts\mp\utility\stats::initpersstat("_encstr_AD7F0937568E890B1B6D37");
    scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_AD7F0937568E890B1B6D37", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_AD7F0937568E890B1B6D37");

  if(!isDefined(self.pers["_encstr_ACF5089FF6827199725B"])) {
    scripts\mp\utility\stats::initpersstat("_encstr_ACF5089FF6827199725B");
    scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_ACF5089FF6827199725B", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_ACF5089FF6827199725B");

  if(!isDefined(self.pers["_encstr_A7E80EB868982F22383F6F4FD680F85D"])) {
    scripts\mp\utility\stats::initpersstat("_encstr_A7E80EB868982F22383F6F4FD680F85D");
    scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_A7E80EB868982F22383F6F4FD680F85D", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_A7E80EB868982F22383F6F4FD680F85D");

  if(!isDefined(self.pers["_encstr_B2BE0788BAF573592F"])) {
    scripts\mp\utility\stats::initpersstat("_encstr_B2BE0788BAF573592F");
    scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_B2BE0788BAF573592F", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_B2BE0788BAF573592F");

  if(!isDefined(self.pers["_encstr_8CA50D83B05BC18A16EDD8153E88E8"]))
    scripts\mp\utility\stats::initpersstat("_encstr_8CA50D83B05BC18A16EDD8153E88E8");

  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_8CA50D83B05BC18A16EDD8153E88E8");

  if(!isDefined(self.pers["_encstr_A9AB06297DDFD816"])) {
    scripts\mp\utility\stats::initpersstat("_encstr_A9AB06297DDFD816");
    scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_A9AB06297DDFD816", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_A9AB06297DDFD816");

  if(!isDefined(self.pers["_encstr_A77D0ABAF0559B4B51C6041B"])) {
    scripts\mp\utility\stats::initpersstat("_encstr_A77D0ABAF0559B4B51C6041B");
    scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_A77D0ABAF0559B4B51C6041B", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_A77D0ABAF0559B4B51C6041B");

  if(!isDefined(self.pers["_encstr_A9F6058464DADF"]))
    scripts\mp\utility\stats::initpersstat("_encstr_A9F6058464DADF");

  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_A9F6058464DADF");

  if(!isDefined(self.pers["_encstr_ADF208A8B778CDD39BAF"]))
    scripts\mp\utility\stats::initpersstat("_encstr_ADF208A8B778CDD39BAF");

  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_ADF208A8B778CDD39BAF");

  if(!isDefined(self.pers["_encstr_82190715F52B81894E"]))
    scripts\mp\utility\stats::initpersstat("_encstr_82190715F52B81894E");

  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_82190715F52B81894E");

  if(!isDefined(self.pers["_encstr_A1AB0EAD3FC881A8AD18838F9C6F13D1"]))
    scripts\mp\utility\stats::initpersstat("_encstr_A1AB0EAD3FC881A8AD18838F9C6F13D1");

  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_A1AB0EAD3FC881A8AD18838F9C6F13D1");

  if(!isDefined(self.pers["_encstr_95B80C17DA7BF867C7ED6BC84D94"]))
    scripts\mp\utility\stats::initpersstat("_encstr_95B80C17DA7BF867C7ED6BC84D94");

  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_95B80C17DA7BF867C7ED6BC84D94");

  if(!isDefined(self.pers["_encstr_B49005512AF703"]))
    scripts\mp\utility\stats::initpersstat("_encstr_B49005512AF703");

  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_B49005512AF703");

  if(!isDefined(self.pers["_encstr_8CED0F31BD8EB86A6F0230BFFB1B231064"]))
    self.pers["_encstr_8CED0F31BD8EB86A6F0230BFFB1B231064"] = 0;

  scripts\mp\utility\stats::initpersstat("_encstr_87F20E78EA85EF89E7449E053AC771BF");
  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_87F20E78EA85EF89E7449E053AC771BF");
  self.pers["_encstr_8CAA06DB20A31543"] = scripts\mp\utility\game::getgametypenumlives();
  scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_85CE0B9770B02C71A1760F06D2", 0);
  scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_8CAD05DB100303", 0);
  scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_91190447C232", 0);
  scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_A9EE0FD2365AB32DD275DBD5CCE4C027A1", "_encstr_8BBA05185F8B99");
  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_85CE0B9770B02C71A1760F06D2");
  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_8CAD05DB100303");
  scripts\mp\utility\stats::timedrun_finishlinevfx("_encstr_91190447C232");
}

addtoteamcount(var_0) {
  thread scripts\mp\utility\teams::addplayertoteam(self, self.team, var_0);
  [[level.updategameevents]]();
}

removefromteamcount() {
  scripts\mp\utility\teams::removeplayerfromteam(self, self.team);
}

addtoalivecount(var_0) {
  var_1 = self.team;

  if(!(isDefined(self.alreadyaddedtoalivecount) && self.alreadyaddedtoalivecount)) {
    scripts\mp\utility\teams::modifyteamdata(var_1, "_encstr_A1310B432F9BDEFBEF4393B0F1", 1);
    incrementalivecount(var_1, 0, var_0);
  }

  self.alreadyaddedtoalivecount = undefined;
  var_2 = 0;

  foreach(var_4 in level.teamnamelist)
  var_2 = var_2 + scripts\mp\utility\teams::getteamdata(var_4, "_encstr_8A2A0B936CCCC3078547970A8B");

  if(var_2 > level.maxplayercount)
    level.maxplayercount = var_2;
}

incrementalivecount(var_0, var_1, var_2) {
  scripts\mp\utility\teams::addtoteamlives(self, var_0, var_1, var_2);
  [[level.updategameevents]]();
}

removefromalivecount(var_0, var_1) {
  var_2 = self.pers["_encstr_8CAA06DB20A31543"];
  var_3 = scripts\mp\utility\game::getgametypenumlives() != 0 && var_2 == 0 && !istrue(level._id_133DF);
  self notify("_encstr_9AFB18534AAFA0A05757CD1D9FBD217F73226B3971FFE8E0AD54");
  var_4 = self.team;

  if(isDefined(self.switching_teams) && self.switching_teams && isDefined(self.joining_team) && self.joining_team == self.team)
    var_4 = self.leaving_team;

  if(isDefined(var_0))
    removeallfromlivescount();
  else if(isDefined(self.switching_teams)) {
    if(!level.ingraceperiod || self.hasdonecombat) {
      scripts\mp\utility\teams::modifyteamdata(var_4, "_encstr_A1310B432F9BDEFBEF4393B0F1", -1);

      if(var_2)
        self.pers["_encstr_8CAA06DB20A31543"]--;
    }
  }

  decrementalivecount(var_4, var_3, var_1);
}

decrementalivecount(var_0, var_1, var_2) {
  scripts\mp\utility\teams::removefromteamlives(self, var_0, var_1, var_2);
  [[level.updategameevents]]();
}

addtolivescount() {
  scripts\mp\utility\teams::modifyteamdata(self.team, "_encstr_B8DF0B365AD9593734B7D5DC1D", self.pers["_encstr_8CAA06DB20A31543"]);
}

removefromlivescount() {
  scripts\mp\utility\teams::setteamdata(self.team, "_encstr_B8DF0B365AD9593734B7D5DC1D", int(max(0, scripts\mp\utility\teams::getteamdata(self.team, "_encstr_B8DF0B365AD9593734B7D5DC1D") - 1)));
}

removeallfromlivescount() {
  scripts\mp\utility\teams::setteamdata(self.team, "_encstr_B8DF0B365AD9593734B7D5DC1D", int(max(0, scripts\mp\utility\teams::getteamdata(self.team, "_encstr_B8DF0B365AD9593734B7D5DC1D") - self.pers["_encstr_8CAA06DB20A31543"])));
}

resetuiomnvarscommon() {
  if(isDefined(level.resetuiomnvargamemode))
    [[level.resetuiomnvargamemode]]();

  self setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 0);
  self setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
  self setclientomnvar("_encstr_ADFC0EEB491FDE8F28B12E6FAE1160AC", -1);
  self setclientomnvar("_encstr_AC4D1C4FD076CB3271996EE6716F8A8679F9A78750C8315B4B26755DED1F", 0);
  self setclientomnvar("_encstr_8F090D605A191B594785485C94BFE3", 0);
  self setclientomnvar("_encstr_A74C2765C3E9CED3AFE89A62B1E8DB856BBDD7EC7BD0972B58A1C27ABED92FBDA033734587181D3B76", 0);
  self setclientomnvar("_encstr_A24213BAA57D63B466CAEBB5B41BD8BED8DEBA731D", 0);
  self setclientomnvar("_encstr_99FC106B18C9591B88F99FDFE146B389A841", 0);
}

resetuidvarsonconnect() {
  resetuiomnvarscommon();
  self setclientdvar("_encstr_823F1C033AD71568C7EB2F57EEA14068C3B19808D2B35B409FD3475D0C92", 0);
  self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", -1);
  self setclientomnvar("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", 0);

  if(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    self setclientomnvar("_encstr_82231507E01F6D82E3468271C14A010815DFEFFDB550B7", 1);
  else
    self setclientomnvar("_encstr_82231507E01F6D82E3468271C14A010815DFEFFDB550B7", 0);
}

resetuidvarsonspectate() {
  resetuiomnvarscommon();
  self setclientdvar("_encstr_823F1C033AD71568C7EB2F57EEA14068C3B19808D2B35B409FD3475D0C92", 0);
}

clearpinnedobjectives() {
  if(isbot(self)) {
    return;
  }
  if(isDefined(level.objectives)) {
    foreach(var_1 in level.objectives) {
      if(isDefined(var_1.objidnum))
        scripts\mp\objidpoolmanager::objective_unpin_player(var_1.objidnum, self, var_1.showoncompass);
    }
  }

  if(isDefined(level.uncapturableobjectives)) {
    foreach(var_1 in level.uncapturableobjectives) {
      if(isDefined(var_1.objidnum))
        scripts\mp\objidpoolmanager::objective_unpin_player(var_1.objidnum, self, var_1.showoncompass);
    }
  }
}

watchtargethealth() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self.targethealthinfo = [];

  for(;;) {
    var_0 = (self.origin[0], self.origin[1], self.origin[2] + 64);
    var_1 = self getplayerangles();
    var_2 = anglesToForward(var_1);
    var_3 = var_0 + var_2 * 10000;
    var_4 = scripts\engine\trace::_bullet_trace(var_0, var_3, 1, self, 0, 0, 0, 0, 0);
    var_5 = var_4["_encstr_850E077B0BF30318B9"];

    if(isDefined(var_5) && isPlayer(var_5) && var_5.team != self.team) {
      if(isDefined(var_5))
        updatetargethealthvariable("_encstr_B66B11AE2D7D3A2C27762B477DD02B0BC61DD0", var_5.health);

      if(isDefined(var_5))
        updatetargethealthvariable("_encstr_B19C155DD2BE1D0BE49D951D7D6B16E1AF43B2851B1D34", var_5.maxhealth);

      if(isDefined(var_5))
        updatetargethealthvariable("_encstr_8DAB154BF8E10D8F036F05536F28C061BAE34259A6F590", var_5 getentitynumber());
    } else
      updatetargethealthvariable("_encstr_8DAB154BF8E10D8F036F05536F28C061BAE34259A6F590", -1);

    wait 0.1;
  }
}

updatetargethealthvariable(var_0, var_1) {
  waitframe();

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(self.targethealthinfo[var_0]) || var_1 != self.targethealthinfo[var_0]) {
    self setclientomnvar(var_0, var_1);
    self.targethealthinfo[var_0] = var_1;
  }
}

showgamemodeobjectivetext() {
  if(self.hasspawned) {
    return;
  }
  if(!showmatchhint()) {
    return;
  }
  if(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    return;
  }
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  wait 1.0;

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.pers["_encstr_8AEF05472BC2D6"])) {
    return;
  }
  var_0 = self.pers["_encstr_8AEF05472BC2D6"];
  var_1 = scripts\mp\utility\game::getobjectivehinttext(var_0);

  if(isDefined(var_1)) {
    var_2 = 0;

    if(game["_encstr_B6A70A23CA6659DC91CAE4DC"] == var_0)
      var_2 = 1;

    self setclientomnvar("_encstr_BAE912ED0CA18F0122D720908F56B9B7BBB7E3F5", var_2);
    wait 6;
    self setclientomnvar("_encstr_BAE912ED0CA18F0122D720908F56B9B7BBB7E3F5", -1);
  }
}

showmatchhint() {
  var_0 = scripts\mp\utility\game::getgametype();

  switch (var_0) {
    case "_encstr_A9B606B0C956B916":
      if(isDefined(game["_encstr_8DC30DAA0285FD69FAE113371B1934"]) && game["_encstr_8DC30DAA0285FD69FAE113371B1934"] > 0)
        return 0;

      break;
    default:
      break;
  }

  return 1;
}

trydisableminimap() {
  if(scripts\mp\utility\player::alwaysshowminimap() || scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
    return;
  }
  if(!istrue(self.showuavminimaponspawn) && !scripts\mp\utility\perk::_hasperk("_encstr_AAB419B907596CB4C2D81D2FAF168DDD58E59BBED62DB92DADC207"))
    scripts\mp\utility\player::hideminimap(1);

  self.showuavminimaponspawn = 0;
}

initinputtypewatcher() {
  self.gamepadwasenabled = scripts\engine\utility::is_player_gamepad_enabled();
}

updateinputtypewatcher() {
  var_0 = scripts\engine\utility::is_player_gamepad_enabled();

  if(self.gamepadwasenabled != var_0) {
    self notify("_encstr_AA63132DE6C1ABA37D1DF2C159D7C6430BCD3BB223", var_0);
    self.gamepadwasenabled = var_0;
  }
}

updateplayerwindmaterial() {
  var_0 = 100;
  var_1 = 700;
  var_2 = var_1 - var_0;
  var_3 = 0;
  var_4 = 10;

  for(;;) {
    foreach(var_6 in level.players) {
      if(!isDefined(var_6)) {
        continue;
      }
      if(!scripts\mp\utility\player::isreallyalive(var_6)) {
        continue;
      }
      if(istrue(var_6.manualoverridewindmaterial)) {
        continue;
      }
      if(isDefined(var_6.vehicle))
        var_7 = clamp(length(var_6.vehicle vehicle_getvelocity()), var_0, var_1);
      else
        var_7 = clamp(length(var_6 getvelocity()), var_0, var_1);

      var_8 = (var_7 - var_0) / var_2;
      var_8 = var_8 * 10;
      var_8 = int(var_8);

      if(!isDefined(var_6._id_145C6) || var_6._id_145C6 != var_8) {
        switch (var_8) {
          case 0:
            var_6 setscriptablepartstate("_encstr_BDF6055F93E8B3", "_encstr_934C0218", 0);
            break;
          case 1:
            var_6 setscriptablepartstate("_encstr_BDF6055F93E8B3", "_encstr_AF0703133A", 0);
            break;
          case 2:
            var_6 setscriptablepartstate("_encstr_BDF6055F93E8B3", "_encstr_990703B2F9", 0);
            break;
          case 3:
            var_6 setscriptablepartstate("_encstr_BDF6055F93E8B3", "_encstr_8D070366C0", 0);
            break;
          case 4:
            var_6 setscriptablepartstate("_encstr_BDF6055F93E8B3", "_encstr_AA07038618", 0);
            break;
          case 5:
            var_6 setscriptablepartstate("_encstr_BDF6055F93E8B3", "_encstr_82070322E1", 0);
            break;
          case 6:
            var_6 setscriptablepartstate("_encstr_BDF6055F93E8B3", "_encstr_B107031B8F", 0);
            break;
          case 7:
            var_6 setscriptablepartstate("_encstr_BDF6055F93E8B3", "_encstr_B20703B767", 0);
            break;
          case 8:
            var_6 setscriptablepartstate("_encstr_BDF6055F93E8B3", "_encstr_840703171A", 0);
            break;
          case 9:
            var_6 setscriptablepartstate("_encstr_BDF6055F93E8B3", "_encstr_810703AF78", 0);
            break;
          case 10:
            var_6 setscriptablepartstate("_encstr_BDF6055F93E8B3", "_encstr_9A1804890618", 0);
            break;
        }
      }

      var_6._id_145C6 = var_8;
      var_3++;

      if(var_3 == var_4) {
        waitframe();
        var_3 = 0;
      }
    }

    wait 0.1;
  }
}

_id_1331C() {
  if(isDefined(level._id_1331D))
    return [[level._id_1331D]]();

  return 1;
}