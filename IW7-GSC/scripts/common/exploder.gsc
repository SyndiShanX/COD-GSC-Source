/***************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\common\exploder.gsc
***************************************/

setup_individual_exploder(param_00) {
  var_01 = param_00.script_exploder;
  if(!isDefined(level.exploders[var_01])) {
    level.exploders[var_01] = [];
  }

  var_02 = param_00.var_336;
  if(!isDefined(var_02)) {
    var_02 = "";
  }

  level.exploders[var_01][level.exploders[var_01].size] = param_00;
  if(exploder_model_starts_hidden(param_00)) {
    param_00 hide();
    return;
  }

  if(exploder_model_is_damaged_model(param_00)) {
    param_00 hide();
    param_00 notsolid();
    if(isDefined(param_00.spawnimpulsefield) && param_00.spawnimpulsefield & 1) {
      if(isDefined(param_00.script_disconnectpaths)) {
        param_00 connectpaths();
      }
    }

    return;
  }

  if(exploder_model_is_chunk(param_00)) {
    param_00 hide();
    param_00 notsolid();
    if(isDefined(param_00.spawnimpulsefield) && param_00.spawnimpulsefield & 1) {
      param_00 connectpaths();
    }
  }
}

setupexploders() {
  scripts\engine\utility::set_createfx_enabled();
  level.exploders = [];
  var_00 = getEntArray("script_brushmodel", "classname");
  var_01 = getEntArray("script_model", "classname");
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    var_00[var_00.size] = var_01[var_02];
  }

  foreach(var_04 in var_00) {
    if(isDefined(var_04.script_prefab_exploder)) {
      var_04.script_exploder = var_04.script_prefab_exploder;
    }

    if(isDefined(var_04.masked_exploder)) {
      continue;
    }

    if(isDefined(var_04.script_exploder)) {
      setup_individual_exploder(var_04);
    }
  }

  var_06 = [];
  var_07 = getEntArray("script_brushmodel", "classname");
  for(var_02 = 0; var_02 < var_07.size; var_02++) {
    if(isDefined(var_07[var_02].script_prefab_exploder)) {
      var_07[var_02].script_exploder = var_07[var_02].script_prefab_exploder;
    }

    if(isDefined(var_07[var_02].script_exploder)) {
      var_06[var_06.size] = var_07[var_02];
    }
  }

  var_07 = getEntArray("script_model", "classname");
  for(var_02 = 0; var_02 < var_07.size; var_02++) {
    if(isDefined(var_07[var_02].script_prefab_exploder)) {
      var_07[var_02].script_exploder = var_07[var_02].script_prefab_exploder;
    }

    if(isDefined(var_07[var_02].script_exploder)) {
      var_06[var_06.size] = var_07[var_02];
    }
  }

  var_07 = getEntArray("item_health", "classname");
  for(var_02 = 0; var_02 < var_07.size; var_02++) {
    if(isDefined(var_07[var_02].script_prefab_exploder)) {
      var_07[var_02].script_exploder = var_07[var_02].script_prefab_exploder;
    }

    if(isDefined(var_07[var_02].script_exploder)) {
      var_06[var_06.size] = var_07[var_02];
    }
  }

  var_07 = level.struct;
  for(var_02 = 0; var_02 < var_07.size; var_02++) {
    if(!isDefined(var_07[var_02])) {
      continue;
    }

    if(isDefined(var_07[var_02].script_prefab_exploder)) {
      var_07[var_02].script_exploder = var_07[var_02].script_prefab_exploder;
    }

    if(isDefined(var_07[var_02].script_exploder)) {
      if(!isDefined(var_07[var_02].angles)) {
        var_07[var_02].angles = (0, 0, 0);
      }

      var_06[var_06.size] = var_07[var_02];
    }
  }

  if(!isDefined(level.createfxent)) {
    level.createfxent = [];
  }

  var_08 = [];
  var_08["exploderchunk visible"] = 1;
  var_08["exploderchunk"] = 1;
  var_08["exploder"] = 1;
  thread setup_flag_exploders();
  for(var_02 = 0; var_02 < var_06.size; var_02++) {
    var_09 = var_06[var_02];
    var_04 = scripts\engine\utility::createexploder(var_09.script_fxid);
    var_04.v = [];
    var_04.v["origin"] = var_09.origin;
    var_04.v["angles"] = var_09.angles;
    var_04.v["delay"] = var_09.script_delay;
    var_04.v["delay_post"] = var_09.script_delay_post;
    var_04.v["firefx"] = var_09.script_firefx;
    var_04.v["firefxdelay"] = var_09.script_firefxdelay;
    var_04.v["firefxsound"] = var_09.script_firefxsound;
    var_04.v["earthquake"] = var_09.script_earthquake;
    var_04.v["rumble"] = var_09.script_rumble;
    var_04.v["damage"] = var_09.script_damage;
    var_04.v["damage_radius"] = var_09.script_radius;
    var_04.v["soundalias"] = var_09.script_soundalias;
    var_04.v["repeat"] = var_09.script_repeat;
    var_04.v["delay_min"] = var_09.script_delay_min;
    var_04.v["delay_max"] = var_09.script_delay_max;
    var_04.v["target"] = var_09.target;
    var_04.v["ender"] = var_09.script_ender;
    var_04.v["physics"] = var_09.script_physics;
    var_04.v["type"] = "exploder";
    if(!isDefined(var_09.script_fxid)) {
      var_04.v["fxid"] = "No FX";
    } else {
      var_04.v["fxid"] = var_09.script_fxid;
    }

    var_04.v["exploder"] = var_09.script_exploder;
    if(isDefined(level.createfxexploders)) {
      var_0A = level.createfxexploders[var_04.v["exploder"]];
      if(!isDefined(var_0A)) {
        var_0A = [];
      }

      var_0A[var_0A.size] = var_04;
      level.createfxexploders[var_04.v["exploder"]] = var_0A;
    }

    if(!isDefined(var_04.v["delay"])) {
      var_04.v["delay"] = 0;
    }

    if(isDefined(var_09.target)) {
      var_0B = getEntArray(var_04.v["target"], "targetname")[0];
      if(isDefined(var_0B)) {
        var_0C = var_0B.origin;
        var_04.v["angles"] = vectortoangles(var_0C - var_04.v["origin"]);
      } else {
        var_0B = scripts\engine\utility::get_target_ent(var_04.v["target"]);
        if(isDefined(var_0B)) {
          var_0C = var_0B.origin;
          var_04.v["angles"] = vectortoangles(var_0C - var_04.v["origin"]);
        }
      }
    }

    if(!isDefined(var_09.var_9F)) {
      var_04.model = var_09;
      if(isDefined(var_04.model.script_modelname)) {
        precachemodel(var_04.model.script_modelname);
      }
    } else if(var_09.var_9F == "script_brushmodel" || isDefined(var_09.model)) {
      var_04.model = var_09;
      var_04.model.disconnect_paths = var_09.script_disconnectpaths;
    }

    if(isDefined(var_09.var_336) && isDefined(var_08[var_09.var_336])) {
      var_04.v["exploder_type"] = var_09.var_336;
    } else {
      var_04.v["exploder_type"] = "normal";
    }

    if(isDefined(var_09.masked_exploder)) {
      var_04.v["masked_exploder"] = var_09.model;
      var_04.v["masked_exploder_spawnflags"] = var_09.spawnimpulsefield;
      var_04.v["masked_exploder_script_disconnectpaths"] = var_09.script_disconnectpaths;
      var_09 delete();
    }

    var_04 scripts\common\createfx::post_entity_creation_function();
  }
}

