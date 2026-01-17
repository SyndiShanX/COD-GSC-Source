/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_russianbase.gsc
**************************************/

#include maps\mp\_utility;

main() {
  maps\mp\mp_russianbase_fx::main();
  precachemodel("collision_geo_32x32x128");
  precachemodel("collision_wall_256x256x10");
  maps\mp\_load::main();
  maps\mp\mp_russianbase_amb::main();
  if(GetDvarInt(#"xblive_wagermatch") == 1) {
    maps\mp\_compass::setupMiniMap("compass_map_mp_russianbase_wager");
  } else {
    maps\mp\_compass::setupMiniMap("compass_map_mp_russianbase");
  }
  maps\mp\gametypes\_teamset_winterspecops::level_init();
  setdvar("compassmaxrange", "2100");
  maps\mp\gametypes\_spawning::level_use_unified_spawning(true);
  spawncollision("collision_wall_256x256x10", "collider", (-1731, 960, 288), (0, 270, 0));
  spawncollision("collision_geo_32x32x128", "collider", (-120, 1828, 63), (0, 0, 0));
  window1 = spawn("script_model", (-2116, 0, 504));
  if(isDefined(window1)) {
    window1.angles = (0, 0, 0);
    window1 setModel("p_rus_window_dark01");
  }
  window2 = spawn("script_model", (-1878, 0, 504));
  if(isDefined(window2)) {
    window2.angles = (0, 0, 0);
    window2 setModel("p_rus_window_dark01");
  }
  pole1 = spawn("script_model", (-114.081, 1821.35, -10));
  if(isDefined(pole1)) {
    pole1.angles = (0, 15.2, 0);
    pole1 setModel("p_rus_electricpole");
  }
  level thread runTrain();
}
runTrain() {
  level endon("game_ended");
  precacheModel("t5_veh_train_boxcar");
  precacheModel("t5_veh_train_fuelcar");
  precacheModel("t5_veh_train_engine");
  moveTime = 20;
  numOfCarts = 40;
  originalRation = (moveTime / 80);
  maxWaitBetweenTrains = getDvarIntDefault(#"scr_maxWaitBetweenTrains", 200);
  trainTime = (moveTime + (numOfCarts * 4 * originalRation));
  for(;;) {
    waitBetweenTrains = randomint(maxWaitBetweenTrains);
    if(waitBetweenTrains > 0)
      wait(waitBetweenTrains);
    level clientNotify("play_train");
    wait(trainTime);
  }
}