/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_5f4e5598b1c5636f.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_90fe452303cd22fb;

function private autoexec init() {
  character = #"hash_3d3eb20a1f2123f7";

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
  self.animationarchetype = "civilian_react";
  self.voice = #"unitednationsfemale";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self setModel("body_civ_london_female_9_2");
  self attach("head_sc_f_dizon_var_1", "", 1);
  self.headmodel = "head_sc_f_dizon_var_1";
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
  precachemodel("body_civ_london_female_9_2");
  precachemodel("head_sc_f_dizon_var_1");
}

function precache_cpmp() {
  precache();
}