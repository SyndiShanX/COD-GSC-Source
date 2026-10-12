/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\c_jup_sp_hero_gaz_london_tactical.gsc
***********************************************************/



#using scripts\common\utility;
#namespace c_jup_sp_hero_gaz_london_tactical;

function private autoexec init() {
  character = #"c_jup_sp_hero_gaz_london_tactical";

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
  self setModel("body_c_jup_sp_hero_gaz_london_tactical");
  self attach("head_c_jup_sp_hero_gaz_london_tactical", "", 1);
  self.headmodel = "head_c_jup_sp_hero_gaz_london_tactical";
  self setclothtype(#"nylon");
  self setgeartype(#"milmedgr");
  self setbagtype(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("body_c_jup_sp_hero_gaz_london_tactical");
  precachemodel("head_c_jup_sp_hero_gaz_london_tactical");
}

function precache_cpmp() {
  precache();
}