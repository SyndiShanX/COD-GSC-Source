/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_silo_sound.gsc
***********************************************/

#namespace mp_silo_sound;

main() {
  level thread function_10156cf8();
  level thread function_448f6f5d();
}

function_10156cf8() {
  while(true) {
    level waittill(#"hash_388057c56b2acf4c");
    playsoundatposition(#"hash_3eeefdf762713cfa", (-7169, -4858, 547));
  }
}

function_448f6f5d() {
  while(true) {
    level waittill(#"hash_771bf8874446d6f6");
    playsoundatposition(#"hash_3ca0f0298d34aa6a", (-5364, -10363, 608));
    playsoundatposition(#"hash_3ca0f0298d34aa6a", (-7397, 8858, 1244));
  }
}