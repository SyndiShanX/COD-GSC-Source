/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\utility\killstreak.gsc
***********************************************/

hasplayerdiedwhileusingkillstreak(var_0) {
  return var_0.lifeid != scripts\cp_mp\utility\killstreak_utility::getcurrentplayerlifeidforkillstreak();
}

addtoactivekillstreaklist(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = self getentitynumber();
  self.activeid = var_2 getactivekillstreakid();

  if(isDefined(var_0)) {
    if(isremotekillstreak(var_0)) {
      addtoremotekillstreaklist(var_7);
      thread removefromremotekillstreaklistondeath(var_7);
    }

    if(isuavkillstreak(var_0)) {
      addtouavlist(var_7, var_2);
      thread removefromuavlistondeath(var_7, var_2);
    } else if(isairstrikekillstreak(var_0)) {
      addtoairstrikelist(var_7);
      thread removefromairstrikelistondeath(var_7);
    } else if(islittlebirdkillstreak(var_0)) {
      addtolittlebirdlist(var_7);
      thread removefromlittlebirdlistondeath(var_7);
    } else if(ishelikillstreak(var_0)) {
      addtohelilist(var_7);
      thread removefromhelilistondeath(var_7);
    } else if(isturretkillstreak(var_0)) {
      addtoturretlist(var_7);
      thread removefromturretlistondeathorcarry(var_7);
    } else if(iscarrykillstreak(var_0)) {
      addtocarrylist(var_7);
      thread removefromcarrylistondeathorcarry(var_7);
    } else if(isprojectilekillstreak(var_0)) {
      addtoprojectilelist(var_7);
      thread removefromprojectilelistondeath(var_7);
    } else if(issupportdronekillstreak(var_0)) {
      addtosupportdronelist(var_7);
      thread removefromsupportdronelistondeath(var_7);
    } else if(isassaultdronekillstreak(var_0)) {
      addtoassaultdronelist(var_7);
      thread removefromassaultdronelistondeath(var_7);
    } else {
      addtoplayerkillstreaklist(var_7);
      thread removefromplayerkillstreaklistondeath(var_7);
    }

    if(iskillstreaklockonable(var_0))
      self.affectedbylockon = 1;
  }

  level.activekillstreaks[var_7] = self;
  level.activekillstreaks[var_7].streakname = var_0;

  if(var_1 == "_encstr_81860F1741A58ADBBB43D3B36C79AF3083") {
    self.isairkillstreak = 1;

    if(!isDefined(var_0) || var_0 != "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950" && var_0 != "_encstr_81CC0586854EC1")
      self enableplayermarks("_encstr_A1940FD903FBCF747BC05AA328652FEF30");
  } else {
    self.isairkillstreak = 0;
    self enableplayermarks("_encstr_85CE0B9770B02C73A1760F06D2");
  }

  if(level.teambased)
    self filteroutplayermarks(var_2.team);
  else
    self filteroutplayermarks(var_2);

  if(istrue(var_3)) {
    var_8 = undefined;
    var_9 = undefined;

    if(level.teambased) {
      if(scripts\cp_mp\utility\killstreak_utility::isridekillstreak(var_0)) {
        foreach(var_11 in level.players) {
          if(var_11.team == self.team && var_11 != self.owner)
            var_8 = scripts\mp\utility\outline::outlineenableforplayer(self, var_11, "_encstr_9ABD15C87B5C489BD2AFFF95EF1AD5F0F49476C1E0B190", "_encstr_A7440781BA73D7D8C1");

          if(isDefined(var_8))
            thread removeoutlineonnotify(var_8, var_6);
        }

        var_9 = 1;
      } else
        var_8 = scripts\mp\utility\outline::outlineenableforteam(self, var_2.team, "_encstr_9ABD15C87B5C489BD2AFFF95EF1AD5F0F49476C1E0B190", "_encstr_A7440781BA73D7D8C1");
    } else
      var_8 = scripts\mp\utility\outline::outlineenableforplayer(self, var_2, "_encstr_9ABD15C87B5C489BD2AFFF95EF1AD5F0F49476C1E0B190", "_encstr_A7440781BA73D7D8C1");

    if(!istrue(var_9))
      thread removeoutlineonnotify(var_8, var_6);
  }

  if(istrue(var_4)) {
    var_13 = 0;

    if(var_2 scripts\mp\utility\player::isusingremote())
      var_13 = 1;

    var_14 = undefined;

    if(level.teambased)
      var_14 = thread scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, var_5, 1, 10000, undefined, undefined, 1, var_13);
    else {
      if(istrue(var_13)) {
        return;
      }
      var_14 = thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(var_2, "_encstr_A62C214CED91A9090910CB07C021F9E20F0D92835BE1C24DF0F0171B0898B50AC11118", var_5, 1, 10000, undefined, undefined, 1);
    }

    thread removeteamheadicononnotify(var_14, var_6);
  }
}

getactivekillstreakid() {
  if(!isDefined(self.pers["_encstr_95010DDCCA87E80A6CA3B4D92B9222"]))
    self.pers["_encstr_95010DDCCA87E80A6CA3B4D92B9222"] = 0;

  var_0 = self.pers["_encstr_95010DDCCA87E80A6CA3B4D92B9222"];
  self.pers["_encstr_95010DDCCA87E80A6CA3B4D92B9222"]++;
  return var_0;
}

removeoutlineonnotify(var_0, var_1) {
  var_2 = ["_encstr_AD75063D571AE108"];

  if(isDefined(var_1))
    var_2[var_2.size] = var_1;

  scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var_2);
  scripts\mp\utility\outline::outlinedisable(var_0, self);
}

removeteamheadicononnotify(var_0, var_1) {
  var_2 = ["_encstr_AD75063D571AE108"];

  if(isDefined(var_1))
    var_2[var_2.size] = var_1;

  scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var_2);
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_0);
}

removefromactivekillstreaklist(var_0) {
  level.activekillstreaks[var_0] = undefined;
}

