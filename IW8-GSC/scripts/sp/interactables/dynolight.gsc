/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\interactables\dynolight.gsc
**************************************************/

function init() {
  if(isDefined(level.dynolights_initialized)) {
    return;
  }

  level.dynolights_initialized = 1;

  if(!isDefined(level.dynolights)) {
    level.dynolights = [];
  }

  if(!getdvarint("scr_disable_dynolight_switching")) {
    setDvar("scr_disable_dynolight_switching", 0);
  }

  level.castingdynolights = [];

  foreach(var1 in level.dynolights) {
    if(!isDefined(var1.init_count)) {
      var1.init_count = 0;
    }

    var1.init_count++;
    thread dynolight_postload_state_init();
    thread dynolight_death_watcher();

    if(isDefined(var1.targetname)) {
      var2 = getEntArray(var1.targetname, "target");
    } else {
      var2 = [];
    }

    foreach(var4 in var2) {
      if(is_lightswitch(var4)) {
        thread lightswitch_init(var4);
      }
    }

    var1.lightpos = var1.origin;
  }

  level.dynolight_trace_contents = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 0, 0, 1, 0);
}

function add_dynolight(var0) {
  if(!isDefined(level.dynolights)) {
    level.dynolights = [];
  }

  level.dynolights[level.dynolights.size] = var0;
}

function dynolight_postload_state_init() {
  self endon("death");
  wait 0.05;

  if(!isDefined(self.circuitparents)) {
    self.circuitparents = [];
  }

  var0 = strtok(self.script_noteworthy, "_");
  var1 = 0;

  foreach(var3 in var0) {
    if(var3 == "off") {
      var1 = 1;
    }
  }

  if(var1) {
    self setscriptablepartstate("onoff", "off");
  } else {
    self setscriptablepartstate("onoff", "on");
  }

  self.timeoflaststatechange = gettime();
  self.intensity = float(self getscriptablepartstate("light_intensity"));

  if(self.intensity > 0) {
    level.castingdynolights = scripts\engine\utility::array_add(level.castingdynolights, self);
  }

  self.data = scripts\engine\sp\utility::get_linked_struct();

  if(isDefined(self.data) && !istrue(self.data.script_ignoreme)) {
    if(isDefined(self.data.target)) {
      self.data.angles = vectortoangles(scripts\engine\utility::getStruct(self.data.target, "targetname").origin - self.data.origin);
    }

    if(!isDefined(self.data.script_radius)) {
      iprintln("dynolight data struct at " + self.origin + " missing script_radius kvp");
    }

    if(!isDefined(self.data.script_fov_inner)) {
      iprintln("dynolight data struct at " + self.origin + " missing script_fov_inner kvp");
    }

    if(!isDefined(self.data.script_type)) {
      iprintln("dynolight data struct at " + self.origin + " missing script_type kvp");
    }
  }

  var5 = scripts\engine\utility::get_linked_ents();

  if(isDefined(var5)) {
    self.linked_ents = var5;
  }

  self.lightpos = get_model_trace_start();
}

function lightswitch_postload_state_init() {
  self endon("death");
  wait 0.05;
  thread lightswitch_interact_manager();

  if(!self.script_light_switch_state) {
    lightswitch_update_children(self.script_light_switch_state);
    return;
  }
}

function lightswitch_init(var0) {
  if(!isDefined(var0.circuitparents)) {
    var0.circuitparents = [];
  }

  if(!scripts\engine\utility::array_contains(var0.circuitparents, self)) {
    var0.circuitparents = scripts\engine\utility::array_add(var0.circuitparents, self);
  }

  if(!isDefined(self.lights)) {
    self.lights = [];
    self.circuitchildren = [];
    self.circuitsiblings = [];
    self.circuitparents = [];
    self.disabled = 0;

    if(!isDefined(self.script_light_switch_state)) {
      self.script_light_switch_state = 1;
    }

    if(!isDefined(self.script_light_switch_sfx)) {
      self.script_light_switch_sfx = "light_switch";
    }

    if(isDefined(self.script_light_idle_sfx)) {
      self playLoopSound(self.script_light_idle_sfx);
    }

    if(isDefined(self.script_light_idle_sfx) && !self.script_light_switch_state) {
      self scalevolume(0, 0);
    }

    thread lightswitch_postload_state_init();
    thread lightswitch_death_watcher();

    if(isDefined(self.targetname)) {
      var1 = getEntArray(self.targetname, "target");
    } else {
      var1 = [];
    }

    foreach(var3 in var1) {
      if(isDefined(var3.classname) && var3.classname == "script_origin") {
        thread lightswitch_init(var3);
      }
    }
  }

  foreach(var6 in var1.circuitparents) {
    if(!scripts\engine\utility::array_contains(self.circuitsiblings, var6)) {
      self.circuitsiblings = scripts\engine\utility::array_add(self.circuitsiblings, var6);
    }

    if(!scripts\engine\utility::array_contains(var6.circuitsiblings, self)) {
      var6.circuitsiblings = scripts\engine\utility::array_add(var6.circuitsiblings, self);
      LOC_00000191:
    }
    LOC_00000191:
  }

  if(is_light(var1)) {
    self.lights = scripts\engine\utility::array_add(self.lights, var1);
    return;
  }

  if(is_lightswitch(var1)) {
    self.circuitchildren = scripts\engine\utility::array_add(self.circuitchildren, var1);
    return;
  }
}

