/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\exploder.gsc
***********************************************/

function setup_individual_exploder(var_0) {
  var_1 = var_0.targetname;

  if(!isDefined(var_1)) {
    var_1 = "";
  }

  if(exploder_starts_hidden(var_0)) {
    var_0 hide();
    return;
  }

  if(exploder_is_damaged_model(var_0)) {
    var_0 hide();
    var_0 notsolid();

    if(isDefined(var_0.spawnflags) && var_0.spawnflags & 1) {
      if(isDefined(var_0.script_disconnectpaths)) {
        var_0 connectpaths();
      }
    }

    return;
  }

  if(exploder_is_chunk(var_0)) {
    var_0 hide();
    var_0 notsolid();

    if(isDefined(var_0.spawnflags) && var_0.spawnflags & 1) {
      var_0 connectpaths();
    }

    return;
  }
}

function addinitexploders(var_0) {
  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }

    if(isDefined(var_2.script_prefab_exploder)) {
      var_2.script_exploder = var_2.script_prefab_exploder;
      level.init_exploders[level.init_exploders.size] = var_2;
      continue;
    }

    if(isDefined(var_2.script_exploder)) {
      var_3 = 1;

      if(!isDefined(var_2.angles)) {
        var_2.angles = (0, 0, 0);
      }

      level.init_exploders[level.init_exploders.size] = var_2;
    }
  }
}

function removedeletableexploders(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_delete) && var_2.script_delete) {
      level.struct[var_3] = undefined;
    }
  }
}

function setupexploders() {
  level.init_exploders = [];
  level.exploders = [];
  var_0 = getEntArray("script_brushmodel", "classname");
  var_1 = getEntArray("script_model", "classname");

  foreach(var_3 in var_1) {
    var_0 = var_3;
  }

  foreach(var_6 in var_0) {
    if(isDefined(var_6.script_prefab_exploder)) {
      var_6.script_exploder = var_6.script_prefab_exploder;
    }

    if(isDefined(var_6.masked_exploder)) {
      continue;
    }

    if(isDefined(var_6.script_exploder)) {
      setup_individual_exploder(var_6);
    }
  }

  addinitexploders(getEntArray("script_brushmodel", "classname"));
  addinitexploders(getEntArray("script_model", "classname"));
  addinitexploders(level.struct);

  if(!isDefined(level.createfxent)) {
    level.createfxent = [];
  }

  var_8 = [];
  GscBinSkip0(0x2e, "exploderchunk visible", 1);
}

function exploder_flag_wait(var_0, var_1) {
  if(!scripts\engine\utility::flag_exist(var_0)) {
    scripts\engine\utility::flag_init(var_0);
  }

  scripts\engine\utility::flag_wait(var_0);

  foreach(var_3 in var_1) {
    foreach(var_5 in level.createfxexploders[var_3]) {
      var_5 scripts\engine\utility::activate_individual_exploder();
    }
  }
}

function exploder_is_damaged_model(var_0) {
  return isDefined(var_0.targetname) && var_0.targetname == "exploder";
}

function exploder_starts_hidden(var_0) {
  return var_0.model == "fx" && (!isDefined(var_0.targetname) || var_0.targetname != "exploderchunk");
}

function exploder_is_chunk(var_0) {
  return isDefined(var_0.targetname) && var_0.targetname == "exploderchunk";
}

function show_exploder_models_proc(var_0) {
  var_0 += "";
  var_1 = get_exploders();

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      if(isstruct(var_3.model)) {
        continue;
      }

      if(!exploder_starts_hidden(var_3.model) && !exploder_is_damaged_model(var_3.model) && !exploder_is_chunk(var_3.model)) {
        var_3.model show();
      }

      if(isDefined(var_3.brush_shown)) {
        var_3.model show();
      }
    }

    return;
  }
}

function get_exploders(var_0) {
  var_1 = [];

  if(level.createfx_enabled) {
    var_1 = get_createfx_exploders(var_0);
  } else if(isDefined(level.createfxexploders[var_0])) {
    var_1 = level.createfxexploders[var_0];
  }

  if(isDefined(level.exploders[var_0])) {
    foreach(var_3 in level.exploders[var_0]) {
      var_1 = var_3;
    }
  }

  return var_1;
}

function get_createfx_exploders(var_0) {}

function stop_exploder_proc(var_0, var_1, var_2) {
  var_0 += "";
  var_3 = 0;
  var_4 = get_exploders(var_0);

  if(isDefined(var_4)) {
    foreach(var_6 in var_4) {
      if(!isDefined(var_6.looper)) {
        continue;
      }

      if(isDefined(var_6.loopsound_ent)) {
        var_6.loopsound_ent stoploopsound();
        var_6.loopsound_ent delete();
      }

      var_6.looper delete();
      var_3 = 1;
    }
  }

  if(!shouldrunserversideeffects() && (isplatformconsole() || !var_3)) {
    stop_clientside_exploder(var_0, var_1, var_2);
    return;
  }
}