setup_flag_exploders() {
  waittillframeend;
  waittillframeend;
  waittillframeend;
  var_00 = [];
  foreach(var_02 in level.createfxent) {
    if(var_02.v["type"] != "exploder") {
      continue;
    }

    var_03 = var_02.v["flag"];
    if(!isDefined(var_03)) {
      continue;
    }

    if(var_03 == "nil") {
      var_02.v["flag"] = undefined;
    }

    var_00[var_03] = 1;
  }

  foreach(var_07, var_06 in var_00) {
    thread exploder_flag_wait(var_07);
  }
}

exploder_flag_wait(param_00) {
  if(!scripts\engine\utility::flag_exist(param_00)) {
    scripts\engine\utility::flag_init(param_00);
  }

  scripts\engine\utility::flag_wait(param_00);
  foreach(var_02 in level.createfxent) {
    if(var_02.v["type"] != "exploder") {
      continue;
    }

    var_03 = var_02.v["flag"];
    if(!isDefined(var_03)) {
      continue;
    }

    if(var_03 != param_00) {
      continue;
    }

    var_02 scripts\engine\utility::activate_individual_exploder();
  }
}

exploder_model_is_damaged_model(param_00) {
  return isDefined(param_00.var_336) && param_00.var_336 == "exploder";
}

