/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\agents\_agents_gametype_demo.gsc
************************************************************/

main() {
  _id_87A7();
}

_id_87A7() {
  level._id_0A41["player"]["think"] = ::_id_0A46;
}

_id_0A46() {
  common_scripts\utility::_id_0615();

  foreach(var_1 in level._id_1913)
  var_1._id_9D65 enableplayeruse(self);

  thread maps\mp\bots\_bots_gametype_sd::_id_1AC0();
}