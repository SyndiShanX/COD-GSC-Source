/*****************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\civilian\civilian_flashed.gsc
*****************************************************/

get_flashed_anim() {
  return anim.civilianflashedarray[randomint(anim.civilianflashedarray.size)];
}

main() {
  var_0 = maps\_utility::flashbanggettimeleftsec();

  if(var_0 <= 0) {
    return;
  }
  animscripts\flashed::flashbangedloop(get_flashed_anim(), var_0);
}