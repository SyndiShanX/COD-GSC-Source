/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_hero_price_urban.gsc
****************************************************/



#using scripts\common\utility;
#namespace character_hero_price_urban;

function private autoexec init() {
  character = #"character_hero_price_urban";

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
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self setModel("body_hero_price_urban_beanie");
  self attach("head_hero_price_newrig_bald", "", 1);
  self.headmodel = "head_hero_price_newrig_bald";
  self.hatmodel = "hat_hero_price_beanie";
  self attach(self.hatmodel);
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
  precachemodel("body_hero_price_urban_beanie");
  precachemodel("head_hero_price_newrig_bald");
  precachemodel("hat_hero_price_beanie");
}

function precache_cpmp() {
  precache();
}