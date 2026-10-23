/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\agents\_agents_gametype_sd.gsc
**********************************************************/

main() {
  setup_callbacks();
}

setup_callbacks() {
  level._id_0A41["player"]["think"] = ::_id_0A46;
}

_id_0A46() {
  common_scripts\utility::_id_0615();

  foreach(var_1 in level.bombzones) {
    var_1.trigger enableplayeruse(self);
  }

  thread maps\mp\bots\_bots_gametype_sd::bot_sd_think();
}