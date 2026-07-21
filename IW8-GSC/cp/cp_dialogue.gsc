/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_dialogue.gsc
***********************************************/

main() {
  level.dialogue_playing = 0;
  level.current_dialogue = "_encstr_B40101";
}

play_vo_to_all(var_0, var_1) {
  if(isDefined(var_1))
    wait(var_1);

  if(istrue(level.dialogue_playing)) {
    return;
  }
  level.dialogue_playing = 1;
  level.announcer_vo_playing = 1;
  level.current_dialogue = var_0;

  foreach(var_3 in level.players) {
    var_3.battlechatterallowed = 0;
    thread play_vo_to_player(var_3, var_0);
  }

  wait(scripts\cp\cp_vo::get_sound_length(var_0));

  foreach(var_3 in level.players)
  var_3.battlechatterallowed = 1;

  level.dialogue_playing = 0;
  level.announcer_vo_playing = 0;
  level.current_dialogue = "_encstr_B40101";
}

play_vo_to_player(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(istrue(var_0.dialogue_playing)) {
    return;
  }
  var_0.dialogue_playing = 1;
  var_0.current_dialogue = var_1;

  if(isarray(var_1))
    var_1 = scripts\engine\utility::random(var_1);

  if(soundexists(var_1)) {
    var_0 playlocalsound(var_1);
    wait(scripts\cp\cp_vo::get_sound_length(var_1));
  }

  var_0.dialogue_playing = 0;
  var_0.current_dialogue = "_encstr_B40101";
}

stop_current_dialogue() {
  if(istrue(level.dialogue_playing)) {
    foreach(var_1 in level.players) {
      var_1 stoplocalsound(var_1.current_dialogue);
      var_1.dialogue_playing = 0;
    }

    level.dialogue_playing = 0;
  }
}