/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\currency.gsc
***********************************************/

#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace currency;

function init_currency() {
  function_68a07bf45b0ba30a();
  level thread function_c1674a2bf8fcb89a();
}

function function_c1674a2bf8fcb89a() {
  waitframe();
}

function function_68a07bf45b0ba30a() {
  if(isDefined(level.gamemodebundle.pricelist) && !isDefined(level.var_4ae3d29e068b4901)) {
    level.var_4ae3d29e068b4901 = getscriptbundle("pricelist:" + level.gamemodebundle.pricelist);
    level.var_4ae3d29e068b4901.var_163ce105edf9e5de = [];
    level.var_4ae3d29e068b4901.var_1982789b1e12442b = [];
    assertex(isDefined(level.var_4ae3d29e068b4901.var_d5753c1d2046e1c4), "<dev string:x1c>" + level.gamemodebundle.pricelist + "<dev string:x3e>");

    foreach(var_98249fc6e5334ea1 in level.var_4ae3d29e068b4901.var_d5753c1d2046e1c4) {
      if(!isDefined(level.var_4ae3d29e068b4901.var_163ce105edf9e5de[var_98249fc6e5334ea1.var_645b9579909be3f8])) {
        level.var_4ae3d29e068b4901.var_163ce105edf9e5de[var_98249fc6e5334ea1.var_645b9579909be3f8] = getscriptbundle("currency:" + var_98249fc6e5334ea1.var_645b9579909be3f8);
      }
    }

    foreach(var_be041469fc4704b in level.var_4ae3d29e068b4901.var_36a99886b712dcc3) {
      if(isDefined(var_be041469fc4704b.var_3fd8eff0621723c9) && isDefined(var_be041469fc4704b.var_af40863a32d7792b)) {
        level.var_4ae3d29e068b4901.var_1982789b1e12442b[var_be041469fc4704b.var_3fd8eff0621723c9] = spawnStruct();
        level.var_4ae3d29e068b4901.var_1982789b1e12442b[var_be041469fc4704b.var_3fd8eff0621723c9].value = var_be041469fc4704b.var_af40863a32d7792b;
        level.var_4ae3d29e068b4901.var_1982789b1e12442b[var_be041469fc4704b.var_3fd8eff0621723c9].currency = var_be041469fc4704b.var_38d055f24fe64e71;
      }
    }
  }
}

function function_2e815a7b6d0bbcf6() {
  return level.var_4ae3d29e068b4901;
}

function function_7714028270738890(var_147708c583186e71) {
  return level.var_4ae3d29e068b4901.var_163ce105edf9e5de[var_147708c583186e71];
}

function function_7dfe1b812431019f(str_currency) {
  if(isDefined(level.var_4ae3d29e068b4901) && isDefined(level.var_4ae3d29e068b4901.var_d5753c1d2046e1c4)) {
    foreach(var_98249fc6e5334ea1 in level.var_4ae3d29e068b4901.var_d5753c1d2046e1c4) {
      if(isDefined(var_98249fc6e5334ea1.var_645b9579909be3f8) && level.var_4ae3d29e068b4901.var_163ce105edf9e5de[var_98249fc6e5334ea1.var_645b9579909be3f8].currencyname == str_currency) {
        return default_to(var_98249fc6e5334ea1.var_9247b3a807fe55ec, 0);
      }
    }
  }
}

function function_3321003104b9507e(var_3719061529ddd848) {
  return level.var_4ae3d29e068b4901.var_1982789b1e12442b[var_3719061529ddd848];
}

function get_perk_machine_cost(str_perk) {
  var_2d823173121c345a = function_ea6ad508534fc509(str_perk);

  if(!isDefined(var_2d823173121c345a)) {
    return;
  }

  return var_2d823173121c345a.var_10d2cda4ce007c3b;
}

function function_bc4d94fa05ac7078(str_perk) {
  var_2d823173121c345a = function_ea6ad508534fc509(str_perk);

  if(!isDefined(var_2d823173121c345a)) {
    return "essence";
  } else if(isDefined(var_2d823173121c345a.var_3995211e6d9a4259)) {
    var_2de54af70b9cbe75 = function_7714028270738890(var_2d823173121c345a.var_3995211e6d9a4259);
    return var_2de54af70b9cbe75.currencyname;
  }

  println("<dev string:x85>" + level.gamemodebundle.pricelist + "<dev string:xc8>" + str_perk + "<dev string:xd1>" + "<dev string:xe5>");
  return "essence";
}

