/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_407a12655e342fca.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_539f27e1bd7c1d9e;

function private autoexec init() {
  character = #"hash_3a9b88b98925a952";

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
  self setModel("body_c_jup_sp_hero_soap_jump");
  self attach("head_c_jup_sp_hero_soap_jump", "", 1);
  self.headmodel = "head_c_jup_sp_hero_soap_jump";
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
  precachemodel("body_c_jup_sp_hero_soap_jump");
  precachemodel("head_c_jup_sp_hero_soap_jump");
}

function precache_cpmp() {
  precache();
}