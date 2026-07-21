/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\spectating.gsc
***********************************************/

init() {
  foreach(var_1 in level.teamnamelist)
  level.spectateoverride[var_1] = spawnStruct();

  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::freecamcallback);
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(::onjoinedteam);

  if(getdvarint("_encstr_A1440B18AD58231CE2EB0139DF", 0) != 0)
    level thread getlevelmlgcams();
}

createmlgcamobject(var_0, var_1) {
  precacheshader(var_0);
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
  var_2 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_2.angles = (0, 0, 0);
  return var_2;
}

setlevelmlgcam(var_0, var_1) {
  var_2 = var_0;

  if(var_2 >= 4)
    var_2 = var_2 - 4;

  var_3 = tolower(getDvar("_encstr_9570084B1793A090CDFF"));
  var_4 = tablelookup(var_1, 0, var_3, var_2 * 2 + 1);

  if(var_4 != "_encstr_B40101") {
    var_5 = var_0 + 1;

    if(var_0 >= 5)
      var_5 = var_5 - 4;

    level.cameramapobjs[var_0] = createmlgcamobject("_encstr_ACF71BB7CFA24F70F35A66B846C7C010FA67213F8F2B15682AB9E9B1ED", 1);
    level.numbermapobjs[var_0] = createmlgcamobject("_encstr_AAF71B7640C0D8B2267FEF2F47C08A3F48A82FFE3998848AFE0F2357B3" + var_5, 0);
    var_6 = tablelookup(var_1, 0, var_3, var_2 * 2 + 2);
    level.camerapos[var_0] = getcameravecorang(var_4);
    level.cameraang[var_0] = getcameravecorang(var_6);
    level.camerahighestindex = var_0;
  }
}

getlevelmlgcams() {
  while(!isDefined(level.objectiveidpool))
    waitframe();

  var_0 = "_encstr_8284135B8397D0165BB2E40B287BE6B447D2DBE69B";
  var_1 = var_0 + "_encstr_BA4C02DF" + scripts\mp\utility\game::getgametype() + "_encstr_96A70506895E33";
  var_0 = var_0 + "_encstr_96A70506895E33";
  level.cameramapobjs = [];
  level.numbermapobjs = [];

  for(var_2 = 0; var_2 < 4; var_2++)
    setlevelmlgcam(var_2, var_0);

  for(var_2 = 4; var_2 < 8; var_2++)
    setlevelmlgcam(var_2, var_1);
}

getcameravecorang(var_0) {
  var_1 = strtok(var_0, "_encstr_974C0246");
  var_2 = (0, 0, 0);

  if(isDefined(var_1[0]) && isDefined(var_1[1]) && isDefined(var_1[2]))
    var_2 = (int(var_1[0]), int(var_1[1]), int(var_1[2]));

  return var_2;
}

onjoinedteam(var_0) {
  var_0 setspectatepermissions();
}

onjoinedspectators(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0 thread onspectatingclient();
  var_0 thread onspectatingmlgcamera();
  var_0 setspectatepermissions();
  var_0 setclientomnvar("_encstr_850913EFEB98025148A8C54B83F999CB6D13BF1769", -1);

  if(var_0 ismlgspectator() || isDefined(var_0.pers["_encstr_AFCE0DB6D89DA607956C1D853ADE27"]) && var_0.pers["_encstr_AFCE0DB6D89DA607956C1D853ADE27"]) {
    var_0 setmlgspectator(1);
    var_0 setmlgfollowdroneactive(0);
    var_0 thread updatemlgspectator();
    var_0 thread autoattachtoplayer();
    var_0 thread _id_12EB1();
  }
}

onspectatingclient() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");

  for(;;) {
    self waittill("_encstr_95C0114B0F99BF33EB808AF230BF2E0FB1F9A5");
    var_0 = self getspectatingplayer();

    if(isDefined(var_0)) {
      if(isDefined(var_0.calloutarea)) {
        var_1 = level.calloutglobals.areaidmap[var_0.calloutarea];
        self setclientomnvar("_encstr_850913EFEB98025148A8C54B83F999CB6D13BF1769", var_1);
      }
    }
  }
}

