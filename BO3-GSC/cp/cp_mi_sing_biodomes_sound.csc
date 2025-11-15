/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_mi_sing_biodomes_sound.csc
*************************************************/

#using scripts\codescripts\struct;
#namespace cp_mi_sing_biodomes_sound;

function main() {
  thread party_stop();
}

function party_stop() {
  level notify("no_party");
}