function lightswitch_interact_manager() {
  self endon("death");
  self.interact = 0;
  lightswitch_enable_interact();

  for(;;) {
    self waittill("lightswitch_toggle");

    if(self.script_light_switch_state == 1) {
      var0 = "_off";
      var1 = 0;

      if(isDefined(self.script_light_switch_fx)) {
        playFXOnTag(self.script_light_switch_fx, self, get_lightswitch_fx_tag());
      }
    } else {
      var0 = "_on";
      var1 = 1;

      if(isDefined(self.script_light_switch_fx)) {
        killfxontag(self.script_light_switch_fx, self, get_lightswitch_fx_tag());
      }
    }

    thread scripts\engine\utility::play_sound_in_space(self.script_light_switch_sfx + var0, self.origin);
    lightswitch_onoff(var1);
    lightswitch_update_children(var1, self);
    thread lightswitch_toggle_debounce();
  }
}

function get_lightswitch_fx_tag() {
  if(isDefined(self.script_light_switch_fx_tag)) {
    return self.script_light_switch_fx_tag;
  }

  return getpartname(self.model, 0);
}

function lightswitch_onoff(var0) {
  if(self.script_light_switch_state == var0) {
    return;
  }

  self.script_light_switch_state = var0;

  if(var0) {
    if(isDefined(self.script_light_idle_sfx)) {
      self scalevolume(0, 0.5);
      return;
    }

    return;
  }

  if(isDefined(self.script_light_idle_sfx)) {
    self scalevolume(1, 0.25);
    return;
  }
}

function lightswitch_disable(var0) {
  if(var0 == self.disabled) {
    return;
  }

  self.disabled = var0;

  if(var0) {
    lightswitch_disable_interact();
    return;
  }

  lightswitch_enable_interact();
}

function lightswitch_send_stealth_event() {
  if(gettime() < 1000) {
    return;
  }

  if(isDefined(level.stealth)) {
    var0 = sortbydistance(self.lights, level.player.origin);

    foreach(var2 in var0) {
      var3 = scripts\engine\sp\utility::get_within_range(var2.lightpos, getaiarray("axis"), 500);
      var3 = sortbydistance(var3, var2.lightpos);

      if(isDefined(var3[0])) {
        var3[0] aieventlistenerevent("footstep", level.player, self.origin);
        return 1;
      }
    }

    return;
  }
}

function lightswitch_toggle_debounce() {
  self endon("death");
  self endon("disable_interact");

  while(level.player useButtonPressed()) {
    wait 0.05;
  }

  lightswitch_enable_interact();
}

function collect_circuit_children(var0) {}

function collect_circuit_siblines(var0) {}

