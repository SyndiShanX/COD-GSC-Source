/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\utility\killstreak_utility.gsc
************************************************/

createstreakinfo(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.streakname = var_0;
  var_2.owner = var_1;
  var_2.id = getuniquekillstreakid(var_1);
  var_2.lifeid = getcurrentplayerlifeidforkillstreak();
  var_2.score = 0;
  var_2.shots_fired = 0;
  var_2.hits = 0;
  var_2.damage = 0;
  var_2.kills = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_9A64178616904FE92BF070CFF4A7C0BA98AA78695339A7A4CE"))
    var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_9A64178616904FE92BF070CFF4A7C0BA98AA78695339A7A4CE")]](var_2, var_0);

  return var_2;
}

getuniquekillstreakid(var_0) {
  if(!isDefined(var_0.pers["_encstr_938E115D69C3B40803691B6F71B6D21930745F"]))
    var_0.pers["_encstr_938E115D69C3B40803691B6F71B6D21930745F"] = 0;

  var_1 = var_0.pers["_encstr_938E115D69C3B40803691B6F71B6D21930745F"];
  var_0.pers["_encstr_938E115D69C3B40803691B6F71B6D21930745F"]++;
  return var_1;
}

getcurrentplayerlifeidforkillstreak() {
  if(!isDefined(self.pers["_encstr_8E0607055DBFB3919A"]))
    return 0;

  return self.pers["_encstr_8E0607055DBFB3919A"];
}

getkillstreaklifeid(var_0) {
  var_1 = undefined;

  for(var_2 = 1; var_2 <= 3; var_2++) {
    var_3 = self.streakdata.streaks[var_2];

    if(isDefined(var_3) && var_3.streakname == var_0) {
      var_1 = var_3;
      break;
    }
  }

  if(isDefined(var_1))
    return var_1.lifeid;

  return undefined;
}

registervisibilityomnvarforkillstreak(var_0, var_1, var_2) {
  if(!isDefined(level.killstreak_visbilityomnvarlist))
    level.killstreak_visbilityomnvarlist = [];

  if(isDefined(level.killstreak_visbilityomnvarlist[var_0]) && isDefined(level.killstreak_visbilityomnvarlist[var_0][var_1])) {
    return;
  }
  var_3 = 0;

  foreach(var_5 in level.killstreak_visbilityomnvarlist) {
    foreach(var_7 in var_5) {
      if(var_2 == var_7) {
        var_3 = 1;
        break;
      }
    }

    if(istrue(var_3))
      return;
  }

  level.killstreak_visbilityomnvarlist[var_0][var_1] = var_2;
}

_setvisibiilityomnvarforkillstreak(var_0, var_1) {
  var_2 = undefined;

  if(var_1 == "_encstr_BA19049F4B2D")
    var_2 = 0;
  else
    var_2 = level.killstreak_visbilityomnvarlist[var_0][var_1];

  self setclientomnvar("_encstr_A374175796FA5B968D36E6A39C560BADBE6CBDDC4739BDD86E", var_2);
}

killstreakcanbeusedatroundstart(var_0) {
  switch (var_0) {
    case "_encstr_970509C3CF3B425F68D9F7":
    case "_encstr_83AC0BD465392B7F30EBAA055B":
    case "_encstr_86F20A19E4F6E659469CDEE0":
    case "_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60":
    case "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD":
    case "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950":
    case "_encstr_8C9D0C506F0B96A8F78B297BF313":
    case "_encstr_851904B59B34":
      return 1;
    default:
      return 0;
  }
}

isridekillstreak(var_0) {
  switch (var_0) {
    case "_encstr_B270105ECB28E94BC5CFABAB937D524C5053":
    case "_encstr_B1B30B51D176511E377A1BC313":
    case "_encstr_8C950E2F42AB5B3BFC5B7958BB07909B":
    case "_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC":
    case "_encstr_86FD08B775CD07DC1338":
    case "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A":
      return 1;
    default:
      return 0;
  }
}

