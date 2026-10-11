/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\character\c_jup_sp_hero_gaz_tundra_frost.gsc
***********************************************************/

#using scripts\common\utility;
#namespace c_jup_sp_hero_gaz_tundra_frost;

function private autoexec init() {
  character = #"c_jup_sp_hero_gaz_tundra_frost";

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
  self setModel("body_c_jup_sp_hero_gaz_tundra_frost");
  self attach("head_c_jup_sp_hero_gaz_tundra_frost", "", 1);
  self.headmodel = "head_c_jup_sp_hero_gaz_tundra_frost";
  self setclothtype(#"cloth");
  self setgeartype(#"milmedgr");
  self setbagtype(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("body_c_jup_sp_hero_gaz_tundra_frost");
  precachemodel("head_c_jup_sp_hero_gaz_tundra_frost");
}

function precache_cpmp() {
  precache();
}