function stop_clientside_exploder(var_0, var_1, var_2) {
  if(isplatformconsole()) {
    loadinfiltransient(var_0, var_1, var_2);
    return;
  }

  if(!is_valid_clientside_exploder_name(var_0)) {
    return;
  }

  var_3 = int(var_0);
  loadinfiltransient(var_3, var_1, var_2);
}

function get_exploder_array_proc(var_0) {
  var_0 += "";
  var_1 = [];
  var_2 = get_exploders(var_0);

  if(isDefined(var_2)) {
    var_1 = var_2;
  }

  return var_1;
}

function hide_exploder_models_proc(var_0) {
  var_0 += "";
  var_1 = get_exploders(var_0);

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      if(isstruct(var_3.model)) {
        continue;
      }

      if(isDefined(var_3.model)) {
        var_3.model hide();
      }
    }

    return;
  }
}

function delete_exploder_proc(var_0) {
  var_0 += "";
  var_1 = get_exploders(var_0);

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      if(isstruct(var_3.model)) {
        continue;
      }

      if(isDefined(var_3.model)) {
        var_3.model delete();
      }
    }
  }

  level notify("killexplodertridgers" + var_0);
}

function exploder_damage() {
  if(isDefined(self.v["delay"])) {
    var_0 = self.v["delay"];
  } else {
    var_0 = 0;
  }

  if(isDefined(self.v["damage_radius"])) {
    var_1 = self.v["damage_radius"];
  } else {
    var_1 = 128;
  }

  var_2 = self.v["damage"];
  var_3 = self.v["origin"];

  if(isDefined(self.v["envonly"])) {
    var_4 = self.v["envonly"];
  } else {
    var_4 = 0;
  }

  if(isDefined(self.v["dotraces"])) {
    var_5 = self.v["dotraces"];
  } else {
    var_5 = 1;
  }

  wait var_2;
  radiusdamage(var_4, var_3, var_4, var_4, undefined, "MOD_EXPLOSIVE", undefined, var_5, var_5);
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
  var_0 = self.v["exploder"];

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

  if(scripts\common\utility::issp() && isDefined(self.model.classname)) {
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

  var_0 = undefined;

  if(isDefined(self.v["target"])) {
    var_0 = scripts\engine\utility::get_target_ent(self.v["target"]);
  }

  if(!isDefined(var_0)) {
    self.model delete();
    return;
  }

  self.model show();

  if(isDefined(self.v["delay_post"])) {
    wait self.v["delay_post"];
  }

  var_1 = self.v["origin"];
  var_2 = self.v["angles"];
  var_3 = var_0.origin;
  var_4 = isDefined(self.v["physics"]);

  if(var_4) {
    var_5 = undefined;

    if(isDefined(var_0.target)) {
      var_5 = var_0 scripts\engine\utility::get_target_ent();
    }

    if(isDefined(var_5)) {
      var_6 = var_0.origin;
      var_7 = vectorNormalize(var_5.origin - var_0.origin);
    } else {
      var_6 = self.model.origin;
      var_7 = vectorNormalize(var_5 - self.model.origin);
    }

    var_7 *= self.v["physics"];
    self.model physicslaunchserver(var_6, var_7);
    return;
  } else {
    var_7 = var_6 - self.model.origin;
    self.model rotatevelocity(var_7, 12);
    self.model movegravity(var_7, 12);
  }

  if(level.createfx_enabled) {
    if(isDefined(self.exploded)) {
      return;
    }

    self.exploded = 1;
    wait 3;
    self.exploded = undefined;
    self.v["origin"] = var_6;
    self.v["angles"] = var_7;
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

  var_0 = 0;
  var_1 = undefined;

  if(!isDefined(self.model.script_modelname)) {
    self.model show();
    self.model solid();
  } else {
    var_0 = 1;
    var_1 = spawn("script_model", self.model.origin);
    var_1.angles = self.model.angles;
    var_1 setModel(self.model.script_modelname);

    if(isDefined(self.model.script_linkname)) {
      var_1.script_linkname = self.model.script_linkname;
    }
  }

  self.brush_shown = 1;

  if(!var_0 && scripts\common\utility::issp() && self.model.spawnflags & 1) {
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

    if(!var_0) {
      self.model hide();
      self.model notsolid();
      return;
    }

    var_1 delete();
    return;
  }
}

function exploder_rumble() {
  if(!scripts\common\utility::issp()) {
    return;
  }

  exploder_delay();
  level.player playRumbleOnEntity(self.v["rumble"]);
}

function exploder_delay() {
  if(!isDefined(self.v["delay"])) {
    self.v["delay"] = 0;
  }

  var_0 = self.v["delay"];
  var_1 = self.v["delay"] + 0.001;

  if(isDefined(self.v["delay_min"])) {
    var_0 = self.v["delay_min"];
  }

  if(isDefined(self.v["delay_max"])) {
    var_1 = self.v["delay_max"];
  }

  if(var_0 > 0) {
    wait randomfloatrange(var_0, var_1);
    return;
  }
}

function effect_loopsound() {
  if(isDefined(self.loopsound_ent)) {
    self.loopsound_ent stoploopsound();
    self.loopsound_ent delete();
  }

  var_0 = self.v["origin"];
  var_1 = self.v["loopsound"];
  exploder_delay();
  self.loopsound_ent = scripts\engine\utility::play_loopsound_in_space(var_1, var_0);
}

function sound_effect() {
  effect_soundalias();
}

function effect_soundalias() {
  var_0 = self.v["origin"];
  var_1 = self.v["soundalias"];
  exploder_delay();
  scripts\engine\utility::play_sound_in_space(var_1, var_0);
}

function exploder_earthquake() {
  exploder_delay();
  scripts\engine\utility::do_earthquake(self.v["earthquake"], self.v["origin"]);
}

function exploder_playSound() {
  if(!isDefined(self.v["soundalias"]) || self.v["soundalias"] == "nil") {
    return;
  }

  scripts\engine\utility::play_sound_in_space(self.v["soundalias"], self.v["origin"]);
}

function fire_effect() {
  var_0 = self.v["forward"];
  var_1 = self.v["up"];
  var_2 = undefined;
  var_3 = self.v["firefxsound"];
  var_4 = self.v["origin"];
  var_5 = self.v["firefx"];
  var_6 = self.v["ender"];

  if(!isDefined(var_6)) {
    var_6 = "createfx_effectStopper";
  }

  var_7 = 0.5;

  if(isDefined(self.v["firefxdelay"])) {
    var_7 = self.v["firefxdelay"];
  }

  exploder_delay();

  if(isDefined(var_3)) {
    scripts\engine\utility::loop_fx_sound(var_3, var_4, 1, var_6);
  }

  playFX(level._effect[var_5], self.v["origin"], var_0, var_1);
}

function cannon_effect() {
  if(isDefined(self.v["repeat"])) {
    thread exploder_playSound();

    for(var_0 = 0; var_0 < self.v["repeat"]; var_0++) {
      playFX(level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"]);
      exploder_delay();
    }

    return;
  }

  exploder_delay();

  if(isDefined(self.looper)) {
    self.looper delete();
  }

  self.looper = spawnfx(scripts\engine\utility::getfx(self.v["fxid"]), self.v["origin"], self.v["forward"], self.v["up"]);
  triggerfx(self.looper);
  exploder_playSound();
}

function activate_exploder(var_0, var_1, var_2) {
  var_0 += "";
  level notify("exploding_" + var_0);
  var_3 = 0;
  var_4 = get_exploders(var_0);

  if(isDefined(var_4)) {
    foreach(var_6 in var_4) {
      var_6 scripts\engine\utility::activate_individual_exploder();
      var_3 = 1;
    }
  }

  if(!shouldrunserversideeffects() && (isplatformconsole() || !var_3)) {
    activate_clientside_exploder(var_0, var_1, var_2);
    return;
  }
}

function activate_clientside_exploder(var_0, var_1, var_2) {
  if(isplatformconsole()) {
    activateclientexploder(var_0, var_1, var_2);
    return;
  }

  if(!is_valid_clientside_exploder_name(var_0)) {
    return;
  }

  var_3 = int(var_0);
  activateclientexploder(var_3, var_1, var_2);
}

function is_valid_clientside_exploder_name(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  var_1 = var_0;

  if(isstring(var_0)) {
    var_1 = int(var_0);

    if(var_1 == 0 && var_0 != "0") {
      return false;
    }
  }

  return var_1 >= 0;
}

function shouldrunserversideeffects() {
  if(scripts\common\utility::issp() && !isplatformconsole()) {
    return 1;
  }

  if(!isDefined(level.createfx_enabled)) {
    scripts\engine\utility::set_createfx_enabled();
  }

  if(level.createfx_enabled) {
    return 1;
  }

  return getDvar("clientSideEffects") != "1";
}

function exploder_before_load(var_0, var_1, var_2) {
  waittillframeend();
  waittillframeend();
  activate_exploder(var_0, var_1, var_2);
}

function exploder_after_load(var_0, var_1, var_2) {
  activate_exploder(var_0, var_1, var_2);
}