ismapselectkillstreak(var_0) {
  switch (var_0) {
    case "_encstr_9688105BBAB1A32D7D0BD2E4373A4E96AD2B":
    case "_encstr_8161113BE8A8948A78316B7F5F9722F718D3B2":
    case "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD":
    case "_encstr_B8BA05F06B9785":
      return 1;
    default:
      return 0;
  }
}

use_contract(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "_encstr_A18315B30F0132D10B889B42C7798B6D13B3279B969960":
    case "_encstr_979914D35F4122577120938A0EDD6F9B58E7551F8BE0":
      var_1 = 1;
      break;
  }

  return var_1;
}

starttabletscreen(var_0, var_1) {
  var_2 = int(tablelookup("_encstr_AB7A17451FC08F44C1703B43683BBE77470FD2CC3DB8E78AAD", 1, var_0, 0));
  self setclientomnvar("_encstr_86601BAE2D7D9C95AD7B8E59D76CBDCD8E93BDD8EBCD59B8AE95CD1BB2", var_2);
  thread tabletdofset(var_1);
}

stoptabletscreen(var_0, var_1) {
  self setclientomnvar("_encstr_86601BAE2D7D9C95AD7B8E59D76CBDCD8E93BDD8EBCD59B8AE95CD1BB2", -1);
  thread tabletdofset(var_0, 1, var_1);
}

tabletdofset(var_0, var_1, var_2) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_AAB40F32F699EBB9CAE8D78EB0268D951D");
  self endon("_encstr_AAB40F32F699EBB9CAE8D78EB0268D951D");

  if(istrue(var_1) && !istrue(var_2)) {
    self enablephysicaldepthoffieldscripting();
    self setphysicaldepthoffield(1.8, 15, 20, 20);
    self setphysicalviewmodeldepthoffield(30, 5);
  }

  if(isDefined(var_0) && var_0 > 0)
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);

  if(istrue(var_1))
    self disablephysicaldepthoffieldscripting();
  else {
    self enablephysicaldepthoffieldscripting();
    self setphysicaldepthoffield(1.8, 15, 20, 20);
    self setphysicalviewmodeldepthoffield(30, 5);
  }
}

killstreak_savenvgstate() {
  if(!isDefined(self.pers["_encstr_BDAA073552DA154FC7"])) {
    return;
  }
  if(self isnightvisionon()) {
    self.pers["_encstr_BDAA073552DA154FC7"] = 1;
    self.pers["_encstr_84681884DB48FCDA5D45EDDB9A098E7752C8FF340115F444CD6C"] = 1;
    self nightvisionviewoff(1);
  } else {
    self.pers["_encstr_BDAA073552DA154FC7"] = 0;
    self.pers["_encstr_84681884DB48FCDA5D45EDDB9A098E7752C8FF340115F444CD6C"] = 0;
  }
}

killstreak_restorenvgstate() {
  if(!isDefined(self.pers["_encstr_BDAA073552DA154FC7"])) {
    return;
  }
  if(istrue(self.pers["_encstr_BDAA073552DA154FC7"])) {
    self nightvisionviewon(1);
    self.pers["_encstr_84681884DB48FCDA5D45EDDB9A098E7752C8FF340115F444CD6C"] = 0;
  }
}

playkillstreakoperatordialog(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isPlayer(self))
    var_3 = self;
  else if(isDefined(self.owner))
    var_3 = self.owner;

  if(isDefined(var_2) && var_2 > 0) {
    var_3 endon("_encstr_8D820B49520F0EC02DDE6367EC");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_2);
  }

  if(isDefined(var_3)) {
    if(!isDefined(var_3.currentkillstreakopvo) || istrue(var_1)) {
      var_3 scripts\cp_mp\utility\dialog_utility::operatordialogonplayer(var_0);
      var_3.currentkillstreakopvo = var_0;
      var_3 thread clearstoredkillstreakoperatordialog(5);
    }
  }
}

