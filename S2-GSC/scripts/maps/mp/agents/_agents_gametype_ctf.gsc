/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\agents\_agents_gametype_ctf.gsc
***********************************************************/

main() {
  setup_callbacks();
}

setup_callbacks() {
  level._id_0A41["player"]["think"] = maps\mp\bots\_bots_gametype_ctf::bot_ctf_think;
}