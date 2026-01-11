/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: destructible_scripts\toy_lv_slot_machine.gsc
********************************************************/

main() {
  toy_lv_slot_machine(0);
}

toy_lv_slot_machine(var_0) {
  if(var_0) {
    var_1 = "toy_lv_slot_machine_flicker";
    var_2 = ::toy_lv_slot_machine_flashlights;
    var_3 = "fx/explosions/tv_flatscreen_explosion";
    var_4 = "dst_slot_machine_sparks";
    var_5 = "dst_slot_machine_sign_sparks";
  } else {
    var_1 = "toy_lv_slot_machine";
    var_2 = ::toy_lv_slot_machine_switchlightsoff;
    var_3 = "fx/explosions/tv_flatscreen_explosion_off";
    var_4 = "dst_slot_machine";
    var_5 = "dst_slot_machine_sign";
  }

  common_scripts\_destructible::destructible_create(var_1, "tag_origin", 0);
  common_scripts\_destructible::destructible_attachmodel(undefined, "lv_slot_machine_destroyed");
  common_scripts\_destructible::destructible_function(var_2);
  common_scripts\_destructible::destructible_state();
  common_scripts\_destructible::destructible_part("tag_origin_intact", undefined, 100);
  common_scripts\_destructible::destructible_damage_threshold(100);
  common_scripts\_destructible::destructible_fx("tag_tokens", "fx/props/lv_slot_machine_chips_fall");
  common_scripts\_destructible::destructible_state("tag_origin_intact", undefined, 400, undefined, undefined, "splash");
  common_scripts\_destructible::destructible_damage_threshold(400);
  common_scripts\_destructible::destructible_notify("stop flashing");
  common_scripts\_destructible::destructible_state("tag_origin_d");
  common_scripts\_destructible::destructible_part("tag_screen", undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_notify("stop flashing");
  common_scripts\_destructible::destructible_sound(var_4, undefined, 0);
  common_scripts\_destructible::destructible_sound(var_4, undefined, 1);
  common_scripts\_destructible::destructible_sound("dst_slot_machine_coins", undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_screen", var_3, 1, undefined, 0);
  common_scripts\_destructible::destructible_fx("tag_screen", var_3, 1, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_tokens", "fx/props/lv_slot_machine_chips_fall", 1, undefined, 1);
  common_scripts\_destructible::destructible_state("tag_screen_d");
  common_scripts\_destructible::destructible_part("tag_billboard", undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_notify("stop flashing");
  common_scripts\_destructible::destructible_sound(var_5, undefined, 0);
  common_scripts\_destructible::destructible_sound(var_5, undefined, 1);
  common_scripts\_destructible::destructible_sound("dst_slot_machine_coins", undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_billboard", var_3, 1, undefined, 0);
  common_scripts\_destructible::destructible_fx("tag_billboard", var_3, 1, undefined, 1);
  common_scripts\_destructible::destructible_fx("tag_tokens", "fx/props/lv_slot_machine_chips_fall", 1, undefined, 1);
  common_scripts\_destructible::destructible_state("tag_billboard_d");
  common_scripts\_destructible::destructible_part("tag_light", undefined, 40, undefined, undefined, undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_notify("stop flashing");
  common_scripts\_destructible::destructible_fx("tag_light", var_3);
  common_scripts\_destructible::destructible_sound(var_4);
  common_scripts\_destructible::destructible_state("tag_light_d");
  level._interactive["lv_slot_machine_flashing_tags"] = [];
  level._interactive["lv_slot_machine_flashing_tags"][0] = "tag_lit_billboard";
  level._interactive["lv_slot_machine_flashing_tags"][1] = "tag_lit_buttons";
  level._interactive["lv_slot_machine_flashing_tags"][2] = "tag_lit_light";

  if(var_0) {
    thread toy_lv_slot_machine_lightstimer();
  }
}

toy_lv_slot_machine_lightstimer() {
  level._interactive["lv_slot_machine_LightsTimer_running"] = 1;
  var_0 = 1;

  for(;;) {
    if(var_0) {
      var_0 = randomint(100) < 50;
    } else {
      var_0 = randomint(100) < 20;
    }

    if(var_0) {
      wait(randomfloatrange(1, 4));
    } else {
      wait(randomfloatrange(0.4, 1));
    }

    level notify("toy_lv_slot_machine_LightsOn");
    wait(randomfloatrange(0.05, 1));
    level notify("toy_lv_slot_machine_LightsOff");
  }
}

toy_lv_slot_machine_flashlights() {
  self endon("stop flashing");
  thread toy_lv_slot_machine_stopflashing();
  var_0 = 50 + randomint(50);
  common_scripts\_destructible::destructible_get_my_breakable_light(128);

  for(;;) {
    var_1 = level common_scripts\utility::waittill_any_return("toy_lv_slot_machine_LightsOn", "toy_lv_slot_machine_LightsOff");

    if(isDefined(var_1)) {
      if(var_1 == "toy_lv_slot_machine_LightsOn") {
        toy_lv_slot_machine_switchlightson(var_0, self.breakable_light);
        continue;
      }

      toy_lv_slot_machine_switchlightsoff(var_0, self.breakable_light);
    }
  }
}

toy_lv_slot_machine_stopflashing(var_0) {
  self waittill("stop flashing");

  foreach(var_2 in level._interactive["lv_slot_machine_flashing_tags"]) {
    self hidepart(var_2);
  }

  if(isDefined(var_0)) {
    var_0 setlightintensity(0);
  }
}

toy_lv_slot_machine_switchlightson(var_0, var_1) {
  level endon("toy_lv_slot_machine_LightsOff");

  if(randomint(100) > var_0) {
    wait(randomfloat(0.3));
  }

  foreach(var_3 in level._interactive["lv_slot_machine_flashing_tags"]) {
    self showpart(var_3);
  }

  if(isDefined(var_1)) {
    var_1 setlightintensity(1);
  }

  if(common_scripts\utility::issp()) {
    self playSound("dst_slot_machine_light_flkr_on", "lightsSound", 1);
  } else {
    self playSound("dst_slot_machine_light_flkr_on");
  }
}

toy_lv_slot_machine_switchlightsoff(var_0, var_1) {
  level endon("toy_lv_slot_machine_LightsOn");

  if(isDefined(var_0) && randomint(100) > var_0) {
    wait(randomfloat(0.1));
  }

  foreach(var_3 in level._interactive["lv_slot_machine_flashing_tags"]) {
    self hidepart(var_3);
  }

  if(isDefined(var_1)) {
    var_1 setlightintensity(0);
  }

  if(common_scripts\utility::issp()) {
    self playSound("dst_slot_machine_light_flkr_off", "lightsSound", 1);
  } else {
    self playSound("dst_slot_machine_light_flkr_off");
  }
}