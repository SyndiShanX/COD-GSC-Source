/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\bots\_bots_gametype_dogfight.gsc
************************************************************/

main() {
  _id_87A7();
}

_id_87A7() {
  level.bot_funcs["gametype_think"] = ::bot_dogfight_think;
}

bot_dogfight_think() {}