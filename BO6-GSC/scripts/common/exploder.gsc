/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\exploder.gsc
***************************************/

#using scripts\common\createfx;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace exploder;

function private event_handler[bootstrap] boot_strap(struct) {
  level.struct_exploders = [];
}

function private event_handler[spawnstruct] spawn_struct(struct) {
  if(isDefined(struct.script_prefab_exploder) || isDefined(struct.script_exploder)) {
    level.struct_exploders[level.struct_exploders.size] = struct;
  }
}

function setup_individual_exploder(ent) {
  targetname = ent.targetname;

  if(!isDefined(targetname)) {
    targetname = "";
  }

  if(exploder_starts_hidden(ent)) {
    ent hide();
    return;
  }

  if(exploder_is_damaged_model(ent)) {
    ent hide();
    ent notsolid();

    if(isDefined(ent.spawnflags) && ent.spawnflags & 1) {
      if(isDefined(ent.script_disconnectpaths)) {
        ent connectpaths();
      }
    }

    return;
  }

  if(exploder_is_chunk(ent)) {
    ent hide();
    ent notsolid();

    if(isDefined(ent.spawnflags) && ent.spawnflags & 1) {
      ent connectpaths();
    }

    return;
  }
}

function addinitexploders(potentialexploders) {
  foreach(ent in potentialexploders) {
    if(!isDefined(ent)) {
      continue;
    }

    if(isDefined(ent.script_prefab_exploder)) {
      ent.script_exploder = ent.script_prefab_exploder;
      level.init_exploders[level.init_exploders.size] = ent;
      continue;
    }

    if(isDefined(ent.script_exploder)) {
      isexploder = 1;

      if(!isDefined(ent.angles)) {
        ent.angles = (0, 0, 0);
      }

      level.init_exploders[level.init_exploders.size] = ent;
    }
  }
}

