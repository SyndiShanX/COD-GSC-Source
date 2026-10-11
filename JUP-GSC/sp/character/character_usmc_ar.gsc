/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\character\character_usmc_ar.gsc
***********************************************/

#using scripts\common\utility;
#namespace character_usmc_ar;

function private autoexec init() {
  character = #"character_usmc_ar";

  if(!isDefined(level.fncharacter)) {
    level.fncharacter = [];
  }

  if(!isDefined(level.fncharacterprecache)) {
    level.fncharacterprecache = [];
  }

  if(!isDefined(level.fncharacterxmodelalias)) {
    level.fncharacterxmodelalias = [];
  }

  level.fncharacter[character] = &main;

  if(issp()) {
    level.fncharacterprecache[character] = &precache_sp;
    return;
  }

  level.fncharacterprecache[character] = &precache_cpmp;
}

function main() {
  level.fncharacterprecache = undefined;
  self.animationarchetype = "soldier";
  self.voice = #"unitedstates";
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self setModel("body_usmc_ar");
  self attach("head_usmc_lmg", "", 1);
  self.headmodel = "head_usmc_lmg";
  self setclothtype(#"vestlight");
  self setgeartype(#"millghtgr");
  self setbagtype(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("body_usmc_ar");
  precachemodel("head_usmc_lmg");
}

function precache_cpmp() {
  precache();
}