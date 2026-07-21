/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\killstreaks\juggernaut.gsc
***********************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_88C5055208731B")]]();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_855012A6C7EA4BFBE41F1071FF1C708FA2E2952D"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_855012A6C7EA4BFBE41F1071FF1C708FA2E2952D")]]();

  level.juggksglobals = spawnStruct();
  level._effect["_encstr_A19115D20D592FF74DD08AC3283FAEA37175256F24C11B"] = loadfx("_encstr_A5D93567991EF25ABB1C7D6BC1CB6D2D3663B9D1E45685B65EB3CCC3AFD4EAD9ECF5360B4E590EC26CAD85EC56D7E6B67BB595C59D330F");
  initconfig();
  initmarker();
  init_jugg_vo();
  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_8111084A907F4CEF60B0", 1);
  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_BDDC100ACE8F0A87ECB8F51AAFF2278AE8BF", 2);
  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_B2DC109A7FAFB747A9F398864F02C8C8E868", 3);
  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_83D41161B917B05FFFFA98F07257A72897277B", 4);
  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_825E15B802DFBAF11F6123338F872976733A13A04AEF61", 5);
}

initconfig() {
  var_0 = level.juggksglobals;
  var_1 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_937E0B73A66F43570D3AD0A082"))
    var_1 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_937E0B73A66F43570D3AD0A082")]]();

  var_0.config = var_1;
  var_1.infiniteammo = 1;
  var_1.infiniteammoupdaterate = 4.0;
  var_1.maxhealth = 3000;
  var_1.startinghealth = 3000;
  var_2 = "_encstr_A5FC15C00B223E6A230FB30F7ADA307B464E17D3A9EDA7";

  if(scripts\common\utility::iscp())
    var_2 = "_encstr_B4FC15E7AF23C953A8C6BC43F93065D3D01B1F6B172683";

  var_1.suit = var_2;
  var_1.clothtype = "_encstr_A96C0A3BAF8B58CB528FFDEB";
  var_1.classstruct.loadoutprimary = "_encstr_9B1315648431B1256020FFFFC0B8EBBB4D1D6F1F7833FB";
  var_1.classstruct.loadoutsecondary = "_encstr_8BBA05185F8B99";

  if(isDefined(level.battle_tracks_stopbattletracksforplayer))
    var_1[[level.battle_tracks_stopbattletracksforplayer]]();
}

initmarker() {
  var_0 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_AC2B0A36CAD9B2368816D1B0"))
    var_0 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_AC2B0A36CAD9B2368816D1B0")]]("_encstr_8BFC0BC2CBD4F737E0A5E1FD79");

  var_0.capturecallback = ::oncratecaptured;
  var_0.destroycallback = ::oncratedestroyed;
  var_0.activatecallback = ::oncrateactivated;
  var_0.headicon = "_encstr_A9691F1ABA46EBB48DEDCDEBDA4BB1C6378EE49558D6F5535D9D765639CD585D8E";
  var_0.capturestring = &"_encstr_ACDE245381A1B18FF9C225F10463EFF07440A50E88E409312DAFC90A3045F779C194D5803928";

  if(level.gametype != "_encstr_B607038AAB") {
    var_0.friendlymodel = "_encstr_B849231F7B9132D490DBD05111781A0A7783BF8FD34CBA87428B41E4CB705742CE053F4F91";
    var_0.enemymodel = "_encstr_B849231F7B9132D490DBD05111781A0A7783BF8FD34CBA87428B41E4CB705742CE053F4F91";
  }
}

init_jugg_vo() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AB3719D4F59F223D1310EFA7D86EFE6A4D019ECD483D2B4519E8C3"] = "_encstr_B49B124DEA76ECCA4ECD2C578ED7314E2B0B3A34";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A9531A35EAB3D9594E732C5D8EF56358C4EDC9B219BE8927AC2C8E1A"] = "_encstr_A9531A35EAB3D9594E732C5D8EF56358C4EDC9B219BE8927AC2C8E1A";
}

tryusejuggernaut(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", self);
  tryusejuggernautfromstruct(var_1, var_0);
}

tryusejuggernautfromstruct(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_8331155EB60A41AB8947E8E00BF2036FE2DF4E500E13D9")) {
    if(!self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_8331155EB60A41AB8947E8E00BF2036FE2DF4E500E13D9")]](var_0))
      return 0;
  }

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0))
      return 0;
  }

  var_2 = getdvarint("_encstr_A5A11837B1C9F5DAE6FA355D3BD9D72D739B472C9B3AAF576E2B");

  if(var_2 || istrue(var_1))
    thread activatejugg(var_0);
  else {
    scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle();
    var_3 = getcompleteweaponname("_encstr_A96115C8B283C6B7E5AFA6BA9DB32BC9372CBAE8FAADE0");
    var_4 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy(var_0, var_3, "_encstr_9B620D8F0DC07577C551F16A3826BF", undefined, undefined, ::markerthrown);

    if(!istrue(var_4)) {
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return 0;
    }
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0))
      return 0;
  }

  return 1;
}

