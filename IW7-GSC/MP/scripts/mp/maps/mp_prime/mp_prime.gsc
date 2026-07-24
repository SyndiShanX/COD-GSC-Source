/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_prime\mp_prime.gsc
*************************************************/

main() {
  scripts\mp\maps\mp_prime\mp_prime_precache::main();
  scripts\mp\maps\mp_prime\gen\mp_prime_art::main();
  scripts\mp\maps\mp_prime\mp_prime_fx::main();
  scripts\mp\load::main();
  scripts\mp\compass::setupminimap("compass_map_mp_prime");
  level._id_C7B3 = getEntArray("OutOfBounds", "targetname");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread scripts\mp\animation_suite::animationsuite();
  thread sfx_club_music();
  thread fix_collision();
}

fix_collision() {
  var_0 = getEnt("player512x512x8", "targetname");
  var_1 = spawn("script_model", (-708, -1759, 476));
  var_1.angles = (0, 0, 90);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("player512x512x8", "targetname");
  var_3 = spawn("script_model", (-708, -1759, 988));
  var_3.angles = (0, 0, 90);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getEnt("player512x512x8", "targetname");
  var_5 = spawn("script_model", (-708, -1759, 1500));
  var_5.angles = (0, 0, 90);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getEnt("clip32x32x128", "targetname");
  var_7 = spawn("script_model", (-1160, -1616, 232));
  var_7.angles = (0, 0, 0);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getEnt("clip128x128x8", "targetname");
  var_9 = spawn("script_model", (-1000, -1380, 340));
  var_9.angles = (270, 180, 180);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_10 = getEnt("player64x64x256", "targetname");
  var_11 = spawn("script_model", (-1298, 1862, 156));
  var_11.angles = (0, 0, 0);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getEnt("player64x64x256", "targetname");
  var_13 = spawn("script_model", (-1298, 1862, 412));
  var_13.angles = (0, 0, 0);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getEnt("player64x64x256", "targetname");
  var_15 = spawn("script_model", (-1298, 1862, 668));
  var_15.angles = (0, 0, 0);
  var_15 clonebrushmodeltoscriptmodel(var_14);
  var_16 = getEnt("clip64x64x64", "targetname");
  var_17 = spawn("script_model", (-156, 2484, -8));
  var_17.angles = (0, 225, 0);
  var_17 clonebrushmodeltoscriptmodel(var_16);
  var_18 = getEnt("clip64x64x64", "targetname");
  var_19 = spawn("script_model", (-188, 2520, -8));
  var_19.angles = (0, 10, 0);
  var_19 clonebrushmodeltoscriptmodel(var_18);
  var_20 = spawn("script_model", (0, 0, 0));
  var_20.angles = (0, 0, 0);
  var_20 setModel("mp_prime_umbra_1");
  var_20 = spawn("script_model", (1374, 3005, 16));
  var_20.angles = (0, 0, 0);
  var_20 setModel("mp_prime_umbra_2");
  var_21 = getEnt("clip512x512x8", "targetname");
  var_22 = spawn("script_model", (-1321, 39, -183));
  var_22.angles = (89.9999, 0, 0);
  var_22 clonebrushmodeltoscriptmodel(var_21);
  var_23 = getEnt("clip512x512x8", "targetname");
  var_24 = spawn("script_model", (-1321, 516, -216));
  var_24.angles = (89.9999, 0, 0);
  var_24 clonebrushmodeltoscriptmodel(var_23);
  var_25 = getEnt("clip256x256x8", "targetname");
  var_26 = spawn("script_model", (392, 2312, 448));
  var_26.angles = (0, 0, 94);
  var_26 clonebrushmodeltoscriptmodel(var_25);
  var_27 = getEnt("clip128x128x8", "targetname");
  var_28 = spawn("script_model", (1116, -1008, 328));
  var_28.angles = (277, 180, 180);
  var_28 clonebrushmodeltoscriptmodel(var_27);
  var_29 = getEnt("clip128x128x8", "targetname");
  var_30 = spawn("script_model", (30, -590, 300));
  var_30.angles = (277, 360, -180);
  var_30 clonebrushmodeltoscriptmodel(var_29);
  var_31 = spawn("script_model", (1382, -277, -128));
  var_31.angles = (0, 270, 0);
  var_31 setModel("mp_prime_cart");
  var_32 = getEnt("player32x32x128", "targetname");
  var_33 = spawn("script_model", (1270, 1428, 236));
  var_33.angles = (0, 0, 7.99996);
  var_33 clonebrushmodeltoscriptmodel(var_32);
  var_34 = getEnt("clip64x64x64", "targetname");
  var_35 = spawn("script_model", (328, 3344, 166));
  var_35.angles = (0, 0, 0);
  var_35 clonebrushmodeltoscriptmodel(var_34);
  var_36 = getEnt("clip256x256x256", "targetname");
  var_37 = spawn("script_model", (1736, 3528, -128));
  var_37.angles = (0, 0, 0);
  var_37 clonebrushmodeltoscriptmodel(var_36);
  var_38 = getEnt("clip256x256x256", "targetname");
  var_39 = spawn("script_model", (1736, 3528, 128));
  var_39.angles = (0, 0, 0);
  var_39 clonebrushmodeltoscriptmodel(var_38);
  var_40 = getEnt("clip32x32x128", "targetname");
  var_41 = spawn("script_model", (536, 12, -8));
  var_41.angles = (90, 0, 0);
  var_41 clonebrushmodeltoscriptmodel(var_40);
  var_42 = getEnt("clip64x64x64", "targetname");
  var_43 = spawn("script_model", (442, -1696, 88));
  var_43.angles = (0, 0, 0);
  var_43 clonebrushmodeltoscriptmodel(var_42);
  var_44 = getEnt("clip32x32x8", "targetname");
  var_45 = spawn("script_model", (469, -1696, 144));
  var_45.angles = (0, 0, 0);
  var_45 clonebrushmodeltoscriptmodel(var_44);
  var_46 = getEnt("clip32x32x128", "targetname");
  var_47 = spawn("script_model", (657, 1315, -32));
  var_47.angles = (270, 0, 0);
  var_47 clonebrushmodeltoscriptmodel(var_46);
  var_40 = getEnt("clip32x32x128", "targetname");
  var_41 = spawn("script_model", (536, -20, -2));
  var_41.angles = (90, 0, 0);
  var_41 clonebrushmodeltoscriptmodel(var_40);
  var_46 = getEnt("clip32x32x128", "targetname");
  var_47 = spawn("script_model", (657, 1347, -26));
  var_47.angles = (270, 0, 0);
  var_47 clonebrushmodeltoscriptmodel(var_46);
}

