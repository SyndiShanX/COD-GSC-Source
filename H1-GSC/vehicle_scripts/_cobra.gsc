/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: vehicle_scripts\_cobra.gsc
********************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("cobra", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_cobra_helicopter", "vehicle_cobra_helicopter_fly");
  maps\_vehicle::build_deathmodel("vehicle_cobra_helicopter_fly", "vehicle_cobra_helicopter_fly");
  maps\_vehicle::build_drive( % bh_rotors, undefined, 0, 3.0);
  maps\_vehicle::build_deathfx("fx\explosions\large_vehicle_explosion", undefined, "explo_metal_rand");
  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("allies");
  maps\_vehicle::build_mainturret();
  maps\_vehicle::build_light(var_2, "wingtip_green", "tag_light_L_wing", "fx\misc\aircraft_light_wingtip_green", "running", 0.1);
  maps\_vehicle::build_light(var_2, "wingtip_red", "tag_light_R_wing", "fx\misc\aircraft_light_wingtip_red", "running", 0.0);
  maps\_vehicle::build_light(var_2, "white_blink", "tag_light_belly", "fx\misc\aircraft_light_white_blink", "running", 0.0);
  maps\_vehicle::build_light(var_2, "white_blink_tail", "tag_light_tail", "fx\misc\aircraft_light_white_blink", "running", 0.4);
  maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
  maps\_vehicle::build_is_helicopter();
}

init_local() {
  self.delete_on_death = 1;
  self.script_badplace = 0;
  thread handle_audio();
}

handle_audio() {
  self endon("death");
  var_0 = 0;
  var_1 = 12000;
  vehicle_scripts\_cobra_aud::snd_init_cobra();
  thread monitor_death_stop_sounds();

  for (;;) {
    if(!isdefined(self.script_disablevehicleaudio) || !self.script_disablevehicleaudio) {
      var_2 = distance(self.origin, level.player.origin);

      if(var_0 && var_2 > var_1) {
        vehicle_scripts\_cobra_aud::snd_stop_cobra(1.0);
        var_0 = 0;
        wait 0.1;
      } else if(!var_0 && var_2 < var_1) {
        vehicle_scripts\_cobra_aud::snd_start_cobra();
        var_0 = 1;
      }
    } else if(var_0) {
      vehicle_scripts\_cobra_aud::snd_stop_cobra(1.5);
      var_0 = 0;
    }

    wait 0.1;
  }
}

monitor_death_stop_sounds() {
  self waittill("death");
  vehicle_scripts\_cobra_aud::snd_stop_cobra(1.0);
}

set_vehicle_anims(var_0) {
  return var_0;
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for (var_1 = 0; var_1 < 2; var_1++)
    var_0[var_1] = spawnstruct();

  var_0[0].sittag = "tag_pilot";
  var_0[1].sittag = "tag_gunner";
  var_0[0].bhasgunwhileriding = 0;
  var_0[1].bhasgunwhileriding = 0;
  var_0[0].idle[0] = % helicopter_pilot1_idle;
  var_0[0].idle[1] = % helicopter_pilot1_twitch_clickpannel;
  var_0[0].idle[2] = % helicopter_pilot1_twitch_lookback;
  var_0[0].idle[3] = % helicopter_pilot1_twitch_lookoutside;
  var_0[0].idleoccurrence[0] = 500;
  var_0[0].idleoccurrence[1] = 100;
  var_0[0].idleoccurrence[2] = 100;
  var_0[0].idleoccurrence[3] = 100;
  var_0[1].idle[0] = % helicopter_pilot2_idle;
  var_0[1].idle[1] = % helicopter_pilot2_twitch_clickpannel;
  var_0[1].idle[2] = % helicopter_pilot2_twitch_lookoutside;
  var_0[1].idle[3] = % helicopter_pilot2_twitch_radio;
  var_0[1].idleoccurrence[0] = 450;
  var_0[1].idleoccurrence[1] = 100;
  var_0[1].idleoccurrence[2] = 100;
  var_0[1].idleoccurrence[3] = 100;
  return var_0;
}