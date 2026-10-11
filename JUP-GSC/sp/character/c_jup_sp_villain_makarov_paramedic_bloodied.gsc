/************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\character\c_jup_sp_villain_makarov_paramedic_bloodied.gsc
************************************************************************/

#using scripts\common\utility;
#namespace c_jup_sp_villain_makarov_paramedic_bloodied;

function private autoexec init() {
  character = #"c_jup_sp_villain_makarov_paramedic_bloodied";

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
  self.animationarchetype = "soldier_makarov_handcuffed";
  self.voice = #"russian";
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self setModel("body_c_jup_sp_villain_makarov_paramedic_bloodied");
  self attach("c_jup_head_hero_makarov_paramedic_bloodied", "", 1);
  self.headmodel = "c_jup_head_hero_makarov_paramedic_bloodied";
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
  precachemodel("body_c_jup_sp_villain_makarov_paramedic_bloodied");
  precachemodel("c_jup_head_hero_makarov_paramedic_bloodied");
}

function precache_cpmp() {
  precache();
}