activekillstreaklistcontains(var_0) {
  if(!isDefined(level.activekillstreaks))
    return 0;

  return isDefined(level.activekillstreaks[var_0]);
}

addtoremotekillstreaklist(var_0) {
  if(!isDefined(level.remotekillstreaks))
    level.remotekillstreaks = [];

  level.remotekillstreaks[var_0] = self;
}

removefromremotekillstreaklistondeath(var_0) {
  self waittill("_encstr_AD75063D571AE108");
  level.remotekillstreaks[var_0] = undefined;
}

addtouavlist(var_0, var_1) {
  if(!isDefined(level.uavmodels))
    level.uavmodels = [];

  if(level.teambased) {
    var_2 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_965B13E617BA0BC850DC2AB285B554B9B0131B95C8"))
      var_2 = level[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_965B13E617BA0BC850DC2AB285B554B9B0131B95C8")]]();

    if(istrue(var_2) && getdvarint("_encstr_B2D8177B77AD67EFA3DDDE475F73C83848E08848EF457ED060", 1)) {
      var_3 = var_1.team + var_1.squadindex;
      level.uavmodels[var_3][level.uavmodels[var_3].size] = self;
      return;
    }

    level.uavmodels[self.team][level.uavmodels[self.team].size] = self;
    return;
  } else
    level.uavmodels[self.owner.guid + "_encstr_BA4C02DF" + gettime()] = self;
}

removefromuavlistondeath(var_0, var_1) {
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(self.uavrig))
    self.uavrig delete();

  if(level.teambased) {
    var_2 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_965B13E617BA0BC850DC2AB285B554B9B0131B95C8"))
      var_2 = level[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_965B13E617BA0BC850DC2AB285B554B9B0131B95C8")]]();

    if(istrue(var_2) && getdvarint("_encstr_B2D8177B77AD67EFA3DDDE475F73C83848E08848EF457ED060", 1)) {
      var_3 = var_1.team + var_1.squadindex;
      level.uavmodels[var_3] = scripts\engine\utility::array_removeundefined(level.uavmodels[var_3]);
    } else
      level.uavmodels[self.team] = scripts\engine\utility::array_removeundefined(level.uavmodels[self.team]);
  } else
    level.uavmodels = scripts\engine\utility::array_removeundefined(level.uavmodels);

  if(isDefined(self))
    self delete();

  removefromactivekillstreaklist(var_0);
}

addtoairstrikelist(var_0) {
  if(!isDefined(level.airstrikemodels))
    level.airstrikemodels = [];

  level.airstrikemodels[var_0] = self;
}

removefromairstrikelistondeath(var_0) {
  self waittill("_encstr_AD75063D571AE108");
  level.airstrikemodels[var_0] = undefined;
  removefromactivekillstreaklist(var_0);
}

addtolittlebirdlist(var_0) {
  if(!isDefined(level.littlebirds))
    level.littlebirds = [];

  level.littlebirds[var_0] = self;
}

removefromlittlebirdlistondeath(var_0) {
  self waittill("_encstr_AD75063D571AE108");
  level.littlebirds[var_0] = undefined;
  removefromactivekillstreaklist(var_0);
}

addtohelilist(var_0) {
  if(!isDefined(level.helis))
    level.helis = [];

  level.helis[var_0] = self;
}

removefromhelilist(var_0) {
  level.helis[var_0] = undefined;
  removefromactivekillstreaklist(var_0);
}

removefromhelilistondeath(var_0) {
  self waittill("_encstr_AD75063D571AE108");
  level.helis[var_0] = undefined;
  removefromactivekillstreaklist(var_0);
}

addtoturretlist(var_0) {
  if(!isDefined(level.turrets))
    level.turrets = [];

  level.turrets[var_0] = self;
}

removefromturretlistondeathorcarry(var_0) {
  scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_A93B084AF782F0DA4A04");
  level.turrets[var_0] = undefined;
  removefromactivekillstreaklist(var_0);
}

addtocarrylist(var_0) {
  if(!isDefined(level.deployables))
    level.deployables = [];

  level.deployables[var_0] = self;
}

removefromcarrylistondeathorcarry(var_0) {
  scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_A93B084AF782F0DA4A04");
  level.deployables[var_0] = undefined;
  removefromactivekillstreaklist(var_0);
}

addtosupportdronelist(var_0) {
  if(!isDefined(level.supportdrones))
    level.supportdrones = [];

  level.supportdrones[var_0] = self;
}

removefromsupportdronelistondeath(var_0) {
  self waittill("_encstr_AD75063D571AE108");
  level.supportdrones[var_0] = undefined;
  removefromactivekillstreaklist(var_0);
}

addtoassaultdronelist(var_0) {
  if(!isDefined(level.assaultdrones))
    level.assaultdrones = [];

  level.assaultdrones[var_0] = self;
}

removefromassaultdronelistondeath(var_0) {
  self waittill("_encstr_AD75063D571AE108");
  level.assaultdrones[var_0] = undefined;
  removefromactivekillstreaklist(var_0);
}

addtoprojectilelist(var_0) {
  if(!isDefined(level.projectilekillstreaks))
    level.projectilekillstreaks = [];

  level.projectilekillstreaks[var_0] = self;
}

removefromprojectilelistondeath(var_0) {
  self waittill("_encstr_AD75063D571AE108");
  level.projectilekillstreaks[var_0] = undefined;
  removefromactivekillstreaklist(var_0);
}

addtoplayerkillstreaklist(var_0) {
  if(!isDefined(level.playerkillstreaks))
    level.playerkillstreaks = [];

  level.playerkillstreaks[var_0] = self;
}

removefromplayerkillstreaklistondeath(var_0) {
  self waittill("_encstr_AD75063D571AE108");
  level.playerkillstreaks[var_0] = undefined;
  removefromactivekillstreaklist(var_0);
}

setkillstreakcontrolpriority(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self makeusable();
  self setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
  self sethintonobstruction("_encstr_BD1805CB69C063");
  self setHintString(var_1);
  self sethintdisplayfov(var_2);
  self setusefov(var_3);
  self sethintdisplayrange(var_4);
  self setuserange(var_5);
  self setusepriority(1);
  level thread applyplayercontrolonconnect(self);

  foreach(var_9 in level.players) {
    if(var_9 == var_0 && !istrue(var_7)) {
      self enableplayeruse(var_9);
      continue;
    }

    self disableplayeruse(var_9);
  }
}

applyplayercontrolonconnect(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_1);
    var_0 disableplayeruse(var_1);
  }
}