clearstoredkillstreakoperatordialog(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_A9CE14B1C6AC85E4BEDC3A7B27CA8CF523D2B08DED3B");
  self endon("_encstr_A9CE14B1C6AC85E4BEDC3A7B27CA8CF523D2B08DED3B");
  wait(var_0);

  if(isDefined(self.currentkillstreakopvo))
    self.currentkillstreakopvo = undefined;
}

killstreak_createdangerzone(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9579102CD3372F4A305BB75B9720F9AB50F0") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9579102CD3372F4A305BB75B9720F9AB50F0")]]()) {
    return;
  }
  killstreak_destroydangerzone();
  var_6 = undefined;

  if(isDefined(var_4) && isDefined(var_5))
    var_6 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8E8A06F7D987435E", "_encstr_9B311317F53C07EF029FC815910E3CB1BD79C8C00B")]](var_0, var_1, var_2, var_5, var_3, var_4, 1);
  else if(isDefined(var_5))
    var_6 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8E8A06F7D987435E", "_encstr_9B311317F53C07EF029FC815910E3CB1BD79C8C00B")]](var_0, var_1, var_2, var_5, var_3, undefined, 1);
  else
    var_6 = killstreak_spawnuniversaldangerzone(var_0, var_1, var_2, var_3);

  self.dangerzoneid = var_6;
  return var_6;
}

killstreak_spawnuniversaldangerzone(var_0, var_1, var_2, var_3) {
  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8E8A06F7D987435E", "_encstr_9B311317F53C07EF029FC815910E3CB1BD79C8C00B")) {
    return;
  }
  var_4 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8E8A06F7D987435E", "_encstr_9B311317F53C07EF029FC815910E3CB1BD79C8C00B")]](var_0, var_1, var_2, undefined, var_3, level.players[randomint(level.players.size)], 1);
  self.dangerzoneid = var_4;
  return var_4;
}

killstreak_destroydangerzone(var_0) {
  if(!isDefined(var_0) && !isDefined(self.dangerzoneid)) {
    return;
  }
  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8E8A06F7D987435E", "_encstr_AAED17502BCAC109F75E158F26CFF18DE072E088A0DD0B2397") || !scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8E8A06F7D987435E", "_encstr_8285169C2BB6DB6759A9E00BBB7388B0E6CE5927D2BDE6B2")) {
    return;
  }
  if(!isDefined(var_0))
    var_0 = self.dangerzoneid;

  if(isDefined(var_0) && [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8E8A06F7D987435E", "_encstr_AAED17502BCAC109F75E158F26CFF18DE072E088A0DD0B2397")]](var_0))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8E8A06F7D987435E", "_encstr_8285169C2BB6DB6759A9E00BBB7388B0E6CE5927D2BDE6B2")]](var_0);

  self.dangerzoneid = undefined;
}

streakcanseetarget(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0);

  if(scripts\engine\trace::ray_trace_passed(var_0, var_1, var_2, var_4))
    var_3 = 1;

  return var_3;
}

