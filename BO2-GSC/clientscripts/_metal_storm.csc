/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_metal_storm.csc
******************************************/

#include clientscripts\_utility;
#include clientscripts\_driving_fx;

autoexec init() {
  println("*** Client : _metalstorm running...");

  clientscripts\_driving_fx::add_vehicletype_callback("drone_metalstorm", ::metalstorm_setup);
  clientscripts\_driving_fx::add_vehicletype_callback("drone_metalstorm_rts", ::metalstorm_setup);
}

metalstorm_setup(localclientnum) {
  self thread clientscripts\_driving_fx::collision_thread(localclientnum);
  self thread metalstorm_player_enter();
}

metalstorm_player_enter(localclientnum) {
  self endon("death");
  self endon("entityshutdown");

  while(true) {
    self waittill("enter_vehicle", user);

    if(user isplayer()) {
      level.player_metalstorm = self;
      wait 0.1;
      self thread metalstorm_update_rumble();
      self waittill("exit_vehicle");
      level.player_metalstorm = undefined;
    }
  }
}

metalstorm_update_rumble() {
  self endon("death");
  self endon("entityshutdown");
  self endon("exit_vehicle");

  while(true) {
    vr = abs(self getspeed() / self getmaxspeed());

    if(vr < 0.1) {
      level.localplayers[0] playrumbleonentity(0, "pullout_small");
      wait 0.3;
    } else if(vr > 0.01 && vr < 0.8 || abs(self getsteering()) > 0.5) {
      level.localplayers[0] earthquake(0.1, 0.1, self.origin, 200);
      level.localplayers[0] playrumbleonentity(0, "pullout_small");
      wait 0.1;
    } else if(vr > 0.8) {
      time = randomfloatrange(0.15, 0.2);
      level.localplayers[0] earthquake(randomfloatrange(0.1, 0.15), time, self.origin, 200);
      level.localplayers[0] playrumbleonentity(0, "pullout_small");
      wait(time);
    } else
      wait 0.1;
  }
}