applykillstreakplayeroutline(var_0, var_1) {
  var_2 = self.team;
  var_3 = self.owner;
  var_4 = undefined;
  var_5 = undefined;

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive() || var_0.team == "_encstr_AF8C0A1B6A1D6045925B4F7D" || var_0.team == "_encstr_933E090A10B17DDFB3E522") {
    return;
  }
  if(var_0 == var_3)
    var_4 = "_encstr_8FCA17B7D5E8C696DCCA664B8D63D7C8AC073A86BE36E50B37";
  else if(var_0 != var_3) {
    if(level.teambased && var_0.team != var_2 || !level.teambased) {
      var_4 = "_encstr_865D19FAA0E11DA730459681E958B7A77B20D30289BFD2BFE8BC9D";
      var_5 = 1;
    } else
      return;
  }

  if(isDefined(var_4)) {
    if(istrue(var_5)) {
      if(var_0 scripts\mp\utility\perk::_hasperk("_encstr_B14C19CD07B28DB42C1BD1BCFADCDBC16385CBB29C8E2CC9EC561D"))
        return;
    }

    var_6 = scripts\mp\utility\outline::outlineenableforplayer(var_0, self.owner, var_4, "_encstr_85CE0B9770B02C73A1760F06D2");
    thread watchoutlineremoveonkillstreakend(var_6, var_0, var_1);
    thread watchoutlineremoveonplayerend(var_6, var_0, var_1);
  }
}

watchoutlineremoveonkillstreakend(var_0, var_1, var_2) {
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill(var_2);
  scripts\mp\utility\outline::outlinedisable(var_0, var_1);
}

watchoutlineremoveonplayerend(var_0, var_1, var_2) {
  self endon(var_2);
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  scripts\mp\utility\outline::outlinedisable(var_0, var_1);
}

getmodifiedantikillstreakdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_3 = scripts\mp\damage::handleshotgundamage(var_1, var_2, var_3);
  var_3 = scripts\mp\damage::handleapdamage(var_1, var_2, var_3, var_0);
  var_11 = var_1.isalternatemode;
  var_12 = 0;

  if(istrue(var_11)) {
    var_13 = scripts\mp\utility\weapon::getweaponattachmentsbasenames(var_1);

    foreach(var_15 in var_13) {
      if(var_15 == "_encstr_8A07035972") {
        var_12 = 1;
        break;
      }
    }
  }

  var_17 = undefined;

  if(var_2 != "_encstr_8DED0A21C79B660BC7588981") {
    switch (var_1.basename) {
      case "_encstr_A29408E6D5D6CAAF5B1C":
      case "_encstr_8DCB0F47F22330CEE7996B13A2E390583A":
        self.largeprojectiledamage = 1;
        self.killoneshot = 1;
        var_17 = 1;
        break;
      case "_encstr_B20A13E6C5D1CBAA99F8F2EA78F722FBC8225795DF":
      case "_encstr_A90D1FCAAD38AF1927B7B92B7DB9DEE67D0E63C22FB239D7465A93561B3AEBD60E":
      case "_encstr_AB64181DDD735E712232B8F8297D2F307768118731CF233FCDAB":
      case "_encstr_A73C111777369AFDE0F3A1772B203E1298F3DB":
      case "_encstr_87DF1286F6D9959CBE9AAC1DBEC1E47B35F56B07":
      case "_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9":
      case "_encstr_AC740FAA3BF169D025C6A373200C27E06B":
      case "_encstr_81430B218B3F7018458997D78A":
      case "_encstr_8ABB134AEB113F41C8C180B2C79AB2FF83E7E7E51B":
      case "_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920":
      case "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8":
      case "_encstr_AD5210B0D388CF9573E1A8CF58B33C4120CA":
      case "_encstr_9B69114A571F8EBD17484FBA87220987C71A97":
      case "_encstr_BE3E15E34720D111A7E99B2A62335DC84FA15D63C7DDF0":
      case "_encstr_8BD015B08BF0BF888F4F2D835BE311954F72E0A061FD59":
      case "_encstr_AAC517BEE0390F6BED2A408B187B8722C6CF7429D2C0E94F20":
      case "_encstr_B65F1413E4B03236ACF2D78EDBDDEB83E4BD4DFAD61C":
        self.largeprojectiledamage = 1;
        var_17 = var_5;
        break;
      case "_encstr_A2CF0C31B4B37D985A2746D76B07":
      case "_encstr_82C50EF0AA8BE0C0963187E155F17037":
      case "_encstr_A1FA123471738359181731B1DB49E14A9FA6BD43":
      case "_encstr_99E107C0F71E86B363":
      case "_encstr_AF3011DD1D21D7BB459072BB83A7F2B3BEF148":
      case "_encstr_8A6C1038D236D6D5E0EBA393ABD8DABEAD0E":
      case "_encstr_87BF13EC43105F1F201BBBB2600E03154801A765F9":
      case "_encstr_A7AA0DE816C6D727DBCEB2C9EBB61C":
      case "_encstr_928912BAA1B60F4D6149DAC57F98196F541ED213":
      case "_encstr_8D7B0D3007F3805512A6C759B18AB1":
      case "_encstr_BE2610C077D0B2630B5683EB7B6E472168F1":
      case "_encstr_8CBA0AD33D120153A1AFA040":
      case "_encstr_B2F60B166F934917E1C5C7BA1B":
      case "_encstr_92B90BC2C11BBEE4AE6ED7AD0E":
      case "_encstr_8FC20FAB0B58176F7853C3BB994A774DA0":
      case "_encstr_A7A70785E89DD7AD0E":
      case "_encstr_827E0D809A9733A0E3992D3FBF8D48":
      case "_encstr_95DB19EB1C61A8BDE1DBF1F7FF3B73281233136682C2B8E219B7F9":
      case "_encstr_B1D20FB2D6077DB34E5673C29156D7DA0E":
      case "_encstr_88710EC26CC49918FA1A815BB5AFADC1":
      case "_encstr_95E70D8EDBDA85F5839CED35F5B683":
      case "_encstr_88E90F60526BE39B37B026C8BBEA614FB1":
      case "_encstr_B107148D23571AD42BA00B173943ADC34F4AD2C999A1":
      case "_encstr_81D911B12DB386D14716DC6DBE8EABE4F5ADE0":
        self.largeprojectiledamage = 1;
        var_17 = var_6;
        break;
      case "_encstr_88F90EF65F8E7A1AEED5251AE97F9788":
      case "_encstr_A2950D16C9E8D2361B59932FF55BC1":
      case "_encstr_A10B13BB213943CF581FC9D16140D45F7FB3F1C22B":
      case "_encstr_8B9E13779010B4923960C8855327AA3913EA4FF7D0":
      case "_encstr_888E0FE659DAD12BC37D89F636D1BE5BC1":
      case "_encstr_ACC40CC1F8A321601715CFBFE0EA":
      case "_encstr_91730EE7A8D8C8B0A5FD1FF790E72860":
      case "_encstr_9AAE0876FCB7603101DB":
      case "_encstr_92A70ABB8267F5E0D89F6351":
      case "_encstr_8C4A10BA936F7F31D0159D6ECB304757814B":
      case "_encstr_B2C0155057B3262F92258D96F869792B0AA370E847451B":
        self.largeprojectiledamage = 0;
        var_17 = var_7;
        break;
      case "_encstr_889F1CA3D0ACC9B62D8EB2FA3CB596DAACC403E4D7390B23A5D5B9BED607":
      case "_encstr_B69C1874D1289ABFBB9B4AD16180F353A18D19EC4BAB62AF51F3":
      case "_encstr_B45E1514B148FADFDBFB2A718221077490ABE8D1476002":
      case "_encstr_8E3B11F9785798B1A7BB5906C267F96061C579":
      case "_encstr_B29B0FE0E32573E3A23395B04E6BBF5898":
        self.largeprojectiledamage = 0;
        var_17 = var_9;
        break;
    }
  } else {
    self.largeprojectiledamage = 0;
    var_17 = var_8;
  }

  if(isDefined(var_10))
    self.largeprojectiledamage = var_10;

  if(isDefined(var_17) && isDefined(var_2) && (var_2 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_2 == "_encstr_A7E3151D0854967FE86A69475ED92EC387C0A129A1BFE5" || var_2 == "_encstr_9B0D099AD3887D91252954" || var_2 == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F" || var_2 == "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B" || var_2 == "_encstr_911B0C7DA090E9A7F799FD50DD48" || var_2 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421" || var_2 == "_encstr_8DED0A21C79B660BC7588981"))
    var_3 = ceil(var_4 / var_17);

  var_18 = 0;

  if(isDefined(var_0) && isDefined(self.owner) && !var_18) {
    if(isDefined(var_0.owner))
      var_0 = var_0.owner;

    if(var_0 == self.owner && !istrue(self.killoneshot))
      var_3 = ceil(var_3 / 2);
  }

  return int(var_3);
}

isexplosiveantikillstreakweapon(var_0) {
  var_1 = 0;
  var_2 = 0;

  if(isstring(var_0))
    var_2 = issubstr(var_0, "_encstr_9B83050BD88EF5");
  else if(issameweapon(var_0))
    var_2 = var_0.isalternate;

  var_3 = 0;

  if(istrue(var_2)) {
    var_4 = scripts\mp\utility\weapon::getweaponattachmentsbasenames(var_0);

    foreach(var_6 in var_4) {
      if(var_6 == "_encstr_8A07035972") {
        var_3 = 1;
        break;
      }
    }
  }

  var_8 = scripts\mp\utility\weapon::getweaponbasenamescript(var_0);

  switch (var_8) {
    case "_encstr_B2431993782C0F025963C8C819B0CF47D811F95A6388EB3F814BD8":
    case "_encstr_998D1868A26D11B3E757B6234FA758FF15CAF0E01A857B2E6F80":
    case "_encstr_B6B314378945F0ED77FACB1372672D69DF1589E7252A":
    case "_encstr_935E169BDD961D6C1AFA318D2C1995BE8D34B46319D76BE0":
    case "_encstr_AFBB119A85B1DA0BD87DC6169B9BEDDCD7DAC1":
    case "_encstr_BE541946E4DEB9B2F5A1A5CEACAF0727BDD4CA8D3AD236B2F5DAC1":
    case "_encstr_B1D20FB2D6077DB34E5673C29156D7DA0E":
    case "_encstr_AB0F0E1CB7E0FA27BD6CB5AC8EFAADE0":
    case "_encstr_A2950D16C9E8D2361B59932FF55BC1":
    case "_encstr_9AAE0876FCB7603101DB":
    case "_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920":
    case "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8":
    case "_encstr_BE3E15E34720D111A7E99B2A62335DC84FA15D63C7DDF0":
    case "_encstr_873910FA8BA0453BB8F9C3BF19DB7387A0B3":
      var_1 = 1;
      break;
  }

  return var_1;
}

nulldamagecheck(var_0) {
  return isDefined(var_0) && var_0 == self.owner;
}