teamhasuav(var_0) {
  var_1 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_965B13E617BA0BC850DC2AB285B554B9B0131B95C8")) {
    var_1 = level[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_965B13E617BA0BC850DC2AB285B554B9B0131B95C8")]]();
    var_1 = var_1 && getdvarint("_encstr_B2D8177B77AD67EFA3DDDE475F73C83848E08848EF457ED060", 1);
  }

  foreach(var_3 in level.teamnamelist) {
    if(var_3 == var_0) {
      continue;
    }
    if(isDefined(level.uavmodels)) {
      if(istrue(var_1)) {
        foreach(var_10, var_5 in level.squaddata[var_3]) {
          var_6 = var_3 + var_10;

          if(isDefined(level.uavmodels[var_6]) && level.uavmodels[var_6].size > 0) {
            foreach(var_8 in level.uavmodels[var_6]) {
              if(!isDefined(var_8)) {
                continue;
              }
              if(var_8.uavtype == "_encstr_8C9D0C506F0B96A8F78B297BF313")
                return 0;
            }
          }
        }

        continue;
      }

      if(isDefined(level.uavmodels[var_3]) && level.uavmodels[var_3].size > 0) {
        foreach(var_8 in level.uavmodels[var_3]) {
          if(!isDefined(var_8)) {
            continue;
          }
          if(var_8.uavtype == "_encstr_8C9D0C506F0B96A8F78B297BF313")
            return 0;
        }
      }
    }
  }

  if(isDefined(level.uavmodels)) {
    if(istrue(var_1)) {
      foreach(var_10, var_5 in level.squaddata[var_0]) {
        var_6 = var_0 + var_10;

        if(isDefined(level.uavmodels[var_6]) && level.uavmodels[var_6].size > 0) {
          foreach(var_8 in level.uavmodels[var_6]) {
            if(!isDefined(var_8)) {
              continue;
            }
            if(var_8.uavtype == "_encstr_851904B59B34" || var_8.uavtype == "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950")
              return 1;
          }
        }
      }
    } else if(isDefined(level.uavmodels[var_0]) && level.uavmodels[var_0].size > 0) {
      foreach(var_8 in level.uavmodels[var_0]) {
        if(!isDefined(var_8)) {
          continue;
        }
        if(var_8.uavtype == "_encstr_851904B59B34" || var_8.uavtype == "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950")
          return 1;
      }
    }
  }

  return 0;
}

_id_13AAF(var_0) {
  var_1 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_965B13E617BA0BC850DC2AB285B554B9B0131B95C8"))
    var_1 = level[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_965B13E617BA0BC850DC2AB285B554B9B0131B95C8")]]();

  if(isDefined(level.uavmodels)) {
    if(istrue(var_1) && getdvarint("_encstr_B2D8177B77AD67EFA3DDDE475F73C83848E08848EF457ED060", 1)) {
      foreach(var_8, var_3 in level.squaddata[var_0]) {
        var_4 = var_0 + var_8;

        if(isDefined(level.uavmodels[var_4]) && level.uavmodels[var_4].size > 0) {
          foreach(var_6 in level.uavmodels[var_4]) {
            if(!isDefined(var_6)) {
              continue;
            }
            if(var_6.uavtype == "_encstr_851904B59B34" || var_6.uavtype == "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950")
              return 1;
          }
        }
      }
    } else if(isDefined(level.uavmodels[var_0]) && level.uavmodels[var_0].size > 0) {
      foreach(var_6 in level.uavmodels[var_0]) {
        if(!isDefined(var_6)) {
          continue;
        }
        if(var_6.uavtype == "_encstr_851904B59B34" || var_6.uavtype == "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950")
          return 1;
      }
    }
  }

  return 0;
}

enemyhascuav(var_0) {
  if(isDefined(level.supportdrones) && level.supportdrones.size > 0) {
    foreach(var_2 in level.supportdrones) {
      if(level.teambased && var_2.team == var_0) {
        continue;
      }
      if(var_2.helperdronetype == "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD")
        return 1;
    }
  }

  return 0;
}

isuavactiveforteam(var_0) {
  if(!isDefined(level.uavmodels))
    return 0;

  if(!isDefined(level.uavmodels[var_0]))
    return 0;

  return level.uavmodels[var_0].size > 0;
}

getkillstreakdeployweapon(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "_encstr_933811582D932393DE38F5B6571B1D2D0ED82B":
    case "_encstr_BA67082278D537E3C827":
      var_1 = "_encstr_A9AF1246CAC1367B2FAF0B969CC8C9DB07AFD683";
      break;
    case "_encstr_8BFC0BC2CBD4F737E0A5E1FD79":
      var_1 = "_encstr_A96115C8B283C6B7E5AFA6BA9DB32BC9372CBAE8FAADE0";
      break;
    case "_encstr_8CC008133958C81BACCB":
    case "_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60":
    case "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950":
    case "_encstr_851904B59B34":
    case "_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3":
      var_1 = "_encstr_93B116F067F7496BAB8B35BE2781A7F13ED7A0689F5F4039";

      if(scripts\cp_mp\utility\game_utility::_id_140A9())
        var_1 = "_encstr_92EA1A170F3174E0A3CB73ABB7A738BDFABFDD9BD799C910F766D88B";

      break;
    case "_encstr_A2E60C6BC099B7E1A0A93A398F48":
      var_1 = "_encstr_A22812C4735AC7E2B64317C3CF560A3128DE7D0A";

      if(scripts\cp_mp\utility\game_utility::_id_140A9())
        var_1 = "_encstr_95C419518C324FF2C9585B5320E52127B178B0D53020BBB1977817";

      break;
    case "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895":
      var_1 = "_encstr_95D71524C4F171FB83E84B7380FB9FFB1F50EA5FB8F33B";

      if(scripts\cp_mp\utility\game_utility::_id_140A9())
        var_1 = "_encstr_95C419518C324FF2C9585B5320E52127B178B0D53020BBB1977817";

      break;
    case "_encstr_B270105ECB28E94BC5CFABAB937D524C5053":
    case "_encstr_B1B30B51D176511E377A1BC313":
    case "_encstr_86FD08B775CD07DC1338":
    case "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A":
      var_1 = "_encstr_979914D35F4122577120938A0EDD6F9B58E7551F8BE0";
      break;
    case "_encstr_8161113BE8A8948A78316B7F5F9722F718D3B2":
    case "_encstr_8C980A867B3B569CFAA659E8":
    case "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD":
      var_1 = "_encstr_B42011379B76D2F27318ABE7680BCA981E68D3";
      break;
    case "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4":
      var_1 = "_encstr_BEBE18E1377010C0EBFF535323F31FD897CB4BBB9A7D889082AB";
      break;
    case "_encstr_AA060B6EB2731DE4BCFAEC57E6":
      var_1 = "_encstr_865111D227E024F720718BB2FA21086791AD98";
      break;
    case "_encstr_B8BA05F06B9785":
      var_1 = "_encstr_A5E612978FB17E603D8DD3C9B916283ACAD76329";
      break;
  }

  return var_1;
}

