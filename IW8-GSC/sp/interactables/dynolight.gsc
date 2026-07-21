/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\interactables\dynolight.gsc
***********************************************/

init() {
  if(isDefined(level.dynolights_initialized)) {
    return;
  }
  level.dynolights_initialized = 1;

  if(!isDefined(level.dynolights))
    level.dynolights = [];

  if(!getdvarint("scr_disable_dynolight_switching"))
    setDvar("scr_disable_dynolight_switching", 0);

  level.castingdynolights = [];

  foreach(var_1 in level.dynolights) {
    if(!isDefined(var_1.init_count))
      var_1.init_count = 0;

    var_1.init_count++;
    var_1 thread dynolight_postload_state_init();
    var_1 thread dynolight_death_watcher();

    if(isDefined(var_1.targetname))
      var_2 = getEntArray(var_1.targetname, "target");
    else
      var_2 = [];

    foreach(var_4 in var_2) {
      if(var_4 is_lightswitch())
        var_4 thread lightswitch_init(var_1);
    }

    var_1.lightpos = var_1.origin;
  }

  level.dynolight_trace_contents = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 0, 0, 1, 0);
}

add_dynolight(var_0) {
  if(!isDefined(level.dynolights))
    level.dynolights = [];

  level.dynolights[level.dynolights.size] = var_0;
}

dynolight_postload_state_init() {
  self endon("death");
  wait 0.05;

  if(!isDefined(self.circuitparents))
    self.circuitparents = [];

  var_0 = strtok(self.script_noteworthy, "_");
  var_1 = 0;

  foreach(var_3 in var_0) {
    if(var_3 == "off")
      var_1 = 1;
  }

  if(var_1)
    self setscriptablepartstate("onoff", "off");
  else
    self setscriptablepartstate("onoff", "on");

  self.timeoflaststatechange = gettime();
  self.intensity = float(self getscriptablepartstate("light_intensity"));

  if(self.intensity > 0)
    level.castingdynolights = scripts\engine\utility::array_add(level.castingdynolights, self);

  self.data = scripts\engine\sp\utility::get_linked_struct();

  if(isDefined(self.data) && !istrue(self.data.script_ignoreme)) {
    if(isDefined(self.data.target))
      self.data.angles = vectortoangles(scripts\engine\utility::getStruct(self.data.target, "targetname").origin - self.data.origin);

    if(!isDefined(self.data.script_radius))
      iprintln("dynolight data struct at " + self.origin + " missing script_radius kvp");

    if(!isDefined(self.data.script_fov_inner))
      iprintln("dynolight data struct at " + self.origin + " missing script_fov_inner kvp");

    if(!isDefined(self.data.script_type))
      iprintln("dynolight data struct at " + self.origin + " missing script_type kvp");
  }

  var_5 = scripts\engine\utility::get_linked_ents();

  if(isDefined(var_5))
    self.linked_ents = var_5;

  self.lightpos = get_model_trace_start();
}

lightswitch_postload_state_init() {
  self endon("death");
  wait 0.05;
  thread lightswitch_interact_manager();

  if(!self.script_light_switch_state)
    lightswitch_update_children(self.script_light_switch_state);
}

lightswitch_init(var_0) {
  if(!isDefined(var_0.circuitparents))
    var_0.circuitparents = [];

  if(!scripts\engine\utility::array_contains(var_0.circuitparents, self))
    var_0.circuitparents = scripts\engine\utility::array_add(var_0.circuitparents, self);

  if(!isDefined(self.lights)) {
    self.lights = [];
    self.circuitchildren = [];
    self.circuitsiblings = [];
    self.circuitparents = [];
    self.disabled = 0;

    if(!isDefined(self.script_light_switch_state))
      self.script_light_switch_state = 1;

    if(!isDefined(self.script_light_switch_sfx))
      self.script_light_switch_sfx = "light_switch";

    if(isDefined(self.script_light_idle_sfx))
      self playLoopSound(self.script_light_idle_sfx);

    if(isDefined(self.script_light_idle_sfx) && !self.script_light_switch_state)
      self scalevolume(0, 0.0);

    thread lightswitch_postload_state_init();
    thread lightswitch_death_watcher();

    if(isDefined(self.targetname))
      var_1 = getEntArray(self.targetname, "target");
    else
      var_1 = [];

    foreach(var_3 in var_1) {
      if(isDefined(var_3.classname) && var_3.classname == "script_origin")
        var_3 thread lightswitch_init(self);
    }
  }

  foreach(var_6 in var_0.circuitparents) {
    if(var_6 == self) {
      continue;
    }
    if(!scripts\engine\utility::array_contains(self.circuitsiblings, var_6))
      self.circuitsiblings = scripts\engine\utility::array_add(self.circuitsiblings, var_6);

    if(!scripts\engine\utility::array_contains(var_6.circuitsiblings, self))
      var_6.circuitsiblings = scripts\engine\utility::array_add(var_6.circuitsiblings, self);
  }

  if(var_0 is_light())
    self.lights = scripts\engine\utility::array_add(self.lights, var_0);
  else if(var_0 is_lightswitch())
    self.circuitchildren = scripts\engine\utility::array_add(self.circuitchildren, var_0);
}

