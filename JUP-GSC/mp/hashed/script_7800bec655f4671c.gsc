/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7800bec655f4671c.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_4ad7bb8eab904f94;

function private autoexec init() {
  character = #"hash_fa09adc25d9aa6b8";

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
  self.animationarchetype = "zombie_base";
  self.voice = #"unitedstates";
  self.bhasthighholster = 0;
  self.animtree = "zombie_base";
  self setModel("c_jup_zmb_zombie_base_female_skirt_wrap");
  self attach("c_jup_zmb_zombie_base_female_skirt_head_01_yz", "", 1);
  self.headmodel = "c_jup_zmb_zombie_base_female_skirt_head_01_yz";
  self setclothtype(#"vestheavy");
  self setgeartype(#"none");
  self setbagtype(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_16c36cf98afe63cd");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("c_jup_zmb_zombie_base_female_skirt_wrap");
  precachemodel("c_jup_zmb_zombie_base_female_skirt_head_01_yz");
}

function precache_cpmp() {
  precache();
}