/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\interactables\dynolight.gsc
**************************************************/



#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\utility;
#using scripts\stealth\event;
#namespace dynolight;

function init() {
  if(isDefined(level.dynolights_initialized)) {
    return;
  }

  level.dynolights_initialized = 1;

  if(!isDefined(level.dynolights)) {
    level.dynolights = [];
  }

  if(!getdvarint(@ "hash_dfe07eaa4a978e85")) {
    setDvar(@ "hash_dfe07eaa4a978e85", 0);
  }

  level.castingdynolights = [];

  foreach(dynolight in level.dynolights) {
    if(!isDefined(dynolight.init_count)) {
      dynolight.init_count = 0;
    }

    dynolight.init_count++;
    dynolight thread dynolight_postload_state_init();
    dynolight thread dynolight_death_watcher();

    if(isDefined(dynolight.targetname)) {
      targets = getEntArray(dynolight.targetname, "target");
    } else {
      targets = [];
    }

    foreach(target in targets) {
      if(target is_lightswitch()) {
        target thread lightswitch_init(dynolight);
      }
    }

    dynolight.lightpos = dynolight.origin;
  }

  level.dynolight_trace_contents = create_contents(0, 1, 0, 0, 0, 0, 0, 1, 0);
}

function add_dynolight(ent) {
  if(!isDefined(level.dynolights)) {
    level.dynolights = [];
  }

  level.dynolights[level.dynolights.size] = ent;
}

