/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\la_2.csc
**************************************/

#include clientscripts\_utility;
#include clientscripts\_filter;
#include clientscripts\_glasses;
#include clientscripts\la_argus;
#include clientscripts\la_2_fx;
#include clientscripts\_load;
#include clientscripts\_audio;
#include clientscripts\_claw_grenade;
#include clientscripts\la_2_amb;

main() {
  clientscripts\la_2_fx::main();
  clientscripts\_load::main();
  thread clientscripts\_audio::audio_init(0);
  clientscripts\_claw_grenade::main();
  thread clientscripts\la_2_amb::main();
  register_clientflag_callback("player", 0, ::player_flag0_handler);
  register_clientflag_callback("scriptmover", 3, ::f35_damage_off);
  register_clientflag_callback("scriptmover", 5, ::f35_damage_light);
  register_clientflag_callback("scriptmover", 6, ::f35_damage_heavy);
  waitforclient(0);
  ui3dsetwindow(0, 0, 0, 1, 1);

  println("*** Client : la_2 running...");

  level thread la2_setup_fullscreen_postfx();
  level thread la2_turn_off_sonar();
  level thread fog_bank_controller();
  level thread fog_bank_eject_sequence();
}

la2_setup_fullscreen_postfx() {
  level waittill("player_put_on_helmet");
  init_f35_hud_damage();
  level thread temp_toggle_hud_damage();
  level.localplayers[0] setsonarenabled(1);
}

la2_turn_off_sonar() {
  level waittill("player_turn_off_sonar");
  level.localplayers[0] setsonarenabled(0);
}

player_flag0_handler(localclientnum, set, newent) {
  if(set) {
    wait 0.05;
    self.visor = spawn(self getlocalclientnumber(), self get_eye(), "script_model");
    self.visor.angles = self.angles;
    self.visor setmodel("test_ui_hud_visor");
    self.visor linktocamera(4, (2.35, 0, 0.1));
  } else {
    wait 0.05;

    if(isDefined(self.visor)) {
      self.visor unlinkfromcamera();
      self.visor delete();
    }
  }
}

fog_bank_controller() {
  level waittill("set_intro_fog_banks");
  setworldfogactivebank(0, 7);
  level waittill("set_jet_fog_banks");
  setworldfogactivebank(0, 1);
}

fog_bank_eject_sequence() {
  level waittill("set_eject_fog_bank");
  setworldfogactivebank(0, 8);
  level waittill("set_outro_fog_bank");
  setworldfogactivebank(0, 1);
}

init_f35_hud_damage() {
  level.localplayers[0].sam_hud_damage_intensity = 0;
  init_filter_f35_damage(level.localplayers[0]);
  enable_filter_f35_damage(level.localplayers[0], 4);
  set_filter_f35_damage_amount(level.localplayers[0], 4, 0);
  level thread f35_damage_reset();
}

temp_toggle_hud_damage() {
  while(true) {
    level waittill("temp_disable_hud_damage");
    disable_filter_f35_damage(level.localplayers[0], 4);

    println("+++ disabled damage filter +++");

    level waittill("temp_enable_hud_damage");
    enable_filter_f35_damage(level.localplayers[0], 4);
    set_filter_f35_damage_amount(level.localplayers[0], 4, 0);

    println("+++ enabled damage filter +++");

  }
}

f35_damage_reset() {
  while(true) {
    level waittill("save_restore");
    level.localplayers[0] setsonarenabled(1);
    level.localplayers[0].sam_hud_damage_intensity = 0;
    set_filter_f35_damage_amount(level.localplayers[0], 4, level.localplayers[0].sam_hud_damage_intensity);
  }
}

f35_damage_off(localclientnum, set, newent) {
  level endon("sam_hud_damage");
  level endon("sam_hud_damage_heavy");

  if(set) {
    while(level.localplayers[0].sam_hud_damage_intensity > 0) {
      level.localplayers[0].sam_hud_damage_intensity = level.localplayers[0].sam_hud_damage_intensity - 3.0303 * 0.0166667;

      if(level.localplayers[0].sam_hud_damage_intensity < 0)
        level.localplayers[0].sam_hud_damage_intensity = 0;

      set_filter_f35_damage_amount(level.localplayers[0], 4, level.localplayers[0].sam_hud_damage_intensity);
      wait 0.0166667;
    }
  }
}

f35_damage_light(localclientnum, set, newent) {
  level endon("sam_hud_damage_heavy");

  if(set) {
    level notify("sam_hud_damage");

    while(level.localplayers[0].sam_hud_damage_intensity < 0.5) {
      level.localplayers[0].sam_hud_damage_intensity = level.localplayers[0].sam_hud_damage_intensity + 5.0 * 0.0166667;

      if(level.localplayers[0].sam_hud_damage_intensity > 0.5)
        level.localplayers[0].sam_hud_damage_intensity = 0.5;

      set_filter_f35_damage_amount(level.localplayers[0], 4, level.localplayers[0].sam_hud_damage_intensity);
      wait 0.0166667;
    }
  }
}

f35_damage_heavy(localclientnum, set, newent) {
  if(set) {
    level notify("sam_hud_damage_heavy");

    while(level.localplayers[0].sam_hud_damage_intensity < 1) {
      level.localplayers[0].sam_hud_damage_intensity = level.localplayers[0].sam_hud_damage_intensity + 5.0 * 0.0166667;

      if(level.localplayers[0].sam_hud_damage_intensity > 1)
        level.localplayers[0].sam_hud_damage_intensity = 1;

      set_filter_f35_damage_amount(level.localplayers[0], 4, level.localplayers[0].sam_hud_damage_intensity);
      wait 0.0166667;
    }
  }
}