dodamagetokillstreak(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = (0, 0, 0);
  var_8 = (0, 0, 0);
  var_9 = (0, 0, 0);
  var_10 = (0, 0, 0);
  var_11 = "_encstr_B40101";
  var_12 = "_encstr_B40101";
  var_13 = "_encstr_B40101";
  var_14 = undefined;

  if(isDefined(var_3)) {
    if(level.teambased) {
      if(!scripts\mp\utility\entity::isvalidteamtarget(var_1, var_3, self))
        return;
    } else if(!scripts\mp\utility\entity::isvalidffatarget(var_1, var_3, self))
      return;
  }

  if(isagent(self))
    self dodamage(var_0, var_4, var_1, var_2, var_5, var_6);
  else if(scripts\cp_mp\vehicles\vehicle::isvehicle())
    self dodamage(var_0, var_4, var_1, var_2, var_5, var_6);
  else {
    var_15 = asmdevgetallstates(var_6);
    self notify("_encstr_B2BE0788BAF573592F", var_0, var_1, var_7, var_8, var_5, var_11, var_12, var_13, var_14, var_15, var_4, var_9, var_10, var_2);
  }
}

playdlightfx(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(var_0))
    var_0 = (0, 0, 0);

  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  var_2 = scripts\engine\utility::getfx("_encstr_ADEE0D312C718480B1E9FC12DA7F18");

  if(istrue(self.isairdrop))
    var_2 = scripts\engine\utility::getfx("_encstr_B1770D53A0E8AF4A397802BD5F21C2");

  self.fxdlightent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  self.fxdlightent setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self.fxdlightent linkTo(self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_0, var_1);
  self.fxdlightent thread deleteonparentdeath(self);
  wait 0.1;
  playFXOnTag(var_2, self.fxdlightent, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
}

deleteonparentdeath(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 waittill("_encstr_AD75063D571AE108");

  if(isDefined(self))
    self delete();
}

isaffectedbyblindeye(var_0) {
  switch (var_0) {
    case "_encstr_B88607820996877650":
    case "_encstr_86470DCD959BE893BCFAB943B7B1DA":
      return 1;
  }

  return 0;
}

getplayerkillstreakcombatmode(var_0) {
  var_1 = "_encstr_8BBA05087F0B9D";

  if(isDefined(var_0.owner) && isDefined(var_0.owner.currentcombatmode))
    var_1 = var_0.owner.currentcombatmode;

  return var_1;
}

watchsupertrophynotify(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_860808CB78E2984063BA");

  for(;;) {
    var_0 waittill("_encstr_8EF61412F9EE8BC2189B151C3F98C8DF95F33ADBE043", var_1, var_2, var_3, var_4, var_5);

    if(var_3 != self.weapon_name) {
      continue;
    }
    var_0 scripts\mp\damagefeedback::updatedamagefeedback("_encstr_B40101");
    break;
  }
}

watchhostmigrationlifetime(var_0, var_1, var_2) {
  if(var_0 != "_encstr_AD75063D571AE108")
    self endon("_encstr_AD75063D571AE108");

  self endon(var_0);
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = gettime() + int(var_1 * 1000);
  level waittill("_encstr_AD3F1534DB9BA3BEADD27627B0D1B4BDCDAFC495EC2DCD");
  self notify("_encstr_AAED1F58EAC2C9CE9F598406298370B7ED71F0E8D29F31C0B77D80FD10EBB95997");
  var_4 = gettime();
  var_5 = var_3 - var_4;
  level waittill("_encstr_85A51314B8F75347B068B7FB30CB39AAB5D8DF0D95");
  var_6 = gettime();
  var_7 = var_6 + var_5;
  var_5 = var_5 / 1000;

  if(isDefined(self.streakname) && scripts\cp_mp\utility\killstreak_utility::isridekillstreak(self.streakname))
    self.owner setclientomnvar("_encstr_B42D181FA4C122A3EC31C0BB932B52E26F3B600BD68C2B3F4738", var_7);

  self[[var_2]](var_5);
}

getenemytargets(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(var_0 scripts\mp\utility\player::isenemy(var_3))
      var_1[var_1.size] = var_3;
  }

  return var_1;
}

_beginlocationselection(var_0, var_1, var_2, var_3) {
  self beginlocationselection(var_1, var_2, 0, var_3);
  self.selectinglocation = 1;
  self setblurforplayer(10.3, 0.3);
  thread endselectiononaction("_encstr_91A21017B155D07573493840921FB5C8AD06");
  thread endselectiononaction("_encstr_AD75063D571AE108");
  thread endselectiononaction("_encstr_8D820B49520F0EC02DDE6367EC");
  thread endselectiononaction("_encstr_95E405AEDCCA91");
  thread endselectiononaction("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  self endon("_encstr_887F1837A3BDC1D763F636161DA5F6CDF5CDB2B1568DE8A5BD37");
  thread endselectiononendgame();

  if(isDefined(var_0) && self.team != "_encstr_AF8C0A1B6A1D6045925B4F7D" && self.team != "_encstr_933E090A10B17DDFB3E522") {
    if(isDefined(self.streakmsg))
      self.streakmsg destroy();

    if(self issplitscreenplayer()) {
      self.streakmsg = scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 1.3);
      self.streakmsg scripts\mp\hud_util::setpoint("_encstr_A5C407E57585313DB1", "_encstr_A5C407E57585313DB1", 0, -98);
    } else {
      self.streakmsg = scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 1.6);
      self.streakmsg scripts\mp\hud_util::setpoint("_encstr_A5C407E57585313DB1", "_encstr_A5C407E57585313DB1", 0, -190);
    }
  }
}

stoplocationselection(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = "_encstr_979608DF73C8E70B73A1";

  if(!var_0) {
    self setblurforplayer(0, 0.3);
    self endlocationselection();
    self.selectinglocation = undefined;

    if(isDefined(self.streakmsg))
      self.streakmsg destroy();
  }

  self notify("_encstr_887F1837A3BDC1D763F636161DA5F6CDF5CDB2B1568DE8A5BD37", var_1);
}