wr_mover_setup() {
  thread _id_5CC7("wr_mover", "wr_mover_start", 200, undefined, undefined);
  wait 60;
  thread _id_5CC7("wr_mover_1", "wr_mover_start", 200, undefined, undefined);
  wait 60;
  thread _id_5CC7("wr_mover_2", "wr_mover_start", 200, undefined, undefined);
}

_id_5CC7(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getEnt(var_0, "targetname");

  if(isDefined(var_3)) {
    var_5._id_4380 = getEnt(var_3, "targetname");
    var_5._id_4380 linkTo(var_5);
  }

  var_6 = 1.0 / var_2;
  var_5._id_C72D = scripts\engine\utility::getStruct(var_1, "targetname");
  var_5 moveTo(var_5._id_C72D.origin, 0.1, 0, 0);
  var_5 rotateTo(var_5._id_C72D.angles, 0.1, 0, 0);
  var_5.speed = 0;
  wait 0.5;

  if(isDefined(var_4)) {
    var_5 playLoopSound(var_4);
  }

  var_5.destination = var_5._id_C72D;

  for(;;) {
    var_5.destination = _id_5CBC(var_5, var_5.destination, var_6);
  }
}

_id_5CBC(var_0, var_1, var_2) {
  var_0 endon("death");
  var_3 = scripts\engine\utility::getStruct(var_1.target, "targetname");

  if(isDefined(var_3.target)) {
    var_4 = abs(distance(var_0.origin, var_3.origin) * var_2);
    var_0 moveTo(var_3.origin, var_4, 0, 0);
    var_0 rotateTo(var_3.angles, var_4, 0, 0);
    wait(var_4);
    return var_3;
  } else {
    var_0 hide();

    if(isDefined(var_0._id_4380)) {
      var_0._id_4380 notsolid();
    }

    wait 1;
    var_0.origin = var_0._id_C72D.origin;
    var_0.angles = var_0._id_C72D.angles;
    wait 1;
    var_0 show();

    if(isDefined(var_0._id_4380)) {
      var_0._id_4380 solid();
    }

    return var_0._id_C72D;
  }
}

sfx_club_music() {
  var_0 = spawn("script_origin", (1200, 703, 238));
  scripts\engine\utility::waitframe();
  var_0 playLoopSound("emt_mus_prime_club");
}