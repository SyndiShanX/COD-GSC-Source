/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_63779139672a2689.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_c324a2e07655d7f5;

function private autoexec init() {
  character = #"hash_47ccd2a89b2a0059";

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
  self setModel("c_jup_zmb_zombie_base_female_skirt_wrap_brown");
  self attach("c_jup_zmb_zombie_base_female_skirt_head_02_yz", "", 1);
  self.headmodel = "c_jup_zmb_zombie_base_female_skirt_head_02_yz";
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
  precachemodel("c_jup_zmb_zombie_base_female_skirt_wrap_brown");
  precachemodel("c_jup_zmb_zombie_base_female_skirt_head_02_yz");
}

function precache_cpmp() {
  precache();
}