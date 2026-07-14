/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_1857592f79a8c5ba.gsc
*****************************************************/

#using scripts\asm\asm_bb;
#using scripts\asm\cap;
#using scripts\engine\utility;
#namespace cap_use_armor_plate_solo;

function function_5a88a0523b4ca0c(asmname, statename, params) {
  stance = asm_bb::bb_getrequestedstance();
  coverstate = asm_bb::bb_getrequestedcoverstate();
  animname = "\x91\xca\xcc\v\xab\xd8:";

  if(coverstate == "\xff\xd5d'hTb") {
    animname = "Y\x87\xe0\xf6s\xacd\xd7" + stance;
  } else {
    covernode = asm_bb::bb_getcovernode();

    if(isDefined(covernode)) {
      covertype = covernode.type;

      switch (covertype) {
        case #"hash_cd3ffe799551db82":
          animname = "6\xb7g\xac\xc9\xfa\xe4Zg\xa1G\xaf" + stance;
          break;
        case #"hash_e1d8e1adebed5a61":
          animname = "\xac\xe98\xb2\x9c\x87\x8d\x83\x87m\xdf" + stance;
          break;
        case #"hash_c3b74422dec48736":
          animname = "\x01f\xf6\xa5\xff\xb80W\x86\xe9\xb7\xe5";
          break;
        case #"hash_78b110033ccb68b0":
          animname = "L)\x81\xfbpg6\xbd\xe0\xb04";
          break;
      }
    }
  }

  armoranim = asm_cap::cap_lookupanimfromalias(statename, animname);
  return armoranim;
}

function function_caf454b99367e70e(asmname, statename, params) {
  utility::issharedfuncdefined(#"ai", #"onusedarmorplate", 1);

  utility::callsharedfunc(#"ai", #"onusedarmorplate");
}

function private isrighthand(note) {
  res = 1;
  hand = getsubstr(note, 7);

  if(isDefined(hand) && hand == "=\xff0b") {
    res = 0;
  }

  return res;
}

function private notehandler_armorplate(note, statename) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  scriptablepart = "A\x88\xb4\xb63.PxqW\xc6";

  if(isstartstr(note, "l\xcd\x8f\x8bX\x1b")) {
    if(isrighthand(note)) {
      self setscriptablepartstate(scriptablepart, "\xec\xa0\xa0\xc2\v(\xf9+\xeb\xd2\xd4\x99");
    } else {
      self setscriptablepartstate(scriptablepart, "\x99\x1d\x03-\xfb<5\x1bR\v%");
    }

    return;
  }

  if(isstartstr(note, "\x17\xa1\xa8i2\xcb")) {
    self setscriptablepartstate(scriptablepart, "\x91\xca\xcc\v\xab\xd8:");
  }
}

function armorplatenotehandler(note, params) {
  scriptablepart = "A\x88\xb4\xb63.PxqW\xc6";

  if(self isscriptable() && self getscriptablehaspart(scriptablepart)) {
    statename = self asmgetcurrentstate(self.asmname);
    notehandler_armorplate(note, statename);
  }
}