/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_boat_soct_ride.csc
*********************************************/

#include clientscripts\_utility;
#include clientscripts\_audio;
#include clientscripts\_music;
#include clientscripts\_driving_fx;

init() {
  clientscripts\_driving_fx::add_vehicletype_callback("boat_soct_player", ::soct_setup);
  clientscripts\_driving_fx::add_vehicletype_callback("boat_soct_allies", ::update_wheels_animation);
  clientscripts\_driving_fx::add_vehicletype_callback("boat_soct_axis", ::update_wheels_animation);
}

soct_setup(localclientnum) {
  self thread driving_anims();
  self thread clientscripts\_driving_fx::collision_thread(localclientnum);
  self thread update_wheels_animation(localclientnum);
  self thread play_water_loop("veh_soct_water_loop", "veh_soct_water_splash", 60);
}

driving_anims() {
  self endon("entityshutdown");

  while(true) {
    player = level.localplayers[0];

    if(isDefined(player) && !self islocalclientdriver(player getlocalclientnumber()))
      level waittill("enter_soct");

    if(self islocalclientdriver(player getlocalclientnumber()))
      wait 0.5;

    player = level.localplayers[0];
    level.vh_player_soct = self;

    if(!isDefined(level.vh_player_soct.viewarms)) {
      level.vh_player_soct.viewarms = player spawn_player_arms();
      level.vh_player_soct thread attach_data_glove();
    }

    if(!isDefined(level.vh_player_soct.steering_wheel)) {
      level.vh_player_soct.steering_wheel = spawn(player getlocalclientnumber(), player getorigin() + vectorscale((0, 0, -1), 1000.0), "script_model");
      level.vh_player_soct.steering_wheel setmodel("veh_t6_mil_soc_t_steeringwheel");
      level.vh_player_soct.steering_wheel linkto(level.vh_player_soct.viewarms, "tag_weapon");
    }

    self thread steering_loop(level.vh_player_soct.viewarms);
    level waittill("exit_vehicle");

    if(isDefined(level.vh_player_soct)) {
      level.vh_player_soct.steering_wheel unlink();
      level.vh_player_soct.steering_wheel delete();
      level.vh_player_soct.viewarms delete();
      level.vh_player_soct = undefined;
      return;
    }
  }
}

attach_data_glove() {
  level.vh_player_soct.viewarms attach("c_usa_cia_frnd_viewbody_vson", "j_wristtwist_le");
}

#using_animtree("player");

steering_loop(viewarms) {
  self endon("entityshutdown");
  viewarms endon("entityshutdown");
  viewarms_anim = % int_boat_steering;
  wait 0.05;
  viewarms useanimtree(#animtree);
  viewarms setanim(viewarms_anim, 1, 0, 0);
  viewarms linkto(self, "tag_driver", (-20, -15, -9));
  time = 0.5;
  max_delta_t = 0.00375;

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

    viewarms setanimtime(viewarms_anim, time);
    wait 0.01;
  }
}

set_soct_boost(enable) {
  if(!isDefined(level.vh_player_soct) || !isDefined(level.vh_player_soct.viewarms)) {
    return;
  }
  if(enable == 1)
    level.vh_player_soct.viewarms setanim( % int_boat_boost_press, 1, 0.1, 3);
  else
    level.vh_player_soct.viewarms clearanim( % int_boat_boost_press, 0.1);
}

#using_animtree("vehicles");

update_wheels_animation(localclientnum) {
  self endon("death");
  self endon("entityshutdown");
  self thread update_splash(localclientnum);
  wait 0.05;

  while(true) {
    if(!isDefined(self)) {
      return;
    }
    self waittill("veh_inair");
    self setanim( % v_soct_wheels_up, 1, 0.2, 1);
    self waittill("veh_landed");
    self clearanim( % v_soct_wheels_up, 0.5);
  }
}

update_splash(localclientnum) {
  self endon("death");
  self endon("entityshutdown");
  self.in_water = 1;
  setdvar("src_player_soct_in_water", "1");
  wait 0.05;

  while(true) {
    if(!isDefined(self)) {
      return;
    }
    if(self isvehicleinwater()) {
      if(!self.in_water) {
        self.in_water = 1;
        setdvar("src_player_soct_in_water", "1");

        if(isDefined(level._effect["soct_water_splash"]))
          playfxontag(localclientnum, level._effect["soct_water_splash"], self, "tag_body");

        if(isDefined(level.vh_player_soct) && self == level.vh_player_soct) {
        }
      }
    } else {
      if(self.in_water == 1)
        setdvar("src_player_soct_in_water", "0");

      self.in_water = 0;
    }

    wait 0.05;
  }
}

update_rumble() {
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