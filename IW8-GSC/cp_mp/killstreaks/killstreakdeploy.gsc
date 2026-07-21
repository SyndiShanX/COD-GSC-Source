/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\killstreaks\killstreakdeploy.gsc
**************************************************/

onplayerconnect() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);

    if(!isDefined(var_0.pers["_encstr_AC8C11E7636176FBBA103518A30A2D90ADB32B"]))
      var_0.pers["_encstr_AC8C11E7636176FBBA103518A30A2D90ADB32B"] = 0;
  }
}

candeploykillstreak(var_0, var_1) {
  if(!scripts\cp_mp\utility\killstreak_utility::killstreakcanbeusedatroundstart(var_0.streakname)) {
    if(isDefined(level.killstreakrounddelay) && level.killstreakrounddelay > 0) {
      if(level.graceperiod - level.ingraceperiod < level.killstreakrounddelay) {
        var_2 = level.killstreakrounddelay - (level.graceperiod - level.ingraceperiod);

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_B60B1E181821A589B9AE2BA6D7AFDE77DD980B7704DB56BB51C317798C2EC96D", var_2);

        return 0;
      }
    }
  }

  if(isDefined(var_1)) {
    var_3 = candeploykillstreakweapon(var_0, var_1);

    if(isDefined(var_3)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]](var_3);

      return 0;
    }
  }

  return 1;
}

ondeploystart(var_0) {
  var_0.isdeploying = 1;
  var_0.owner.isdeploying = 1;
  var_0.owner scripts\common\utility::allow_crate_use(0);
  var_0.owner scripts\common\utility::brjugg_droponplayerdeath(0);
}

ondeployfinished(var_0, var_1) {
  var_0.isdeploying = 0;
  var_0.owner.isdeploying = 0;
  var_0.owner scripts\common\utility::allow_crate_use(1);
  var_0.owner scripts\common\utility::brjugg_droponplayerdeath(1);
}

streakdeploy_cancelalldeployments() {
  self notify("_encstr_8AAE22202AA587E9FB0FE769040F105B8D622860F3BF3B605F5CFD5FEC279A0BB7EA88D0");
}

streakdeploy_dogesturedeploy(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!candeploykillstreak(var_0, var_1))
    return 0;

  ondeploystart(var_0);
  thread watchforcancelduringgesture(var_0, var_1);
  var_2 = streakdeploy_giveandfireoffhandreliable(var_1);
  var_0 notify("_encstr_ACE5151F82939B388E10B1F90D9BE2D7D9EF9F3369BF98");
  ondeployfinished(var_0, var_2);

  if(istrue(self.inlaststand))
    thread _id_144E2(var_1);

  return var_2;
}

watchforcancelduringgesture(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_ACE5151F82939B388E10B1F90D9BE2D7D9EF9F3369BF98");
  self waittill("_encstr_8AAE22202AA587E9FB0FE769040F105B8D622860F3BF3B605F5CFD5FEC279A0BB7EA88D0");
  self takeweapon(var_1);
}

_id_144E2(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self waittill("_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69");
  self takeweapon(var_0);
}

streakdeploy_doweaponswitchdeploy(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!candeploykillstreak(var_0, var_1))
    return 0;

  ondeploystart(var_0);
  var_7 = scripts\engine\utility::ter_op(istrue(var_2), ::waituntilfinishedwithdeployweapon, undefined);
  var_8 = switchtodeployweapon(var_1, var_0, var_7, var_3, var_4, var_5, var_6);

  if(!istrue(var_8)) {
    ondeployfinished(var_0, 0);
    return 0;
  }

  ondeployfinished(var_0, var_8);
  return 1;
}

streakdeploy_doweaponfireddeploy(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!candeploykillstreak(var_0, var_1))
    return 0;

  ondeploystart(var_0);
  var_8 = switchtodeployweapon(var_1, var_0, ::waituntilfinishedwithdeployweapon, var_3, var_4, var_6, var_7);

  if(!istrue(var_8)) {
    ondeployfinished(var_0, 0);
    return 0;
  }

  scripts\common\utility::allow_offhand_weapons(0);
  var_9 = watchdeployweaponfired(var_0, var_2, var_1, var_5);
  scripts\common\utility::allow_offhand_weapons(1);
  ondeployfinished(var_0, var_9);
  return istrue(var_9);
}

