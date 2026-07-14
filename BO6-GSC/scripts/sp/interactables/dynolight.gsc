/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\interactables\dynolight.gsc
**************************************************/

#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\player\cursor_hint;
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
      targets = getEntArray(dynolight.targetname, #target);
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

  level.dynolight_trace_contents = trace::create_contents(0, 1, 0, 0, 0, 0, 0, 1, 0);
}

function add_dynolight(ent) {
  if(!isDefined(level.dynolights)) {
    level.dynolights = [];
  }

  level.dynolights[level.dynolights.size] = ent;
}

function dynolight_postload_state_init() {
  self endon("\x1e\xfd\xd1\xa2\a");
  wait 0.05;

  if(!isDefined(self.circuitparents)) {
    self.circuitparents = [];
  }

  var_5df9ba7651816b1c = strtok(self.script_noteworthy, "w");
  initoff = 0;

  foreach(tok in var_5df9ba7651816b1c) {
    if(tok == "\xf8\x88m") {
      initoff = 1;
    }
  }

  if(initoff) {
    self setscriptablepartstate("\xa8\f\x95\xd1\x1d", "\xf8\x88m");
  } else {
    self setscriptablepartstate("\xa8\f\x95\xd1\x1d", "\xb8\"");
  }

  self.timeoflaststatechange = gettime();
  self.intensity = float(self getscriptablepartstate("\xf3\x9e\xa0\x90\xfb4\xe7,\x9e`\xc7\xf0K\xeb!"));

  if(self.intensity > 0) {
    level.castingdynolights = utility::array_add(level.castingdynolights, self);
  }

  self.data = utility_sp::get_linked_struct();

  if(isDefined(self.data) && !istrue(self.data.script_ignoreme)) {
    if(isDefined(self.data.target)) {
      self.data.angles = vectortoangles(utility::getStruct(self.data.target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc").origin - self.data.origin);
    }

    if(!isDefined(self.data.script_radius)) {
      iprintln("<dev string:x24>" + self.origin + "<dev string:x41>");
    }

    if(!isDefined(self.data.script_fov_inner)) {
      iprintln("<dev string:x24>" + self.origin + "<dev string:x5f>");
    }

    if(!isDefined(self.data.script_type)) {
      iprintln("<dev string:x24>" + self.origin + "<dev string:x80>");
    }
  }

  linked_ents = utility::get_linked_ents();

  if(isDefined(linked_ents)) {
    self.linked_ents = linked_ents;
  }

  self.lightpos = get_model_trace_start();
}

function lightswitch_postload_state_init() {
  self endon("\x1e\xfd\xd1\xa2\a");
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

  if(!arraycontains(controlled.circuitparents, self)) {
    controlled.circuitparents = utility::array_add(controlled.circuitparents, self);
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
      self.script_light_switch_sfx = "7\x94\xcc\xf61Xf\x10,^F\xb2";
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
      targets = getEntArray(self.targetname, #target);
    } else {
      targets = [];
    }

    foreach(target in targets) {
      if(isDefined(target.classname) && target.classname == "\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc") {
        target thread lightswitch_init(self);
      }
    }
  }

  foreach(circuit in controlled.circuitparents) {
    if(circuit == self) {
      continue;
    }

    if(!arraycontains(self.circuitsiblings, circuit)) {
      self.circuitsiblings = utility::array_add(self.circuitsiblings, circuit);
    }

    if(!arraycontains(circuit.circuitsiblings, self)) {
      circuit.circuitsiblings = utility::array_add(circuit.circuitsiblings, self);
    }
  }

  if(controlled is_light()) {
    self.lights = utility::array_add(self.lights, controlled);
    return;
  }

  if(controlled is_lightswitch()) {
    self.circuitchildren = utility::array_add(self.circuitchildren, controlled);
  }
}

function lightswitch_interact_manager() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self.interact = 0;
  lightswitch_enable_interact();

  while(true) {
    self waittill("%\x03]\xf9\xfe\x97B\x85\x05IZsvU\xc4\x80E%");

    if(self.script_light_switch_state == 1) {
      sfx_suffix = "\xa3`\xb5\xfa";
      desired_state = 0;

      if(isDefined(self.script_light_switch_fx)) {
        playFXOnTag(self.script_light_switch_fx, self, get_lightswitch_fx_tag());
      }
    } else {
      sfx_suffix = "\xff\xc7\x84";
      desired_state = 1;

      if(isDefined(self.script_light_switch_fx)) {
        killfxontag(self.script_light_switch_fx, self, get_lightswitch_fx_tag());
      }
    }

    thread utility::play_sound_in_space(self.script_light_switch_sfx + sfx_suffix, self.origin);
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
      guys = utility_sp::get_within_range(light.lightpos, getaiarray("?\xb1\xc0\x9a"), 500);
      guys = sortbydistance(guys, light.lightpos);

      if(isDefined(guys[0])) {
        guys[0] aieventlistenerevent("3\xdb\xb7tn:\x95\xe0", level.player, self.origin);
        return 1;
      }
    }
  }
}

