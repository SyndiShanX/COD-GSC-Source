/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_notetrack.gsc
**************************************/

#include maps\_utility;

play_notetrack(notetrack) {
  PlayNoteTrack(notetrack);
  for(;;) {
    level waittill(notetrack, note, val1, val2, val3);
    if(note == "end") {
      return;
    }
    if(note == "play_sound_at_pos") {
      level thread play_sound_in_space(val1, val2);
    }
  }
}