streakdeploy_doweapontabletdeploy(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(var_7))
    var_7 = ::waituntilfinishedwithdeployweapon;

  var_8 = "_encstr_979914D35F4122577120938A0EDD6F9B58E7551F8BE0";

  if(isDefined(var_5))
    var_8 = var_5;

  var_9 = getcompleteweaponname(var_8);
  var_10 = 1.6;

  if(var_8 == "_encstr_A5E612978FB17E603D8DD3C9B916283ACAD76329")
    var_10 = 2.133;

  if(!candeploykillstreak(var_0, var_9))
    return 0;

  ondeploystart(var_0);
  thread _id_13912(var_0);
  scripts\cp_mp\utility\killstreak_utility::starttabletscreen(var_0.streakname, 0.75);
  scripts\common\utility::allow_movement(0);
  scripts\common\utility::allow_jump(0);
  scripts\common\utility::allow_usability(0);
  scripts\common\utility::allow_melee(0);
  scripts\common\utility::allow_offhand_weapons(0);
  var_11 = switchtodeployweapon(var_9, var_0, var_7, var_1, var_2, var_3, var_4);

  if(isDefined(self) && scripts\cp_mp\utility\player_utility::_isalive()) {
    scripts\common\utility::allow_movement(1);
    scripts\common\utility::allow_jump(1);
    scripts\common\utility::allow_usability(1);
    scripts\common\utility::allow_melee(1);
    scripts\common\utility::allow_offhand_weapons(1);
  }

  if(!istrue(var_11)) {
    ondeployfinished(var_0, 0);

    if(isDefined(self))
      scripts\cp_mp\utility\killstreak_utility::stoptabletscreen(0, 1);

    return 0;
  }

  var_12 = watchdeployweaponanimtransition(var_0, var_10, var_6);
  ondeployfinished(var_0, var_12);
  return istrue(var_12);
}

_id_13912(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.5);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8260069BDBBACD46", "_encstr_83011BC11B0B5E2D5AD8B1373A395916B688CA83B17BE5444B16D8F6D9"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8260069BDBBACD46", "_encstr_83011BC11B0B5E2D5AD8B1373A395916B688CA83B17BE5444B16D8F6D9")]](self, var_0.streakname);
}

streakdeploy_dothrowbackmarkerdeploy(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_7 = "_encstr_B84E14BBF0C6BFDB18D37B4B97586683E2C95371389F";

  if(isDefined(var_1))
    var_7 = var_1;

  var_0.deployweaponobj = getcompleteweaponname(var_7);
  var_8 = var_0.deployweaponobj;

  if(!candeploykillstreak(var_0, var_8))
    return 0;

  ondeploystart(var_0);
  var_9 = switchtodeployweapon(var_8, var_0, ::waituntilfinishedwithdeployweapon, var_2, var_3, var_5, var_6);

  if(!istrue(var_9)) {
    ondeployfinished(var_0, 0);
    return 0;
  }

  var_10 = watchdeployweaponfired(var_0, "_encstr_9B620D8F0DC07577C551F16A3826BF", var_8, var_4);
  ondeployfinished(var_0, var_10);
  return istrue(var_10);
}

switchtodeployweapon(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");

  if(self hasweapon(var_0))
    return 0;

  if(level.gametype != "_encstr_B607038AAB") {
    if(createheadicon(self getcurrentweapon()) == "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB") {
      self notify("_encstr_8EE016B9EE2D8E6CA1AC32FA3327DBB6EBAD2DE64B9D5D37");

      while(createheadicon(self getcurrentweapon()) == "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB")
        waitframe();
    }
  }

  if(!isDefined(var_7))
    var_7 = 1;

  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0, 0, 0, var_7);
  var_8 = callweapongivencallback(var_1, var_3);

  if(!istrue(var_8)) {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
    return 0;
  }

  thread watchforcancelduringweaponswitch(var_1, var_0);
  thread watchformeleeduringweaponswitch(var_1, var_0);
  var_9 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0);
  var_1 notify("_encstr_85931B9F35694AFFBA617F3FB8B3A7325F56235425F7C207C1F00B27E8");

  if(isDefined(var_4))
    self thread[[var_4]](var_1, var_9);

  waitframe();

  if(!var_9)
    var_2 = undefined;

  if(!scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  thread cleanupdeployweapon(var_9, var_1, var_0, var_2, var_5, var_6);
  return var_9;
}

