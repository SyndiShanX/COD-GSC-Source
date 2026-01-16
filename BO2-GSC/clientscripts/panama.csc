/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\panama.csc
**************************************/

#include clientscripts\_utility;
#include clientscripts\_filter;
#include clientscripts\panama_fx;
#include clientscripts\_load;
#include clientscripts\_audio;
#include clientscripts\panama_amb;
#include clientscripts\_swimming;

main() {
  clientscripts\panama_fx::main();
  clientscripts\_load::main();
  thread clientscripts\_audio::audio_init(0);
  thread clientscripts\panama_amb::main();
  thread clientscripts\_swimming::main();
  register_clientflag_callback("player", 0, ::put_on_hat);
  register_clientflag_callback("scriptmover", 1, ::toggle_extra_cam);
  register_clientflag_callback("player", 7, ::toggle_zodiac_overlay);
  waitforclient(0);

  println("*** Client : panama running...");

  init_filter_zodiac_raindrops(level.localplayers[0]);
  set_player_viewmodel("c_usa_woods_panama_viewhands");
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

put_on_hat(localclientnum, set, newent) {
  if(set) {
    self.m_hat = spawn(self getlocalclientnumber(), self gettagorigin("J_HEAD"), "script_model");
    self.m_hat setmodel("c_usa_milcas_woods_cap");
    self.m_hat_linker = spawn(self getlocalclientnumber(), self gettagorigin("J_HEAD"), "script_model");
    self.m_hat_linker setmodel("tag_origin");
    self.m_hat_linker.angles = self.angles;
    self.m_hat linkto(self.m_hat_linker, "tag_origin", (0, 0, 0), vectorscale((0, 1, 0), 90.0));
    self.m_hat_linker linktocamera(4, (12, 0, 1.8));
  } else if(isDefined(self.m_hat)) {
    self.m_hat unlinkfromcamera();
    self.m_hat delete();
  }
}

toggle_zodiac_overlay(localclientnum, set, newent) {
  if(set) {
    println("**** wingsuit overlay on****");

    enable_filter_zodiac_raindrops(level.localplayers[0], 3);
  } else {
    println("**** wingsuit overlay off****");

    disable_filter_zodiac_raindrops(level.localplayers[0], 3);
  }
}