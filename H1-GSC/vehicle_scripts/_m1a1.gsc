/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: vehicle_scripts\_m1a1.gsc
********************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("m1a1", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_m1a1_abrams", "vehicle_m1a1_abrams_dmg");
  maps\_vehicle::build_shoot_shock("tankblast");
  maps\_vehicle::build_drive( % abrams_movement, % abrams_movement_backwards, 10);
  maps\_vehicle::build_exhaust("fx\distortion\abrams_exhaust");
  maps\_vehicle::build_deckdust("fx\dust\abrams_deck_dust");
  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_deathfx("fx\explosions\large_vehicle_explosion", undefined, "exp_armor_vehicle");
  maps\_vehicle::build_turret("m1a1_coaxial_mg", "tag_coax_mg", "vehicle_m1a1_abrams_PKT_Coaxial_MG");
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_rumble("tank_rumble", 0.15, 4.5, 900, 1, 1);
  maps\_vehicle::build_team("allies");
  maps\_vehicle::build_mainturret();
  maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
  maps\_vehicle::build_frontarmor(0.33);
}

init_local() {
  if(!isdefined(level.aud.disable_m1a1_audio))
    handle_audio();
}

handle_audio() {
  self endon("death");
  var_0 = 0;
  var_1 = 6000;
  var_2 = 1.0;
  vehicle_scripts\_m1a1_aud::snd_init_m1a1();
  thread monitor_death_stop_sounds();
  self.snd_disable_vehicle_system = self.script_disablevehicleaudio;

  for (;;) {
    if(!isdefined(self.script_disablevehicleaudio) || !self.script_disablevehicleaudio) {
      var_3 = distance(self.origin, level.player.origin);

      if(var_0 && var_3 > var_1) {
        vehicle_scripts\_m1a1_aud::snd_stop_m1a1(var_2);
        var_0 = 0;
        wait 0.1;
      } else if(!var_0 && var_3 < var_1) {
        vehicle_scripts\_m1a1_aud::snd_start_m1a1();
        var_0 = 1;
      }
    } else if(var_0) {
      vehicle_scripts\_m1a1_aud::snd_stop_m1a1(var_2);
      var_0 = 0;
    }

    wait 0.1;
  }
}

monitor_death_stop_sounds() {
  self waittill("death");
  var_0 = 1.0;
  vehicle_scripts\_m1a1_aud::snd_stop_m1a1(var_0);
}

set_vehicle_anims(var_0) {
  return var_0;
}

setanims() {
  var_0 = [];

  for (var_1 = 0; var_1 < 11; var_1++)
    var_0[var_1] = spawnstruct();

  var_0[0].getout_delete = 1;
  return var_0;
}