function lightswitch_toggle_debounce() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("i\xc6\xdb\xac$\x9eV\xc1\x1b\xbc\x80\xaa{\xf9\xcf\xb7");

  while(level.player useButtonPressed()) {
    wait 0.05;
  }

  lightswitch_enable_interact();
}

function collect_circuit_children(exclude) {}

function collect_circuit_siblines(exclude) {}

function lightswitch_update_children(desired_state, startingent) {
  var_2e41f8d4a80286a9 = self.lights;

  foreach(circuit in self.circuitsiblings) {
    circuit lightswitch_onoff(desired_state);

    foreach(light in circuit.lights) {
      if(!arraycontains(var_2e41f8d4a80286a9, light)) {
        var_2e41f8d4a80286a9 = utility::array_add(var_2e41f8d4a80286a9, light);
      }
    }
  }

  var_bb1baae300d6a314 = self.circuitchildren;
  var_eeb64d1711473da3 = [];

  while(true) {
    var_f9899e6c0b2abf56 = 0;

    foreach(circuit in var_bb1baae300d6a314) {
      if(!arraycontains(var_eeb64d1711473da3, circuit)) {
        foreach(subcircuit in circuit.circuitchildren) {
          if(!arraycontains(var_bb1baae300d6a314, subcircuit)) {
            var_bb1baae300d6a314 = utility::array_add(var_bb1baae300d6a314, subcircuit);
          }
        }

        foreach(subcircuit in circuit.circuitsiblings) {
          if(!arraycontains(var_bb1baae300d6a314, subcircuit)) {
            var_bb1baae300d6a314 = utility::array_add(var_bb1baae300d6a314, subcircuit);
          }
        }

        var_eeb64d1711473da3 = utility::array_add(var_eeb64d1711473da3, circuit);
        var_f9899e6c0b2abf56 = 1;
      }
    }

    if(!var_f9899e6c0b2abf56) {
      break;
    }
  }

  var_5904130678c0a84d = desired_state ? 0 : 1;

  foreach(circuit in var_bb1baae300d6a314) {
    circuit lightswitch_onoff(desired_state);
    circuit lightswitch_disable(var_5904130678c0a84d);

    foreach(light in circuit.lights) {
      if(!arraycontains(var_2e41f8d4a80286a9, light)) {
        var_2e41f8d4a80286a9 = utility::array_add(var_2e41f8d4a80286a9, light);
      }
    }
  }

  foreach(light in var_2e41f8d4a80286a9) {
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

  cursor_hint::create_cursor_hint(undefined, offset, &"script/lightswitch_interact", 65, show_dist, use_dist, 0, undefined, undefined, undefined, "\xd3\nV\n\xa1\xbb\x8d\x91\x93Oa\xd4\x1a", undefined, undefined, undefined, 90);
  thread lightswitch_trigger_notify();
}

function lightswitch_trigger_notify() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("i\xc6\xdb\xac$\x9eV\xc1\x1b\xbc\x80\xaa{\xf9\xcf\xb7");
  self waittill("\x91`\xb1\xe7T\x97>", who);
  self.triggering_ent = who;
  self.interact = 0;

  if(isDefined(level.lightswitch_interact_func)) {
    self[[level.lightswitch_interact_func]]();
  }

  lightswitch_toggle();
  self notify("\xc0Pk\xae\xca \x1fj\x81\xd2\xee\xf08U\x99=\xee\tZ\xdb");
}

