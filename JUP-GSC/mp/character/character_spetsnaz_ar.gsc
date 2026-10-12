/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_spetsnaz_ar.gsc
***********************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\bodies_spetsnaz_ar;
#namespace character_spetsnaz_ar;

function private autoexec init() {
  character = #"hash_ed40bd9b51995dad";

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
    level.fncharacterxmodelalias[%"hash_126f8d26df0d576c"] = &function_ecf17a96e49ab67;
    return;
  }

  level.fncharacterprecache[character] = &precache_cpmp;
}

function main() {
  level.fncharacterprecache = undefined;
  self.animationarchetype = "soldier";
  self.voice = #"russian";
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self function_6b0082dec4510b24("bodies_spetsnaz_ar", xmodelalias\bodies_spetsnaz_ar::main());
  self attach("head_spetsnaz_ar", "", 1);
  self.headmodel = "head_spetsnaz_ar";
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
  scripts\code\character::precachemodelarray(xmodelalias\bodies_spetsnaz_ar::main());
  precachemodel("head_spetsnaz_ar");
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_43375c8124717c70":
      return xmodelalias\bodies_spetsnaz_ar::main();
  }

  assert(0, "<dev string:x1c>");
}