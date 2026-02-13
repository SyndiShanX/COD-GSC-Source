/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\agents\gametype_sd.gsc
*************************************************/

main() {
  _id_D795();
}

_id_D795() {
  level._id_11EF["player"]["think"] = ::_id_1201;
}

_id_1201() {
  scripts\common\utility::_id_158A(1);
  thread scripts\mp\bots\bots_gametype_sd::_id_28B1();
}