onspectatingmlgcamera() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");

  for(;;) {
    self waittill("_encstr_A6EF16C750471B2D974B2830829769B01FE76F5BE52FF0FF");
    var_0 = self getmlgselectedcamera();

    if(self ismlgspectator() || isDefined(self.pers["_encstr_AFCE0DB6D89DA607956C1D853ADE27"]) && self.pers["_encstr_AFCE0DB6D89DA607956C1D853ADE27"]) {
      if(isDefined(var_0)) {
        self setclientomnvar("_encstr_850913EFEB98025148A8C54B83F999CB6D13BF1769", -1);
        continue;
      }
    }
  }
}

freecamcallback(var_0, var_1) {
  if(var_0 == "_encstr_A9B710B6B1767D675ACADDFAC60DC23776CA")
    scripts\mp\playerlogic::resetuidvarsonspectate();
}

updatespectatesettings() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(var_0 = 0; var_0 < level.players.size; var_0++)
    level.players[var_0] setspectatepermissions();
}

linkcameratoball(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");

  for(;;) {
    if(!isDefined(self.codcasterballcamfollow)) {
      break;
    }

    if(self isspectatingplayer()) {
      waitframe();
      continue;
    }

    self cameralinkTo(self.codcasterballcamfollow, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1);
    var_1 = level.codcasterball.origin;
    var_2 = (0, 0, 30);
    var_2 = var_2 + -80 * var_0;
    var_3 = var_1 + var_2;
    self.codcasterballcamfollow moveTo(var_3, 10.5, 5.2, 5.2);
    self.codcasterballcamfollow.angles = vectortoangles(var_0);
    break;
  }
}

autoattachtoplayer() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_A6EF16C750471B2D974B2830829769B01FE76F5BE52FF0FF");
  level scripts\engine\utility::_id_143A6("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B", "_encstr_8F55118F8B711B6436974A09E1173783D313D9", "_encstr_8C0D0E8410E8B112602F133F559DCAF4");
  level.wasflagspawned = game["_encstr_A98714A0D21A21A713BD6EDD912BA9D90AEA30800AF2"];

  for(;;) {
    var_0 = undefined;

    if(!self ismlgspectator() || self isspectatingplayer() || self enablereloading() || self useinvisibleplayerduringspawnselection()) {
      break;
    }

    if(level.players.size > 1) {
      if(level.currentround > 1 && isDefined(level.wasflagspawned) && self.team != "_encstr_933E090A10B17DDFB3E522")
        var_0 = level.wasflagspawned;
      else if(self.team == "_encstr_933E090A10B17DDFB3E522") {
        var_1 = self updatecurrentweapon();
        var_2 = 0;

        foreach(var_4 in level.players) {
          if(var_4 scripts\cp_mp\utility\player_utility::_isalive()) {
            if(var_4 getentitynumber() == var_1) {
              if(var_4.team == "_encstr_AF8C0A1B6A1D6045925B4F7D" || var_4.team == "_encstr_933E090A10B17DDFB3E522")
                var_2 = 1;
              else
                var_0 = var_1;

              break;
            }
          }
        }

        if(var_2) {
          break;
        }
      } else {
        foreach(var_7 in level.teamnamelist) {
          var_8 = scripts\mp\utility\teams::getfriendlyplayers(var_7, 1);

          if(var_8.size > 0)
            var_0 = scripts\mp\utility\player::getlowestclientnum(var_8, 1);
        }
      }

      if(isDefined(var_0)) {
        self spectateclientnum(var_0);
        break;
      }
    }

    wait 1.0;
  }
}

