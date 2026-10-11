/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\character\c_jup_sp_villain_nolan_urban.gsc
*********************************************************/

#using scripts\common\utility;
#namespace c_jup_sp_villain_nolan_urban;

function private autoexec init() {
  character = #"c_jup_sp_villain_nolan_urban";

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
  self.voice = #"konni";
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self setModel("body_c_jup_sp_villain_nolan_urban");
  self attach("c_jup_head_hero_nolan_urban", "", 1);
  self.headmodel = "c_jup_head_hero_nolan_urban";
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
  precachemodel("body_c_jup_sp_villain_nolan_urban");
  precachemodel("c_jup_head_hero_nolan_urban");
}

function precache_cpmp() {
  precache();
}