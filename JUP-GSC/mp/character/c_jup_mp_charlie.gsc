/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\c_jup_mp_charlie.gsc
***********************************************/

#using scripts\common\utility;
#namespace c_jup_mp_charlie;

function private autoexec init() {
  character = #"c_jup_mp_charlie";

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
  self.voice = #"russian";
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self setModel("body_c_jup_mp_charlie");
  self attach("head_c_jup_mp_charlie", "", 1);
  self.headmodel = "head_c_jup_mp_charlie";
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
  precachemodel("body_c_jup_mp_charlie");
  precachemodel("head_c_jup_mp_charlie");
}

function precache_cpmp() {
  precache();
}