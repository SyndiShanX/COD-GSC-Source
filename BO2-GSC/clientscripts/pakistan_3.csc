/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\pakistan_3.csc
****************************************/

#include clientscripts\_utility;
#include clientscripts\_filter;
#include clientscripts\pakistan_3_fx;
#include clientscripts\_load;
#include clientscripts\_boat_soct_ride;
#include clientscripts\_audio;
#include clientscripts\pakistan_3_amb;

main() {
  clientscripts\pakistan_3_fx::main();
  clientscripts\_load::main();
  clientscripts\_boat_soct_ride::init();
  thread clientscripts\_audio::audio_init(0);
  thread clientscripts\pakistan_3_amb::main();
  level.b_outline_active = 0;
  init_filter_pakistan3_outline(getlocalplayers()[0]);
  register_clientflag_callback("player", 15, ::toggle_sonar);
  register_clientflag_callback("vehicle", 1, ::friendly_outline);
  register_clientflag_callback("vehicle", 5, ::set_drone_damage_low);
  register_clientflag_callback("vehicle", 7, ::set_drone_damage_med);
  register_clientflag_callback("vehicle", 9, ::set_drone_damage_hi);
  register_clientflag_callback("vehicle", 13, ::set_soct_damage_low);
  register_clientflag_callback("vehicle", 14, ::set_soct_damage_med);
  register_clientflag_callback("vehicle", 15, ::set_soct_damage_hi);
  waitforclient(0);

  set_player_viewmodel("c_usa_cia_masonjr_armlaunch_viewbody");
  setup_fullscreen_postfx();
}

toggle_sonar(localclientnum, set, newent) {
  level.localplayers[0] setsonarenabled(set);
}

init_filter_hud_projected_pip(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_hud_projected_pip");
}

friendly_outline(localclientnum, set, newent) {
  if(set) {
    self sethudoutlinecolor(2);
    enable_filter_pakistan3_outline(level.localplayers[localclientnum], 0);
    set_filter_pakistan3_outline_reveal_amount(level.localplayers[localclientnum], 0, 120);
    level.b_outline_active = 1;
  } else {
    self sethudoutlinecolor(0);
    disable_filter_pakistan3_outline(level.localplayers[localclientnum], 0);
    level.b_outline_active = 0;
  }
}

set_drone_damage_low(localclientnum, set, newent) {
  if(set) {
    if(isDefined(self.drone_damage_fx_low))
      stopfx(localclientnum, self.drone_damage_fx_low);

    self.drone_damage_fx_low = playfxontag(localclientnum, level._effect["fx_drone_damage_low"], self, "origin_animate_jnt");
  } else {
    if(isDefined(self.drone_damage_fx_low))
      stopfx(localclientnum, self.drone_damage_fx_low);

    self.drone_damage_fx_low = undefined;
  }
}

set_drone_damage_med(localclientnum, set, newent) {
  if(set) {
    if(isDefined(self.drone_damage_fx_med_1)) {
      stopfx(localclientnum, self.drone_damage_fx_med_1);
      stopfx(localclientnum, self.drone_damage_fx_med_2);
    }

    self.drone_damage_fx_med_1 = playfxontag(localclientnum, level._effect["fx_drone_damage_med_1"], self, "origin_animate_jnt");
    self.drone_damage_fx_med_2 = playfxontag(localclientnum, level._effect["fx_drone_damage_med_2"], self, "origin_animate_jnt");
  } else {
    if(isDefined(self.drone_damage_fx_med_1)) {
      stopfx(localclientnum, self.drone_damage_fx_med_1);
      stopfx(localclientnum, self.drone_damage_fx_med_2);
    }

    self.drone_damage_fx_med_1 = undefined;
  }
}

set_drone_damage_hi(localclientnum, set, newent) {
  if(set) {
    if(isDefined(self.drone_damage_fx_hi_1)) {
      stopfx(localclientnum, self.drone_damage_fx_hi_1);
      stopfx(localclientnum, self.drone_damage_fx_hi_2);
    }

    self.drone_damage_fx_hi_1 = playfxontag(localclientnum, level._effect["fx_drone_damage_hi_1"], self, "origin_animate_jnt");
    self.drone_damage_fx_hi_2 = playfxontag(localclientnum, level._effect["fx_drone_damage_hi_2"], self, "origin_animate_jnt");
  } else {
    if(isDefined(self.drone_damage_fx_hi_1)) {
      stopfx(localclientnum, self.drone_damage_fx_hi_1);
      stopfx(localclientnum, self.drone_damage_fx_hi_2);
    }

    self.drone_damage_fx_hi_1 = undefined;
  }
}