exploder_model_starts_hidden(param_00) {
  return param_00.model == "fx" && !isDefined(param_00.var_336) || param_00.var_336 != "exploderchunk";
}

exploder_model_is_chunk(param_00) {
  return isDefined(param_00.var_336) && param_00.var_336 == "exploderchunk";
}

show_exploder_models_proc(param_00) {
  param_00 = param_00 + "";
  if(isDefined(level.createfxexploders)) {
    var_01 = level.createfxexploders[param_00];
    if(isDefined(var_01)) {
      foreach(var_03 in var_01) {
        if(!exploder_model_starts_hidden(var_03.model) && !exploder_model_is_damaged_model(var_03.model) && !exploder_model_is_chunk(var_03.model)) {
          var_03.model show();
        }

        if(isDefined(var_03.brush_shown)) {
          var_03.model show();
        }
      }

      return;
    }

    return;
  }

  var_05 = 0;
  while(var_03 < level.createfxent.size) {
    var_05 = level.createfxent[var_03];
    if(!isDefined(var_05)) {
      continue;
    }

    if(var_05.v["type"] != "exploder") {
      continue;
    }

    if(!isDefined(var_05.v["exploder"])) {
      continue;
    }

    if(var_05.v["exploder"] + "" != var_02) {
      continue;
    }

    if(isDefined(var_05.model)) {
      if(!exploder_model_starts_hidden(var_05.model) && !exploder_model_is_damaged_model(var_05.model) && !exploder_model_is_chunk(var_05.model)) {
        var_05.model show();
      }

      if(isDefined(var_05.brush_shown)) {
        var_05.model show();
      }
    }

    var_03++;
  }
}

stop_exploder_proc(param_00) {
  param_00 = param_00 + "";
  if(isDefined(level.createfxexploders)) {
    var_01 = level.createfxexploders[param_00];
    if(isDefined(var_01)) {
      foreach(var_03 in var_01) {
        if(!isDefined(var_03.looper)) {
          continue;
        }

        if(isDefined(var_03.loopsound_ent)) {
          var_03.loopsound_ent stoploopsound();
          var_03.loopsound_ent delete();
        }

        var_03.looper delete();
      }

      return;
    }

    return;
  }

  var_05 = 0;
  while(var_03 < level.createfxent.size) {
    var_05 = level.createfxent[var_03];
    if(!isDefined(var_05)) {
      continue;
    }

    if(var_05.v["type"] != "exploder") {
      continue;
    }

    if(!isDefined(var_05.v["exploder"])) {
      continue;
    }

    if(var_05.v["exploder"] + "" != var_02) {
      continue;
    }

    if(!isDefined(var_05.looper)) {
      continue;
    }

    if(isDefined(var_05.loopsound_ent)) {
      var_05.loopsound_ent stoploopsound();
      var_05.loopsound_ent delete();
    }

    var_05.looper delete();
    var_03++;
  }
}

