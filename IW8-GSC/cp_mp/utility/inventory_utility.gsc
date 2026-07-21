/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\utility\inventory_utility.gsc
***********************************************/

_giveweapon(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = -1;

  if(!isDefined(var_3))
    var_3 = 0;

  self giveweapon(var_0, var_1, istrue(var_2), -1, var_3);
}

_switchtoweapon(var_0) {
  self switchtoweapon(var_0);
}

_switchtoweaponimmediate(var_0) {
  self switchtoweaponimmediate(var_0);
}

_takeweapon(var_0, var_1) {
  var_2 = 0;

  if(issameweapon(var_0))
    var_2 = self gethighpriorityweapon() == var_0;
  else
    var_2 = createheadicon(self gethighpriorityweapon()) == var_0;

  if(var_2) {
    var_3 = var_0;

    if(!isstring(var_3) && issameweapon(var_0))
      var_3 = createheadicon(var_0);

    self clearhighpriorityweapon(var_0);
  }

  self takeweapon(var_0);
}

takeweaponwhensafe(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    var_1 = 0;

    if(!iscurrentweapon(var_0)) {
      var_2 = self getweaponmeleeslot();

      if(!nullweapon(var_2) && self.currentweapon == var_2)
        var_1 = 0;
      else
        var_1 = 1;
    }

    if(var_1) {
      break;
    }

    waitframe();
  }

  _takeweapon(var_0);
}

getcurrentmonitoredweaponswitchweapon() {
  validatehighpriorityflag();
  var_0 = self gethighpriorityweapon();

  if(nullweapon(var_0))
    return undefined;

  return var_0;
}

isanymonitoredweaponswitchinprogress() {
  return isDefined(getcurrentmonitoredweaponswitchweapon());
}

isswitchingtoweaponwithmonitoring(var_0) {
  if(isstring(var_0))
    var_0 = asmdevgetallstates(var_0);

  var_1 = getcurrentmonitoredweaponswitchweapon();
  return isDefined(var_1) && var_1 == var_0 && !iscurrentweapon(var_0);
}

candomonitoredswitchtoweapon(var_0, var_1) {
  if(!self hasweapon(var_0))
    return 0;

  if(!scripts\common\utility::is_weapon_allowed())
    return 0;

  if(!istrue(var_1) && !scripts\common\utility::is_weapon_switch_allowed() && !scripts\common\utility::is_script_weapon_switch_allowed())
    return 0;

  var_2 = getcurrentmonitoredweaponswitchweapon();

  if(isDefined(var_2)) {
    var_3 = getweaponbasename(var_0);
    var_4 = 0;

    if(var_3 == "_encstr_812C128152B9F8E4EA670F3B8722B8704AE1E85B" || var_3 == "_encstr_B108190EAE4BCAC6C9A07F2F3981B732355017471CAB630D96F86B" || var_3 == "_encstr_976A10EB17828EAF30525010DACD41460FB8" || var_3 == "_encstr_A17810A09B234F7B6B65343E7993A0871D53")
      var_4 = 1;
    else if(weaponinventorytype(var_2) == "_encstr_BA7F0830B3A7859B60B0")
      var_4 = 1;

    if(!var_4)
      return 0;
  }

  if(iscurrentweapon(var_0))
    return 0;

  return 1;
}

abortmonitoredweaponswitch(var_0) {
  if(self gethighpriorityweapon() == var_0)
    self clearhighpriorityweapon(var_0);

  _takeweapon(var_0);
  return;
}

domonitoredweaponswitch(var_0, var_1, var_2) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(var_0))
    return 0;

  if(!candomonitoredswitchtoweapon(var_0, var_2))
    return 0;

  if(isanymonitoredweaponswitchinprogress())
    self clearhighpriorityweapon(getcurrentmonitoredweaponswitchweapon());

  self sethighpriorityweapon(var_0);

  if(istrue(var_1))
    _switchtoweaponimmediate(var_0);

  for(;;) {
    if(iscurrentweapon(var_0)) {
      validatehighpriorityflag();
      return 1;
    }

    if(!self ishighpriorityweapon(var_0) || !self hasweapon(var_0))
      return 0;

    if(!scripts\common\utility::is_weapon_allowed() || !istrue(var_2) && !scripts\common\utility::is_weapon_switch_allowed() && !scripts\common\utility::is_script_weapon_switch_allowed()) {
      self clearhighpriorityweapon(var_0);
      return 0;
    }

    waitframe();
  }
}