function lightswitch_update_children(var0, var1) {
  var2 = self.lights;

  foreach(var4 in self.circuitsiblings) {
    lightswitch_onoff(var4, var0);

    foreach(var6 in var4.lights) {
      if(!scripts\engine\utility::array_contains(var2, var6)) {
        var2 = scripts\engine\utility::array_add(var2, var6);
      }
    }
  }

  var9 = self.circuitchildren;
  var10 = [];

  for(;;) {
    var11 = 0;

    foreach(var4 in var9) {
      if(!scripts\engine\utility::array_contains(var10, var4)) {
        foreach(var14 in var4.circuitchildren) {
          if(!scripts\engine\utility::array_contains(var9, var14)) {
            var9 = scripts\engine\utility::array_add(var9, var14);
          }
        }

        foreach(var14 in var4.circuitsiblings) {
          if(!scripts\engine\utility::array_contains(var9, var14)) {
            var9 = scripts\engine\utility::array_add(var9, var14);
          }
        }

        var10 = scripts\engine\utility::array_add(var10, var4);
        var11 = 1;
      }
    }

    if(!var11) {
      break;
    }
  }

  var19 = scripts\engine\utility::ter_op(var0, 0, 1);

  foreach(var4 in var9) {
    lightswitch_onoff(var4, var0);
    lightswitch_disable(var4, var19);

    foreach(var6 in var4.lights) {
      if(!scripts\engine\utility::array_contains(var2, var6)) {
        var2 = scripts\engine\utility::array_add(var2, var6);
      }
    }
  }

  foreach(var6 in var2) {
    if(!var6.alive) {
      continue;
    }

    dynolight_set_onoff_state(var6, var0);
  }
}

function lightswitch_enable_interact() {
  if(self.disabled) {
    return;
  }

  if(self.interact) {
    return;
  }

  self.interact = 1;
  var0 = (0, 0, 0);

  if(isDefined(self.interact_offset)) {
    var0 = self.interact_offset;

    if(isDefined(self.angles)) {
      var0 = rotatevectorinverted(var0, self.angles);
    }
  }

  var1 = 120;

  if(isDefined(self.show_dist_override)) {
    var1 = self.show_dist_override;
  }

  var2 = 85;

  if(isDefined(self.use_dist_override)) {
    var2 = self.use_dist_override;
  }

  scripts\sp\player\cursor_hint::create_cursor_hint(undefined, var0, &"SCRIPT/LIGHTSWITCH_INTERACT", 65, var1, var2, 0, undefined, undefined, undefined, "duration_none", undefined, undefined, undefined, 90);
  thread lightswitch_trigger_notify();
}

function lightswitch_trigger_notify() {
  self endon("death");
  self endon("disable_interact");
  self waittill("trigger", var0);
  self.triggering_ent = var0;
  self.interact = 0;

  if(isDefined(level.lightswitch_interact_func)) {
    self[[level.lightswitch_interact_func]]();
  }

  lightswitch_toggle();
  self notify("tempRandoDraWdisable");
}

function lightswitch_disable_interact() {
  self notify("disable_interact");
  self.interact = 0;
  scripts\sp\player\cursor_hint::remove_cursor_hint();
}

function lightswitch_toggle() {
  self notify("lightswitch_toggle");
}

function dynolight_set_onoff_state(var0) {
  if(var0 && self getscriptablepartstate("onoff") == "off") {
    dynolight_update_nvg_mode();
    self.timeoflaststatechange = gettime();
    return;
  }

  if(!var0 && self getscriptablepartstate("onoff") != "off") {
    self setscriptablepartstate("onoff", "off");
    self.timeoflaststatechange = gettime();
    thread stealth_event_on_light_death();
    return;
  }
}

function dynolight_update_nvg_mode() {
  if(level.player isnightvisionon() && !level.player scripts\engine\sp\utility::is_flir_vision_on() && !getdvarint("scr_disable_dynolight_switching")) {
    self setscriptablepartstate("onoff", "on");
    return;
  }

  self setscriptablepartstate("onoff", "on");
}

function dynolight_death_watcher() {
  self.alive = 1;
  self waittill("death");
  self.alive = 0;
  self.intensity = 0;
  self.timeoflaststatechange = gettime();

  foreach(var1 in self.circuitparents) {
    var1.lights = scripts\engine\utility::array_remove(var1.lights, self);
    check_lightswitch_cleanup(var1);
  }

  thread stealth_event_on_light_death();
}

function stealth_event_on_light_death() {
  if(isDefined(level.stealth)) {
    var0 = scripts\engine\utility::drop_to_ground(self.lightpos, 24, -256);
    var1 = undefined;

    if(self getscriptablepartstate("onoff") == "death") {
      var1 = 400;
    }

    scripts\stealth\event::event_broadcast_axis_by_sight("light_killed", self, self.lightpos, 800, 0, var0, var1);
    return;
  }
}