function setupexploders() {
  level.init_exploders = [];
  level.exploders = [];
  ents = getEntArray("script_brushmodel", #classname);
  smodels = getEntArray("script_model", #classname);

  foreach(smodel in smodels) {
    ents[ents.size] = smodel;
  }

  foreach(ent in ents) {
    if(isDefined(ent.script_prefab_exploder)) {
      ent.script_exploder = ent.script_prefab_exploder;
    }

    if(isDefined(ent.masked_exploder)) {
      continue;
    }

    if(isDefined(ent.script_exploder)) {
      setup_individual_exploder(ent);
    }
  }

  addinitexploders(getEntArray("script_brushmodel", #classname));
  addinitexploders(getEntArray("script_model", #classname));
  addinitexploders(level.struct_exploders);
  level.struct_exploders = undefined;

  if(!isDefined(level.createfxent)) {
    level.createfxent = [];
  }

  acceptabletargetnames = [];
  acceptabletargetnames["exploderchunk visible"] = 1;
  acceptabletargetnames["exploderchunk"] = 1;
  acceptabletargetnames["exploder"] = 1;

  foreach(exploder in level.init_exploders) {
    ent = utility::createexploder(exploder.script_fxid, 1);
    ent.v = [];
    ent.v["origin"] = exploder.origin;
    ent.v["angles"] = exploder.angles;
    ent.v["delay"] = exploder.script_delay;
    ent.v["delay_post"] = exploder.script_delay_post;
    ent.v["firefx"] = exploder.script_firefx;
    ent.v["firefxdelay"] = exploder.script_firefxdelay;
    ent.v["firefxsound"] = exploder.script_firefxsound;
    ent.v["earthquake"] = exploder.script_earthquake;
    ent.v["rumble"] = exploder.script_rumble;
    ent.v["damage"] = exploder.script_damage;
    ent.v["damage_radius"] = exploder.script_radius;
    ent.v["soundalias"] = exploder.script_soundalias;
    ent.v["repeat"] = exploder.script_repeat;
    ent.v["delay_min"] = exploder.script_delay_min;
    ent.v["delay_max"] = exploder.script_delay_max;
    ent.v["target"] = exploder.target;
    ent.v["ender"] = exploder.script_ender;
    ent.v["physics"] = exploder.script_physics;
    ent.v["type"] = "exploder";
    ent.v["dotraces"] = exploder.script_trace;
    ent.v["envonly"] = exploder.script_envonly;
    ent.v["area_swap_index"] = exploder.script_area_swap_index;
    ent.v["area_swap_state"] = exploder.script_area_swap_state;

    if(!isDefined(ent.v["angles"])) {
      ent.v["angles"] = (0, 0, 0);
    }

    ent createfx::set_forward_and_up_vectors();

    if(!isDefined(exploder.script_fxid)) {
      ent.v["fxid"] = "No FX";
    } else {
      ent.v["fxid"] = exploder.script_fxid;
    }

    ent.v["exploder"] = exploder.script_exploder;
    assert(isDefined(exploder.script_exploder), "<dev string:x24>" + exploder.origin + "<dev string:x3b>");

    if(!isDefined(ent.v["delay"])) {
      ent.v["delay"] = 0;
    }

    if(isDefined(exploder.target)) {
      get_ent = getEntArray(ent.v["target"], #targetname)[0];

      if(isDefined(get_ent)) {
        org = get_ent.origin;
        ent.v["angles"] = vectortoangles(org - ent.v["origin"]);
      } else {
        get_ent = utility::get_target_ent(ent.v["target"]);

        if(isDefined(get_ent)) {
          org = get_ent.origin;
          ent.v["angles"] = vectortoangles(org - ent.v["origin"]);
        }
      }
    }

    if(isstruct(exploder)) {
      ent.model = exploder;

      if(isDefined(ent.model.script_modelname)) {
        precachemodel(ent.model.script_modelname);
      }
    } else if(exploder.code_classname == "script_brushmodel" || isDefined(exploder.model)) {
      ent.model = exploder;
      ent.model.disconnect_paths = exploder.script_disconnectpaths;
    }

    if(isDefined(exploder.targetname) && isDefined(acceptabletargetnames[exploder.targetname])) {
      ent.v["exploder_type"] = exploder.targetname;
    } else {
      ent.v["exploder_type"] = "normal";
    }

    if(isDefined(exploder.masked_exploder)) {
      ent.v["masked_exploder"] = exploder.model;
      ent.v["masked_exploder_spawnflags"] = exploder.spawnflags;
      ent.v["masked_exploder_script_disconnectpaths"] = exploder.script_disconnectpaths;
      exploder delete();
    }

    ent createfx::post_entity_creation_function();
    explodername = ent.v["exploder"];

    if(!isDefined(level.exploders[explodername])) {
      level.exploders[explodername] = [];
    }

    level.exploders[explodername][level.exploders[explodername].size] = ent;
  }

  level.init_exploders = undefined;

  level thread function_37d17d889197cbf9();
}

function exploder_flag_wait(msg, exploderarray) {
  if(!utility::flag_exist(msg)) {
    utility::flag_init(msg);
  }

  utility::flag_wait(msg);

  foreach(exploderstr in exploderarray) {
    foreach(ent in level.createfxexploders[exploderstr]) {
      ent utility::activate_individual_exploder();
    }
  }
}

function exploder_is_damaged_model(ent) {
  return ent.targetname == "exploder";
}

function exploder_starts_hidden(ent) {
  return ent.model == "fx" && ent.targetname != "exploderchunk";
}

function exploder_is_chunk(ent) {
  return ent.targetname == "exploderchunk";
}

function show_exploder_models_proc(num) {
  num += "";
  exploders = get_exploders();

  if(isDefined(exploders)) {
    foreach(ent in exploders) {
      if(isstruct(ent.model)) {
        continue;
      }

      if(!exploder_starts_hidden(ent.model) && !exploder_is_damaged_model(ent.model) && !exploder_is_chunk(ent.model)) {
        ent.model show();
      }

      if(isDefined(ent.brush_shown)) {
        ent.model show();
      }
    }
  }
}

function get_exploders(str) {
  exploders = [];

  if(level.createfx_enabled) {
    exploders = get_createfx_exploders(str);
  } else if(isDefined(level.createfxexploders[str])) {
    exploders = level.createfxexploders[str];
  }

  if(isDefined(level.exploders[str])) {
    foreach(exploder in level.exploders[str]) {
      exploders[exploders.size] = exploder;
    }
  }

  return exploders;
}

function get_createfx_exploders(str) {
  array = [];

  foreach(ent in level.createfxent) {
    if(!isDefined(ent)) {
      continue;
    }

    if(ent.v["<dev string:x56>"] != "<dev string:x5e>") {
      continue;
    }

    if(!isDefined(ent.v["<dev string:x5e>"])) {
      continue;
    }

    if(isDefined(str) && ent.v["<dev string:x5e>"] + "<dev string:x6a>" != str) {
      continue;
    }

    array[array.size] = ent;
  }

  if(array.size == 0) {
    array = undefined;
  }

  return array;
}

function stop_exploder_proc(num, players, bkill, radius, origin) {
  num += "";
  var_2a2d2d350c260c94 = 0;
  exploders = get_exploders(num);
  radiussq = isDefined(radius) ? squared(radius) : undefined;

  if(isDefined(exploders)) {
    foreach(ent in exploders) {
      if(!isDefined(ent.looper)) {
        continue;
      }

      if(isDefined(radius) && distancesquared(ent.origin, origin) > radiussq) {
        continue;
      }

      if(isDefined(ent.loopsound_ent)) {
        ent.loopsound_ent stoploopsound();
        ent.loopsound_ent delete();
      }

      ent.looper delete();
      var_2a2d2d350c260c94 = 1;
    }
  }

  if(!shouldrunserversideeffects() && (havemapentseffects() || !var_2a2d2d350c260c94)) {
    stop_clientside_exploder(num, players, bkill, radius, origin);
  }
}

function stop_clientside_exploder(explodername, players, bkill, radius, origin) {
  if(havemapentseffects()) {
    stopclientexploder(explodername, players, bkill, radius, origin);
    return;
  }

  if(!is_valid_clientside_exploder_name(explodername)) {
    println("<dev string:x6e>" + explodername + "<dev string:x8b>");
    return;
  }

  exploder_num = int(explodername);
  stopclientexploder(exploder_num, players, bkill, radius, origin);
}

function get_exploder_array_proc(msg) {
  msg += "";
  array = [];
  exploders = get_exploders(msg);

  if(isDefined(exploders)) {
    array = exploders;
  }

  return array;
}

function hide_exploder_models_proc(num) {
  num += "";
  exploders = get_exploders(num);

  if(isDefined(exploders)) {
    foreach(ent in exploders) {
      if(isstruct(ent.model)) {
        continue;
      }

      if(isDefined(ent.model)) {
        ent.model hide();
      }
    }
  }
}

function delete_exploder_proc(num) {
  num += "";
  exploders = get_exploders(num);

  if(isDefined(exploders)) {
    foreach(ent in exploders) {
      if(isstruct(ent.model)) {
        continue;
      }

      if(isDefined(ent.model)) {
        ent.model delete();
      }
    }
  }

  level notify("killexplodertridgers" + num);
}

function exploder_damage() {
  if(isDefined(self.v["delay"])) {
    delay = self.v["delay"];
  } else {
    delay = 0;
  }

  if(isDefined(self.v["damage_radius"])) {
    radius = self.v["damage_radius"];
  } else {
    radius = 128;
  }

  damage = self.v["damage"];
  origin = self.v["origin"];

  if(isDefined(self.v["envonly"])) {
    envonly = self.v["envonly"];
  } else {
    envonly = 0;
  }

  if(isDefined(self.v["dotraces"])) {
    dotraces = self.v["dotraces"];
  } else {
    dotraces = 1;
  }

  wait delay;
  radiusdamage(origin, radius, damage, damage, undefined, "MOD_EXPLOSIVE", undefined, envonly, dotraces);
}

function activate_individual_exploder_proc() {
  if(isDefined(self.v["firefx"])) {
    thread fire_effect();
  }

  if(isDefined(self.v["fxid"]) && self.v["fxid"] != "No FX") {
    thread cannon_effect();
  } else if(isDefined(self.v["soundalias"]) && self.v["soundalias"] != "nil") {
    thread sound_effect();
  }

  if(isDefined(self.v["loopsound"]) && self.v["loopsound"] != "nil") {
    thread effect_loopsound();
  }

  if(isDefined(self.v["damage"])) {
    thread exploder_damage();
  }

  if(isDefined(self.v["earthquake"])) {
    thread exploder_earthquake();
  }

  if(isDefined(self.v["rumble"])) {
    thread exploder_rumble();
  }

  if(self.v["exploder_type"] == "exploder") {
    thread brush_show();
    return;
  }

  if(self.v["exploder_type"] == "exploderchunk" || self.v["exploder_type"] == "exploderchunk visible") {
    thread brush_throw();
    return;
  }

  thread brush_delete();
}

function brush_delete() {
  num = self.v["exploder"];

  if(isDefined(self.v["delay"])) {
    wait self.v["delay"];
  } else {
    waitframe();
  }

  if(!isDefined(self.model)) {
    return;
  }

  if(isstruct(self.model)) {
    return;
  }

  if(utility::issp() && isDefined(self.model.classname)) {
    if(self.model.spawnflags & 1) {
      self.model builtin[[level.func["connectPaths"]]]();
    }
  }

  if(level.createfx_enabled) {
    if(isDefined(self.exploded)) {
      return;
    }

    self.exploded = 1;
    self.model hide();
    self.model notsolid();
    wait 3;
    self.exploded = undefined;
    self.model show();
    self.model solid();
    return;
  }

  if(!isDefined(self.v["fxid"]) || self.v["fxid"] == "No FX") {
    self.v["exploder"] = undefined;
  }

  waittillframeend();
  self.model delete();
}

function brush_throw() {
  if(isDefined(self.v["delay"])) {
    wait self.v["delay"];
  }

  ent = undefined;

  if(isDefined(self.v["target"])) {
    ent = utility::get_target_ent(self.v["target"]);
  }

  if(!isDefined(ent)) {
    self.model delete();
    return;
  }

  self.model show();

  if(isDefined(self.v["delay_post"])) {
    wait self.v["delay_post"];
  }

  startorg = self.v["origin"];
  startang = self.v["angles"];
  org = ent.origin;
  physics = isDefined(self.v["physics"]);

  if(physics) {
    target = undefined;

    if(isDefined(ent.target)) {
      target = ent utility::get_target_ent();
    }

    if(isDefined(target)) {
      contact_point = ent.origin;
      throw_vec = vectorNormalize(target.origin - ent.origin);
    } else {
      contact_point = self.model.origin;
      throw_vec = vectorNormalize(org - self.model.origin);
    }

    throw_vec *= self.v["physics"];
    self.model physicslaunchserver(contact_point, throw_vec);
    return;
  } else {
    throw_vec = org - self.model.origin;
    self.model rotatevelocity(throw_vec, 12);
    self.model movegravity(throw_vec, 12);
  }

  if(level.createfx_enabled) {
    if(isDefined(self.exploded)) {
      return;
    }

    self.exploded = 1;
    wait 3;
    self.exploded = undefined;
    self.v["origin"] = startorg;
    self.v["angles"] = startang;
    self.model hide();
    return;
  }

  self.v["exploder"] = undefined;
  wait 6;
  self.model delete();
}

function brush_show() {
  if(isDefined(self.v["delay"])) {
    wait self.v["delay"];
  }

  assert(isDefined(self.model));
  is_struct = 0;
  structmodel = undefined;

  if(!isDefined(self.model.script_modelname)) {
    self.model show();
    self.model solid();
  } else {
    is_struct = 1;
    structmodel = spawn("script_model", self.model.origin);
    structmodel.angles = self.model.angles;
    structmodel setModel(self.model.script_modelname);

    if(isDefined(self.model.script_linkname)) {
      structmodel.script_linkname = self.model.script_linkname;
    }
  }

  self.brush_shown = 1;

  if(!is_struct && utility::issp() && self.model.spawnflags & 1) {
    if(!isDefined(self.model.disconnect_paths)) {
      self.model builtin[[level.func["connectPaths"]]]();
    } else {
      self.model builtin[[level.func["disconnectPaths"]]]();
    }
  }

  if(level.createfx_enabled) {
    if(isDefined(self.exploded)) {
      return;
    }

    self.exploded = 1;
    wait 3;
    self.exploded = undefined;

    if(!is_struct) {
      self.model hide();
      self.model notsolid();
      return;
    }

    structmodel delete();
  }
}

function exploder_rumble() {
  if(!utility::issp()) {
    return;
  }

  exploder_delay();
  level.player playRumbleOnEntity(self.v["rumble"]);
}

function exploder_delay() {
  if(!isDefined(self.v["delay"])) {
    self.v["delay"] = 0;
  }

  min_delay = self.v["delay"];
  max_delay = self.v["delay"] + 0.001;

  if(isDefined(self.v["delay_min"])) {
    min_delay = self.v["delay_min"];
  }

  if(isDefined(self.v["delay_max"])) {
    max_delay = self.v["delay_max"];
  }

  if(min_delay > 0) {
    wait randomfloatrange(min_delay, max_delay);
  }
}

function effect_loopsound() {
  if(isDefined(self.loopsound_ent)) {
    self.loopsound_ent stoploopsound();
    self.loopsound_ent delete();
  }

  origin = self.v["origin"];
  alias = self.v["loopsound"];
  exploder_delay();
  self.loopsound_ent = utility::play_loopsound_in_space(alias, origin);
}

function sound_effect() {
  effect_soundalias();
}

function effect_soundalias() {
  origin = self.v["origin"];
  alias = self.v["soundalias"];
  exploder_delay();
  utility::play_sound_in_space(alias, origin);
}

function exploder_earthquake() {
  exploder_delay();
  utility::do_earthquake(self.v["earthquake"], self.v["origin"]);
}

function exploder_playSound() {
  if(!isDefined(self.v["soundalias"]) || self.v["soundalias"] == "nil") {
    return;
  }

  utility::play_sound_in_space(self.v["soundalias"], self.v["origin"]);
}

function fire_effect() {
  forward = self.v["forward"];
  up = self.v["up"];
  org = undefined;
  firefxsound = self.v["firefxsound"];
  origin = self.v["origin"];
  firefx = self.v["firefx"];
  ender = self.v["ender"];

  if(!isDefined(ender)) {
    ender = "createfx_effectStopper";
  }

  firefxdelay = 0.5;

  if(isDefined(self.v["firefxdelay"])) {
    firefxdelay = self.v["firefxdelay"];
  }

  exploder_delay();

  if(isDefined(firefxsound)) {
    utility::loop_fx_sound(firefxsound, origin, 1, ender);
  }

  playFX(level._effect[firefx], self.v["origin"], forward, up);
}

function cannon_effect() {
  if(isDefined(self.v["repeat"])) {
    thread exploder_playSound();

    for(i = 0; i < self.v["repeat"]; i++) {
      playFX(level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"]);
      exploder_delay();
    }

    return;
  }

  exploder_delay();

  if(isDefined(self.looper)) {
    self.looper delete();
  }

  self.looper = spawnfx(utility::getfx(self.v["fxid"]), self.v["origin"], self.v["forward"], self.v["up"]);
  triggerfx(self.looper);
  exploder_playSound();
}

function function_37d17d889197cbf9() {
  level endon("<dev string:xb3>");

  while(true) {
    level waittill("<dev string:xc1>", origin, delay, damageamount, damageradius, dotraces, envonly, earthquakename, rumblename);
    ent = spawnStruct();
    ent.v = [];
    ent.v["<dev string:x5e>"] = 0;
    ent.v["<dev string:xd1>"] = origin;
    ent.v["<dev string:xdb>"] = (0, 0, 0);
    ent.v["<dev string:xe5>"] = delay;
    ent.v["<dev string:xf2>"] = damageamount;
    ent.v["<dev string:xfc>"] = damageradius;
    ent.v["<dev string:x10d>"] = dotraces;
    ent.v["<dev string:x119>"] = envonly;
    ent.v["<dev string:x124>"] = "<dev string:x135>";

    if(isDefined(earthquakename) && earthquakename.size > 0) {
      ent.v["<dev string:x13f>"] = earthquakename;
    }

    if(isDefined(rumblename) && rumblename.size > 0) {
      ent.v["<dev string:x14d>"] = rumblename;
    }

    ent activate_individual_exploder_proc();
  }
}

function activate_exploder(num, players, starttime, radius, origin) {
  num += "";
  level notify("exploding_" + num);
  var_2a2d2d350c260c94 = 0;
  exploders = get_exploders(num);
  radiussq = isDefined(radius) ? squared(radius) : undefined;

  if(isDefined(exploders)) {
    foreach(ent in exploders) {
      if(isDefined(radius) && distancesquared(ent.origin, origin) > radiussq) {
        continue;
      }

      ent utility::activate_individual_exploder();
      var_2a2d2d350c260c94 = 1;
    }
  }

  if(!shouldrunserversideeffects() && (havemapentseffects() || !var_2a2d2d350c260c94)) {
    activate_clientside_exploder(num, players, starttime, radius, origin);
  }
}

function activate_clientside_exploder(explodername, players, starttime, radius, origin) {
  if(havemapentseffects()) {
    activateclientexploder(explodername, players, starttime, 0, radius, origin);
    return;
  }

  if(!is_valid_clientside_exploder_name(explodername)) {
    println("<dev string:x6e>" + explodername + "<dev string:x8b>");
    return;
  }

  exploder_num = int(explodername);
  activateclientexploder(exploder_num, players, starttime, 0, radius, origin);
}

function is_valid_clientside_exploder_name(explodername) {
  if(!isDefined(explodername)) {
    return false;
  }

  exploder_num = explodername;

  if(isstring(explodername)) {
    exploder_num = int(explodername);

    if(exploder_num == 0 && explodername != "0") {
      return false;
    }
  }

  return exploder_num >= 0;
}

function shouldrunserversideeffects() {
  if(utility::issp() && !havemapentseffects()) {
    return 1;
  }

  if(!isDefined(level.createfx_enabled)) {
    utility::set_createfx_enabled();
  }

  if(level.createfx_enabled) {
    return 1;
  }

  return getdvarint(@ "clientsideeffects") != 1;
}

function exploder_before_load(num, players, starttime, radius, origin) {
  waittillframeend();
  waittillframeend();
  activate_exploder(num, players, starttime, radius, origin);
}

function exploder_after_load(num, players, starttime, radius, origin) {
  activate_exploder(num, players, starttime, radius, origin);
}