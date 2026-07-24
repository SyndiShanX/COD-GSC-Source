/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2929.gsc
**************************************/

precache() {}

_id_104DE() {}

_id_F626() {
  setsaveddvar("Ragdoll_max_life", 60000);
}

_id_F3CF() {
  setsaveddvar("glass_angular_vel", "1 5");
  setsaveddvar("glass_linear_vel", "20 40");
  setsaveddvar("glass_fall_gravity", 0);
  setsaveddvar("glass_simple_duration", 10000);
}

_id_D2AC() {
  thread _id_D2B2();
}

_id_D2B2() {
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

_id_11031() {
  self notify("stop_space_breathe");
  self stoplocalsound("scuba_breathe_player");
}

_id_4EFF() {
  for(;;) {
    wait 0.5;
  }
}

_id_104DD(var_0) {
  if(var_0 == 1) {
    setsaveddvar("hud_showStance", "0");
    setsaveddvar("compass", "0");
  } else {
    setsaveddvar("hud_drawhud", "1");
    setsaveddvar("hud_showStance", "1");
    setsaveddvar("compass", "1");
  }
}

_id_D2B8(var_0) {
  self._id_9161 = scripts\sp\hud_util::_id_48B7("hud_space_helmet_overlay", 1, self);
  self._id_9161.foreground = 0;
  self._id_9161.sort = -99;
}

_id_D2B9(var_0) {
  if(isDefined(self._id_9162)) {
    self._id_9162 scripts\sp\hud_util::destroyelem();
  }

  if(isDefined(self._id_9161)) {
    self._id_9161 scripts\sp\hud_util::destroyelem();
  }
}