markerthrown(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_A35F1AE79D8E1B5D5881BD03DD0B7573CC136B1F6FA1D23320EBB50B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_A35F1AE79D8E1B5D5881BD03DD0B7573CC136B1F6FA1D23320EBB50B")]]();

  var_2.owner = self;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_870A137C78DAD34CC8844325CE9D76B38743E05084"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_870A137C78DAD34CC8844325CE9D76B38743E05084")]](var_0.streakname, self.origin);

  var_2 thread watchmarkeractivate(var_0);
  var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
  return "_encstr_88E30897BDF1B71F7823";
}

watchmarkeractivate(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = self.owner.angles;
  var_2 = self.owner;
  self waittill("_encstr_860808CB78E2984063BA", var_3);

  if(!isDefined(var_2)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A")]]();

    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  } else {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A")]]();

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_AB591A0DA2CAD95D42AF80300B7A102BD10EFE03BAD34BE110D74858") && level.gametype != "_encstr_B607038AAB") {
      var_0.vehicleisreserved = 1;
      var_4 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_AB591A0DA2CAD95D42AF80300B7A102BD10EFE03BAD34BE110D74858")]](var_2, var_2.team, "_encstr_8BFC0BC2CBD4F737E0A5E1FD79", var_3, var_1, var_1 + (0, 180, 0), var_0);
      var_2 thread scripts\cp_mp\killstreaks\airdrop::br_c130spawndone(var_0, "_encstr_BA67082278D537E3C827");

      if(!isDefined(var_4)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
          var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_88D02667E3D104E7E1DAB5C7236955AFFB8BEF767025C71BBD758B984F87CAA13C3C71A96EA075BC");

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A9321A075FDE4B51A11F9170EB0323FDC9C0E5F6A73867FB4BDBBA59")) {
          var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A9321A075FDE4B51A11F9170EB0323FDC9C0E5F6A73867FB4BDBBA59")]](var_0.mpstreaksysteminfo, "_encstr_8261067B1D34AC27");
          return;
        }

        return;
      }

      return;
    }

    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

    if(level.gametype == "_encstr_B607038AAB") {
      var_5 = 1;
      var_2 thread scripts\cp_mp\killstreaks\airdrop::_id_13669(var_3, var_5);
    }
  }
}

oncrateactivated(var_0) {
  if(istrue(var_0))
    playFX(scripts\engine\utility::getfx("_encstr_A19115D20D592FF74DD08AC3283FAEA37175256F24C11B"), self.origin);
}

oncratecaptured(var_0) {
  var_1 = self.data;

  if(istrue(var_0.isjuggernaut)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_A1C61066D3304A728AFB93ABF73DDB95E8B8")) {
      self.streakinfo = var_1;
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_A1C61066D3304A728AFB93ABF73DDB95E8B8")]](var_1.streakname, var_0, self);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BA67082278D537E3C827", "_encstr_BD53157A9377DBFB98D8730770938DE2D7A602358FB7E2"))
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BA67082278D537E3C827", "_encstr_BD53157A9377DBFB98D8730770938DE2D7A602358FB7E2")]](var_1.streakname, undefined, 1);
  } else
    var_0 activatejugg(var_1);
}

oncratedestroyed(var_0) {
  var_1 = self.data;

  if(isDefined(level.killstreakfinishusefunc))
    level[[level.killstreakfinishusefunc]](var_1);
}

activatejugg(var_0) {
  var_1 = level.juggksglobals;
  var_2 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_8A4B0F5B0BB65949D576CE2B3937C257A3"))
    var_2 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_8A4B0F5B0BB65949D576CE2B3937C257A3")]](var_1.config, var_0);

  if(!var_2)
    return 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_8C6F14129071CB5F8B67363F09A82359808D18EB5035"))
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_8C6F14129071CB5F8B67363F09A82359808D18EB5035")]](self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18"))
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18")]]("_encstr_A73C1047773DCAD7D0D3AFB7C9C83E528DC1", self);

  createjuggobjective();

  if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "_encstr_B82907C2887BC62B39")
    self _meth_87AA("_encstr_956C0F5F17A32190D37C4679E7A5D8E9BA");
  else
    self _meth_87AA("_encstr_A54F0D51AA7701B872C31F43F19D50");

  self setsoundsubmix("_encstr_ACC00EAD7BDF3263073FCF0B80AED31B", 0.5);
  thread _id_144BD(var_0);
  thread watchforjuggernautend(var_0);
  thread _id_144BC(var_0);

  if(level.gametype != "_encstr_B607038AAB" && !scripts\common\utility::iscp())
    thread modelaststandallowed();
}