function lightswitch_disable_interact() {
  self notify("i\xc6\xdb\xac$\x9eV\xc1\x1b\xbc\x80\xaa{\xf9\xcf\xb7");
  self.interact = 0;
  cursor_hint::remove_cursor_hint();
}

function lightswitch_toggle() {
  self notify("%\x03]\xf9\xfe\x97B\x85\x05IZsvU\xc4\x80E%");
}

function dynolight_set_onoff_state(on) {
  if(on && self getscriptablepartstate("\xa8\f\x95\xd1\x1d") == "\xf8\x88m") {
    dynolight_update_nvg_mode();
    self.timeoflaststatechange = gettime();
    return;
  }

  if(!on && self getscriptablepartstate("\xa8\f\x95\xd1\x1d") != "\xf8\x88m") {
    self setscriptablepartstate("\xa8\f\x95\xd1\x1d", "\xf8\x88m");
    self.timeoflaststatechange = gettime();
    thread stealth_event_on_light_death();
  }
}

function dynolight_update_nvg_mode() {
  if(level.player isnightvisionon() && !level.player utility_sp::is_flir_vision_on() && !getdvarint(@ "hash_dfe07eaa4a978e85")) {
    self setscriptablepartstate("\xa8\f\x95\xd1\x1d", "\xb8\"");
    return;
  }

  self setscriptablepartstate("\xa8\f\x95\xd1\x1d", "\xb8\"");
}

function dynolight_death_watcher() {
  self.alive = 1;
  self waittill("\x1e\xfd\xd1\xa2\a");
  self.alive = 0;
  self.intensity = 0;
  self.timeoflaststatechange = gettime();

  foreach(lightswitch in self.circuitparents) {
    lightswitch.lights = arrayremove(lightswitch.lights, self);
    lightswitch check_lightswitch_cleanup();
  }

  thread stealth_event_on_light_death();
}

function stealth_event_on_light_death() {
  if(isDefined(level.stealth)) {
    lightpos = utility::drop_to_ground(self.lightpos, 24, -256);
    autorange = undefined;

    if(self getscriptablepartstate("\xa8\f\x95\xd1\x1d") == "\x1e\xfd\xd1\xa2\a") {
      autorange = 400;
    }

    event::event_broadcast_axis_by_sight("\xdd\x10\xe9y\xc0\x91\xf7\x92\xba\xd7\xc6\x80", self, self.lightpos, 800, 0, lightpos, autorange);
  }
}

function get_model_trace_start() {
  start = self gettagorigin("w\xd7\x17\xfa\xbf\x94!\xa1\xfb ?", 1);

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
  self waittill("\x1e\xfd\xd1\xa2\a");

  foreach(lightswitch in self.circuitparents) {
    lightswitch.circuitchildren = arrayremove(lightswitch.circuitchildren, self);
    lightswitch check_lightswitch_cleanup();
  }
}

function check_lightswitch_cleanup() {
  if(self.lights.size == 0 && self.circuitchildren.size == 0) {
    self delete();
  }
}

function is_lightswitch() {
  if(isDefined(self.code_classname) && self.code_classname == "\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc") {
    return 1;
  }

  return 0;
}

function is_light() {
  if(isDefined(self.code_classname) && self.code_classname == "X\xf2Z\x1b\xc3\x03\xb9\xee\xd1\x95") {
    return 1;
  }

  return 0;
}