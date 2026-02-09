/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\dog\dog_flashed.gsc
*******************************************/

#using_animtree("dog");

main() {
  self endon("killanimscript");
  self endon("stop_flashbang_effect");
  wait(randomfloatrange(0, 0.4));
  self clearanim(%root, 0.1);
  var_0 = maps\_utility::_id_2094();

  if(var_0 > 2 && randomint(100) > 60) {
    self setflaggedanimrestart("flashed_anim", %german_shepherd_run_pain, 1, 0.2, self._id_10F7 * 0.75);
  } else {
    self setflaggedanimrestart("flashed_anim", %german_shepherd_run_flashbang_b, 1, 0.2, self._id_10F7);
  }
  var_1 = getanimlength(%german_shepherd_run_flashbang_b) * self._id_10F7;

  if(var_0 < var_1) {
    animscripts\notetracks::_id_0D4F(var_0, "flashed_anim");
  } else {
    animscripts\shared::_id_0C51("flashed_anim");
  }
  self._id_2097 = 0;
  self notify("stop_flashbang_effect");
}