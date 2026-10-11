/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_3c3d6a77457a1e3f.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_2582ba1a52053b55;

function private autoexec init() {
  character = #"hash_d2393444e3930941";

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
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self setModel("body_sp_heroe_nikolai_convoy");
  self attach("head_hero_nikolai", "", 1);
  self.headmodel = "head_hero_nikolai";
  self setclothtype(#"hash_1f62791cede09086");
  self setgeartype(#"none");
  self setbagtype(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("body_sp_heroe_nikolai_convoy");
  precachemodel("head_hero_nikolai");
}

function precache_cpmp() {
  precache();
}