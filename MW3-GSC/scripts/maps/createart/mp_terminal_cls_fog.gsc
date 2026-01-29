/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\createart\mp_terminal_cls_fog.gsc
**********************************************************/

main() {
  var_0 = maps\_utility::create_vision_set_fog("mp_terminal_cls");
  var_0.startdist = 2219;
  var_0.halfwaydist = 13307;
  var_0.red = 0.721;
  var_0.green = 0.737;
  var_0.blue = 0.759;
  var_0.maxopacity = 0.53;
  var_0.transitiontime = 0;
  var_0.sunfogenabled = 0;
  maps\_utility::vision_set_fog_changes("mp_terminal_cls", 0);
}