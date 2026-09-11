/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_dialogue.gsc
***********************************************/

function main() {
  level.dialogue_playing = 0;
  level.current_dialogue = "";
}

function play_vo_to_all(var0, var1) {
  if(isDefined(var1)) {
    wait var1;
  }

  if(istrue(level.dialogue_playing)) {
    return;
  }

  level.dialogue_playing = 1;
  level.announcer_vo_playing = 1;
  level.current_dialogue = var0;

  foreach(var3 in level.players) {
    var3.battlechatterallowed = 0;
    thread play_vo_to_player(var3, var0);
  }

  wait scripts\cp\cp_vo::get_sound_length(var0);

  foreach(var3 in level.players) {
    var3.battlechatterallowed = 1;
  }

  level.dialogue_playing = 0;
  level.announcer_vo_playing = 0;
  level.current_dialogue = "";
}

function play_vo_to_player(var0, var1) {
  level endon("game_ended");
  var0 endon("death");
  var0 endon("disconnect");

  if(istrue(var0.dialogue_playing)) {
    return;
  }

  var0.dialogue_playing = 1;
  var0.current_dialogue = var1;

  if(isarray(var1)) {
    var1 = scripts\engine\utility::random(var1);
  }

  if(soundexists(var1)) {
    var0 playlocalsound(var1);
    wait scripts\cp\cp_vo::get_sound_length(var1);
  }

  var0.dialogue_playing = 0;
  var0.current_dialogue = "";
}

function stop_current_dialogue() {
  if(istrue(level.dialogue_playing)) {
    foreach(var1 in level.players) {
      var1 stoplocalsound(var1.current_dialogue);
      var1.dialogue_playing = 0;
    }

    level.dialogue_playing = 0;
    return;
  }
}