modelaststandallowed() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108");
  var_0 = getcompleteweaponname("_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB");
  self giveweapon(var_0);
  var_1 = self dropitem(var_0);

  if(!isDefined(var_1)) {
    self takeallweapons();
    return;
  }

  var_1.objweapon = var_0;
  var_1.targetname = "_encstr_AD580F5F2388E9EB57322E3069A1074090";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_A6DE0C7758E8B1A105B436ADEAE0"))
    var_1 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_A6DE0C7758E8B1A105B436ADEAE0")]](self);

  waitframe();
  self takeallweapons();
}

_id_144BD(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_88B00FB037873113F3557705AB596B58EC");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(self) && isDefined(var_0))
    scripts\cp_mp\utility\killstreak_utility::_id_12AA7(var_0);
}

watchforjuggernautend(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = self.juggcontext;
  self waittill("_encstr_88B00FB037873113F3557705AB596B58EC");

  if(isDefined(self.operatorcustomization)) {
    if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "_encstr_B82907C2887BC62B39")
      self _meth_87AA("_encstr_B82907C2887BC62B39");
    else
      self _meth_87AA("_encstr_B40101");
  }

  self clearsoundsubmix("_encstr_ACC00EAD7BDF3263073FCF0B80AED31B", 0.5);
  onjuggernautend(var_0, var_1);
}

onjuggernautend(var_0, var_1) {
  if(level.gametype != "_encstr_B607038AAB") {
    if(isDefined(level.killstreakfinishusefunc))
      level[[level.killstreakfinishusefunc]](var_0);

    var_0.onspray = 1;
    scripts\cp_mp\utility\killstreak_utility::_id_12AA7(var_0);
  }

  cleanupjuggobjective(var_1);
}

_id_144BC(var_0) {
  self endon("_encstr_88B00FB037873113F3557705AB596B58EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = self.juggcontext;
  self waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  cleanupjuggobjective(var_1);
}

createjuggobjective() {
  self setscriptablepartstate("_encstr_8D6D0C78D7A9D74ECACB31BF4740", "_encstr_A5F509EADB99F26B80595F", 0);

  if(istrue(level.vehicle_occupancy_forceweaponswitchallowed)) {
    var_0 = 0;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_965B13E617BA0BC850DC2AB285B554B9B0131B95C8"))
      var_0 = level[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_965B13E617BA0BC850DC2AB285B554B9B0131B95C8")]]();

    var_1 = getdvarint("_encstr_BDE41DF3AA5338C0D3EF4FB302FD50F593C109987377635061D943A934E598", 0) == 1;

    if(var_1) {
      self setscriptablepartstate("_encstr_857210F7D5DA3B69B287A0F837FB0353133F", "_encstr_8BFC0BC2CBD4F737E0A5E1FD79", 0);
      return;
    }

    self setscriptablepartstate("_encstr_857210F7D5DA3B69B287A0F837FB0353133F", "_encstr_B2D714FAF3ECFF3FF8AD19F56169060F042E93B2D9B1", 0);
    return;
  } else {
    var_2 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_B6481343D019E0F217299F763213BEF3CF6B375057"))
      var_2 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_B6481343D019E0F217299F763213BEF3CF6B375057");

    if(isDefined(var_2)) {
      var_3 = [[var_2]](99);
      self.juggcontext.juggobjid = var_3;
      scripts\mp\objidpoolmanager::objective_add_objective(var_3, "_encstr_930B07BB1B6B3854FF", self.origin, "_encstr_A13718BF3A67AAB7F81C98731DB6A7E7E8FFC9A45D6042F90BC9");
      scripts\mp\objidpoolmanager::objective_set_play_intro(var_3, 0);
      scripts\mp\objidpoolmanager::objective_set_play_outro(var_3, 0);

      foreach(var_5 in level.players) {
        if(isDefined(var_5)) {
          if(var_5 != self) {
            scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_3, var_5);
            continue;
          }

          scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_3, var_5);
        }
      }

      scripts\mp\objidpoolmanager::update_objective_onentity(var_3, self);
      scripts\mp\objidpoolmanager::update_objective_setbackground(var_3, 1);

      if(level.teambased)
        scripts\mp\objidpoolmanager::update_objective_ownerteam(var_3, self.team);
      else
        scripts\mp\objidpoolmanager::_id_13FA2(var_3, self);
    }
  }
}

