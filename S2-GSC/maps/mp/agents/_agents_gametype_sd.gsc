/**************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\agents\_agents_gametype_sd.gsc
**************************************************/

main() {
  func_87A7();
}

func_87A7() {
  level.var_A41["player"]["think"] = ::func_0A46;
}

func_0A46() {
  common_scripts\utility::func_615();
  foreach(var_01 in level.var_1913) {
    var_01.var_9D65 enableplayeruse(self);
  }

  thread maps / mp / bots / _bots_gametype_sd::func_1AC0();
}