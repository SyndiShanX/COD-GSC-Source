/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\character\c_jup_sp_hero_soap_london.gsc
******************************************************/

#using scripts\common\utility;
#namespace c_jup_sp_hero_soap_london;

function private autoexec init() {
  character = #"c_jup_sp_hero_soap_london";

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
  self setModel("body_c_jup_sp_hero_soap_london");
  self attach("head_hero_soap_lod", "", 1);
  self.headmodel = "head_hero_soap_lod";
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
  precachemodel("body_c_jup_sp_hero_soap_london");
  precachemodel("head_hero_soap_lod");
}

function precache_cpmp() {
  precache();
}