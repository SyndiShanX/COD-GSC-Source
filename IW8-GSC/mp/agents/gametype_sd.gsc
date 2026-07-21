/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\agents\gametype_sd.gsc
***********************************************/

main() {
  setup_callbacks();
}

setup_callbacks() {
  level.agent_funcs["_encstr_8BB007E03658CBCAE4"]["_encstr_B672066D30FF90B7"] = ::agent_player_sd_think;
}

agent_player_sd_think() {
  scripts\common\utility::allow_usability(1);
  thread _encstr_B228252B9FC804A35D0386AA8B18137D1027FF822FA0CA578C79BAD2130B13B7F1CF2C46473016::bot_sd_think();
}