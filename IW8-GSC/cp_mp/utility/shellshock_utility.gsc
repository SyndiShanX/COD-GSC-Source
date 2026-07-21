/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\utility\shellshock_utility.gsc
************************************************/

_shellshock(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4))
    var_4 = [[level.shockinterruptdelayfuncs[var_1]]](var_0, var_2);

  var_5 = gettime() + var_4;

  if(var_1 != "_encstr_AC190479FF92") {
    if(!scripts\common\utility::is_shellshock_allowed())
      return 0;
  }

  if(isDefined(self.shockcategory)) {
    var_6 = level.shockpriorities[self.shockcategory];
    var_7 = level.shockpriorities[var_1];

    if(var_7 > var_6) {
      if(gettime() < self.shockinterrupttime)
        return 0;
    } else if(var_7 == var_6) {
      if(var_5 < self.shockinterrupttime)
        return 0;
    } else if(var_7 < var_6)
      return 0;
  }

  self.shockname = var_0;
  self.shockcategory = var_1;
  self.shockinterrupttime = var_5;

  if(isDefined(var_3))
    self shellshock(var_0, var_2, var_3);
  else
    self shellshock(var_0, var_2);

  self notify("_encstr_A6091499035BE76D1867E0FF5FF87937F179F212AB2F");
  thread shellshock_cleanup(var_2);
}

_stopshellshock(var_0) {
  self notify("_encstr_8CDA10D74F9D52D00198D79DF0E968AAFE97");

  if(!istrue(var_0))
    self stopshellshock();

  self.shockname = undefined;
  self.shockcategory = undefined;
  self.shockinterrupttime = undefined;
}

enableshellshockfunc() {}

disableshellshockfunc() {
  _stopshellshock(scripts\cp_mp\utility\player_utility::_isalive());
}

shellshock_artilleryearthquake(var_0, var_1, var_2, var_3, var_4) {
  playrumbleonposition("_encstr_A9D111B0278EA5D8D85939CBF5E4AED613D8B2", var_0);

  if(!isDefined(var_1))
    var_1 = 0.7;

  if(!isDefined(var_2))
    var_2 = 0.5;

  if(!isDefined(var_3))
    var_3 = 800;

  earthquake(var_1, var_2, var_0, var_3);
  shellshock_screenshakeonposition(var_0, var_3, var_4);
}

shellshock_screenshakeonposition(var_0, var_1, var_2) {
  var_3 = scripts\common\utility::playersinsphere(var_0, var_1);

  foreach(var_5 in var_3) {
    if(!isDefined(var_5)) {
      continue;
    }
    if(isDefined(var_2)) {
      if(isarray(var_2)) {
        if(scripts\engine\utility::array_contains(var_2, var_5))
          continue;
      } else if(var_5 == var_2)
        continue;
    }

    if(var_5 scripts\cp_mp\utility\player_utility::isusingremote()) {
      continue;
    }
    var_5 setclientomnvar("_encstr_BA2A0D5D4BD743AE32EB6E340BB559", 1);
  }
}

shellshock_utility_init() {
  level.enableshellshockfunc = ::enableshellshockfunc;
  level.disableshellshockfunc = ::disableshellshockfunc;
  level.shockpriorities = [];
  level.shockpriorities["_encstr_AC190479FF92"] = 0;
  level.shockpriorities["_encstr_88A906570DDE7B21"] = 1;
  level.shockpriorities["_encstr_9B1905D3B92BF0"] = 2;
  level.shockpriorities["_encstr_9B1804C793EB"] = 3;
  level.shockpriorities["_encstr_8E440A950FE01BB76E96BDE6"] = 4;
  level.shockpriorities["_encstr_B2BE0788BAF573592F"] = 4;
  level.shockpriorities["_encstr_A146078E65FB5158DD"] = 5;
  level.shockinterruptdelayfuncs["_encstr_AC190479FF92"] = ::shellshock_interruptdelayfunc;
  level.shockinterruptdelayfuncs["_encstr_88A906570DDE7B21"] = ::shellshock_flashinterruptdelayfunc;
  level.shockinterruptdelayfuncs["_encstr_9B1905D3B92BF0"] = ::shellshock_stuninterruptdelayfunc;
  level.shockinterruptdelayfuncs["_encstr_9B1804C793EB"] = ::shellshock_gasinterruptdelayfunc;
  level.shockinterruptdelayfuncs["_encstr_8E440A950FE01BB76E96BDE6"] = ::shellshock_interruptdelayfunc;
  level.shockinterruptdelayfuncs["_encstr_B2BE0788BAF573592F"] = ::shellshock_damageinterruptdelayfunc;
  level.shockinterruptdelayfuncs["_encstr_A146078E65FB5158DD"] = ::shellshock_nointerruptdelayfunc;
}