set_soct_damage_low(localclientnum, set, newent) {
  if(set) {
    if(isDefined(self.soct_damage_fx_low_1)) {
      stopfx(localclientnum, self.soct_damage_fx_low_1);
      stopfx(localclientnum, self.soct_damage_fx_low_2);
      stopfx(localclientnum, self.soct_damage_fx_low_3);
    }

    self.soct_damage_fx_low_1 = playfxontag(localclientnum, level._effect["fx_soct_damage_low_1"], self, "tag_console_fx");
    self.soct_damage_fx_low_2 = playfxontag(localclientnum, level._effect["fx_soct_damage_low_2"], self, "tag_hood_vent_left_fx");
    self.soct_damage_fx_low_3 = playfxontag(localclientnum, level._effect["fx_soct_damage_low_2"], self, "tag_hood_vent_right_fx");
  } else {
    if(isDefined(self.soct_damage_fx_low_1)) {
      stopfx(localclientnum, self.soct_damage_fx_low_1);
      stopfx(localclientnum, self.soct_damage_fx_low_2);
      stopfx(localclientnum, self.soct_damage_fx_low_3);
    }

    self.soct_damage_fx_low_1 = undefined;
  }
}

set_soct_damage_med(localclientnum, set, newent) {
  if(set) {
    if(isDefined(self.soct_damage_fx_med_1)) {
      stopfx(localclientnum, self.soct_damage_fx_med_1);
      stopfx(localclientnum, self.soct_damage_fx_med_2);
      stopfx(localclientnum, self.soct_damage_fx_med_3);
    }

    self.soct_damage_fx_med_1 = playfxontag(localclientnum, level._effect["fx_soct_damage_med_1"], self, "tag_console_fx");
    self.soct_damage_fx_med_2 = playfxontag(localclientnum, level._effect["fx_soct_damage_med_2"], self, "tag_hood_vent_left_fx");
    self.soct_damage_fx_med_3 = playfxontag(localclientnum, level._effect["fx_soct_damage_med_2"], self, "tag_hood_vent_right_fx");
  } else {
    if(isDefined(self.soct_damage_fx_med_1)) {
      stopfx(localclientnum, self.soct_damage_fx_med_1);
      stopfx(localclientnum, self.soct_damage_fx_med_2);
      stopfx(localclientnum, self.soct_damage_fx_med_3);
    }

    self.soct_damage_fx_med_1 = undefined;
  }
}

set_soct_damage_hi(localclientnum, set, newent) {
  if(set) {
    if(isDefined(self.soct_damage_fx_hi_1)) {
      stopfx(localclientnum, self.soct_damage_fx_hi_1);
      stopfx(localclientnum, self.soct_damage_fx_hi_2);
    }

    self.soct_damage_fx_hi_1 = playfxontag(localclientnum, level._effect["fx_soct_damage_hi_1"], self, "tag_console_fx");
    self.soct_damage_fx_hi_2 = playfxontag(localclientnum, level._effect["fx_soct_damage_hi_2"], self, "tag_hood_vent_left_fx");
    self.soct_damage_fx_hi_3 = playfxontag(localclientnum, level._effect["fx_soct_damage_hi_2"], self, "tag_hood_vent_right_fx");
  } else {
    if(isDefined(self.soct_damage_fx_hi_1)) {
      stopfx(localclientnum, self.soct_damage_fx_hi_1);
      stopfx(localclientnum, self.soct_damage_fx_hi_2);
      stopfx(localclientnum, self.soct_damage_fx_hi_3);
    }

    self.soct_damage_fx_hi_1 = undefined;
  }
}

setup_fullscreen_postfx() {
  init_filter_crackedglass_pakistan3(level.localplayers[0]);
  level.mask_crack_stage = 0;
}

put_on_oxygen_mask(set_filter) {
  level.mask_crack_stage = 0;
  set_filter_crackedglass_pakistan3_state(level.localplayers[0], 0, level.mask_crack_stage);
}

take_off_oxygen_mask() {
  level.mask_crack_stage = 0;
  set_filter_crackedglass_pakistan3_state(level.localplayers[0], 0, level.mask_crack_stage);
}

oxygen_mask_crack() {
  level.mask_crack_stage++;
  set_filter_crackedglass_pakistan3_state(level.localplayers[0], 0, level.mask_crack_stage);
}