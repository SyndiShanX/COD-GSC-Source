/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_runner_pm\mp_runner_pm_lighting.gsc
**********************************************************/

main() {
  thread hide_brush();
}

hide_brush() {
  var_0 = getEntArray("_encstr_8BAF0D88B7DB93A6D08591EDEE09B1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0)
  var_2 hide();
}