cleanupjuggobjective(var_0) {
  if(isDefined(self))
    self setscriptablepartstate("_encstr_8D6D0C78D7A9D74ECACB31BF4740", "_encstr_B4250C393D87BECBF505130E27C3", 0);

  if(isDefined(self) && level.gametype == "_encstr_B607038AAB")
    self setscriptablepartstate("_encstr_857210F7D5DA3B69B287A0F837FB0353133F", "_encstr_BA19049F4B2D", 0);
  else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_867712AA1378832BD004D25AA9BECB7C808B1924"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_867712AA1378832BD004D25AA9BECB7C808B1924")]](var_0.juggobjid);
}

watchjuggernautweaponenduse(var_0, var_1) {
  self notifyonplayercommand("_encstr_9A361BFBC758CB067DD15334F19550F30FD23B40D0A0806030DAF41B12", "_encstr_A6E60A229B175A3B48A543AB");
  thread removejuggernautweapononaction("_encstr_8EE016B9EE2D8E6CA1AC32FA3327DBB6EBAD2DE64B9D5D37", var_1);
  thread removejuggernautweapononaction("_encstr_996216BF40C07962F328F176819BBA07E9584323883BAD9A", var_1);
  thread removejuggernautweapononaction("_encstr_AD75063D571AE108");
  thread watchjuggernautweaponswitch(var_0);
  thread watchjuggernautweaponammo(var_0);
}

watchjuggernautweaponswitch(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A702111AF557B7BF23BAEA6828779B1C4B023C");
  self endon("_encstr_A66D1055FA9281533DC3B1289F5E08D75B65");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    scripts\engine\utility::_id_143A5("_encstr_9A361BFBC758CB067DD15334F19550F30FD23B40D0A0806030DAF41B12", "_encstr_914C0EDDB20B837BB97D38D2365BAB83");

    if(self getcurrentweapon() != var_0) {
      continue;
    }
    self notify("_encstr_8EE016B9EE2D8E6CA1AC32FA3327DBB6EBAD2DE64B9D5D37");
    break;
  }
}

watchjuggernautweaponammo(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A702111AF557B7BF23BAEA6828779B1C4B023C");
  self endon("_encstr_A66D1055FA9281533DC3B1289F5E08D75B65");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_1 = self getweaponammoclip(var_0);

    if(var_1 <= 0) {
      self notify("_encstr_996216BF40C07962F328F176819BBA07E9584323883BAD9A");
      break;
    }

    waitframe();
  }
}

removejuggernautweapononaction(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A702111AF557B7BF23BAEA6828779B1C4B023C");
  self endon("_encstr_A66D1055FA9281533DC3B1289F5E08D75B65");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill(var_0);
  dropjuggernautweapon(var_0, var_1);
}

dropjuggernautweapon(var_0, var_1) {
  self._id_12346 = undefined;
  self.minigunprevweaponobject = undefined;
  self.playerstreakspeedscale = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_AB8015F3AB952FB39823AFBE1B41FA674D81291A1179F7"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_AB8015F3AB952FB39823AFBE1B41FA674D81291A1179F7")]]();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_8FD90F58A8C26D7F9F36D0CC3A90C7A549"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_8FD90F58A8C26D7F9F36D0CC3A90C7A549")]]("_encstr_BD2C09BF097845B8ADDF97", 1);

  if(!istrue(level.loadout_updateammo)) {
    scripts\common\utility::allow_mount_top(1, "_encstr_BD2C09BF097845B8ADDF97");
    scripts\common\utility::allow_mount_side(1, "_encstr_BD2C09BF097845B8ADDF97");
  }

  var_2 = getcompleteweaponname("_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB");

  if(var_0 == "_encstr_8EE016B9EE2D8E6CA1AC32FA3327DBB6EBAD2DE64B9D5D37" || var_0 == "_encstr_B1860E4F9B31C4516B19ED6568152A90") {
    if(self hasweapon(var_2)) {
      var_3 = self dropitem(var_2);
      var_3.objweapon = var_2;
      var_3.targetname = "_encstr_AD580F5F2388E9EB57322E3069A1074090";

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_A6DE0C7758E8B1A105B436ADEAE0"))
        var_3 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_A6DE0C7758E8B1A105B436ADEAE0")]](self);
    }
  } else if(var_0 == "_encstr_996216BF40C07962F328F176819BBA07E9584323883BAD9A") {
    if(self hasweapon(var_2))
      thread delaytakeminigun(0.5, var_2);
  }

  if(isDefined(var_1)) {
    self.lastdroppableweaponobj = var_1;
    self switchtoweapon(var_1);
  }

  self notify("_encstr_A66D1055FA9281533DC3B1289F5E08D75B65");
}

delaytakeminigun(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self takeweapon(var_1);
}