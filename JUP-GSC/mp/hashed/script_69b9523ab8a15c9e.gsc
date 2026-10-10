/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_69b9523ab8a15c9e.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_6e63717c6ac203d8;

function private autoexec init() {
  character = #"hash_3b4a07fb57da36cc";

  if(!isDefined(level.fncharacter)) {
    level.fncharacter = [];
  }

  if(!isDefined(level.var_7d97144daa7995cd)) {
    level.var_7d97144daa7995cd = [];
  }

  if(!isDefined(level.var_44bf7e31237b3073)) {
    level.var_44bf7e31237b3073 = [];
  }

  level.fncharacter[character] = &main;

  if(issp()) {
    level.var_7d97144daa7995cd[character] = &precache_sp;
    return;
  }

  level.var_7d97144daa7995cd[character] = &precache_cpmp;
}

function main() {
  level.var_7d97144daa7995cd = undefined;
  self.animationarchetype = "zombie_base";
  self.voice = #"unitedstates";
  self.bhasthighholster = 0;
  self.animtree = "zombie_base";
  self setModel("c_jup_zmb_zombie_base_female_dress_grey_gz");
  self attach("c_jup_zmb_zombie_base_female_dress_head_01_grey_gz", "", 1);
  self.headmodel = "c_jup_zmb_zombie_base_female_dress_head_01_grey_gz";
  self setclothtype(#"vestheavy");
  self function_8abe5a968cc3c220(#"none");
  self function_1863f51c1339d80f(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_16c36cf98afe63cd");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("c_jup_zmb_zombie_base_female_dress_grey_gz");
  precachemodel("c_jup_zmb_zombie_base_female_dress_head_01_grey_gz");
}

function precache_cpmp() {
  precache();
}