callweapongivencallback(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8AAE22202AA587E9FB0FE769040F105B8D622860F3BF3B605F5CFD5FEC279A0BB7EA88D0");

  if(isDefined(var_1))
    return self[[var_1]](var_0);

  return 1;
}

watchforcancelduringweaponswitch(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_85931B9F35694AFFBA617F3FB8B3A7325F56235425F7C207C1F00B27E8");
  self waittill("_encstr_8AAE22202AA587E9FB0FE769040F105B8D622860F3BF3B605F5CFD5FEC279A0BB7EA88D0");

  if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(var_1))
    scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var_1);
}

watchformeleeduringweaponswitch(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_85931B9F35694AFFBA617F3FB8B3A7325F56235425F7C207C1F00B27E8");
  self waittill("_encstr_8272124FD0706552B7B6CB441FFBC93BDB68BB53");

  if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(var_1))
    scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var_1);
  else {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1);
    thread scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(self.lastdroppableweaponobj);
  }
}

watchdeployweaponfired(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  self endon("_encstr_8AAE22202AA587E9FB0FE769040F105B8D622860F3BF3B605F5CFD5FEC279A0BB7EA88D0");

  for(;;) {
    var_4 = undefined;
    var_5 = undefined;

    switch (var_1) {
      case "_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19":
        self waittill(var_1, var_4);
        break;
      case "_encstr_A2600E386AB2399AF3D9B99FA3BDBAA0":
        self waittill(var_1, var_4);
        break;
      case "_encstr_9B620D8F0DC07577C551F16A3826BF":
        self waittill(var_1, var_5, var_4);
        break;
      default:
        self waittill(var_1);
        break;
    }

    if(var_4 == var_2) {
      if(isDefined(var_3)) {
        var_6 = [[var_3]](var_0, var_4, var_5);

        if(!isDefined(var_6))
          return 0;
        else if(var_6 == "_encstr_9724088623A8FD3FD659")
          return 0;
        else if(var_6 == "_encstr_AFAC097640D8DC32A87307") {
          if(isDefined(level.votes))
            [[level.votes]]();

          continue;
        } else if(var_6 == "_encstr_88E30897BDF1B71F7823")
          return 1;
        else
          return 0;
      }

      return 1;
    }
  }

  return 0;
}

watchdeployweaponanimtransition(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(var_2))
    var_2 = 1;

  var_3 = "_encstr_84391A8DDB29BB5AF11977634D2D82E381E306D6B02B6CF15C134763";

  switch (var_0.streakname) {
    case "_encstr_B8BA05F06B9785":
      var_3 = "_encstr_AFBF1A5BC1AFDA4BD8B1E6479C592CD6D7DCD5D62BD78EB0C4B1AC1D";
      break;
    case "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A":
      var_3 = "_encstr_81851A9F5FB0B9D9CB92F991EF10D7F1633B355DA807232E6D29C973";
      break;
    case "_encstr_B270105ECB28E94BC5CFABAB937D524C5053":
      var_3 = "_encstr_92BF1A90ABD05F89238543466D6FB0FBEA731863225171814BB45D3D";
      break;
    case "_encstr_86FD08B775CD07DC1338":
      var_3 = "_encstr_849013F2D81189C7FB783B2883235F0BCBE82A8A68";
      break;
    case "_encstr_B1B30B51D176511E377A1BC313":
      var_3 = "_encstr_9B4A14674FFA60B343DF27594EE7831FD93398509B9B";
      break;
  }

  self playlocalsound(var_3);
  scripts\cp_mp\utility\player_utility::setusingremote(var_0.streakname);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_AFA91575E1F8CD92A54B4B1F2B406909204F2D7E3A2882") && isDefined(self.pinnedobjid)) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_AFA91575E1F8CD92A54B4B1F2B406909204F2D7E3A2882")]](self.pinnedobjid, self);
    self.remoteunpinned = 1;
  }

  scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "_encstr_B1D411B596C6B1B98E272BC2AD4459E08DDBF2");
  thread unfreezecontrolsonroundend();

  if(istrue(var_2))
    thread startweapontabletfadetransition(var_1 - 0.3);

  thread watchweapontabletstop(var_0);
  thread watchweapontabletcallinpos();
  var_4 = scripts\engine\utility::_id_143BB(var_1, "_encstr_AD75063D571AE108", "_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", "_encstr_8AAE22202AA587E9FB0FE769040F105B8D622860F3BF3B605F5CFD5FEC279A0BB7EA88D0");
  self notify("_encstr_8A7B0EDA8FB90C908071386FC16FD8C7");
  scripts\cp_mp\utility\player_utility::_freezecontrols(0, undefined, "_encstr_B1D411B596C6B1B98E272BC2AD4459E08DDBF2");

  if(!isDefined(var_4) || var_4 != "_encstr_995408F398012F656821" || !self isonground() || self isonladder()) {
    var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
    self stoplocalsound("_encstr_84391A8DDB29BB5AF11977634D2D82E381E306D6B02B6CF15C134763");
    self notify("_encstr_B44F170EF9A0B39AF17F73277328D3ED81030712932B76325D");
    return 0;
  }

  self notify("_encstr_B24F1EE0FBE8E1051377BB0F338AEF23A199862CC8EF5893704BE59E6648D8D1");
  return 1;
}

