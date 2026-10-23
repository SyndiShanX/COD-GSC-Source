/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\agents\_agents_gametype_hp.gsc
**********************************************************/

main() {
  setup_callbacks();
}

setup_callbacks() {
  level._id_0A41["player"]["think"] = maps\mp\bots\_bots_gametype_hp::bot_hp_think;
}