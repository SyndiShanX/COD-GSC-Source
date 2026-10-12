/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_hero_hadir_prisoner.gsc
*******************************************************/



#using scripts\common\utility;
#namespace character_hero_hadir_prisoner;

function private autoexec init() {
  character = #"character_hero_hadir_prisoner";

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
  self.voice = #"sas";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self setModel("body_hero_hadir_prisoner");
  self attach("head_hero_hadir_teen_blendshape", "", 1);
  self.headmodel = "head_hero_hadir_teen_blendshape";
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
  precachemodel("body_hero_hadir_prisoner");
  precachemodel("head_hero_hadir_teen_blendshape");
}

function precache_cpmp() {
  precache();
}