shellshock_cleanup(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8CDA10D74F9D52D00198D79DF0E968AAFE97");
  self endon("_encstr_A6091499035BE76D1867E0FF5FF87937F179F212AB2F");
  wait(var_0);
  self.shockname = undefined;
  self.shockcategory = undefined;
  self.shockinterrupttime = undefined;
}

shellshock_interruptdelayfunc(var_0, var_1) {
  return 250.0;
}

shellshock_flashinterruptdelayfunc(var_0, var_1) {
  var_2 = undefined;

  switch (var_0) {
    case "_encstr_AB0B1199B158CD0DAF76C9B2DC0B2395D7B683":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8CF40B9B3BFD1849BB9CC8C6B4", "_encstr_AFDA186663169B1A92B94795934EBA83D1882BC60B9791AECDC6"))
        var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8CF40B9B3BFD1849BB9CC8C6B4", "_encstr_AFDA186663169B1A92B94795934EBA83D1882BC60B9791AECDC6")]](var_1);

      break;
    case "_encstr_A6D514333658CD0DFA9D4E2BB9584656EBB538FA0F64":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8CF40B9B3BFD1849BB9CC8C6B4", "_encstr_AFDA186663169B1A92B94795934EBA83D1882BC60B9791AECDC6"))
        var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8CF40B9B3BFD1849BB9CC8C6B4", "_encstr_AFDA186663169B1A92B94795934EBA83D1882BC60B9791AECDC6")]](var_1);

      break;
    default:
  }

  return var_2;
}

shellshock_stuninterruptdelayfunc(var_0, var_1) {
  var_2 = undefined;

  switch (var_0) {
    case "_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8CF40B9B3BFD1849BB9CC8C6B4", "_encstr_83631D97EFB2E6F013BA4098E5C1E0A5FA732D332BBB2D0854164AB5CBDED0"))
        var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8CF40B9B3BFD1849BB9CC8C6B4", "_encstr_83631D97EFB2E6F013BA4098E5C1E0A5FA732D332BBB2D0854164AB5CBDED0")]](var_1);

      break;
    default:
  }

  return var_2;
}

shellshock_gasinterruptdelayfunc(var_0, var_1) {
  var_2 = undefined;

  switch (var_0) {
    case "_encstr_B11215D9C2CDF59D4E567358322BFA1BB43B43E8BE5B07":
    case "_encstr_A79B156C86EB6739A25FB0B023CD7641D22E5CEB91E2C1":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8CF40B9B3BFD1849BB9CC8C6B4", "_encstr_92C6169D2CB94AB93A2BC94EBAE047225636B05E32ABDCD8"))
        var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8CF40B9B3BFD1849BB9CC8C6B4", "_encstr_92C6169D2CB94AB93A2BC94EBAE047225636B05E32ABDCD8")]](var_1);

      break;
    default:
      var_2 = shellshock_interruptdelayfunc(var_1);
  }

  return var_2;
}

shellshock_damageinterruptdelayfunc(var_0, var_1) {
  var_2 = undefined;

  switch (var_0) {
    case "_encstr_AD740E39563BE1EE732BF89873876021":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8CF40B9B3BFD1849BB9CC8C6B4", "_encstr_888F1CD858E6D19AA385B946A4B9E859C939D538A311CA632CBC19AB376C"))
        var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8CF40B9B3BFD1849BB9CC8C6B4", "_encstr_888F1CD858E6D19AA385B946A4B9E859C939D538A311CA632CBC19AB376C")]](var_1);

      break;
    default:
      var_2 = shellshock_interruptdelayfunc(var_1);
  }

  return var_2;
}

shellshock_nointerruptdelayfunc(var_0, var_1) {
  return 0;
}