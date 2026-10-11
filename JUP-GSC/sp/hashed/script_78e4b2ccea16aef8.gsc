/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_78e4b2ccea16aef8.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_b5d77f7ac2a24c62;

function private autoexec init() {
  character = #"hash_3b9ce46604d4776e";

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
  self setModel("c_jup_body_cp_alex_iw9_1_1");
  self attach("head_hero_alex_lod_iw9", "", 1);
  self.headmodel = "head_hero_alex_lod_iw9";
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
  precachemodel("c_jup_body_cp_alex_iw9_1_1");
  precachemodel("head_hero_alex_lod_iw9");
}

function precache_cpmp() {
  precache();
}