updatemlgspectator() {
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.iswatchingcodcasterball = 0;
  self.codcasterballcamfollow = undefined;
  self.spectatingplayerbeforeballcam = undefined;

  for(;;) {
    if(self ismlgspectator() && self isspectatingplayer()) {
      var_0 = self getspectatingplayer();

      if(isDefined(var_0))
        level.wasflagspawned = var_0.clientid;
    }

    var_1 = isDefined(level.codcasterball);

    if(!var_1 || !self ismlgfollowdroneactive()) {
      if(self.iswatchingcodcasterball) {
        self.iswatchingcodcasterball = 0;
        self.codcasterballcamfollow unlink();
        self.codcasterballcamfollow delete();
        self.codcasterballcamfollow = undefined;

        if(!self isspectatingplayer() && isDefined(self.spectatingplayerbeforeballcam))
          self spectateclientnum(self.spectatingplayerbeforeballcam getentitynumber());
        else
          self cameraunlink();

        self.spectatingplayerbeforeballcam = undefined;
      }
    } else if(!self.iswatchingcodcasterball) {
      if(self ismlgfollowdroneactive()) {
        var_0 = self getspectatingplayer();

        if(isDefined(var_0) && isDefined(level.codcasterballowner) && var_0 == level.codcasterballowner) {
          self.iswatchingcodcasterball = 1;
          self.spectatingplayerbeforeballcam = var_0;
          var_2 = vectorNormalize(level.codcasterballinitialforcevector);
          var_3 = var_0 getvieworigin();
          self.codcasterballcamfollow = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3);
          self.codcasterballcamfollow.angles = vectortoangles(var_2);
          self.codcasterballcamfollow setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
          stopspectateplayer(self getentitynumber());
          self cameraunlink();
          thread linkcameratoball(var_2);
        }
      }
    } else if(isDefined(self.codcasterballcamfollow)) {
      var_4 = level.codcasterball.origin;
      var_5 = self.codcasterballcamfollow.origin;
      var_6 = distance2d(var_4, var_5);
      var_7 = var_4 - var_5;
      var_8 = (var_7[0], var_7[1], 0);
      var_8 = vectorNormalize(var_8);
      var_9 = var_4;
      var_10 = (0, 0, 30);
      var_10 = var_10 + -80 * var_8;
      var_11 = var_9 + var_10;

      if(var_6 > 600)
        self.codcasterballcamfollow.origin = var_11;
      else
        self.codcasterballcamfollow moveTo(var_11, 0.5, 0, 0.2);

      self.codcasterballcamfollow rotateTo(vectortoangles(var_7), 0.15, 0.05, 0.05);
    }

    wait 0.05;
  }
}

_id_12EB1() {
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  game["_encstr_A98714A0D21A21A713BD6EDD912BA9D90AEA30800AF2"] = level.wasflagspawned;
}

