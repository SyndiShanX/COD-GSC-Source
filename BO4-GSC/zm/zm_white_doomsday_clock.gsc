/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_white_doomsday_clock.gsc
***********************************************/

#namespace zm_white_doomsday_clock;

init() {
  level thread function_c720fa94();
}

function_c720fa94() {
  var_e323931b = getent("e_doomsday_clock_min_hand", "targetname");
  var_e323931b.position = 0;

  while(true) {
    level waittill(#"update_doomsday_clock");
    level thread update_doomsday_clock(var_e323931b);
  }
}

update_doomsday_clock(var_e323931b) {
  while(var_e323931b.is_updating === 1) {
    wait 0.05;
  }

  var_e323931b.is_updating = 1;

  if(var_e323931b.position == 0) {
    var_e323931b.position = 3;
    var_e323931b rotatepitch(-90, 1);
    var_e323931b playSound("zmb_clock_hand");
    var_e323931b waittill(#"rotatedone");
    var_e323931b playSound("zmb_clock_chime");
  } else {
    var_e323931b.position--;
    var_e323931b rotatepitch(30, 1);
    var_e323931b playSound("zmb_clock_hand");
    var_e323931b waittill(#"rotatedone");
  }

  level notify(#"nuke_clock_moved");
  var_e323931b.is_updating = 0;
}