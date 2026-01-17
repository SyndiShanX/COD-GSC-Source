/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\nazi_zombie_prototype.csc
*****************************************************/

#include clientscripts\_utility;
#include clientscripts\_music;

zombie_monitor(clientNum) {
  self endon("disconnect");
  self endon("zombie_off");
  while(1) {
    if(isDefined(self.zombifyFX)) {
      playFX(clientNum, level._effect["zombie_grain"], self.origin);
    }
    realwait(0.1);
  }
}

zombifyHandler(clientNum, newState, oldState) {
  player = getlocalplayers()[clientNum];
  if(newState == "1") {
    if(!isDefined(player.zombifyFX)) {
      player.zombifyFX = 1;
      player thread zombie_monitor(clientNum);
      println("Zombie effect on");
    }
  } else if(newState == "0") {
    if(isDefined(player.zombifyFX)) {
      player.zombifyFX = undefined;
      self notify("zombie_off");
      println("Zombie effect off");
    }
  }
}

main() {
  clientscripts\_load::main();
  println("Registering zombify");
  clientscripts\_utility::registerSystem("zombify", ::zombifyHandler);
  clientscripts\nazi_zombie_prototype_fx::main();
  thread clientscripts\_audio::audio_init(0);
  thread clientscripts\nazi_zombie_prototype_amb::main();
  thread waitforclient(0);
  println("*** Client : zombie running...or is it chasing? Muhahahaha");
}