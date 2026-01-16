/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_bigdog.csc
**************************************/

#include clientscripts\_utility;
#include clientscripts\_audio;
#include clientscripts\_driving_fx;
#include clientscripts\_footsteps;

autoexec init() {
  println("*** Client : _bigdog running...");

  clientscripts\_driving_fx::add_vehicletype_callback("drone_claw", ::bigdog_setup);
  clientscripts\_driving_fx::add_vehicletype_callback("drone_claw_wflamethrower", ::bigdog_setup);
  clientscripts\_driving_fx::add_vehicletype_callback("drone_claw_rts", ::bigdog_setup);
  clientscripts\_footsteps::registervehiclefootstepcallback("drone_claw", ::bigdog_feet);
  clientscripts\_footsteps::registervehiclefootstepcallback("drone_claw_wflamethrower", ::bigdog_feet);
  clientscripts\_footsteps::registervehiclefootstepcallback("drone_claw_rts", ::bigdog_feet);
}

bigdog_setup(localclientnum) {
  self thread clientscripts\_driving_fx::collision_thread(localclientnum);
  self thread bigdog_mount(localclientnum);
}

bigdog_feet(localclientnum, note, ground_type) {
  origin = self.origin;
  sound_alias = "fly_step_run_bigdog";
  sound_alias = sound_alias + "_" + ground_type;
  playsound(localclientnum, sound_alias, origin);

  if(self islocalclientdriver(localclientnum)) {
    player = getlocalplayer(localclientnum);
    player playrumbleonentity(localclientnum, "pullout_small");
    speed = self getspeed() / 17.6;
    speed = abs(speed) / 9.0;
    intensity = 0.065 + 0.065 * speed;

    if(intensity > 0.001)
      player earthquake(intensity, 0.3, self.origin, 200);
  }
}

bigdog_mount(localclientnum) {
  self endon("death");
  self endon("entityshutdown");

  while(true) {
    if(self islocalclientdriver(localclientnum))
      user = getlocalplayer(localclientnum);
    else {
      self waittill("enter_vehicle", user);
      playsound(0, "veh_claw_plr_enter");
    }

    soundloopemitter("veh_claw_plr_loop", (0, 0, 0));

    if(user isplayer()) {
      wait 0.5;
      self waittill("exit_vehicle");
      playsound(0, "veh_claw_plr_exit");
      soundstoploopemitter("veh_claw_plr_loop", (0, 0, 0));
    }
  }
}