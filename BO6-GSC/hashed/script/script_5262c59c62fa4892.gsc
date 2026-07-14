/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_5262c59c62fa4892.gsc
*****************************************************/

#using scripts\asm\asm;
#namespace cap_ai_revival;

function needtoturninplace(asmname, statename, params) {
  angletodyingguy = absangleclamp180(self.revivetargetangles[1] - self.angles[1]);
  turnthresh = 45;

  if(angletodyingguy > turnthresh) {
    return true;
  }

  return false;
}

function capchooseturnanim(asmname, statename, params) {
  angletodyingguy = angleclamp180(self.revivetargetangles[1] - self.angles[1]);
  animindex = asm::yawdiffto2468(angletodyingguy);
  turnanim = asm::asm_lookupanimfromalias(statename, animindex);
  return turnanim;
}

function function_26cdc6d35ad73b93(asmname, statename, params) {
  dyingguy = getdyingguy();
  self.var_6f153b04b485b273 = 6;
  self.damagedirsuffix = "\x15%\x06\xefm";

  if(isDefined(dyingguy)) {
    self.var_6f153b04b485b273 = function_af3185c651a23e1e(dyingguy, self);
    self.damagedirsuffix = dyingguy getdamagedirectionsuffix();
  }

  self notify("5\xd9\x1a(2`\xe51\x90\xeb\xbc\xb7\xe5\xfb\xa4#\a\xd2\xda\xe64");
  return asm::asm_lookupanimfromalias(statename, self.var_6f153b04b485b273);
}

function function_3661e24aafb341b7(asmname, statename, params) {
  return asm::asm_lookupanimfromalias(statename, self.var_6f153b04b485b273 + self.damagedirsuffix);
}

function function_40bde55564beb4d7(asmname, statename, params) {
  return asm::asm_lookupanimfromalias(statename, self.var_6f153b04b485b273 + self.damagedirsuffix);
}

function function_75c989ae13fa9a92(asmname, statename, params) {
  helper = function_2f5f9f667ef35df9();
  self.var_6f153b04b485b273 = 6;

  if(isDefined(helper)) {
    self.var_6f153b04b485b273 = function_af3185c651a23e1e(self, helper);
  }

  self.damagedirsuffix = getdamagedirectionsuffix();
  return asm::asm_lookupanimfromalias(statename, self.var_6f153b04b485b273 + self.damagedirsuffix);
}

function function_fded4c1d0223ec70(asmname, statename, params) {
  return asm::asm_lookupanimfromalias(statename, self.var_6f153b04b485b273 + self.damagedirsuffix);
}

function function_338878d4852a2308(asmname, statename, params) {
  return asm::asm_lookupanimfromalias(statename, self.var_6f153b04b485b273 + self.damagedirsuffix);
}

function stimnotehandler(note, params) {
  scriptablepart = "\x8a\xb2\x9b\x05svC\xf10\xa4,/\"\x82\xfa~\fL\xa3";

  if(self isscriptable() && self getscriptablehaspart(scriptablepart)) {
    statename = self asmgetcurrentstate(self.asmname);
    notehandler_stim(note, statename);
  }
}

function function_1246549ed6a6b8f9(asmname, statename, params) {
  self.var_6f153b04b485b273 = 8;

  if(isDefined(self.revivetarget)) {
    totarget = self.revivetarget.origin - self.origin;
    angletodyingguy = angleclamp180(vectortoyaw(totarget) - self.angles[1]);
    self.var_6f153b04b485b273 = asm::yawdiffto2468(angletodyingguy);
  }

  stance = "";

  if(self.currentpose == "1x\xc5\xb4\xabx") {
    stance = "\xebl9\xde]l\xd0";
  }

  return asm::asm_lookupanimfromalias(statename, self.var_6f153b04b485b273 + stance);
}