endselectiononaction(var_0) {
  self endon("_encstr_887F1837A3BDC1D763F636161DA5F6CDF5CDB2B1568DE8A5BD37");
  self waittill(var_0);
  thread stoplocationselection(var_0 == "_encstr_8D820B49520F0EC02DDE6367EC", var_0);
}

endselectiononendgame() {
  self endon("_encstr_887F1837A3BDC1D763F636161DA5F6CDF5CDB2B1568DE8A5BD37");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  thread stoplocationselection(0, "_encstr_A3AF090768A9910F4118EF");
}

streakshouldchain(var_0) {
  var_1 = scripts\mp\killstreaks\killstreaks::calcstreakcost(var_0);
  var_2 = scripts\mp\killstreaks\killstreaks::getnextstreakname();
  var_3 = scripts\mp\killstreaks\killstreaks::calcstreakcost(var_2);
  return var_1 < var_3;
}

streakcheckistargetindoors(var_0, var_1) {
  var_2 = 0;
  var_3 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0);

  if(!scripts\engine\trace::ray_trace_passed(var_0, var_0 + (0, 0, 10000), var_1, var_3))
    var_2 = 1;

  return var_2;
}

validateusestreak(var_0, var_1) {
  if((!self isonground() || self iswallrunning()) && scripts\cp_mp\utility\killstreak_utility::isridekillstreak(var_0)) {
    scripts\mp\hud_message::showerrormessage("_encstr_88DC1899E78C341FF13A053F44B9DFDF265FF9310F542D751897");
    return 0;
  }

  if(isDefined(self.selectinglocation))
    return 0;

  if(scripts\mp\utility\game::isairdenied()) {
    if(isflyingkillstreak(var_0)) {
      if(!(isDefined(var_1) && var_1))
        scripts\mp\hud_message::showerrormessage("_encstr_92CE20FB3CF9F18F2D5DB3BF8947590D76B31F37DC942B2B6C5F69D7E4BF5998F550");

      return 0;
    }
  }

  if(self isusingturret() && (scripts\cp_mp\utility\killstreak_utility::isridekillstreak(var_0) || iscarrykillstreak(var_0) || isturretkillstreak(var_0))) {
    if(!(isDefined(var_1) && var_1))
      scripts\mp\hud_message::showerrormessage("_encstr_B4C025BC40E3E951D3923333E34AEA2D43789765A81BB711FD9D7F03C324299C5F414F8F819775");

    return 0;
  }

  if(!scripts\common\utility::is_weapon_allowed())
    return 0;

  if(isDefined(level.civilianjetflyby) && isflyingkillstreak(var_0)) {
    if(!(isDefined(var_1) && var_1)) {}

    return 0;
  }

  if(isDefined(var_0) && var_0 == "_encstr_86470DCD959BE893BCFAB943B7B1DA" && scripts\mp\arbitrary_up::isinarbitraryup()) {
    if(!(isDefined(var_1) && var_1))
      scripts\mp\hud_message::showerrormessage("_encstr_88DC1899E78C341FF13A053F44B9DFDF265FF9310F542D751897");

    return 0;
  }

  return 1;
}

isplayerkillstreak(var_0) {
  if(!isDefined(var_0.activeplayerstreak))
    return 0;

  switch (var_0.activeplayerstreak) {
    default:
      return 0;
  }
}

iscarrykillstreak(var_0) {
  switch (var_0) {
    default:
      return 0;
  }
}

isremotekillstreak(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC":
    case "_encstr_8C950E2F42AB5B3BFC5B7958BB07909B":
    case "_encstr_86FD08B775CD07DC1338":
    case "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A":
    case "_encstr_B270105ECB28E94BC5CFABAB937D524C5053":
    case "_encstr_B1B30B51D176511E377A1BC313":
      var_1 = 1;
      break;
  }

  return var_1;
}

isuavkillstreak(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "_encstr_81CC0586854EC1":
    case "_encstr_8C9D0C506F0B96A8F78B297BF313":
    case "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950":
    case "_encstr_851904B59B34":
      var_1 = 1;
      break;
  }

  return var_1;
}

isairstrikekillstreak(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "_encstr_9688105BBAB1A32D7D0BD2E4373A4E96AD2B":
    case "_encstr_8161113BE8A8948A78316B7F5F9722F718D3B2":
    case "_encstr_8C980A867B3B569CFAA659E8":
    case "_encstr_86FD08B775CD07DC1338":
    case "_encstr_BA910F9957CA63EBB02D9C373A93B4B5CA":
    case "_encstr_A2E60C6BC099B7E1A0A93A398F48":
    case "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895":
      var_1 = 1;
      break;
  }

  return var_1;
}

islittlebirdkillstreak(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "_encstr_BA67082278D537E3C827":
      var_1 = 1;
      break;
  }

  return var_1;
}

ishelikillstreak(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3":
    case "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A":
      var_1 = 1;
      break;
  }

  return var_1;
}

isballdronekillstreak(var_0) {
  var_1 = 0;
  return var_1;
}

isturretkillstreak(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4":
      var_1 = 1;
      break;
  }

  return var_1;
}

isprojectilekillstreak(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "_encstr_B270105ECB28E94BC5CFABAB937D524C5053":
      var_1 = 1;
      break;
  }

  return var_1;
}

issupportdronekillstreak(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "_encstr_8FBC173B6136974D08F94D428760D2E750D971C2CB06774250":
    case "_encstr_81E01312A3403EA3C0F95B724025DFF7200FB79A11":
    case "_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC":
    case "_encstr_8C950E2F42AB5B3BFC5B7958BB07909B":
    case "_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60":
    case "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD":
      var_1 = 1;
      break;
  }

  return var_1;
}

isassaultdronekillstreak(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "_encstr_B1B30B51D176511E377A1BC313":
      var_1 = 1;
      break;
  }

  return var_1;
}

iscarepackage(var_0) {
  return isDefined(var_0) && isDefined(var_0.id) && var_0.id == "_encstr_BAE50DE60E739BA638C72068AF47B9";
}

