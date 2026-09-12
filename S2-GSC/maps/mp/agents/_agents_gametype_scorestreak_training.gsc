/********************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\agents\_agents_gametype_scorestreak_training.gsc
********************************************************************/

main() {
  func_87A7();
}

func_87A7() {
  level.var_A41["player"]["think"] = ::maps / mp / bots / _bots_gametype_scorestreak_training::func_1ABC;
}