function private function_ea6ad508534fc509(str_perk) {
  var_c82bc608d1423259 = function_2e815a7b6d0bbcf6();

  if(isDefined(var_c82bc608d1423259) && isDefined(var_c82bc608d1423259.var_fff87512f24a9908)) {
    foreach(var_3cdbf17f49ef52e8 in var_c82bc608d1423259.var_fff87512f24a9908) {
      if(isDefined(var_3cdbf17f49ef52e8.var_cb1f5a302f01f831) && var_3cdbf17f49ef52e8.var_cb1f5a302f01f831 == str_perk) {
        return var_3cdbf17f49ef52e8;
      }
    }

    println("<dev string:xf0>" + level.gamemodebundle.pricelist + "<dev string:xc8>" + str_perk);
  }
}

function function_51ff679cabccfcd0() {
  if(!isDefined(level.gamemodebundle.pricelist)) {
    return;
  }

  var_c82bc608d1423259 = function_2e815a7b6d0bbcf6();
  assertex(isDefined(var_c82bc608d1423259.var_63f11055773fb7d6), "<dev string:x130>" + level.gamemodebundle.pricelist);
  return var_c82bc608d1423259.var_63f11055773fb7d6;
}

function function_fd307a39427b77da() {
  if(!isDefined(level.gamemodebundle.pricelist)) {
    return;
  }

  var_c82bc608d1423259 = function_2e815a7b6d0bbcf6();
  assertex(isDefined(var_c82bc608d1423259.var_f26b80cb6833eb9), "<dev string:x152>" + level.gamemodebundle.pricelist);
  return var_c82bc608d1423259.var_f26b80cb6833eb9;
}

function function_86ff2975af8e08be() {
  if(!isDefined(level.gamemodebundle.pricelist)) {
    return;
  }

  var_c82bc608d1423259 = function_2e815a7b6d0bbcf6();
  var_2de54af70b9cbe75 = function_7714028270738890(var_c82bc608d1423259.var_8e4ed0273dc8b664);
  assertex(isDefined(var_c82bc608d1423259.var_8e4ed0273dc8b664) && isDefined(var_2de54af70b9cbe75.currencyname), "<dev string:x17e>" + level.gamemodebundle.pricelist);
  return var_2de54af70b9cbe75.currencyname;
}

function private function_a6b6cc77c4485d21(var_545dc2e67db04095) {
  if(!isDefined(level.gamemodebundle.pricelist)) {
    return;
  }

  var_c82bc608d1423259 = function_2e815a7b6d0bbcf6();

  if(isDefined(var_c82bc608d1423259) && isDefined(var_c82bc608d1423259.var_1f851a428523f96b)) {
    foreach(var_7b9786d925211f8c in var_c82bc608d1423259.var_1f851a428523f96b) {
      if(isDefined(var_7b9786d925211f8c.var_3a186553b8a52af5) && var_7b9786d925211f8c.var_3a186553b8a52af5 == var_545dc2e67db04095) {
        return var_7b9786d925211f8c;
      }
    }
  }
}

function function_93cabb608eabdb7c(var_545dc2e67db04095) {
  var_7b9786d925211f8c = function_a6b6cc77c4485d21(var_545dc2e67db04095);

  if(!isDefined(var_7b9786d925211f8c)) {
    return;
  }

  return var_7b9786d925211f8c.var_4e0e100f89227f67;
}

function function_57e6c79279b89596(var_545dc2e67db04095) {
  var_7b9786d925211f8c = function_a6b6cc77c4485d21(var_545dc2e67db04095);

  if(!isDefined(var_7b9786d925211f8c)) {
    return;
  }

  return var_7b9786d925211f8c.var_e6e7b751029bb9dc;
}

function function_98aedb8cf660c612(var_545dc2e67db04095) {
  var_7b9786d925211f8c = function_a6b6cc77c4485d21(var_545dc2e67db04095);

  if(!isDefined(var_7b9786d925211f8c)) {
    return;
  }

  var_2de54af70b9cbe75 = function_7714028270738890(var_7b9786d925211f8c.var_e7a5769148797e0d);
  assertex(isDefined(var_7b9786d925211f8c.var_e7a5769148797e0d) && isDefined(var_2de54af70b9cbe75.currencyname), "<dev string:x1a3>" + level.gamemodebundle.pricelist + "<dev string:xc8>" + var_545dc2e67db04095);
  return var_2de54af70b9cbe75.currencyname;
}

