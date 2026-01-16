/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\angola.csc
**************************************/

#include clientscripts\_utility;
#include clientscripts\_filter;
#include clientscripts\angola_fx;
#include clientscripts\_load;
#include clientscripts\_audio;
#include clientscripts\angola_amb;

main() {
  clientscripts\angola_fx::main();
  clientscripts\_load::main();
  thread clientscripts\_audio::audio_init(0);
  thread clientscripts\angola_amb::main();
  thread fog_controller();
  register_clientflag_callback("scriptmover", 1, ::toggle_extra_cam);
  setdvarfloat("vehNPCThrottleMultiplier", 8.0);
  waitforclient(0);
  thread init_ball_turret();

  println("*** Client : angola running...");
}

toggle_extra_cam(localclientnum, set, newent) {
  if(!isDefined(level.extracamactive))
    level.extracamactive = 0;

  if(!level.extracamactive && set) {
    println("**** extra cam on - client****");

    level.extracamactive = 1;
    self isextracam(localclientnum);
  } else if(level.extracamactive && !set) {
    println("**** extra cam on - client****");

    stopextracam(localclientnum);
    level.extracamactive = 0;
  }
}

fog_controller() {
  level waittill("fog_change");
  setworldfogactivebank(0, 2);
  level waittill("fog_change");
  setworldfogactivebank(0, 3);
  level waittill("fog_change");
  setworldfogactivebank(0, 1);
}

init_ball_turret() {
  player = getlocalplayers()[0];
  init_filter_angola_gun_cam(player);
}

enable_turret_static() {
  player = level.localplayers[0];
  enable_filter_angola_gun_cam(player, 0);
}

disable_turret_static() {
  player = level.localplayers[0];
  disable_filter_angola_gun_cam(player, 0);
}

fade_in_static() {
  player = level.localplayers[0];
  amount = 1;
  enable_turret_static();
  wait 1.5;

  while(amount > 0.25) {
    set_filter_angola_gun_cam(player, 0, amount);
    amount = amount - 0.05;

    if(amount <= 0.25)
      amount = 0.25;

    wait 0.05;
  }
}

fade_out_static() {
  player = level.localplayers[0];
  amount = 0.25;

  while(amount < 1) {
    set_filter_angola_gun_cam(player, 0, amount);
    amount = amount + 0.0375;

    if(amount >= 1)
      amount = 1;

    wait 0.05;
  }

  wait 1;
  disable_turret_static();
}