function dynolight_postload_state_init() {
  self endon("death");
  wait 0.05;

  if(!isDefined(self.circuitparents)) {
    self.circuitparents = [];
  }

  var_8c990dfe07dc97dd = strtok(self.script_noteworthy, "_");
  initoff = 0;

  foreach(tok in var_8c990dfe07dc97dd) {
    if(tok == "off") {
      initoff = 1;
    }
  }

  if(initoff) {
    self setscriptablepartstate("onoff", "off");
  } else {
    self setscriptablepartstate("onoff", "on");
  }

  self.timeoflaststatechange = gettime();
  self.intensity = float(self getscriptablepartstate("light_intensity"));

  if(self.intensity > 0) {
    level.castingdynolights = array_add(level.castingdynolights, self);
  }

  self.data = get_linked_struct();

  if(isDefined(self.data) && !istrue(self.data.script_ignoreme)) {
    if(isDefined(self.data.target)) {
      self.data.angles = vectortoangles(getStruct(self.data.target, "targetname").origin - self.data.origin);
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

  linked_ents = get_linked_ents();

  if(isDefined(linked_ents)) {
    self.linked_ents = linked_ents;
  }

  self.lightpos = get_model_trace_start();
}

function lightswitch_postload_state_init() {
  self endon("death");
  wait 0.05;
  thread lightswitch_interact_manager();

  if(!self.script_light_switch_state) {
    lightswitch_update_children(self.script_light_switch_state);
  }
}

function lightswitch_init(controlled) {
  if(!isDefined(controlled.circuitparents)) {
    controlled.circuitparents = [];
  }

  if(!array_contains(controlled.circuitparents, self)) {
    controlled.circuitparents = array_add(controlled.circuitparents, self);
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
      targets = getEntArray(self.targetname, "target");
    } else {
      targets = [];
    }

    foreach(target in targets) {
      if(isDefined(target.classname) && target.classname == "script_origin") {
        target thread lightswitch_init(self);
      }
    }
  }

  foreach(circuit in controlled.circuitparents) {
    if(circuit == self) {
      continue;
    }

    if(!array_contains(self.circuitsiblings, circuit)) {
      self.circuitsiblings = array_add(self.circuitsiblings, circuit);
    }

    if(!array_contains(circuit.circuitsiblings, self)) {
      circuit.circuitsiblings = array_add(circuit.circuitsiblings, self);
    }
  }

  if(controlled is_light()) {
    self.lights = array_add(self.lights, controlled);
    return;
  }

  if(controlled is_lightswitch()) {
    self.circuitchildren = array_add(self.circuitchildren, controlled);
  }
}

function lightswitch_interact_manager() {
  self endon("death");
  self.interact = 0;
  lightswitch_enable_interact();

  while(true) {
    self waittill("lightswitch_toggle");

    if(self.script_light_switch_state == 1) {
      sfx_suffix = "_off";
      desired_state = 0;

      if(isDefined(self.script_light_switch_fx)) {
        playFXOnTag(self.script_light_switch_fx, self, get_lightswitch_fx_tag());
      }
    } else {
      sfx_suffix = "_on";
      desired_state = 1;

      if(isDefined(self.script_light_switch_fx)) {
        killfxontag(self.script_light_switch_fx, self, get_lightswitch_fx_tag());
      }
    }

    thread play_sound_in_space(self.script_light_switch_sfx + sfx_suffix, self.origin);
    lightswitch_onoff(desired_state);
    lightswitch_update_children(desired_state, self);
    thread lightswitch_toggle_debounce();
  }
}

function get_lightswitch_fx_tag() {
  if(isDefined(self.script_light_switch_fx_tag)) {
    return self.script_light_switch_fx_tag;
  }

  return getpartname(self.model, 0);
}

function lightswitch_onoff(state) {
  if(self.script_light_switch_state == state) {
    return;
  }

  self.script_light_switch_state = state;

  if(state) {
    if(isDefined(self.script_light_idle_sfx)) {
      self scalevolume(0, 0.5);
    }

    return;
  }

  if(isDefined(self.script_light_idle_sfx)) {
    self scalevolume(1, 0.25);
  }
}

function lightswitch_disable(state) {
  if(state == self.disabled) {
    return;
  }

  self.disabled = state;

  if(state) {
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
    lights = sortbydistance(self.lights, level.player.origin);

    foreach(light in lights) {
      guys = scripts\engine\sp\utility::get_within_range(light.lightpos, getaiarray("axis"), 500);
      guys = sortbydistance(guys, light.lightpos);

      if(isDefined(guys[0])) {
        guys[0] aieventlistenerevent("footstep", level.player, self.origin);
        return 1;
      }
    }
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

function collect_circuit_children(exclude) {}

function collect_circuit_siblines(exclude) {}

function lightswitch_update_children(desired_state, startingent) {
  var_56f49452d58c0380 = self.lights;

  foreach(circuit in self.circuitsiblings) {
    circuit lightswitch_onoff(desired_state);

    foreach(light in circuit.lights) {
      if(!array_contains(var_56f49452d58c0380, light)) {
        var_56f49452d58c0380 = array_add(var_56f49452d58c0380, light);
      }
    }
  }

  var_701ae0782a275861 = self.circuitchildren;
  var_20133fbeadfae162 = [];

  while(true) {
    var_e186c1bce116892b = 0;

    foreach(circuit in var_701ae0782a275861) {
      if(!array_contains(var_20133fbeadfae162, circuit)) {
        foreach(subcircuit in circuit.circuitchildren) {
          if(!array_contains(var_701ae0782a275861, subcircuit)) {
            var_701ae0782a275861 = array_add(var_701ae0782a275861, subcircuit);
          }
        }

        foreach(subcircuit in circuit.circuitsiblings) {
          if(!array_contains(var_701ae0782a275861, subcircuit)) {
            var_701ae0782a275861 = array_add(var_701ae0782a275861, subcircuit);
          }
        }

        var_20133fbeadfae162 = array_add(var_20133fbeadfae162, circuit);
        var_e186c1bce116892b = 1;
      }
    }

    if(!var_e186c1bce116892b) {
      break;
    }
  }

  var_272e5f2d4e8dbc28 = ter_op(desired_state, 0, 1);

  foreach(circuit in var_701ae0782a275861) {
    circuit lightswitch_onoff(desired_state);
    circuit lightswitch_disable(var_272e5f2d4e8dbc28);

    foreach(light in circuit.lights) {
      if(!array_contains(var_56f49452d58c0380, light)) {
        var_56f49452d58c0380 = array_add(var_56f49452d58c0380, light);
      }
    }
  }

  foreach(light in var_56f49452d58c0380) {
    if(!light.alive) {
      continue;
    }

    light dynolight_set_onoff_state(desired_state);
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
  offset = (0, 0, 0);

  if(isDefined(self.interact_offset)) {
    offset = self.interact_offset;

    if(isDefined(self.angles)) {
      offset = rotatevectorinverted(offset, self.angles);
    }
  }

  show_dist = 120;

  if(isDefined(self.show_dist_override)) {
    show_dist = self.show_dist_override;
  }

  use_dist = 85;

  if(isDefined(self.use_dist_override)) {
    use_dist = self.use_dist_override;
  }

  scripts\sp\player\cursor_hint::create_cursor_hint(undefined, offset, &"SCRIPT/LIGHTSWITCH_INTERACT", 65, show_dist, use_dist, 0, undefined, undefined, undefined, "duration_none", undefined, undefined, undefined, 90);
  thread lightswitch_trigger_notify();
}

function lightswitch_trigger_notify() {
  self endon("death");
  self endon("disable_interact");
  self waittill("trigger", who);
  self.triggering_ent = who;
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

function dynolight_set_onoff_state(on) {
  if(on && self getscriptablepartstate("onoff") == "off") {
    dynolight_update_nvg_mode();
    self.timeoflaststatechange = gettime();
    return;
  }

  if(!on && self getscriptablepartstate("onoff") != "off") {
    self setscriptablepartstate("onoff", "off");
    self.timeoflaststatechange = gettime();
    thread stealth_event_on_light_death();
  }
}

function dynolight_update_nvg_mode() {
  if(level.player isnightvisionon() && !level.player is_flir_vision_on() && !getdvarint(@ "hash_dfe07eaa4a978e85")) {
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

  foreach(lightswitch in self.circuitparents) {
    lightswitch.lights = array_remove(lightswitch.lights, self);
    lightswitch check_lightswitch_cleanup();
  }

  thread stealth_event_on_light_death();
}

function stealth_event_on_light_death() {
  if(isDefined(level.stealth)) {
    lightpos = drop_to_ground(self.lightpos, 24, -256);
    autorange = undefined;

    if(self getscriptablepartstate("onoff") == "death") {
      autorange = 400;
    }

    scripts\stealth\event::event_broadcast_axis_by_sight("light_killed", self, self.lightpos, 800, 0, lightpos, autorange);
  }
}

function get_model_trace_start() {
  start = self gettagorigin("tag_fx_bulb", 1);

  if(isDefined(start)) {
    return start;
  }

  switch (self.model) {
    case #"hash_50c6e9acc93ebab9":
    case #"hash_f53ee33851499d8a":
      start = self.origin + (0, 0, 120);
      break;
    case #"hash_c8afd261103ab322":
    case #"hash_6f21302b6fd78a88":
      start = self.origin - (0, 0, 10) + anglesToForward(self.angles) * 35;
      break;
    case #"hash_7f8013b5754db59":
    case #"hash_1fbecb098edc2fca":
    case #"hash_2266a26ff2e07f1d":
      start = self.origin + (0, 0, 131) + anglesToForward(self.angles) * 19;
      break;
    case #"hash_df6199aab2d1cb75":
    case #"hash_9e62f6b7946110d8":
    case #"hash_7889eab78057b071":
      start = self.origin + (0, 0, 39);
      break;
    case #"hash_72a9ca52c64b224f":
    case #"hash_95452fcd6ba92b59":
      start = self.origin + anglesToForward(self.angles) * 10;
      break;
    case #"hash_2ac6bd29ccb3ea46":
    case #"hash_cbf5a810a6cf666e":
      start = self.origin - (0, 0, 64);
      break;
    case #"hash_57c76cc271a950a7":
    case #"hash_5189e7bed9baf274":
      start = self.origin - (0, 0, 30);
      break;
    case #"hash_ad0c07500eb9a7bc":
    case #"hash_f192eca827092bb4":
      start = self.origin - (0, 0, 7) + anglesToForward(self.angles) * 5;
      break;
    case #"hash_bc57416fd1489eef":
      start = self.origin + (0, 0, 43) + anglesToForward(self.angles) * 28;
      break;
    case #"hash_3c16a52d41c4255a":
      start = self.origin + anglesToForward(self.angles) * 15;
      break;
    case #"hash_b07183c93e9267c5":
      start = self.origin - (0, 0, 23);
      break;
    case #"hash_d55e1183bc3b07cd":
    case #"hash_64b4f20c1c6dcf33":
    case #"hash_77f52361803cbf50":
      start = self.origin + (0, 0, 11) + anglesToForward(self.angles) * 6;
      break;
    case #"hash_33a8e7e88db235":
      start = self.origin - (0, 0, 7);
      break;
    case #"hash_5553d43f36d78085":
    case #"hash_d66765bb9c4f6cb6":
    case #"hash_dd0765f6c4518a2b":
      start = self.origin + anglesToForward(self.angles) * 9;
      break;
    case #"hash_c52f30313312b890":
    case #"hash_d60e048832e77e88":
    case #"hash_be24151c84448788":
      start = self.origin - (0, 0, 44);
      break;
    case #"hash_529c90edac329c9b":
      start = self.origin - (0, 0, 6) + anglesToForward(self.angles) * 8;
      break;
    case #"hash_d9d89b463c8c7b9f":
      start = self.origin - (0, 0, 8);
      break;
    case #"hash_b1dc41525b9090cc":
    case #"hash_fd77cfc6873f4218":
    case #"hash_fe5556528440720a":
      start = self.origin + (0, 0, 25) + anglesToForward(self.angles) * 9;
      break;
    case #"hash_a8f6bd40179b8266":
      start = self.origin - (0, 0, 37);
      break;
    case #"hash_721ea101b3ccbb31":
    case #"hash_7b2b517c6bd3e227":
      start = self.origin - (0, 0, 40);
      break;
    case #"hash_be7cf74161f99815":
    case #"hash_a252601a175f3c1b":
      start = self.origin + (0, 0, 240);
      break;
    default:
      start = self.origin;
      break;
  }

  return start;
}

function lightswitch_death_watcher() {
  self waittill("death");

  foreach(lightswitch in self.circuitparents) {
    lightswitch.circuitchildren = array_remove(lightswitch.circuitchildren, self);
    lightswitch check_lightswitch_cleanup();
  }
}

function check_lightswitch_cleanup() {
  if(self.lights.size == 0 && self.circuitchildren.size == 0) {
    self delete();
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