function function_cca1bcebd7aa11cf(currencytype, getfunc, setfunc, addfunc, subfunc, buysound, denysound) {
  if(isDefined(level.currency) && isDefined(level.currency[currencytype])) {
    assert("<dev string:x1cd>" + currencytype + "<dev string:x1db>");
    return;
  } else {
    level.currency = default_to(level.currency, []);
  }

  currencystruct = spawnStruct();
  level.currency[currencytype] = currencystruct;
  level.currency[currencytype].currencytype = currencytype;
  level.currency[currencytype].getfunc = getfunc;
  level.currency[currencytype].setfunc = setfunc;
  level.currency[currencytype].addfunc = addfunc;
  level.currency[currencytype].subfunc = subfunc;
  level.currency[currencytype].buysound = buysound;
  level.currency[currencytype].denysound = denysound;

  level thread function_2e0cc380e14c340b(currencytype);
}

function function_adc47eed1b02ec05(currencytype, var_978799e2da3eab39) {
  if(!isPlayer(self)) {
    assert("<dev string:x1f2>");
    return;
  }

  if(!isDefined(var_978799e2da3eab39)) {
    var_978799e2da3eab39 = 0;
  }

  function_d0948454b7f94d18(currencytype, var_978799e2da3eab39);

  if(getdvarint(@ "hash_bc19129b877ec86b", 0)) {
    thread function_d67d3f6e87682c71(self.currency.size, currencytype);
  }
}

function function_3036cef61495210f(currencytype, amount, reason) {
  var_65b4e89f87e61c2 = amount;

  if(isDefined(level.currency[currencytype].addfunc)) {
    self[[level.currency[currencytype].addfunc]](amount);
  } else {
    function_8301d03eb828b5a5(amount, currencytype);
  }

  sparams = spawnStruct();
  sparams.var_65b4e89f87e61c2 = var_65b4e89f87e61c2;
  sparams.currencytype = currencytype;
  sparams.amount = amount;
  sparams.reason = reason;
  callback::callback("currency_add", sparams);
}

function function_8301d03eb828b5a5(amount, currencytype) {
  var_3d7ffadeef043c6 = function_15975e20bbd2c824(currencytype);
  newamount = var_3d7ffadeef043c6 + amount;

  if(amount > 0 && newamount < var_3d7ffadeef043c6) {
    newamount = 2147483647;
  }

  if(newamount < 0) {
    newamount = 0;
  }

  function_d0948454b7f94d18(currencytype, newamount);
}

function function_a06aa3b8c98e131e(currencytype, amount, reason, info) {
  var_65b4e89f87e61c2 = amount;

  if(isDefined(level.currency[currencytype].subfunc)) {
    self[[level.currency[currencytype].subfunc]](amount);
  } else {
    function_76906efe4e7c93fc(amount, currencytype);
  }

  sparams = spawnStruct();
  sparams.var_65b4e89f87e61c2 = var_65b4e89f87e61c2;
  sparams.currencytype = currencytype;
  sparams.amount = amount;
  sparams.reason = reason;
  sparams.info = info;
  callback::callback("currency_sub", sparams);
}

function function_76906efe4e7c93fc(amount, currencytype) {
  var_3d7ffadeef043c6 = function_15975e20bbd2c824(currencytype);
  newamount = var_3d7ffadeef043c6 - amount;

  if(amount < 0 && newamount < var_3d7ffadeef043c6) {
    newamount = 2147483647;
  }

  if(newamount < 0) {
    newamount = 0;
  }

  function_d0948454b7f94d18(currencytype, newamount);
}

function function_d0948454b7f94d18(currencytype, amount, reason) {
  var_65b4e89f87e61c2 = amount;

  if(isDefined(self.currency) && isDefined(currencytype) && isDefined(self.currency[currencytype])) {
    var_65b4e89f87e61c2 = self.currency[currencytype];
  }

  var_becfac3d1b3aa3dc = level.currency[currencytype].setfunc;

  if(isDefined(var_becfac3d1b3aa3dc)) {
    self[[var_becfac3d1b3aa3dc]](amount);
  } else {
    function_c6f24e4d5f1dcba(amount, currencytype);
  }

  sparams = {
    #reason: reason, #amount: amount, #currencytype: currencytype, #var_65b4e89f87e61c2: var_65b4e89f87e61c2
  };
  callback::callback("currency_set", sparams);
}

function function_c6f24e4d5f1dcba(amount, currencytype) {
  self.currency[currencytype] = amount;
}

function function_15975e20bbd2c824(currencytype) {
  if(isDefined(level.currency[currencytype].getfunc)) {
    return [[level.currency[currencytype].getfunc]]();
  }

  return function_65e84417bc4c405e(currencytype);
}

