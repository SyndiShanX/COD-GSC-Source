/**********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: character\character_tf_141_forest_unique_a.gsc
**********************************************************/

main() {
  self setModel("body_forest_tf141_shotgun");
  self attach("head_tf141_forest_b", "", true);
  self.headModel = "head_tf141_forest_b";
  self.voice = "taskforce";
}

precache() {
  precacheModel("body_forest_tf141_shotgun");
  precacheModel("head_tf141_forest_b");
}