get_exploder_array_proc(param_00) {
  param_00 = param_00 + "";
  var_01 = [];
  if(isDefined(level.createfxexploders)) {
    var_02 = level.createfxexploders[param_00];
    if(isDefined(var_02)) {
      var_01 = var_02;
    }
  } else {
    foreach(var_04 in level.createfxent) {
      if(var_04.v["type"] != "exploder") {
        continue;
      }

      if(!isDefined(var_04.v["exploder"])) {
        continue;
      }

      if(var_04.v["exploder"] + "" != param_00) {
        continue;
      }

      var_01[var_01.size] = var_04;
    }
  }

  return var_01;
}

hide_exploder_models_proc(param_00) {
  param_00 = param_00 + "";
  if(isDefined(level.createfxexploders)) {
    var_01 = level.createfxexploders[param_00];
    if(isDefined(var_01)) {
      foreach(var_03 in var_01) {
        if(isDefined(var_03.model)) {
          var_03.model hide();
        }
      }

      return;
    }

    return;
  }

  var_05 = 0;
  while(var_03 < level.createfxent.size) {
    var_05 = level.createfxent[var_03];
    if(!isDefined(var_05)) {
      continue;
    }

    if(var_05.v["type"] != "exploder") {
      continue;
    }

    if(!isDefined(var_05.v["exploder"])) {
      continue;
    }

    if(var_05.v["exploder"] + "" != var_02) {
      continue;
    }

    if(isDefined(var_05.model)) {
      var_05.model hide();
    }

    var_03++;
  }
}

delete_exploder_proc(param_00) {
  param_00 = param_00 + "";
  if(isDefined(level.createfxexploders)) {
    var_01 = level.createfxexploders[param_00];
    if(isDefined(var_01)) {
      foreach(var_03 in var_01) {
        if(isDefined(var_03.model)) {
          var_03.model delete();
        }
      }
    }
  } else {
    for(var_05 = 0; var_05 < level.createfxent.size; var_05++) {
      var_03 = level.createfxent[var_05];
      if(!isDefined(var_03)) {
        continue;
      }

      if(var_03.v["type"] != "exploder") {
        continue;
      }

      if(!isDefined(var_03.v["exploder"])) {
        continue;
      }

      if(var_03.v["exploder"] + "" != param_00) {
        continue;
      }

      if(isDefined(var_03.model)) {
        var_03.model delete();
      }
    }
  }

  level notify("killexplodertridgers" + param_00);
}

exploder_damage() {
  if(isDefined(self.v["delay"])) {
    var_00 = self.v["delay"];
  } else {
    var_00 = 0;
  }

  if(isDefined(self.v["damage_radius"])) {
    var_01 = self.v["damage_radius"];
  } else {
    var_01 = 128;
  }

  var_02 = self.v["damage"];
  var_03 = self.v["origin"];
  wait(var_00);
  if(isDefined(level.custom_radius_damage_for_exploders)) {
    [[level.custom_radius_damage_for_exploders]](var_03, var_01, var_02);
    return;
  }

  radiusdamage(var_03, var_01, var_02, var_02);
}

