/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\test_character_dog.gsc
***********************************************/

#using_animtree("dog");

function main() {
  self setModel("fullbody_dog_c");
  self.bhasthighholster = 0;
  self.animtree = "dog";
  self.animationarchetype = "dog";
  self.voice = "unitednations";
  self setclothtype("vestlight");

  if(issentient(self)) {
    self sethitlocdamagetable("ai_lochit_dmgtable");
  }

  self useanimtree(#animtree);
}

function precache() {
  precachemodel("fullbody_dog_c");
}

function main_mp() {
  self.animationarchetype = "dog";
  self.voice = "unitednations";
  self setModel("fullbody_dog_c");
}

function precache_mp(var0) {
  level.agent_definition[var0]["animclass"] = "dog";
}