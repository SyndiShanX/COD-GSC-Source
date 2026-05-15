/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_underwater.gsc
*****************************************************/

friendly_bubbles() {
  self endon("death");
  self notify("stop_friendly_bubbles");
  self endon("stop_friendly_bubbles");
  thread friendly_bubbles_cleanup();
  thread friendly_bubbles_cleanup_on_death();
  var_0 = "TAG_EYE";
  self.scuba_org = common_scripts\utility::spawn_tag_origin();
  self.scuba_org linkto(self, "tag_eye", (5, 0, -6), (-90, 0, 0));

  for(;;) {
    wait(3.5 + randomfloat(3));
    playFXOnTag(common_scripts\utility::getfx("scuba_bubbles_friendly"), self.scuba_org, "tag_origin");
  }
}

friendly_bubbles_stop() {
  self notify("stop_friendly_bubbles");
  self.scuba_org delete();
}

friendly_bubbles_cleanup_on_death() {
  common_scripts\utility::waittill_either("death", "stop_friendly_bubbles");
  self.scuba_org delete();
}

friendly_bubbles_cleanup() {
  self endon("death");
  self waittillmatch("single anim", "surfacing");
  self notify("stop_friendly_bubbles");
}

player_scuba() {
  if(!issplitscreen()) {
    thread player_scuba_breathe_sound();
  } else if(self == level.player) {
    thread player_scuba_breathe_sound();
  }

  thread player_scuba_bubbles();
}

player_scuba_breathe_sound() {
  self endon("death");
  self notify("start_scuba_breathe");
  self endon("start_scuba_breathe");
  self endon("stop_scuba_breathe");

  for(;;) {
    wait 0.05;
    self notify("scuba_breathe_sound_starting");

    if(self issprinting()) {
      self playlocalsound("scuba_breathe_player_sprint", "scuba_breathe_sound_done");
    } else {
      self playlocalsound("scuba_breathe_player", "scuba_breathe_sound_done");
    }

    self waittill("scuba_breathe_sound_done");
  }
}

stop_player_scuba() {
  self notify("stop_scuba_breathe");
  self stoplocalsound("scuba_breathe_player");
}

debug_org() {
  for(;;) {
    wait 0.5;
  }
}

player_scuba_bubbles() {
  if(getdvarint("demo_mode")) {
    return;
  }
  self endon("death");
  self endon("stop_scuba_breathe");
  waittillframeend;
  self.playerfxorg = spawn("script_model", self.origin + (0, 0, 0));
  self.playerfxorg setModel("tag_origin");
  self.playerfxorg.angles = self.angles;
  self.playerfxorg.origin = self getEye() - (0, 0, 10);
  self.playerfxorg linktoplayerview(self, "tag_origin", (5, 0, -55), (0, 0, 0), 1);
  thread scuba_fx_cleanup(self.playerfxorg);

  for(;;) {
    self waittill("scuba_breathe_sound_starting");
    wait 2.1;
    thread player_bubbles_fx(self.playerfxorg);

    if(common_scripts\utility::cointoss()) {
      self waittill("scuba_breathe_sound_starting");
    }
  }
}

scuba_fx_cleanup(var_0) {
  self waittill("stop_scuba_breathe");
  var_0 unlinkfromplayerview(self);
  var_0 delete();
}

player_bubbles_fx(var_0) {
  self endon("stop_scuba_breathe");
  playFXOnTag(common_scripts\utility::getfx("scuba_bubbles"), var_0, "TAG_ORIGIN");
}

underwater_hud_enable(var_0) {
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

player_scuba_mask(var_0, var_1) {
  if(getdvarint("sg_scuba_mask_off") == 1) {
    return;
  }
  if(getdvarint("demo_mode")) {
    return;
  }
  var_2 = "halo_overlay_scuba";

  if(isDefined(var_1)) {
    var_2 = var_1;
  }

  self.hud_scubamask = maps\_hud_util::create_client_overlay(var_2, 1, self);
  self.hud_scubamask.foreground = 0;
  self.hud_scubamask.sort = -99;
  self.scubamask_distortion = spawn("script_model", level.player.origin);
  self.scubamask_distortion setModel("tag_origin");
  self.scubamask_distortion.origin = self.origin;
  self.scubamask_distortion linktoplayerview(self, "tag_origin", (10, 0, 0), (0, 180, 0), 1);
  playFXOnTag(common_scripts\utility::getfx("scuba_mask_distortion"), self.scubamask_distortion, "tag_origin");
  self.hud_scubamask_model = spawn("script_model", level.player getEye());
  self.hud_scubamask_model setModel("shpg_udt_headgear_player_a");
  self.hud_scubamask_model linktoplayerview(self, "tag_origin", (-0.3, 0, -1.2), (0, 90, -4), 1);

  if(getdvarint("demo_mode")) {
    self.hud_scubamask_model delete();
    stopFXOnTag(common_scripts\utility::getfx("scuba_mask_distortion"), self.scubamask_distortion, "tag_origin");
  }
}

player_scuba_mask_disable(var_0) {
  if(getdvarint("sg_scuba_mask_off") == 1) {
    return;
  }
  if(getdvarint("demo_mode")) {
    return;
  }
  if(isDefined(self.hud_scubamask)) {
    self.hud_scubamask maps\_hud_util::destroyelem();
    self.scubamask_distortion unlinkfromplayerview(self);
    self.scubamask_distortion delete();
    self.hud_scubamask_model unlinkfromplayerview(self);
    self.hud_scubamask_model delete();
  }
}