validatehighpriorityflag() {
  var_0 = self getcurrentweapon();

  if(self ishighpriorityweapon(var_0))
    self clearhighpriorityweapon(var_0);
}

getridofweapon(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!self hasweapon(var_0))
    return 0;

  if(!iscurrentweapon(var_0)) {
    _takeweapon(var_0);
    return 1;
  }

  while(isanymonitoredweaponswitchinprogress())
    waitframe();

  if(!iscurrentweapon(var_0)) {
    _takeweapon(var_0);
    return 1;
  }

  var_2 = domonitoredweaponswitch(self.lastdroppableweaponobj, var_1);

  if(isbot(self)) {
    self switchtoweaponimmediate(isundefinedweapon());
    var_2 = 1;
  }

  _takeweapon(var_0);
  self notify("_encstr_A5DB1426DB5B26D70B36B17BDDD7EDCC3343B0B9C837");

  if(!var_2)
    forcevalidweapon();

  return 1;
}

forcevalidweapon(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  while(nullweapon(self getcurrentweapon())) {
    if(self isswitchingweapon() || isanymonitoredweaponswitchinprogress()) {
      waitframe();
      continue;
    }

    var_1 = var_0;

    if(istrue(self.isjuggernaut)) {
      var_2 = "_encstr_9B1315648431B1256020FFFFC0B8EBBB4D1D6F1F7833FB";

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_A3E5115F78581833C82D3178FE841059AFE858"))
        var_2 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_A3E5115F78581833C82D3178FE841059AFE858")]]();

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_BA2F14D80B9BAA6EB2EAACB083B79B414B6C6DD5E0B9")) {
        var_3 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_BA2F14D80B9BAA6EB2EAACB083B79B414B6C6DD5E0B9")]]();

        if(istrue(var_3)) {
          if(isDefined(self.lastdroppableweaponobj) && self hasweapon(self.lastdroppableweaponobj))
            var_2 = self.lastdroppableweaponobj;
          else {
            var_4 = getcurrentprimaryweaponsminusalt();

            if(var_4.size > 0)
              var_2 = var_4[0];
          }
        }
      }

      var_1 = getcompleteweaponname(var_2);
    } else {
      var_4 = getcurrentprimaryweaponsminusalt();

      if(!isDefined(var_1) || !self hasweapon(var_1)) {
        if(!isDefined(self.lastdroppableweaponobj) || self.lastdroppableweaponobj.basename == "_encstr_8BBA05185F8B99") {
          break;
        }

        if(self hasweapon(self.lastdroppableweaponobj))
          var_1 = self.lastdroppableweaponobj;
        else if(var_4.size > 0)
          var_1 = var_4[0];
      }

      if(isDefined(var_1) && getweaponbasename(var_1) == "_encstr_82060BC06F232071438BBFC321" && self getweaponammoclip(var_1) == 0 && var_4.size == 1)
        var_1.basename = "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C";
      else if(self hasweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C")) {
        if(var_4.size == 1)
          var_1 = var_4[0];
        else if(var_4.size == 2 && (self hasweapon("_encstr_AFBB115ADD1CD75BDCA5CC56DC1D2CC4D7DAC1") || self hasweapon("_encstr_B6202030B8C2304120681F3C3C48493BD6B4CC476F18BBF297D92FA5085FC1F7E5FB") || self hasweapon("_encstr_93C224EC0CC949B4C8586F07A8209FB2CDABB767E0ABB2EDF1100347E0FE5D1AB135FF1151E9") || self hasweapon("_encstr_A10A211A6393EF8BD845C7C76BB01777D0D86242CE0583041051FFD51B885FB790F07B"))) {
          if(var_4[0].basename == "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C")
            var_1 = var_4[0];
          else
            var_1 = var_4[1];
        }
      }
    }

    domonitoredweaponswitch(var_1);
    waitframe();
  }
}

iscurrentweapon(var_0) {
  if(isstring(var_0))
    var_0 = asmdevgetallstates(var_0);

  return isnullweapon(self getcurrentweapon(), var_0, 1);
}

getcurrentprimaryweaponsminusalt() {
  var_0 = [];
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(!var_3.isalternate)
      var_0[var_0.size] = var_3;
  }

  return var_0;
}