function get_model_trace_start() {
  var0 = self gettagorigin("tag_fx_bulb", 1);

  if(isDefined(var0)) {
    return var0;
  }

  switch (self.model) {
    case "light_lamp_floor_tall_01_on":
    case "pnr_light_lamp_floor_tall_01_on":
      var0 = self.origin + (0, 0, 120);
      break;
    case "ch_street_wall_light_01_on":
    case "ch_street_wall_light_01_off":
      var0 = self.origin - (0, 0, 10) + anglesToForward(self.angles) * 35;
      break;
    case "ind_spotlight_generator_on":
    case "ind_spotlight_generator_stripes":
    case "ind_spotlight_generator_off":
      var0 = self.origin + (0, 0, 131) + anglesToForward(self.angles) * 19;
      break;
    case "ind_flood_light_standing_tall_dmg":
    case "ind_flood_light_standing_tall_on":
    case "ind_flood_light_standing_tall_off":
      var0 = self.origin + (0, 0, 39);
      break;
    case "deco_wall_light_fn_01_on":
    case "deco_wall_light_fn_01":
      var0 = self.origin + anglesToForward(self.angles) * 10;
      break;
    case "clk_industrial_light_01_on":
    case "clk_industrial_light_01_on_warm":
      var0 = self.origin - (0, 0, 64);
      break;
    case "cp_disco_fluorescent_light_on":
    case "cp_disco_fluorescent_light_on_blue":
      var0 = self.origin - (0, 0, 30);
      break;
    case "crr_light_utility_01_on":
    case "crr_light_utility_01":
      var0 = self.origin - (0, 0, 7) + anglesToForward(self.angles) * 5;
      break;
    case "cp_disco_searchlight_swivel_on":
      var0 = self.origin + (0, 0, 43) + anglesToForward(self.angles) * 28;
      break;
    case "cs_cargoship_wall_light_off":
      var0 = self.origin + anglesToForward(self.angles) * 15;
      break;
    case "dam_tunnel_light_01_off":
      var0 = self.origin - (0, 0, 23);
      break;
    case "com_floodlight":
    case "com_floodlight_scr":
    case "com_floodlight_on":
      var0 = self.origin + (0, 0, 11) + anglesToForward(self.angles) * 6;
      break;
    case "tent_ceiling_light_off":
      var0 = self.origin - (0, 0, 7);
      break;
    case "zmb_center_portal_base_small_lights":
    case "zmb_center_portal_base_small_lights_off":
    case "zmb_center_portal_base_small_lights_blue":
      var0 = self.origin + anglesToForward(self.angles) * 9;
      break;
    case "p7_light_chandelier_vintage_01_on":
    case "p7_light_chandelier_vintage_01":
    case "p7_light_chandelier_vintage_01_broken":
      var0 = self.origin - (0, 0, 44);
      break;
    case "light_outdoorwall01":
      var0 = self.origin - (0, 0, 6) + anglesToForward(self.angles) * 8;
      break;
    case "mp_dart_lightfluo_on":
      var0 = self.origin - (0, 0, 8);
      break;
    case "light_lamp_black_01":
    case "light_lamp_black_01_ems":
    case "light_lamp_black_01_off":
      var0 = self.origin + (0, 0, 25) + anglesToForward(self.angles) * 9;
      break;
    case "bo_lights_hang_lamp_on":
      var0 = self.origin - (0, 0, 37);
      break;
    case "floor01_lamp_01":
    case "floor01_lamp_01_off":
      var0 = self.origin - (0, 0, 40);
      break;
    case "street_lamp_post_old_iw6_on":
    case "street_lamp_post_old_iw6":
      var0 = self.origin + (0, 0, 240);
      break;
    default:
      var0 = self.origin;
      break;
  }

  return var0;
}

function lightswitch_death_watcher() {
  self waittill("death");

  foreach(var1 in self.circuitparents) {
    var1.circuitchildren = scripts\engine\utility::array_remove(var1.circuitchildren, self);
    check_lightswitch_cleanup(var1);
  }
}

function check_lightswitch_cleanup() {
  if(self.lights.size == 0 && self.circuitchildren.size == 0) {
    self delete();
    return;
  }
}

function is_lightswitch() {
  if(isDefined(self.code_classname) && self.code_classname == "script_origin") {
    return 1;
  }

  return 0;
}

function is_light() {
  if(isDefined(self.code_classname) && self.code_classname == "scriptable") {
    return 1;
  }

  return 0;
}