activate_individual_exploder_proc() {
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

brush_delete() {
  var_00 = self.v["exploder"];
  if(isDefined(self.v["delay"])) {
    wait(self.v["delay"]);
  } else {
    wait(0.05);
  }

  if(!isDefined(self.model)) {
    return;
  }

  if(isDefined(self.model.classname)) {
    if(!isstruct(self.model) && isDefined(self.model.classname)) {
      if(scripts\engine\utility::issp() && self.model.spawnimpulsefield & 1) {
        self.model[[level.func["connectPaths"]]]();
      }
    }
  }

  if(level.createfx_enabled) {
    if(isDefined(self.exploded)) {
      return;
    }

    self.exploded = 1;
    self.model hide();
    self.model notsolid();
    wait(3);
    self.exploded = undefined;
    self.model show();
    self.model solid();
    return;
  }

  if(!isDefined(self.v["fxid"]) || self.v["fxid"] == "No FX") {
    self.v["exploder"] = undefined;
  }

  waittillframeend;
  if(isDefined(self.model) && !isstruct(self.model) && isDefined(self.model.classname)) {
    self.model delete();
  }
}

brush_throw() {
  if(isDefined(self.v["delay"])) {
    wait(self.v["delay"]);
  }

  var_00 = undefined;
  if(isDefined(self.v["target"])) {
    var_00 = scripts\engine\utility::get_target_ent(self.v["target"]);
  }

  if(!isDefined(var_00)) {
    self.model delete();
    return;
  }

  self.model show();
  if(isDefined(self.v["delay_post"])) {
    wait(self.v["delay_post"]);
  }

  var_01 = self.v["origin"];
  var_02 = self.v["angles"];
  var_03 = var_00.origin;
  var_04 = isDefined(self.v["physics"]);
  if(var_04) {
    var_05 = undefined;
    if(isDefined(var_00.target)) {
      var_05 = var_00 scripts\engine\utility::get_target_ent();
    }

    if(isDefined(var_05)) {
      var_06 = var_00.origin;
      var_07 = vectornormalize(var_05.origin - var_00.origin);
    } else {
      var_06 = self.model.origin;
      var_07 = vectornormalize(var_04 - self.model.origin);
    }

    var_07 = var_07 * self.v["physics"];
    self.model physicslaunchserver(var_06, var_07);
    return;
  } else {
    var_07 = var_06 - self.model.origin;
    self.model rotatevelocity(var_07, 12);
    self.model movegravity(var_07, 12);
  }

  if(level.createfx_enabled) {
    if(isDefined(self.exploded)) {
      return;
    }

    self.exploded = 1;
    wait(3);
    self.exploded = undefined;
    self.v["origin"] = var_03;
    self.v["angles"] = var_04;
    self.model hide();
    return;
  }

  self.v["exploder"] = undefined;
  wait(6);
  self.model delete();
}

brush_show() {
  if(isDefined(self.v["delay"])) {
    wait(self.v["delay"]);
  }

  if(!isDefined(self.model.script_modelname)) {
    self.model show();
    self.model solid();
  } else {
    var_00 = self.model scripts\engine\utility::spawn_tag_origin();
    if(isDefined(self.model.destroynavobstacle)) {
      var_00.destroynavobstacle = self.model.destroynavobstacle;
    }

    var_00 setModel(self.model.script_modelname);
    var_00 show();
  }

  self.brush_shown = 1;
  if(scripts\engine\utility::issp() && !isDefined(self.model.script_modelname) && self.model.spawnimpulsefield & 1) {
    if(!isDefined(self.model.disconnect_paths)) {
      self.model[[level.func["connectPaths"]]]();
    } else {
      self.model[[level.func["disconnectPaths"]]]();
    }
  }

  if(level.createfx_enabled) {
    if(isDefined(self.exploded)) {
      return;
    }

    self.exploded = 1;
    wait(3);
    self.exploded = undefined;
    if(!isDefined(self.model.script_modelname)) {
      self.model hide();
      self.model notsolid();
    }
  }
}

exploder_rumble() {
  if(!scripts\engine\utility::issp()) {
    return;
  }

  exploder_delay();
  level.player playrumbleonentity(self.v["rumble"]);
}

exploder_delay() {
  if(!isDefined(self.v["delay"])) {
    self.v["delay"] = 0;
  }

  var_00 = self.v["delay"];
  var_01 = self.v["delay"] + 0.001;
  if(isDefined(self.v["delay_min"])) {
    var_00 = self.v["delay_min"];
  }

  if(isDefined(self.v["delay_max"])) {
    var_01 = self.v["delay_max"];
  }

  if(var_00 > 0) {
    wait(randomfloatrange(var_00, var_01));
  }
}

effect_loopsound() {
  if(isDefined(self.loopsound_ent)) {
    self.loopsound_ent stoploopsound();
    self.loopsound_ent delete();
  }

  var_00 = self.v["origin"];
  var_01 = self.v["loopsound"];
  exploder_delay();
  self.loopsound_ent = scripts\engine\utility::play_loopsound_in_space(var_01, var_00);
}

sound_effect() {
  effect_soundalias();
}

effect_soundalias() {
  var_00 = self.v["origin"];
  var_01 = self.v["soundalias"];
  exploder_delay();
  scripts\engine\utility::play_sound_in_space(var_01, var_00);
}

exploder_earthquake() {
  exploder_delay();
  scripts\engine\utility::do_earthquake(self.v["earthquake"], self.v["origin"]);
}

exploder_playSound() {
  if(!isDefined(self.v["soundalias"]) || self.v["soundalias"] == "nil") {
    return;
  }

  scripts\engine\utility::play_sound_in_space(self.v["soundalias"], self.v["origin"]);
}

fire_effect() {
  var_00 = self.v["forward"];
  var_01 = self.v["up"];
  var_02 = undefined;
  var_03 = self.v["firefxsound"];
  var_04 = self.v["origin"];
  var_05 = self.v["firefx"];
  var_06 = self.v["ender"];
  if(!isDefined(var_06)) {
    var_06 = "createfx_effectStopper";
  }

  var_07 = 0.5;
  if(isDefined(self.v["firefxdelay"])) {
    var_07 = self.v["firefxdelay"];
  }

  exploder_delay();
  if(isDefined(var_03)) {
    scripts\engine\utility::loop_fx_sound(var_03, var_04, 1, var_06);
  }

  playFX(level._effect[var_05], self.v["origin"], var_00, var_01);
}

cannon_effect() {
  if(isDefined(self.v["repeat"])) {
    thread exploder_playSound();
    for(var_00 = 0; var_00 < self.v["repeat"]; var_00++) {
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

activate_exploder(param_00, param_01, param_02) {
  param_00 = param_00 + "";
  level notify("exploding_" + param_00);
  var_03 = 0;
  if(isDefined(level.createfxexploders) && !level.createfx_enabled) {
    var_04 = level.createfxexploders[param_00];
    if(isDefined(var_04)) {
      foreach(var_06 in var_04) {
        var_06 scripts\engine\utility::activate_individual_exploder();
        var_03 = 1;
      }
    }
  } else {
    for(var_08 = 0; var_08 < level.createfxent.size; var_08++) {
      var_06 = level.createfxent[var_08];
      if(!isDefined(var_06)) {
        continue;
      }

      if(var_06.v["type"] != "exploder") {
        continue;
      }

      if(!isDefined(var_06.v["exploder"])) {
        continue;
      }

      if(var_06.v["exploder"] + "" != param_00) {
        continue;
      }

      var_06 scripts\engine\utility::activate_individual_exploder();
      var_03 = 1;
    }
  }

  if(!shouldrunserversideeffects() && !var_03) {
    activate_clientside_exploder(param_00, param_01, param_02);
  }
}

activate_clientside_exploder(param_00, param_01, param_02) {
  if(!is_valid_clientside_exploder_name(param_00)) {
    return;
  }

  var_03 = int(param_00);
  activateclientexploder(var_03, param_01, param_02);
}

is_valid_clientside_exploder_name(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  var_01 = param_00;
  if(isstring(param_00)) {
    var_01 = int(param_00);
    if(var_01 == 0 && param_00 != "0") {
      return 0;
    }
  }

  return var_01 >= 0;
}

shouldrunserversideeffects() {
  if(scripts\engine\utility::issp()) {
    return 1;
  }

  if(!isDefined(level.createfx_enabled)) {
    scripts\engine\utility::set_createfx_enabled();
  }

  if(level.createfx_enabled) {
    return 1;
  }

  return getdvar("clientSideEffects") != "1";
}

exploder_before_load(param_00, param_01, param_02) {
  waittillframeend;
  waittillframeend;
  activate_exploder(param_00, param_01, param_02);
}

exploder_after_load(param_00, param_01, param_02) {
  activate_exploder(param_00, param_01, param_02);
}