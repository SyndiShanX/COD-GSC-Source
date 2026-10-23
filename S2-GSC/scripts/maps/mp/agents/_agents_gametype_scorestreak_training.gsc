/****************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\agents\_agents_gametype_scorestreak_training.gsc
****************************************************************************/

main() {
  setup_callbacks();
}

setup_callbacks() {
  level._id_0A41["player"]["think"] = maps\mp\bots\_bots_gametype_scorestreak_training::_id_1ABC;
}