isjuggernaut() {
  return istrue(self.isjuggernaut);
}

isremotekillstreakweapon(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "_encstr_A73F143F7720ABEDE8906B378E483F9206E3D37723DF":
    case "_encstr_B4CB12574F71BEA0FD4D130979D0C87E6A9723E9":
    case "_encstr_83911473FFE146EF9E0163FACBE0CBFA085DF5FF6B40":
    case "_encstr_8AEA13B69BBE27956BB7E8B2EB1993DE3795F56B0E":
    case "_encstr_A5E612978FB17E603D8DD3C9B916283ACAD76329":
    case "_encstr_B42011379B76D2F27318ABE7680BCA981E68D3":
    case "_encstr_A18315B30F0132D10B889B42C7798B6D13B3279B969960":
    case "_encstr_979914D35F4122577120938A0EDD6F9B58E7551F8BE0":
      var_1 = 1;
      break;
  }

  return var_1;
}

iskillstreaklockonable(var_0) {
  switch (var_0) {
    case "_encstr_81CC0586854EC1":
    case "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950":
    case "_encstr_B270105ECB28E94BC5CFABAB937D524C5053":
      return 0;
    default:
      return 1;
  }
}

isflyingkillstreak(var_0) {
  switch (var_0) {
    case "_encstr_AAFC0BF2206F353F4EABF1E635":
    case "_encstr_9B100BD059D8A5D7C1B4C6B7D1":
    case "_encstr_B4BE172C5AE432C9DEC1AF9BB237A393CBD7D64BDC2D3B57CD":
    case "_encstr_8F010BD0591B4B36B7831D5693":
    case "_encstr_85B5101FA940A47EE093911F1E232E68F880":
    case "_encstr_BA67082278D537E3C827":
    case "_encstr_86FD08B775CD07DC1338":
    case "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895":
      return 1;
    default:
      return 0;
  }
}

getkillstreakindex(var_0) {
  return level.killstreakglobals.streaktable.tabledatabyref[var_0]["_encstr_B48F06CC58B0F50B"];
}

getkillstreakkills(var_0) {
  var_1 = "_encstr_8E8D0697EB01F243";

  if(scripts\mp\utility\perk::_hasperk("_encstr_96F4242EE80FF173FE6A107031140B684373352655C738D763625158EA2DF581871CBE15A947") && var_0 != "_encstr_B8BA05F06B9785")
    var_1 = "_encstr_82F50AC337E76B7345E50B74";
  else if(scripts\mp\utility\perk::_hasperk("_encstr_A29E1E378356D85A16C63A97D7DCD583C1B7931DFA5B2DC6D8DC3A93B20BDA6E"))
    var_1 = "_encstr_A9BD0C33AB3FCBD580F16347D798";

  return level.killstreakglobals.streaktable.tabledatabyref[var_0][var_1];
}

getkillstreakenemyusedialogue(var_0) {
  return level.killstreakglobals.streaktable.tabledatabyref[var_0]["_encstr_82A50F2BCA77EB1A6F33F56D31E7E0A75F"];
}

getkillstreakaudioref(var_0) {
  var_1 = getkillstreakaudiorefoverride(var_0);

  if(var_1 != "_encstr_B40101")
    return var_1;

  var_2 = strtok(var_0, "_encstr_BA4C02DF");

  foreach(var_4 in var_2) {
    if(var_1 == "_encstr_B40101") {
      var_1 = var_4;
      continue;
    }

    var_1 = var_1 + var_4;
  }

  return var_1;
}

getkillstreakaudiorefoverride(var_0) {
  var_1 = "_encstr_B40101";

  switch (var_0) {
    case "_encstr_AF7F10B9B1C92CDA8936B2937D32E4DE73B2":
      var_1 = "_encstr_B4570A0E100E4F3D82C16ACB";
      break;
    case "_encstr_B270105ECB28E94BC5CFABAB937D524C5053":
      var_1 = "_encstr_A23D094FEA22B9411CDFC8";
      break;
    case "_encstr_A2E60C6BC099B7E1A0A93A398F48":
      var_1 = "_encstr_88020ED680A07B434D1D3F3B05637AA5";
      break;
    case "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895":
      var_1 = "_encstr_A7FF0A11CA9F330B2B40C3E1";
      break;
  }

  return var_1;
}

getkillstreakoverheadicon(var_0) {
  return level.killstreakglobals.streaktable.tabledatabyref[var_0]["_encstr_8FAE0D7BECCA4ED05958C892B1B737"];
}

currentactivevehiclecount(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  var_1 = var_0;

  if(isDefined(level.helis))
    var_1 = var_1 + level.helis.size;

  if(isDefined(level.littlebirds))
    var_1 = var_1 + level.littlebirds.size;

  if(isDefined(level.ugvs))
    var_1 = var_1 + level.ugvs.size;

  if(isDefined(level.bradley) && isDefined(level.bradley.vehicles))
    var_1 = var_1 + level.bradley.size;

  if(isDefined(level.supportdrones))
    var_1 = var_1 + level.supportdrones.size;

  if(isDefined(level.assaultdrones))
    var_1 = var_1 + level.assaultdrones.size;

  return var_1;
}

maxvehiclesallowed() {
  return 8;
}

fauxvehiclecount() {
  return level.fauxvehiclecount;
}

incrementfauxvehiclecount(var_0) {
  if(!isDefined(var_0))
    level.fauxvehiclecount++;
  else
    level.fauxvehiclecount = level.fauxvehiclecount + var_0;
}

decrementfauxvehiclecount(var_0) {
  if(!isDefined(var_0))
    level.fauxvehiclecount--;
  else
    level.fauxvehiclecount = level.fauxvehiclecount - var_0;

  if(level.fauxvehiclecount < 0)
    level.fauxvehiclecount = 0;
}

