/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_dd686dde22d69b5.gsc
************************************************/

#using scripts\common\utility;
#namespace namespace_4bfdbbf11d3481bd;

function private autoexec init() {
  character = #"hash_69869d0dc2b708e9";

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
  self.voice = #"unitednationsfemale";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self setModel("body_c_jup_zmb_npc_ava_jansen");
  self attach("head_c_jup_zmb_npc_ava_jansen_lod1", "", 1);
  self.headmodel = "head_c_jup_zmb_npc_ava_jansen_lod1";
  self setclothtype(#"vestlight");
  self setgeartype(#"milmedgr");
  self setbagtype(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("body_c_jup_zmb_npc_ava_jansen");
  precachemodel("head_c_jup_zmb_npc_ava_jansen_lod1");
}

function precache_cpmp() {
  precache();
}