lightswitch_interact_manager() {
  self endon("death");
  self.interact = 0;
  lightswitch_enable_interact();

  for(;;) {
    self waittill("lightswitch_toggle");

    if(self.script_light_switch_state == 1) {
      var_0 = "_off";
      var_1 = 0;

      if(isDefined(self.script_light_switch_fx))
        playFXOnTag(self.script_light_switch_fx, self, get_lightswitch_fx_tag());
    } else {
      var_0 = "_on";
      var_1 = 1;

      if(isDefined(self.script_light_switch_fx))
        killfxontag(self.script_light_switch_fx, self, get_lightswitch_fx_tag());
    }

    thread scripts\engine\utility::play_sound_in_space(self.script_light_switch_sfx + var_0, self.origin);
    lightswitch_onoff(var_1);
    lightswitch_update_children(var_1, self);
    thread lightswitch_toggle_debounce();
  }
}

get_lightswitch_fx_tag() {
  if(isDefined(self.script_light_switch_fx_tag))
    return self.script_light_switch_fx_tag;

  return getpartname(self.model, 0);
}

lightswitch_onoff(var_0) {
  if(self.script_light_switch_state == var_0) {
    return;
  }
  self.script_light_switch_state = var_0;

  if(var_0) {
    if(isDefined(self.script_light_idle_sfx))
      self scalevolume(0, 0.5);
  } else if(isDefined(self.script_light_idle_sfx))
    self scalevolume(1, 0.25);
}

lightswitch_disable(var_0) {
  if(var_0 == self.disabled) {
    return;
  }
  self.disabled = var_0;

  if(var_0)
    lightswitch_disable_interact();
  else
    lightswitch_enable_interact();
}

lightswitch_send_stealth_event() {
  if(gettime() < 1000) {
    return;
  }
  if(isDefined(level.stealth)) {
    var_0 = sortbydistance(self.lights, level.player.origin);

    foreach(var_2 in var_0) {
      var_3 = scripts\engine\sp\utility::get_within_range(var_2.lightpos, getaiarray("axis"), 500);
      var_3 = sortbydistance(var_3, var_2.lightpos);

      if(isDefined(var_3[0])) {
        var_3[0] aieventlistenerevent("footstep", level.player, self.origin);
        return 1;
      }
    }
  }
}

lightswitch_toggle_debounce() {
  self endon("death");
  self endon("disable_interact");

  while(level.player useButtonPressed())
    wait 0.05;

  lightswitch_enable_interact();
}

collect_circuit_children(var_0) {}

collect_circuit_siblines(var_0) {}