unsetobjectivemarker(var_0) {
  var_1 = 0;

  switch (var_0.basename) {
    case "_encstr_A9AF1246CAC1367B2FAF0B969CC8C9DB07AFD683":
    case "_encstr_A5E612978FB17E603D8DD3C9B916283ACAD76329":
    case "_encstr_865111D227E024F720718BB2FA21086791AD98":
    case "_encstr_BEBE18E1377010C0EBFF535323F31FD897CB4BBB9A7D889082AB":
    case "_encstr_B42011379B76D2F27318ABE7680BCA981E68D3":
    case "_encstr_95D71524C4F171FB83E84B7380FB9FFB1F50EA5FB8F33B":
    case "_encstr_95C419518C324FF2C9585B5320E52127B178B0D53020BBB1977817":
    case "_encstr_A22812C4735AC7E2B64317C3CF560A3128DE7D0A":
    case "_encstr_92EA1A170F3174E0A3CB73ABB7A738BDFABFDD9BD799C910F766D88B":
    case "_encstr_93B116F067F7496BAB8B35BE2781A7F13ED7A0689F5F4039":
    case "_encstr_A96115C8B283C6B7E5AFA6BA9DB32BC9372CBAE8FAADE0":
    case "_encstr_979914D35F4122577120938A0EDD6F9B58E7551F8BE0":
      var_1 = 1;
      break;
  }

  return var_1;
}

getkillstreakgameweapons(var_0) {
  var_1 = [];
  var_2 = scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]() == "_encstr_B607038AAB";

  switch (var_0) {
    case "_encstr_8BFC0BC2CBD4F737E0A5E1FD79":
      var_1 = ["_encstr_9B1315648431B1256020FFFFC0B8EBBB4D1D6F1F7833FB", "_encstr_8B161CE1674A5927235032DA1B88670AB01B67779FA01FEBD8A9DA4160DF", "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB"];
      break;
    case "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4":
      var_1 = ["_encstr_969E11D61673EA0B8DF58EAE39272B477DB61C"];
      break;
    case "_encstr_AA060B6EB2731DE4BCFAEC57E6":
      if(var_2) {
        var_1 = ["_encstr_824611B2BD3DBC6881966B03923A1BA3613818"];
        break;
      }

      var_1 = ["_encstr_BD4611B956CDD14EF2F5E8ABC99C953AF55B38"];
      break;
  }

  return var_1;
}

