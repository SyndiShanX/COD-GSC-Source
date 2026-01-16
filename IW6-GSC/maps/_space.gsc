/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_space.gsc
*****************************************************/

precache() {
  precacheshader("hud_space_helmet_overlay");
}

set_zero_gravity() {}

set_glass_zero_gravity() {
  setsaveddvar("glass_angular_vel", "1 5");
  setsaveddvar("glass_linear_vel", "20 40");
  setsaveddvar("glass_fall_gravity", 0);
  setsaveddvar("glass_simple_duration", 10000);
}

player_space() {
  if(!issplitscreen())
    thread player_space_breathe_sound();
  else if(self == level.player)
    thread player_space_breathe_sound();

  thread player_scuba_bubbles();
}

player_space_breathe_sound() {
  self endon("death");
  self endon("disable_space");
  self notify("start_space_breathe");
  self endon("start_space_breathe");
  self endon("stop_space_breathe");

  for(;;) {
    wait 0.05;
    self notify("space_breathe_sound_starting");
    self waittill("space_breathe_sound_done");
  }
}

stop_player_space() {
  self notify("stop_space_breathe");
  self stoplocalsound("scuba_breathe_player");
}

debug_org() {
  for(;;)
    wait 0.5;
}

player_scuba_bubbles() {
  self endon("death");
  self endon("disable_space");
  self endon("stop_space_breathe");
  waittillframeend;
  self.playerfxorg = spawn("script_model", self.origin + (0, 0, 0));
  self.playerfxorg setModel("tag_origin");
  self.playerfxorg.angles = self.angles;
  self.playerfxorg.origin = self getEye() - (0, 0, 10);
  self.playerfxorg linktoplayerview(self, "tag_origin", (5, 0, -55), (0, 0, 0), 1);
  thread scuba_fx_cleanup(self.playerfxorg);

  for(;;) {
    self waittill("space_breathe_sound_starting");
    wait 2.1;

    if(common_scripts\utility::cointoss())
      self waittill("space_breathe_sound_starting");
  }
}

scuba_fx_cleanup(var_0) {
  self waittill("stop_space_breathe");
  var_0 unlinkfromplayerview(self);
  var_0 delete();
}

player_bubbles_fx(var_0) {
  self endon("stop_space_breathe");
}

space_hud_enable(var_0) {
  wait 0.05;

  if(var_0 == 1) {
    setsaveddvar("hud_showStance", "0");
    setsaveddvar("compass", "0");
  } else {
    setsaveddvar("hud_drawhud", "1");
    setsaveddvar("hud_showStance", "1");
    setsaveddvar("compass", "1");
  }
}

player_space_helmet(var_0) {
  self.hud_space_helmet_overlay = maps\_hud_util::create_client_overlay("hud_space_helmet_overlay", 1, self);
  self.hud_space_helmet_overlay.foreground = 0;
  self.hud_space_helmet_overlay.sort = -99;
}

player_space_helmet_disable(var_0) {
  if(isDefined(self.hud_space_helmet_rim))
    self.hud_space_helmet_rim maps\_hud_util::destroyelem();

  if(isDefined(self.hud_space_helmet_overlay))
    self.hud_space_helmet_overlay maps\_hud_util::destroyelem();
}