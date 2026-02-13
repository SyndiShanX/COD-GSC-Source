/*******************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_sumpf\cp_sumpf_audio.gsc
*******************************************************/

main() {
  level.round_start_music_states = [];
  level.round_start_music_states = scripts\engine\utility::array_add(level.round_start_music_states, "round_start_0");
  level.round_start_music_states = scripts\engine\utility::array_add(level.round_start_music_states, "round_start_1");
  level.round_start_music_states = scripts\engine\utility::array_add(level.round_start_music_states, "round_start_2");
  level.round_end_music_states = [];
  level.round_end_music_states = scripts\engine\utility::array_add(level.round_end_music_states, "round_end");
  level.cp_music_gameover = "death_sumpf";
}