getnumactivekillstreakperteam(var_0, var_1) {
  var_2 = 0;

  foreach(var_4 in var_1) {
    if(var_4.team == var_0)
      var_2++;
  }

  return var_2;
}

removeextracthelipad() {
  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()))
    return scripts\cp_mp\utility\game_utility::getlocaleent("_encstr_A9E210B2E845424BDB3BE3E543C1C78F9998");

  var_0 = getEntArray("_encstr_A9E210B2E845424BDB3BE3E543C1C78F9998", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size > 1) {}

  return var_0[0];
}

_id_12CC6(var_0) {
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
  var_1 = 0.5;

  if(!isDefined(var_0.restoreangles)) {
    return;
  }
  while(var_1 > 0) {
    var_0 setplayerangles((var_0.restoreangles[0], var_0.restoreangles[1], 0));
    var_1 = var_1 - 0.05;
    wait 0.05;
  }

  var_0.restoreangles = undefined;
}

_id_12AA7(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_8492109210F704EBD8E63C3285018F47D5D8")) {
    var_1 = var_0.mpstreaksysteminfo;

    if(isDefined(var_1)) {
      var_2 = var_1.streakname;
      var_3 = gettime();
      var_4 = var_3 - var_1.attackerisinflictor;
      var_5 = var_0.kills;
      var_6 = 0;
      var_7 = 0;
      var_8 = 0;
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_8492109210F704EBD8E63C3285018F47D5D8")]](var_2, var_4, var_3, var_5, var_6, var_7, var_8);
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8A6705191B7B76", "_encstr_9BBE1203BB08753F4D33D29AF83D4BAA88358594")) {
    var_1 = var_0.mpstreaksysteminfo;

    if(isDefined(var_1)) {
      var_9 = var_1._id_13913;
      var_10 = var_1.streakname;
      var_11 = var_1.isgimme;
      var_3 = gettime();
      var_12 = self.origin;
      var_13 = istrue(var_0.onspray);
      var_14 = var_0.shots_fired;
      var_15 = var_0.hits;
      var_16 = var_0.kills;
      var_17 = var_0.score;
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8A6705191B7B76", "_encstr_9BBE1203BB08753F4D33D29AF83D4BAA88358594")]](self, var_9, var_10, var_11, var_3, var_12, var_13, var_14, var_15, var_16, var_17);
    }
  }
}

_id_125F8() {
  var_0 = undefined;

  if(isDefined(self.vehicle))
    var_0 = [self.vehicle];
  else {
    var_1 = self getgroundentity();

    if(isDefined(var_1) && isDefined(var_1.classname) && var_1.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56")
      var_0 = [var_1];
  }

  return var_0;
}

_id_11DC0(var_0) {
  var_1 = var_0 getmovingplatformparent();

  if(isDefined(var_1) && _calloutmarkerping_handleluinotify_enemyrepinged::trophy_tryreflectsnapshot(var_1) || scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_850E077B0BF30318B9", "_encstr_9BBD0F018F51B5CB4590429ADDA67F6A80") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_850E077B0BF30318B9", "_encstr_9BBD0F018F51B5CB4590429ADDA67F6A80")]](var_1)) {
    var_0 playerlinkTo(var_1);
    var_0 playerlinkedoffsetenable();
    var_0._id_11DC2 = var_1;
  }
}

_id_11DC1(var_0) {
  if(isDefined(var_0._id_11DC2)) {
    var_0._id_11DC2 = undefined;
    var_0 unlink();
  }
}