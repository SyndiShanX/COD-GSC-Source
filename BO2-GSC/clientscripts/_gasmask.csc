/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_gasmask.csc
**************************************/

#include clientscripts\_utility;
#include clientscripts\_filter;

init() {
  waitforclient(0);
  init_filter_hazmat(level.localplayers[0]);
  thread gasmask_off();
  thread gasmask_on_pristine();
  thread gasmask_on_cracked_1();
  thread gasmask_on_cracked_2();
  thread gasmask_on_cracked_3();

  println("_gasmask::init() completed");
}

gasmask_off() {
  while(true) {
    level waittill("_gasmask_off");
    disable_filter_hazmat(level.localplayers[0], 0, 0);

    println("_gasmask::gasmask_off completed");

  }
}

gasmask_on_pristine() {
  while(true) {
    level waittill("_gasmask_on_pristine");
    level notify("audio_mask");
    enable_filter_hazmat(level.localplayers[0], 0, 0, 1, 1.0);
    thread gasmask_breathing();

    println("_gasmask::gasmask_on_pristine completed");

  }
}

gasmask_on_cracked_1() {
  while(true) {
    println("waiting for cracked notify");

    level waittill("_gasmask_on_cracked_1");

    println("cracked notify received");

    enable_filter_hazmat(level.localplayers[0], 0, 0, 2, 1.0);

    println("_gaskmask::gasmask_on_cracked_1 complted");

  }
}

gasmask_on_cracked_2() {
  while(true) {
    println("waiting for cracked notify");

    level waittill("_gasmask_on_cracked_2");

    println("cracked notify received");

    enable_filter_hazmat(level.localplayers[0], 0, 0, 3, 1.0);

    println("_gaskmask::gasmask_on_cracked_2 complted");

  }
}

gasmask_on_cracked_3() {
  while(true) {
    println("waiting for cracked notify");

    level waittill("_gasmask_on_cracked_3");

    println("cracked notify received");

    enable_filter_hazmat(level.localplayers[0], 0, 0, 4, 1.0);

    println("_gaskmask::gasmask_on_cracked_3 complted");

  }
}

gasmask_breathing() {
}