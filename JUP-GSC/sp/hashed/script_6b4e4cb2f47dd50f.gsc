/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_6b4e4cb2f47dd50f.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_6cbbf28f4ffa9ff3;

function private autoexec init() {
  character = #"hash_438794d65fae84f";

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
  self.animationarchetype = "civilian_react_female";
  self.voice = #"unitednations";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self setModel("body_c_jup_npc_f_whiskey_hacker");
  self attach("head_c_jup_sc_f_miller_whiskey_hacker", "", 1);
  self.headmodel = "head_c_jup_sc_f_miller_whiskey_hacker";
  self setclothtype(#"nylon");
  self setgeartype(#"none");
  self setbagtype(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("body_c_jup_npc_f_whiskey_hacker");
  precachemodel("head_c_jup_sc_f_miller_whiskey_hacker");
}

function precache_cpmp() {
  precache();
}