function function_65e84417bc4c405e(currencytype) {
  return self.currency[currencytype];
}

function function_bcc79745d547a99c(currencytype, cost) {
  var_7965af849f61fa07 = 1;
  var_dfe39d340d15cb99 = function_15975e20bbd2c824(currencytype);

  if(cost > var_dfe39d340d15cb99) {
    var_7965af849f61fa07 = 0;
  }

  return var_7965af849f61fa07;
}

function attempt_purchase(currencytype, cost, var_92f8f0879c089e9, var_b138a0b1e1a62a04, reason, info) {
  if(function_bcc79745d547a99c(currencytype, cost)) {
    function_a06aa3b8c98e131e(currencytype, cost, reason, info);

    if(isDefined(level.currency[currencytype].buysound) && !istrue(var_92f8f0879c089e9)) {
      self playsoundtoplayer(level.currency[currencytype].buysound, self);
    }

    if(!isDefined(self.pers["currency_spent"])) {
      self.pers["currency_spent"] = cost;
    } else {
      self.pers["currency_spent"] = self.pers["currency_spent"] + cost;
    }

    return 1;
  }

  if(isDefined(level.currency[currencytype].denysound) && !istrue(var_b138a0b1e1a62a04)) {
    self playsoundtoplayer(level.currency[currencytype].denysound, self);
  }

  return 0;
}

function function_fc06aafd52e1707b(currencytype, namestring) {
  level.currency[currencytype].displayname = namestring;
}

function function_d67d3f6e87682c71(var_f246314e1dbaefea, currencytype) {
  level endon("game_ended");
  self endon("disconnect");
  var_5454163114cd6502 = newclienthudelem(self);
  var_5454163114cd6502.x = -20;
  var_5454163114cd6502.y = 380 - 15 * var_f246314e1dbaefea;
  var_5454163114cd6502.alignx = "center";
  var_5454163114cd6502.aligny = "top";
  var_5454163114cd6502.vertalign = "fullscreen";
  var_5454163114cd6502.var_406fd34934f7e3d2 = "fullscreen";
  var_5454163114cd6502.font = "smallfixed";
  var_5454163114cd6502.fontscale = 0.75;
  var_6dfa383229c11ead = newclienthudelem(self);
  var_6dfa383229c11ead.x = 60;
  var_6dfa383229c11ead.y = 380 - 15 * var_f246314e1dbaefea;
  var_6dfa383229c11ead.alignx = "center";
  var_6dfa383229c11ead.aligny = "top";
  var_6dfa383229c11ead.vertalign = "fullscreen";
  var_6dfa383229c11ead.var_406fd34934f7e3d2 = "fullscreen";
  var_6dfa383229c11ead.font = "smallfixed";
  var_6dfa383229c11ead.fontscale = 0.75;

  while(true) {
    if(currencytype == "essence") {
      var_5454163114cd6502 settext(&"SHARED_HINTSTRINGS/CURRENCY_HUDELEM_ESSENCE");
      var_6dfa383229c11ead setvalue(self.currency["essence"]);
    } else if(currencytype == "salvage") {
      var_5454163114cd6502 settext(&"SHARED_HINTSTRINGS/CURRENCY_HUDELEM_SALVAGE");
      var_6dfa383229c11ead setvalue(self.currency["salvage"]);
    } else if(currencytype == "rare_salvage") {
      var_5454163114cd6502 settext(&"SHARED_HINTSTRINGS/CURRENCY_HUDELEM_RARE_SALVAGE");
      var_6dfa383229c11ead setvalue(self.currency["rare_salvage"]);
    } else if(isDefined(level.currency[currencytype].displayname)) {
      var_5454163114cd6502 settext(level.currency[currencytype].displayname);
      var_6dfa383229c11ead setvalue(self.currency[currencytype]);
    }

    waitframe();
  }
}

function function_2e0cc380e14c340b(currency_type) {
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x207>");
  scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x21a>" + currency_type, "<dev string:x227>" + currency_type, &function_382bfcbb2e043576, 0);
  scripts\common\devgui::function_fe953f000498048f();
}

function function_382bfcbb2e043576(params) {
  currency_type = params[0];

  foreach(player in level.players) {
    if(isDefined(level.currency[currency_type])) {
      player function_3036cef61495210f(currency_type, 10000);
      continue;
    }

    iprintln(currency_type + "<dev string:x23d>");
  }
}

# /