setspectatepermissions(var_0) {
  if(level.gameended && gettime() - level.gameendtime >= 2000 && !istrue(level.postgameexfil)) {
    if(level.teambased) {
      foreach(var_2 in level.teamnamelist)
      self allowspectateteam(var_2, 0);
    }

    self allowspectateteam("_encstr_818709A35AE71A38D792CF", 0);
    self allowspectateteam("_encstr_8BBA05185F8B99", 1);
    return;
  }

  var_4 = scripts\mp\tweakables::gettweakablevalue("_encstr_B472054FE12550", "_encstr_813D0DBF280F4875CF0391BBBBE3A5");

  if(getdvarint("_encstr_8D9B112D074310378FF7141FC16538FB931B25", 0) == 1)
    var_4 = 2;

  if(self ismlgspectator())
    var_4 = 2;

  if(istrue(self.inspawncamera))
    var_4 = 0;

  if(istrue(var_0))
    var_4 = 2;

  var_5 = self.sessionteam;

  switch (var_4) {
    case 0:
      setdisabled();
      break;
    case 1:
      self notify("_encstr_9BED19B39B7BE46F7D36BF0F613DD18B6E22287932C561938BA1B1");

      if(var_5 != "_encstr_AF8C0A1B6A1D6045925B4F7D" && var_5 != "_encstr_933E090A10B17DDFB3E522")
        setteamorplayeronly(var_5);
      else if(isDefined(self.pers["_encstr_82AE0ABC1348CBA7E549FA22"])) {
        var_5 = self.pers["_encstr_82AE0ABC1348CBA7E549FA22"];
        setteamorplayeronly(var_5);
      } else if(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
        var_6 = randomint(level.teamnamelist.size);
        setteamorplayeronly(level.teamnamelist[var_6]);
      } else {
        setteamorplayeronly("_encstr_9A8507BA4040188D08");
        thread waitforgamestartspectate();
        return;
      }

      break;
    case 2:
      setfreelook(var_0);
      break;
    case 3:
      if(var_5 == "_encstr_AF8C0A1B6A1D6045925B4F7D" || var_5 == "_encstr_933E090A10B17DDFB3E522")
        setfreelook();
      else
        setteamorplayeronly(var_5);

      break;
  }

  if(isDefined(var_5) && scripts\mp\utility\teams::isgameplayteam(var_5)) {
    if(istrue(level.spectateoverride[var_5].allowfreespectate))
      self allowspectateteam("_encstr_818709A35AE71A38D792CF", 1);

    if(istrue(level.spectateoverride[var_5].allowenemyspectate)) {
      var_7 = scripts\mp\utility\teams::getenemyteams(var_5);

      foreach(var_2 in var_7)
      self allowspectateteam(var_2, 1);
    }
  }
}

waitforgamestartspectate() {
  self endon("_encstr_9BED19B39B7BE46F7D36BF0F613DD18B6E22287932C561938BA1B1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level waittill("_encstr_8FF80EBBE8D1ED92613E8C49105DEABA");
  thread setspectatepermissions();
}

setdisabled() {
  self allowspectateteam("_encstr_818709A35AE71A38D792CF", 0);
  self allowspectateteam("_encstr_8BBA05185F8B99", 0);

  foreach(var_1 in level.teamnamelist)
  self allowspectateteam(var_1, 0);
}

setteamorplayeronly(var_0) {
  self allowspectateteam("_encstr_818709A35AE71A38D792CF", 0);

  if(level.teambased) {
    self allowspectateteam("_encstr_8BBA05185F8B99", 0);

    foreach(var_2 in level.teamnamelist) {
      if(var_0 == var_2) {
        self allowspectateteam(var_2, 1);
        continue;
      }

      self allowspectateteam(var_2, 0);
    }
  } else {
    self allowspectateteam("_encstr_8BBA05185F8B99", 1);

    foreach(var_2 in level.teamnamelist)
    self allowspectateteam(var_2, 1);
  }
}

setfreelook(var_0) {
  self allowspectateteam("_encstr_818709A35AE71A38D792CF", 1);
  self allowspectateteam("_encstr_8BBA05185F8B99", 1);

  if(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    foreach(var_2 in level.teamnamelist)
    self allowspectateteam(var_2, 1);

    if(istrue(var_0)) {
      thread scripts\mp\playerlogic::spawnspectator(undefined, undefined, 1);
      return;
    }
  } else if(self ismlgspectator()) {
    self allowspectateteam("_encstr_9A8507BA4040188D08", 1);
    self allowspectateteam("_encstr_8E8405EA382B2A", 1);
    thread waitforgamestartspectate();
  } else {
    var_4 = self.sessionteam;

    if(self == level.players[0] || var_4 == "_encstr_AF8C0A1B6A1D6045925B4F7D" || var_4 == "_encstr_933E090A10B17DDFB3E522") {
      self allowspectateteam("_encstr_9A8507BA4040188D08", 1);
      self allowspectateteam("_encstr_8E8405EA382B2A", 0);
      thread waitforgamestartspectate();
    }
  }
}