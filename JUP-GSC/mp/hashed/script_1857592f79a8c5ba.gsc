/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1857592f79a8c5ba.gsc
*************************************************/

#using scripts\asm\asm_bb;
#using scripts\asm\cap;
#using scripts\engine\utility;
#namespace cap_use_armor_plate_solo;

function function_6c3d4156dec73e1d(asmname, statename, params) {
  stance = scripts\asm\asm_bb::bb_getrequestedstance();
  coverstate = scripts\asm\asm_bb::bb_getrequestedcoverstate();
  animname = "default";

  if(coverstate == "exposed") {
    animname = "exposed_" + stance;
  } else {
    covernode = scripts\asm\asm_bb::bb_getcovernode();

    if(isDefined(covernode)) {
      covertype = covernode.type;

      switch (covertype) {
        case #"hash_cd3ffe799551db82":
          animname = "cover_right_" + stance;
          break;
        case #"hash_e1d8e1adebed5a61":
          animname = "cover_left_" + stance;
          break;
        case #"hash_c3b74422dec48736":
          animname = "cover_crouch";
          break;
        case #"hash_78b110033ccb68b0":
          animname = "cover_stand";
          break;
      }
    }
  }

  armoranim = scripts\asm\cap::function_18e6c36c02a94dbd(statename, animname);
  return armoranim;
}

function function_45dc5e082d9a020f(asmname, statename, params) {
  utility::issharedfuncdefined("<dev string:x1c>", "<dev string:x22>", 1);

  utility::function_f3bb4f4911a1beb2("ai", "onUsedArmorPlate");
}

function private isrighthand(note) {
  res = 1;
  hand = getsubstr(note, 7);

  if(isDefined(hand) && hand == "left") {
    res = 0;
  }

  return res;
}

function private function_45dc0311bb854741(note, statename) {
  self endon("death");
  self endon(statename + "_finished");
  scriptablepart = "armor_plate";

  if(isstartstr(note, "attach")) {
    if(isrighthand(note)) {
      self setscriptablepartstate(scriptablepart, "active_right");
    } else {
      self setscriptablepartstate(scriptablepart, "active_left");
    }

    return;
  }

  if(isstartstr(note, "detach")) {
    self setscriptablepartstate(scriptablepart, "default");
  }
}

function function_e05a85a79478670c(note, params) {
  scriptablepart = "armor_plate";

  if(self isscriptable() && self getscriptablehaspart(scriptablepart)) {
    statename = self asmgetcurrentstate(self.asmname);
    function_45dc0311bb854741(note, statename);
  }
}