unfreezecontrolsonroundend() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8A7B0EDA8FB90C908071386FC16FD8C7");
  level waittill("_encstr_8CBD0DDE3DB33D51871F70886BD3A8");
  scripts\cp_mp\utility\player_utility::_freezecontrols(0, undefined, "_encstr_B1D411B596C6B1B98E272BC2AD4459E08DDBF2");
}

startweapontabletfadetransition(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = scripts\engine\utility::_id_143B9(var_0, "_encstr_B44F170EF9A0B39AF17F73277328D3ED81030712932B76325D");

  if(!isDefined(var_1) || var_1 == "_encstr_B44F170EF9A0B39AF17F73277328D3ED81030712932B76325D") {
    return;
  }
  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    self playlocalsound("_encstr_931C204560D17FF0D85AD63B0A588FA41F35D27773DF2243F0F84AA1DFC075E757E0");
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0.3);
    var_1 = scripts\engine\utility::_id_143B9(0.7, "_encstr_AD75063D571AE108");

    if(!isDefined(var_1) || var_1 == "_encstr_AD75063D571AE108")
      self stoplocalsound("_encstr_931C204560D17FF0D85AD63B0A588FA41F35D27773DF2243F0F84AA1DFC075E757E0");

    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 0.3);
  }
}

watchweapontabletstop(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 waittill("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
  scripts\cp_mp\utility\killstreak_utility::stoptabletscreen(0.325);
  scripts\cp_mp\utility\player_utility::clearusingremote();
}

watchweapontabletcallinpos() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_B24F1EE0FBE8E1051377BB0F338AEF23A199862CC8EF5893704BE59E6648D8D1");
  self endon("_encstr_B44F170EF9A0B39AF17F73277328D3ED81030712932B76325D");

  for(;;) {
    if(!self isonground()) {
      streakdeploy_cancelalldeployments();
      break;
    }

    waitframe();
  }
}