lightswitch_update_children(var_0, var_1) {
  var_2 = self.lights;

  foreach(var_4 in self.circuitsiblings) {
    var_4 lightswitch_onoff(var_0);

    foreach(var_6 in var_4.lights) {
      if(!scripts\engine\utility::array_contains(var_2, var_6))
        var_2 = scripts\engine\utility::array_add(var_2, var_6);
    }
  }

  var_9 = self.circuitchildren;
  var_10 = [];

  for(;;) {
    var_11 = 0;

    foreach(var_4 in var_9) {
      if(!scripts\engine\utility::array_contains(var_10, var_4)) {
        foreach(var_14 in var_4.circuitchildren) {
          if(!scripts\engine\utility::array_contains(var_9, var_14))
            var_9 = scripts\engine\utility::array_add(var_9, var_14);
        }

        foreach(var_14 in var_4.circuitsiblings) {
          if(!scripts\engine\utility::array_contains(var_9, var_14))
            var_9 = scripts\engine\utility::array_add(var_9, var_14);
        }

        var_10 = scripts\engine\utility::array_add(var_10, var_4);
        var_11 = 1;
      }
    }

    if(!var_11) {
      break;
    }
  }

  var_19 = scripts\engine\utility::ter_op(var_0, 0, 1);

  foreach(var_4 in var_9) {
    var_4 lightswitch_onoff(var_0);
    var_4 lightswitch_disable(var_19);

    foreach(var_6 in var_4.lights) {
      if(!scripts\engine\utility::array_contains(var_2, var_6))
        var_2 = scripts\engine\utility::array_add(var_2, var_6);
    }
  }

  foreach(var_6 in var_2) {
    if(!var_6.alive) {
      continue;
    }
    var_6 dynolight_set_onoff_state(var_0);
  }
}

lightswitch_enable_interact() {
  if(self.disabled) {
    return;
  }
  if(self.interact) {
    return;
  }
  self.interact = 1;
  var_0 = (0, 0, 0);

  if(isDefined(self.interact_offset)) {
    var_0 = self.interact_offset;

    if(isDefined(self.angles))
      var_0 = rotatevectorinverted(var_0, self.angles);
  }

  var_1 = 120;

  if(isDefined(self.show_dist_override))
    var_1 = self.show_dist_override;

  var_2 = 85;

  if(isDefined(self.use_dist_override))
    var_2 = self.use_dist_override;

  scripts\sp\player\cursor_hint::create_cursor_hint(undefined, var_0, &"SCRIPT/LIGHTSWITCH_INTERACT", 65, var_1, var_2, 0, undefined, undefined, undefined, "duration_none", undefined, undefined, undefined, 90);
  thread lightswitch_trigger_notify();
}

lightswitch_trigger_notify() {
  self endon("death");
  self endon("disable_interact");
  self waittill("trigger", var_0);
  self.triggering_ent = var_0;
  self.interact = 0;

  if(isDefined(level.lightswitch_interact_func))
    self[[level.lightswitch_interact_func]]();

  lightswitch_toggle();
  self notify("tempRandoDraWdisable");
}

lightswitch_disable_interact() {
  self notify("disable_interact");
  self.interact = 0;
  scripts\sp\player\cursor_hint::remove_cursor_hint();
}

lightswitch_toggle() {
  self notify("lightswitch_toggle");
}

dynolight_set_onoff_state(var_0) {
  if(var_0 && self getscriptablepartstate("onoff") == "off") {
    dynolight_update_nvg_mode();
    self.timeoflaststatechange = gettime();
  } else if(!var_0 && self getscriptablepartstate("onoff") != "off") {
    self setscriptablepartstate("onoff", "off");
    self.timeoflaststatechange = gettime();
    thread stealth_event_on_light_death();
  }
}

dynolight_update_nvg_mode() {
  if(level.player isnightvisionon() && !level.player scripts\engine\sp\utility::is_flir_vision_on() && !getdvarint("scr_disable_dynolight_switching"))
    self setscriptablepartstate("onoff", "on");
  else
    self setscriptablepartstate("onoff", "on");
}

dynolight_death_watcher() {
  self.alive = 1;
  self waittill("death");
  self.alive = 0;
  self.intensity = 0;
  self.timeoflaststatechange = gettime();

  foreach(var_1 in self.circuitparents) {
    var_1.lights = scripts\engine\utility::array_remove(var_1.lights, self);
    var_1 check_lightswitch_cleanup();
  }

  thread stealth_event_on_light_death();
}

stealth_event_on_light_death() {
  if(isDefined(level.stealth)) {
    var_0 = scripts\engine\utility::drop_to_ground(self.lightpos, 24, -256);
    var_1 = undefined;

    if(self getscriptablepartstate("onoff") == "death")
      var_1 = 400;

    scripts\stealth\event::event_broadcast_axis_by_sight("light_killed", self, self.lightpos, 800, 0, var_0, var_1);
  }
}