isassaultkillstreak(var_0) {
  switch (var_0) {
    case "_encstr_AAFC0BF2206F353F4EABF1E635":
    case "_encstr_81CC0586854EC1":
    case "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950":
    case "_encstr_851904B59B34":
      return 1;
    default:
      return 0;
  }
}

isresourcekillstreak(var_0) {
  switch (var_0) {
    case "_encstr_A3E6105C78780A302A0191B0F58030D821E8":
    case "_encstr_A16E0B55AFD367DAD988921AC8":
    case "_encstr_B21E0CB00B7DD8B05DCD36D0B29C":
    case "_encstr_A6EE0CC545C660206F1AE951123B":
    case "_encstr_962C0B9B16ADBE47EAE49C568E":
    case "_encstr_B63910C82B831BDEBCB0261BCAD7CE95E6E8":
      return 1;
    default:
      return 0;
  }
}

issupportkillstreak(var_0) {
  switch (var_0) {
    default:
      return 0;
  }
}

isspecialistkillstreak(var_0) {
  switch (var_0) {
    default:
      return 0;
  }
}

gethelipilotmeshoffset() {
  return (0, 0, 5000);
}

gethelipilottraceoffset() {
  return (0, 0, 2500);
}

isnavmeshkillstreak(var_0) {
  var_1 = 0;
  return var_1;
}

iscontrollingproxyagent() {
  var_0 = 0;

  if(isDefined(self.playerproxyagent) && isalive(self.playerproxyagent))
    var_0 = 1;

  return var_0;
}

killshouldaddtokillstreak(var_0) {
  if(scripts\mp\utility\perk::_hasperk("_encstr_B4371B9BE0B26C5A85B1A32FD7CAE11C1B7B374B3B2B26AB361B95479B"))
    return 0;

  return !scripts\mp\utility\weapon::iskillstreakweapon(var_0.basename) && !scripts\mp\utility\points::update_objective_setmlgbackground(var_0);
}

iskillstreak(var_0) {
  return getkillstreakindex(var_0) != -1;
}

getairdropcrates() {
  if(isDefined(level.cratedata))
    return level.cratedata.crates;

  return [];
}

getnumairdropcrates() {
  if(isDefined(level.cratedata))
    return level.cratedata.crates.size;

  return 0;
}

attackerinremotekillstreak() {
  if(!isDefined(self))
    return 0;

  if(isDefined(level.gunshipplayer) && self == level.gunshipplayer)
    return 1;

  if(isDefined(level.chopper) && isDefined(level.chopper.gunner) && self == level.chopper.gunner)
    return 1;

  if(isDefined(self.using_remote_tank) && self.using_remote_tank)
    return 1;

  return 0;
}

killstreak_make_vehicle(var_0, var_1, var_2, var_3, var_4) {
  self.vehiclename = var_0;
  self.scorepopup = var_1;
  self.vodestroyed = var_2;
  self.votimeout = var_3;
  self.destroyedsplash = var_4;
  self enableplayermarks("_encstr_85CE0B9770B02C73A1760F06D2");

  if(level.teambased)
    self filteroutplayermarks(self.team);
  else
    self filteroutplayermarks(self.owner);

  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_enableownerdamage(self);
  scripts\mp\vehicles\damage::get_vehicle_mod_damage_data(var_0, 1);
}

killstreak_vehicle_callback_init() {
  if(!istrue(level.kscallbackinitcomplete)) {
    level.kscallbackinitcomplete = 1;
    level.kspremoddamagecallback = ::killstreak_pre_mod_damage_callback;
    level.kspostmoddamagecallback = ::killstreak_post_mod_damage_callback;
    level.ksdeathcallback = ::killstreak_death_callback;
  }
}

killstreak_pre_mod_damage_callback(var_0) {
  var_1 = var_0.damage;
  var_2 = var_0.attacker;

  if(!istrue(self.killoneshot)) {
    if(isDefined(var_2) && isDefined(self.owner) && var_2 == self.owner)
      var_1 = int(ceil(var_1 * 0.5));

    var_0.damage = var_1;
  }

  var_3 = 1;
  var_4 = self.kspremoddamagecallback;

  if(isDefined(var_4))
    var_3 = self[[var_4]](var_0);

  return var_3;
}

killstreak_post_mod_damage_callback(var_0) {
  scripts\mp\killstreaks\killstreaks::killstreakhit(var_0.attacker, var_0.objweapon, self, var_0.meansofdeath, var_0.damage);
  var_1 = 1;
  var_2 = self.kspostmoddamagecallback;

  if(isDefined(var_2))
    var_1 = self[[var_2]](var_0);

  return var_1;
}

killstreak_death_callback(var_0) {
  scripts\mp\damage::onkillstreakkilled(self.streakname, var_0.attacker, var_0.objweapon, var_0.meansofdeath, var_0.damage, self.scorepopup, self.vodestroyed, self.destroyedsplash);
  var_1 = 1;
  var_2 = self.ksdeathcallback;

  if(isDefined(var_2))
    var_1 = self[[var_2]](var_0);

  return var_1;
}

killstreak_set_pre_mod_damage_callback(var_0, var_1) {
  killstreak_vehicle_callback_init();
  scripts\mp\vehicles\damage::set_pre_mod_damage_callback(var_0, level.kspremoddamagecallback);
  self.kspremoddamagecallback = var_1;
}

killstreak_set_post_mod_damage_callback(var_0, var_1) {
  killstreak_vehicle_callback_init();
  scripts\mp\vehicles\damage::set_post_mod_damage_callback(var_0, level.kspostmoddamagecallback);
  self.kspostmoddamagecallback = var_1;
}

killstreak_set_death_callback(var_0, var_1) {
  killstreak_vehicle_callback_init();
  scripts\mp\vehicles\damage::set_death_callback(var_0, level.ksdeathcallback);
  self.ksdeathcallback = var_1;
}

getkillstreaknamefromweapon(var_0) {
  var_1 = var_0.basename;

  if(isDefined(level.killstreakweaponmap[var_1]))
    return level.killstreakweaponmap[var_1];

  return undefined;
}