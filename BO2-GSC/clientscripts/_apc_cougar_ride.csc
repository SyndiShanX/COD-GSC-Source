/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_apc_cougar_ride.csc
**********************************************/

#include clientscripts\_utility;
#include clientscripts\_driving_fx;

init() {
  clientscripts\_driving_fx::add_vehicletype_callback("apc_cougar_player", ::cougar_setup);
}

cougar_setup(localclientnum) {
  self thread driving_anims();
  self thread clientscripts\_driving_fx::collision_thread(localclientnum);
}

driving_anims() {
  self endon("entityshutdown");

  while(true) {
    level waittill("enter_cougar");
    player = level.localplayers[0];
    viewarms = player spawn_player_arms();
    self thread steering_loop(viewarms);
    self thread rumble_loop(player);
    self waittill("exit_vehicle");
    viewarms delete();
  }
}

rumble_loop(player) {
  self endon("entityshutdown");
  self endon("exit_vehicle");
  distance_between_rumble = 500;
  distance_between_wheels = 160;
  origin = self.origin;

  while(isDefined(self)) {
    while(distancesquared(origin, self.origin) < distance_between_rumble * distance_between_rumble)
      wait 0.1;

    origin = self.origin;
    player playrumbleonentity(0, "reload_clipin");
    wait 0.1;

    while(distancesquared(origin, self.origin) < distance_between_wheels * distance_between_wheels)
      wait 0.1;

    origin = self.origin;
    player playrumbleonentity(0, "reload_clipin");
    wait 0.1;
  }
}

#using_animtree("vehicles");
#using_animtree("player");

steering_loop(viewarms) {
  self endon("entityshutdown");
  self endon("exit_vehicle");
  viewarms endon("entityshutdown");
  cougar_anim = % v_la_04_01_drive_leftturn_cougar;
  viewarms_anim = % ch_la_04_01_drive_leftturn_player;
  self setanim(cougar_anim, 1, 0, 0);
  wait 0.05;
  viewarms useanimtree(#animtree);
  viewarms setanim(viewarms_anim, 1, 0, 0);
  viewarms linkto(self, "tag_arms");
  time = 0.5;
  max_delta_t = 0.03;

  while(isDefined(self)) {
    target_time = self getsteering() + 1;
    target_time = target_time * 0.5;
    delta_change = target_time - time;

    if(delta_change > max_delta_t)
      delta_change = max_delta_t;
    else if(delta_change < max_delta_t * -1)
      delta_change = max_delta_t * -1;

    time = time + delta_change;

    if(time > 1)
      time = 1;
    else if(time < 0)
      time = 0;

    self setanim(cougar_anim, 1, 0, 0);
    self setanimtime(cougar_anim, time);
    viewarms setanimtime(viewarms_anim, time);
    wait 0.01;
  }
}