waituntilfinishedwithdeployweapon(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  scripts\engine\utility::waittill_any_ents(var_0, "_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E", self, "_encstr_8AAE22202AA587E9FB0FE769040F105B8D622860F3BF3B605F5CFD5FEC279A0BB7EA88D0", self, "_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
}

cleanupdeployweapon(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");

  if(isDefined(var_3))
    self[[var_3]](var_1);

  if(self hasweapon(var_2)) {
    var_6 = scripts\cp_mp\utility\killstreak_utility::use_contract(var_2.basename);
    var_7 = scripts\cp_mp\utility\killstreak_utility::ismapselectkillstreak(var_1.streakname);
    scripts\common\utility::allow_melee(0);
    scripts\common\utility::allow_offhand_weapons(0);
    scripts\common\utility::brjugg_droponplayerdeath(0);

    if(var_6) {
      scripts\common\utility::allow_mantle(0);
      scripts\common\utility::allow_movement(0);
      scripts\cp_mp\utility\player_utility::_freezelookcontrols(1);
    } else if(istrue(var_7))
      scripts\common\utility::allow_mantle(0);

    if(isDefined(var_4))
      self[[var_4]](var_1, var_0, var_2);
    else
      rocket_fuel(var_2);

    scripts\common\utility::allow_melee(1);
    scripts\common\utility::allow_offhand_weapons(1);
    scripts\common\utility::brjugg_droponplayerdeath(1);

    if(var_6) {
      scripts\common\utility::allow_mantle(1);
      scripts\common\utility::allow_movement(1);
      scripts\cp_mp\utility\player_utility::_freezelookcontrols(0);
    } else if(istrue(var_7))
      scripts\common\utility::allow_mantle(1);
  }

  if(isDefined(var_5))
    self[[var_5]](var_1);
}

rocket_fuel(var_0) {
  scripts\cp_mp\utility\inventory_utility::getridofweapon(var_0);
  var_1 = self getcurrentweapon();

  if(var_1.basename == "_encstr_8BBA05185F8B99")
    scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
}

candeploykillstreakweapon(var_0, var_1) {
  if(self hasweapon(var_1))
    return "_encstr_AD481BB44A2689D4454A8AA02DD4CB3482C99C3D45BE908AFA55A9A888";

  if(self isonladder())
    return "_encstr_AD481BB44A2689D4454A8AA02DD4CB3482C99C3D45BE908AFA55A9A888";

  if(self ismantling())
    return "_encstr_AD481BB44A2689D4454A8AA02DD4CB3482C99C3D45BE908AFA55A9A888";

  if(!scripts\common\utility::is_weapon_switch_allowed())
    return "_encstr_AD481BB44A2689D4454A8AA02DD4CB3482C99C3D45BE908AFA55A9A888";

  if(istrue(self.alreadytouchingtrigger))
    return "_encstr_AD481BB44A2689D4454A8AA02DD4CB3482C99C3D45BE908AFA55A9A888";

  if((scripts\cp_mp\utility\killstreak_utility::isridekillstreak(var_0.streakname) || scripts\cp_mp\utility\killstreak_utility::ismapselectkillstreak(var_0.streakname)) && !self isonground())
    return "_encstr_AD481BB44A2689D4454A8AA02DD4CB3482C99C3D45BE908AFA55A9A888";

  if(scripts\cp_mp\utility\player_utility::isusingremote())
    return "_encstr_AD481BB44A2689D4454A8AA02DD4CB3482C99C3D45BE908AFA55A9A888";

  return;
}

streakdeploy_giveandfireoffhandreliable(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self giveandfireoffhand(var_0);

  if(!self hasweapon(var_0)) {
    self notify("_encstr_9A4E2129A4151FD88DB20B8F0DB5F82A1F698A88712353CCB71FB8C00D635AA29AB511", var_0);
    return 0;
  }

  var_1 = spawnStruct();
  var_1 childthread streakdeploy_watchgiveandfireoffhandreliablesuccess(self, var_0);
  var_1 childthread streakdeploy_watchgiveandfireoffhandreliablefailure(self, var_0);
  var_1 waittill("_encstr_85740BF696FA032EB36BB83873");
  waittillframeend;
  var_1 notify("_encstr_A9010985E752D59115EDF1");

  if(istrue(var_1.success)) {
    self notify("_encstr_9B2024344BCB55CE988B0DB82D8D4F2E6773872B3397C261ABBB95CCFFDACD9A4A1F7354A357", var_0);
    return 1;
  } else if(istrue(var_1.failure)) {
    self notify("_encstr_9A4E2129A4151FD88DB20B8F0DB5F82A1F698A88712353CCB71FB8C00D635AA29AB511", var_0);
    return 0;
  }
}

streakdeploy_watchgiveandfireoffhandreliablesuccess(var_0, var_1) {
  self endon("_encstr_A9010985E752D59115EDF1");
  var_0 waittillmatch("_encstr_A2600E386AB2399AF3D9B99FA3BDBAA0", var_1);
  self.success = 1;
  self notify("_encstr_85740BF696FA032EB36BB83873");
}

streakdeploy_watchgiveandfireoffhandreliablefailure(var_0, var_1) {
  self endon("_encstr_A9010985E752D59115EDF1");

  while(var_0 hasweapon(var_1))
    waitframe();

  self.failure = 1;
  self notify("_encstr_85740BF696FA032EB36BB83873");
}