function function_294c7222c570ea4b(asmname, statename, params) {
  self.var_6f153b04b485b273 = 6;
  self.damagedirsuffix = getdamagedirectionsuffix();
  return asm::asm_lookupanimfromalias(statename, self.var_6f153b04b485b273 + self.damagedirsuffix);
}

function remoterevivenotehandler(note, params) {
  switch (note) {
    case #"hash_2c1d80fc22d55f17":
      self shoot(100, self.revivetarget);
      self.var_b5bb7c85d338f913 = gettime();
      self.revivetarget notify("\xcc\a\xcb7R\xc2>\xa7\x9a\r2\xddc\xdd\x1f\x98Z\xbf\xee\xa7\xfe");
      return;
  }
}

function function_af3185c651a23e1e(from, to) {
  angle = getangle(from, to);
  index = 6;

  if(angle >= 0) {
    index = 4;
  }

  return index;
}

function getdamagedirectionsuffix() {
  forcedsuffix = function_f71731e44badaa7f();

  if(isDefined(forcedsuffix)) {
    return forcedsuffix;
  }

  if(self.longdeathanims_shootenabled) {
    return "";
  }

  if(!isDefined(self.damageyaw)) {
    return "\x15%\x06\xefm";
  }

  yawabs = abs(self.damageyaw);

  if(yawabs > 135) {
    return "\xf4\x80n\x9a\x7f\xa1";
  } else if(yawabs < 45) {
    return "\x15%\x06\xefm";
  } else if(self.damageyaw < 0) {
    return "\a}";
  }

  return "9\x02";
}

function private notehandler_stim(note, statename) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  scriptablepart = "\x8a\xb2\x9b\x05svC\xf10\xa4,/\"\x82\xfa~\fL\xa3";

  if(isstartstr(note, "\x9c\xbe&e0\x13\xcc<\xc6\xe8\x8a")) {
    if(isrighthand(note)) {
      self setscriptablepartstate(scriptablepart, "\xec\xa0\xa0\xc2\v(\xf9+\xeb\xd2\xd4\x99");
    } else {
      self setscriptablepartstate(scriptablepart, "\x99\x1d\x03-\xfb<5\x1bR\v%");
    }

    return;
  }

  if(isstartstr(note, "\x0e](;\x1c>i\xaf\x0ex\xf4")) {
    self setscriptablepartstate(scriptablepart, "\x91\xca\xcc\v\xab\xd8:");
  }
}

function private isrighthand(note) {
  res = 1;
  hand = getsubstr(note, 12);

  if(isDefined(hand) && hand == "=\xff0b") {
    res = 0;
  }

  return res;
}

function private function_2f5f9f667ef35df9() {
  id = self getinteractionid();
  users = function_a57c59df65be713(id, "\x0fd\xbf\xddt\xf5X\x99\x82\xbf\xf4\xa2");
  return users[0];
}

function private getdyingguy() {
  id = self getinteractionid();
  users = function_a57c59df65be713(id, "<\x11\x1d\x91\x93\xe3\xd5=\xc3");
  return users[0];
}

function private getangle(guy, otherguy) {
  if(isDefined(guy) && isDefined(otherguy)) {
    pos = guy.origin;
    otherpos = otherguy.origin;
    var_bf057450ef361e4 = vectortoyaw(otherpos - pos);
    return angleclamp180(var_bf057450ef361e4 - guy.angles[1]);
  }

  return 0;
}

function private function_f71731e44badaa7f() {
  if(!isDefined(self.forcelongdeath)) {
    return undefined;
  }

  switch (self.forcelongdeath) {
    case 37:
    case 38:
    case 47:
    case 48:
      return "";
    case 39:
    case 40:
      return "\x15%\x06\xefm";
    case 41:
    case 42:
      return "\xf4\x80n\x9a\x7f\xa1";
    case 43:
    case 45:
      return "9\x02";
    case 44:
    case 46:
      return "\a}";
  }

  return undefined;
}