get_model_trace_start() {
  var_0 = self gettagorigin("tag_fx_bulb", 1);

  if(isDefined(var_0))
    return var_0;

  switch (self.model) {
    case "pnr_light_lamp_floor_tall_01_on":
    case "light_lamp_floor_tall_01_on":
      var_0 = self.origin + (0, 0, 120);
      break;
    case "ch_street_wall_light_01_off":
    case "ch_street_wall_light_01_on":
      var_0 = self.origin - (0, 0, 10) + anglesToForward(self.angles) * 35;
      break;
    case "ind_spotlight_generator_stripes":
    case "ind_spotlight_generator_on":
    case "ind_spotlight_generator_off":
      var_0 = self.origin + (0, 0, 131) + anglesToForward(self.angles) * 19;
      break;
    case "ind_flood_light_standing_tall_dmg":
    case "ind_flood_light_standing_tall_off":
    case "ind_flood_light_standing_tall_on":
      var_0 = self.origin + (0, 0, 39);
      break;
    case "deco_wall_light_fn_01":
    case "deco_wall_light_fn_01_on":
      var_0 = self.origin + anglesToForward(self.angles) * 10;
      break;
    case "clk_industrial_light_01_on_warm":
    case "clk_industrial_light_01_on":
      var_0 = self.origin - (0, 0, 64);
      break;
    case "cp_disco_fluorescent_light_on_blue":
    case "cp_disco_fluorescent_light_on":
      var_0 = self.origin - (0, 0, 30);
      break;
    case "crr_light_utility_01_on":
    case "crr_light_utility_01":
      var_0 = self.origin - (0, 0, 7) + anglesToForward(self.angles) * 5;
      break;
    case "cp_disco_searchlight_swivel_on":
      var_0 = self.origin + (0, 0, 43) + anglesToForward(self.angles) * 28;
      break;
    case "cs_cargoship_wall_light_off":
      var_0 = self.origin + anglesToForward(self.angles) * 15;
      break;
    case "dam_tunnel_light_01_off":
      var_0 = self.origin - (0, 0, 23);
      break;
    case "com_floodlight_on":
    case "com_floodlight_scr":
    case "com_floodlight":
      var_0 = self.origin + (0, 0, 11) + anglesToForward(self.angles) * 6;
      break;
    case "tent_ceiling_light_off":
      var_0 = self.origin - (0, 0, 7);
      break;
    case "zmb_center_portal_base_small_lights_blue":
    case "zmb_center_portal_base_small_lights_off":
    case "zmb_center_portal_base_small_lights":
      var_0 = self.origin + anglesToForward(self.angles) * 9;
      break;
    case "p7_light_chandelier_vintage_01_on":
    case "p7_light_chandelier_vintage_01_broken":
    case "p7_light_chandelier_vintage_01":
      var_0 = self.origin - (0, 0, 44);
      break;
    case "light_outdoorwall01":
      var_0 = self.origin - (0, 0, 6) + anglesToForward(self.angles) * 8;
      break;
    case "mp_dart_lightfluo_on":
      var_0 = self.origin - (0, 0, 8);
      break;
    case "light_lamp_black_01_ems":
    case "light_lamp_black_01_off":
    case "light_lamp_black_01":
      var_0 = self.origin + (0, 0, 25) + anglesToForward(self.angles) * 9;
      break;
    case "bo_lights_hang_lamp_on":
      var_0 = self.origin - (0, 0, 37);
      break;
    case "floor01_lamp_01_off":
    case "floor01_lamp_01":
      var_0 = self.origin - (0, 0, 40);
      break;
    case "street_lamp_post_old_iw6":
    case "street_lamp_post_old_iw6_on":
      var_0 = self.origin + (0, 0, 240);
      break;
    default:
      var_0 = self.origin;
      break;
  }

  return var_0;
}

lightswitch_death_watcher() {
  self waittill("death");

  foreach(var_1 in self.circuitparents) {
    var_1.circuitchildren = scripts\engine\utility::array_remove(var_1.circuitchildren, self);
    var_1 check_lightswitch_cleanup();
  }
}

check_lightswitch_cleanup() {
  if(self.lights.size == 0 && self.circuitchildren.size == 0)
    self delete();
}

is_lightswitch() {
  if(isDefined(self.code_classname) && self.code_classname == "script_origin")
    return 1;
  else
    return 0;
}

is_light() {
  if(isDefined(self.code_classname) && self.code_classname == "scriptable")
    return 1;
  else
    return 0;
}