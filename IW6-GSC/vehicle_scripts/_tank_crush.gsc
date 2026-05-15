/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\_tank_crush.gsc
*******************************************/

init_tank_crush() {
  setdvarifuninitialized("debug_tankcrush", "0");
}

tank_crush(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_6)) {
    var_6 = 1;
  }

  var_7 = self;
  self vehicle_setspeed(7 * var_6, 5, 5);
  var_8 = getanimlength(var_2) / var_6;
  var_9 = var_8 / 3;
  var_10 = var_8 / 3;
  var_11 = var_0.origin;
  var_12 = var_0.angles;
  var_13 = anglesToForward(var_12);
  var_14 = anglestoup(var_12);
  var_15 = anglestoright(var_12);
  var_16 = getstartorigin(var_11, var_12, var_2);
  var_17 = getstartangles(var_11, var_12, var_2);
  var_18 = anglesToForward(var_17);
  var_19 = anglestoup(var_17);
  var_20 = anglestoright(var_17);
  var_21 = anglesToForward(var_7.angles);
  var_22 = anglestoup(var_7.angles);
  var_23 = anglestoright(var_7.angles);
  var_24 = var_11 - var_16;
  var_25 = vectordot(var_24, var_18);
  var_26 = vectordot(var_24, var_19);
  var_27 = vectordot(var_24, var_20);
  var_28 = spawn("script_origin", var_7.origin);
  var_28.origin = var_28.origin + var_21 * var_25;
  var_28.origin = var_28.origin + var_22 * var_26;
  var_28.origin = var_28.origin + var_23 * var_27;
  var_24 = anglesToForward(var_12);
  var_25 = vectordot(var_24, var_18);
  var_26 = vectordot(var_24, var_19);
  var_27 = vectordot(var_24, var_20);
  var_29 = var_21 * var_25;
  var_29 = var_29 + var_22 * var_26;
  var_29 = var_29 + var_23 * var_27;
  var_28.angles = vectortoangles(var_29);

  if(isDefined(var_5)) {
    level thread common_scripts\utility::play_sound_in_space(var_5, var_11);
  }

  var_0 useanimtree(var_4);
  var_7 useanimtree(var_4);
  var_0 thread tank_crush_fx_on_tag("tag_window_left_glass_fx", level._vehicle_effect["tankcrush"]["window_med"], "veh_glass_break_small", 0.2);
  var_0 thread tank_crush_fx_on_tag("tag_window_right_glass_fx", level._vehicle_effect["tankcrush"]["window_med"], "veh_glass_break_small", 0.4);
  var_0 thread tank_crush_fx_on_tag("tag_windshield_back_glass_fx", level._vehicle_effect["tankcrush"]["window_large"], "veh_glass_break_large", 0.7);
  var_0 thread tank_crush_fx_on_tag("tag_windshield_front_glass_fx", level._vehicle_effect["tankcrush"]["window_large"], "veh_glass_break_large", 1.5);
  var_0 animscripted("tank_crush_anim", var_11, var_12, var_3);
  var_7 animscripted("tank_crush_anim", var_28.origin, var_28.angles, var_2);

  if(var_6 != 1) {
    var_0 setflaggedanim("tank_crush_anim", var_3, 1, 0, var_6);
    var_7 setflaggedanim("tank_crush_anim", var_2, 1, 0, var_6);
  }

  var_28 moveto(var_11, var_9, var_9 / 2, var_9 / 2);
  var_28 rotateto(var_12, var_9, var_9 / 2, var_9 / 2);
  wait(var_9);
  var_8 = var_8 - var_9;
  var_8 = var_8 - var_10;
  wait(var_8);
  var_30 = spawn("script_model", var_16);
  var_30.angles = var_17;
  var_31 = var_30 localtoworldcoords(getmovedelta(var_2, 0, 1));
  var_32 = var_17 + (0, getangledelta(var_2, 0, 1), 0);
  var_30 delete();
  var_33 = anglesToForward(var_32);
  var_34 = anglestoup(var_32);
  var_35 = anglestoright(var_32);
  var_36 = self getattachpos(var_1);
  var_21 = anglesToForward(var_36[1]);
  var_22 = anglestoup(var_36[1]);
  var_23 = anglestoright(var_36[1]);
  var_24 = var_11 - var_31;
  var_25 = vectordot(var_24, var_33);
  var_26 = vectordot(var_24, var_34);
  var_27 = vectordot(var_24, var_35);
  var_28.final_origin = var_36[0];
  var_28.final_origin = var_28.final_origin + var_21 * var_25;
  var_28.final_origin = var_28.final_origin + var_22 * var_26;
  var_28.final_origin = var_28.final_origin + var_23 * var_27;
  var_24 = anglesToForward(var_12);
  var_25 = vectordot(var_24, var_33);
  var_26 = vectordot(var_24, var_34);
  var_27 = vectordot(var_24, var_35);
  var_29 = var_21 * var_25;
  var_29 = var_29 + var_22 * var_26;
  var_29 = var_29 + var_23 * var_27;
  var_28.final_angles = vectortoangles(var_29);
  var_28 moveto(var_28.final_origin, var_10, var_10 / 2, var_10 / 2);
  var_28 rotateto(var_28.final_angles, var_10, var_10 / 2, var_10 / 2);
  wait(var_10);
  self attachpath(var_1);
  common_scripts\utility::waitframe();
}

tank_crush_fx_on_tag(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    wait(var_3);
  }

  playFXOnTag(var_1, self, var_0);

  if(isDefined(var_2)) {
    thread maps\_utility::play_sound_on_tag(var_2, var_0);
  }
}