/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\exploder.gsc
***********************************************/

setup_individual_exploder(ent) {
  targetname = ent.targetname;

  if(!isDefined(targetname))
    targetname = "";

  if(exploder_starts_hidden(ent)) {
    ent hide();
    return;
  }

  if(exploder_is_damaged_model(ent)) {
    ent hide();
    ent notsolid();

    if(isDefined(ent.spawnflags) && ent.spawnflags & 1) {
      if(isDefined(ent.script_disconnectpaths))
        ent connectpaths();
    }

    return;
  }

  if(exploder_is_chunk(ent)) {
    ent hide();
    ent notsolid();

    if(isDefined(ent.spawnflags) && ent.spawnflags & 1)
      ent connectpaths();

    return;
  }
}

addinitexploders(_id_287AFA57AB1A64A1) {
  foreach(ent in _id_287AFA57AB1A64A1) {
    if(!isDefined(ent)) {
      continue;
    }
    if(isDefined(ent.script_prefab_exploder)) {
      ent.script_exploder = ent.script_prefab_exploder;
      level.init_exploders[level.init_exploders.size] = ent;
      continue;
    }

    if(isDefined(ent.script_exploder)) {
      _id_62F91D5269545D20 = 1;

      if(!isDefined(ent.angles))
        ent.angles = (0, 0, 0);

      level.init_exploders[level.init_exploders.size] = ent;
    }
  }
}

setupexploders() {
  level.init_exploders = [];
  level.exploders = [];
  ents = getEntArray("script_brushmodel", "classname");
  _id_A85ECA59011EC620 = getEntArray("script_model", "classname");

  foreach(_id_3FDD0A3144354113 in _id_A85ECA59011EC620)
  ents[ents.size] = _id_3FDD0A3144354113;

  foreach(ent in ents) {
    if(isDefined(ent.script_prefab_exploder))
      ent.script_exploder = ent.script_prefab_exploder;

    if(isDefined(ent.masked_exploder)) {
      continue;
    }
    if(isDefined(ent.script_exploder))
      setup_individual_exploder(ent);
  }

  addinitexploders(getEntArray("script_brushmodel", "classname"));
  addinitexploders(getEntArray("script_model", "classname"));
  addinitexploders(level._id_AFB53D6348C4FC39);
  level._id_AFB53D6348C4FC39 = undefined;

  if(!isDefined(level.createfxent))
    level.createfxent = [];

  _id_C3C643C725497308 = [];
  _id_C3C643C725497308["exploderchunk visible"] = 1;
  _id_C3C643C725497308["exploderchunk"] = 1;
  _id_C3C643C725497308["exploder"] = 1;

  foreach(exploder in level.init_exploders) {
    ent = scripts\engine\utility::createexploder(exploder.script_fxid, 1);
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
    ent.v["area_swap_index"] = exploder._id_70FC63EF46137E97;
    ent.v["area_swap_state"] = exploder._id_6D7DC2BCFC863AD2;

    if(!isDefined(ent.v["angles"]))
      ent.v["angles"] = (0, 0, 0);

    ent scripts\common\createfx::set_forward_and_up_vectors();

    if(!isDefined(exploder.script_fxid))
      ent.v["fxid"] = "No FX";
    else
      ent.v["fxid"] = exploder.script_fxid;

    ent.v["exploder"] = exploder.script_exploder;

    if(!isDefined(ent.v["delay"]))
      ent.v["delay"] = 0;

    if(isDefined(exploder.target)) {
      _id_29F6EA7F6BDA85D9 = getEntArray(ent.v["target"], "targetname")[0];

      if(isDefined(_id_29F6EA7F6BDA85D9)) {
        org = _id_29F6EA7F6BDA85D9.origin;
        ent.v["angles"] = vectortoangles(org - ent.v["origin"]);
      } else {
        _id_29F6EA7F6BDA85D9 = scripts\engine\utility::get_target_ent(ent.v["target"]);

        if(isDefined(_id_29F6EA7F6BDA85D9)) {
          org = _id_29F6EA7F6BDA85D9.origin;
          ent.v["angles"] = vectortoangles(org - ent.v["origin"]);
        }
      }
    }

    if(isstruct(exploder)) {
      ent.model = exploder;

      if(isDefined(ent.model.script_modelname))
        precachemodel(ent.model.script_modelname);
    } else if(exploder.code_classname == "script_brushmodel" || isDefined(exploder.model)) {
      ent.model = exploder;
      ent.model.disconnect_paths = exploder.script_disconnectpaths;
    }

    if(isDefined(exploder.targetname) && isDefined(_id_C3C643C725497308[exploder.targetname]))
      ent.v["exploder_type"] = exploder.targetname;
    else
      ent.v["exploder_type"] = "normal";

    if(isDefined(exploder.masked_exploder)) {
      ent.v["masked_exploder"] = exploder.model;
      ent.v["masked_exploder_spawnflags"] = exploder.spawnflags;
      ent.v["masked_exploder_script_disconnectpaths"] = exploder.script_disconnectpaths;
      exploder delete();
    }

    ent scripts\common\createfx::post_entity_creation_function();
    _id_8927E0F5F68E6073 = ent.v["exploder"];

    if(!isDefined(level.exploders[_id_8927E0F5F68E6073]))
      level.exploders[_id_8927E0F5F68E6073] = [];

    level.exploders[_id_8927E0F5F68E6073][level.exploders[_id_8927E0F5F68E6073].size] = ent;
  }

  level.init_exploders = undefined;
}

exploder_flag_wait(msg, _id_E2A3F554E65A5CED) {
  if(!scripts\engine\utility::flag_exist(msg))
    scripts\engine\utility::flag_init(msg);

  scripts\engine\utility::flag_wait(msg);

  foreach(_id_14285E61FB120C7F in _id_E2A3F554E65A5CED) {
    foreach(ent in level.createfxexploders[_id_14285E61FB120C7F])
    ent scripts\engine\utility::activate_individual_exploder();
  }
}

exploder_is_damaged_model(ent) {
  return isDefined(ent.targetname) && ent.targetname == "exploder";
}

exploder_starts_hidden(ent) {
  return ent.model == "fx" && (!isDefined(ent.targetname) || ent.targetname != "exploderchunk");
}

exploder_is_chunk(ent) {
  return isDefined(ent.targetname) && ent.targetname == "exploderchunk";
}

show_exploder_models_proc(num) {
  num = num + "";
  exploders = get_exploders();

  if(isDefined(exploders)) {
    foreach(ent in exploders) {
      if(isstruct(ent.model)) {
        continue;
      }
      if(!exploder_starts_hidden(ent.model) && !exploder_is_damaged_model(ent.model) && !exploder_is_chunk(ent.model))
        ent.model show();

      if(isDefined(ent.brush_shown))
        ent.model show();
    }
  }
}

get_exploders(str) {
  exploders = [];

  if(level.createfx_enabled)
    exploders = get_createfx_exploders(str);
  else if(isDefined(level.createfxexploders[str]))
    exploders = level.createfxexploders[str];

  if(isDefined(level.exploders[str])) {
    foreach(exploder in level.exploders[str])
    exploders[exploders.size] = exploder;
  }

  return exploders;
}

get_createfx_exploders(str) {}

stop_exploder_proc(num, players, _id_4DEA0FF931DAA8BD) {
  num = num + "";
  _id_1C5E2F2D32A97F95 = 0;
  exploders = get_exploders(num);

  if(isDefined(exploders)) {
    foreach(ent in exploders) {
      if(!isDefined(ent.looper)) {
        continue;
      }
      if(isDefined(ent.loopsound_ent)) {
        ent.loopsound_ent stoploopsound();
        ent.loopsound_ent delete();
      }

      ent.looper delete();
      _id_1C5E2F2D32A97F95 = 1;
    }
  }

  if(!shouldrunserversideeffects() && (havemapentseffects() || !_id_1C5E2F2D32A97F95))
    stop_clientside_exploder(num, players, _id_4DEA0FF931DAA8BD);
}

stop_clientside_exploder(_id_8927E0F5F68E6073, players, _id_4DEA0FF931DAA8BD) {
  if(havemapentseffects()) {
    stopclientexploder(_id_8927E0F5F68E6073, players, _id_4DEA0FF931DAA8BD);
    return;
  }

  if(!is_valid_clientside_exploder_name(_id_8927E0F5F68E6073)) {
    return;
  }
  _id_D3173D85D3828C1B = int(_id_8927E0F5F68E6073);
  stopclientexploder(_id_D3173D85D3828C1B, players, _id_4DEA0FF931DAA8BD);
}

get_exploder_array_proc(msg) {
  msg = msg + "";
  array = [];
  exploders = get_exploders(msg);

  if(isDefined(exploders))
    array = exploders;

  return array;
}

hide_exploder_models_proc(num) {
  num = num + "";
  exploders = get_exploders(num);

  if(isDefined(exploders)) {
    foreach(ent in exploders) {
      if(isstruct(ent.model)) {
        continue;
      }
      if(isDefined(ent.model))
        ent.model hide();
    }
  }
}

delete_exploder_proc(num) {
  num = num + "";
  exploders = get_exploders(num);

  if(isDefined(exploders)) {
    foreach(ent in exploders) {
      if(isstruct(ent.model)) {
        continue;
      }
      if(isDefined(ent.model))
        ent.model delete();
    }
  }

  level notify("killexplodertridgers" + num);
}

exploder_damage() {
  if(isDefined(self.v["delay"]))
    delay = self.v["delay"];
  else
    delay = 0;

  if(isDefined(self.v["damage_radius"]))
    radius = self.v["damage_radius"];
  else
    radius = 128;

  damage = self.v["damage"];
  origin = self.v["origin"];

  if(isDefined(self.v["envonly"]))
    _id_73928F1475549032 = self.v["envonly"];
  else
    _id_73928F1475549032 = 0;

  if(isDefined(self.v["dotraces"]))
    _id_7004F6C6F1534D8E = self.v["dotraces"];
  else
    _id_7004F6C6F1534D8E = 1;

  wait(delay);
  radiusdamage(origin, radius, damage, damage, undefined, "MOD_EXPLOSIVE", undefined, _id_73928F1475549032, _id_7004F6C6F1534D8E);
}

activate_individual_exploder_proc() {
  if(isDefined(self.v["firefx"]))
    thread fire_effect();

  if(isDefined(self.v["fxid"]) && self.v["fxid"] != "No FX")
    thread cannon_effect();
  else if(isDefined(self.v["soundalias"]) && self.v["soundalias"] != "nil")
    thread sound_effect();

  if(isDefined(self.v["loopsound"]) && self.v["loopsound"] != "nil")
    thread effect_loopsound();

  if(isDefined(self.v["damage"]))
    thread exploder_damage();

  if(isDefined(self.v["earthquake"]))
    thread exploder_earthquake();

  if(isDefined(self.v["rumble"]))
    thread exploder_rumble();

  if(self.v["exploder_type"] == "exploder")
    thread brush_show();
  else if(self.v["exploder_type"] == "exploderchunk" || self.v["exploder_type"] == "exploderchunk visible")
    thread brush_throw();
  else
    thread brush_delete();
}

brush_delete() {
  num = self.v["exploder"];

  if(isDefined(self.v["delay"]))
    wait(self.v["delay"]);
  else
    waitframe();

  if(!isDefined(self.model)) {
    return;
  }
  if(isstruct(self.model)) {
    return;
  }
  if(scripts\common\utility::issp() && isDefined(self.model.classname)) {
    if(self.model.spawnflags & 1)
      self.model call[[level.func["connectPaths"]]]();
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

  if(!isDefined(self.v["fxid"]) || self.v["fxid"] == "No FX")
    self.v["exploder"] = undefined;

  waittillframeend;
  self.model delete();
}

brush_throw() {
  if(isDefined(self.v["delay"]))
    wait(self.v["delay"]);

  ent = undefined;

  if(isDefined(self.v["target"]))
    ent = scripts\engine\utility::get_target_ent(self.v["target"]);

  if(!isDefined(ent)) {
    self.model delete();
    return;
  }

  self.model show();

  if(isDefined(self.v["delay_post"]))
    wait(self.v["delay_post"]);

  _id_D917428537562C1F = self.v["origin"];
  startang = self.v["angles"];
  org = ent.origin;
  _id_F62283F85095D8B6 = isDefined(self.v["physics"]);

  if(_id_F62283F85095D8B6) {
    target = undefined;

    if(isDefined(ent.target))
      target = ent scripts\engine\utility::get_target_ent();

    if(isDefined(target)) {
      _id_397ED46FFCB0452E = ent.origin;
      _id_ED4645685B897766 = vectorNormalize(target.origin - ent.origin);
    } else {
      _id_397ED46FFCB0452E = self.model.origin;
      _id_ED4645685B897766 = vectorNormalize(org - self.model.origin);
    }

    _id_ED4645685B897766 = _id_ED4645685B897766 * self.v["physics"];
    self.model physicslaunchserver(_id_397ED46FFCB0452E, _id_ED4645685B897766);
    return;
  } else {
    _id_ED4645685B897766 = org - self.model.origin;
    self.model rotatevelocity(_id_ED4645685B897766, 12);
    self.model movegravity(_id_ED4645685B897766, 12);
  }

  if(level.createfx_enabled) {
    if(isDefined(self.exploded)) {
      return;
    }
    self.exploded = 1;
    wait 3;
    self.exploded = undefined;
    self.v["origin"] = _id_D917428537562C1F;
    self.v["angles"] = startang;
    self.model hide();
    return;
  }

  self.v["exploder"] = undefined;
  wait 6;
  self.model delete();
}

brush_show() {
  if(isDefined(self.v["delay"]))
    wait(self.v["delay"]);

  _id_1E8E886B6825DF9F = 0;
  _id_64C6A44C81DF86C1 = undefined;

  if(!isDefined(self.model.script_modelname)) {
    self.model show();
    self.model solid();
  } else {
    _id_1E8E886B6825DF9F = 1;
    _id_64C6A44C81DF86C1 = spawn("script_model", self.model.origin);
    _id_64C6A44C81DF86C1.angles = self.model.angles;
    _id_64C6A44C81DF86C1 setModel(self.model.script_modelname);

    if(isDefined(self.model.script_linkname))
      _id_64C6A44C81DF86C1.script_linkname = self.model.script_linkname;
  }

  self.brush_shown = 1;

  if(!_id_1E8E886B6825DF9F && scripts\common\utility::issp() && self.model.spawnflags & 1) {
    if(!isDefined(self.model.disconnect_paths))
      self.model call[[level.func["connectPaths"]]]();
    else
      self.model call[[level.func["disconnectPaths"]]]();
  }

  if(level.createfx_enabled) {
    if(isDefined(self.exploded)) {
      return;
    }
    self.exploded = 1;
    wait 3;
    self.exploded = undefined;

    if(!_id_1E8E886B6825DF9F) {
      self.model hide();
      self.model notsolid();
    } else
      _id_64C6A44C81DF86C1 delete();
  }
}

exploder_rumble() {
  if(!scripts\common\utility::issp()) {
    return;
  }
  exploder_delay();
  level.player playRumbleOnEntity(self.v["rumble"]);
}

exploder_delay() {
  if(!isDefined(self.v["delay"]))
    self.v["delay"] = 0;

  min_delay = self.v["delay"];
  max_delay = self.v["delay"] + 0.001;

  if(isDefined(self.v["delay_min"]))
    min_delay = self.v["delay_min"];

  if(isDefined(self.v["delay_max"]))
    max_delay = self.v["delay_max"];

  if(min_delay > 0)
    wait(randomfloatrange(min_delay, max_delay));
}

effect_loopsound() {
  if(isDefined(self.loopsound_ent)) {
    self.loopsound_ent stoploopsound();
    self.loopsound_ent delete();
  }

  origin = self.v["origin"];
  alias = self.v["loopsound"];
  exploder_delay();
  self.loopsound_ent = scripts\engine\utility::play_loopsound_in_space(alias, origin);
}

sound_effect() {
  effect_soundalias();
}

effect_soundalias() {
  origin = self.v["origin"];
  alias = self.v["soundalias"];
  exploder_delay();
  scripts\engine\utility::play_sound_in_space(alias, origin);
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
  forward = self.v["forward"];
  up = self.v["up"];
  org = undefined;
  _id_27F0CE069C761562 = self.v["firefxsound"];
  origin = self.v["origin"];
  _id_04DC3FEC57663543 = self.v["firefx"];
  ender = self.v["ender"];

  if(!isDefined(ender))
    ender = "createfx_effectStopper";

  _id_E2C5D47CEAC37D32 = 0.5;

  if(isDefined(self.v["firefxdelay"]))
    _id_E2C5D47CEAC37D32 = self.v["firefxdelay"];

  exploder_delay();

  if(isDefined(_id_27F0CE069C761562))
    scripts\engine\utility::loop_fx_sound(_id_27F0CE069C761562, origin, 1, ender);

  playFX(level._effect[_id_04DC3FEC57663543], self.v["origin"], forward, up);
}

cannon_effect() {
  if(isDefined(self.v["repeat"])) {
    thread exploder_playSound();

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.v["repeat"]; _id_AC0E594AC96AA3A8++) {
      playFX(level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"]);
      exploder_delay();
    }

    return;
  }

  exploder_delay();

  if(isDefined(self.looper))
    self.looper delete();

  self.looper = spawnfx(scripts\engine\utility::getfx(self.v["fxid"]), self.v["origin"], self.v["forward"], self.v["up"]);
  triggerfx(self.looper);
  exploder_playSound();
}

activate_exploder(num, players, starttime) {
  num = num + "";
  level notify("exploding_" + num);
  _id_1C5E2F2D32A97F95 = 0;
  exploders = get_exploders(num);

  if(isDefined(exploders)) {
    foreach(ent in exploders) {
      ent scripts\engine\utility::activate_individual_exploder();
      _id_1C5E2F2D32A97F95 = 1;
    }
  }

  if(!shouldrunserversideeffects() && (havemapentseffects() || !_id_1C5E2F2D32A97F95))
    activate_clientside_exploder(num, players, starttime);
}

activate_clientside_exploder(_id_8927E0F5F68E6073, players, starttime) {
  if(havemapentseffects()) {
    activateclientexploder(_id_8927E0F5F68E6073, players, starttime);
    return;
  }

  if(!is_valid_clientside_exploder_name(_id_8927E0F5F68E6073)) {
    return;
  }
  _id_D3173D85D3828C1B = int(_id_8927E0F5F68E6073);
  activateclientexploder(_id_D3173D85D3828C1B, players, starttime);
}

is_valid_clientside_exploder_name(_id_8927E0F5F68E6073) {
  if(!isDefined(_id_8927E0F5F68E6073))
    return 0;

  _id_D3173D85D3828C1B = _id_8927E0F5F68E6073;

  if(isstring(_id_8927E0F5F68E6073)) {
    _id_D3173D85D3828C1B = int(_id_8927E0F5F68E6073);

    if(_id_D3173D85D3828C1B == 0 && _id_8927E0F5F68E6073 != "0")
      return 0;
  }

  return _id_D3173D85D3828C1B >= 0;
}

shouldrunserversideeffects() {
  if(scripts\common\utility::issp() && !havemapentseffects())
    return 1;

  if(!isDefined(level.createfx_enabled))
    scripts\engine\utility::set_createfx_enabled();

  if(level.createfx_enabled)
    return 1;
  else
    return getDvar("clientSideEffects") != "1";
}

exploder_before_load(num, players, starttime) {
  waittillframeend;
  waittillframeend;
  activate_exploder(num, players, starttime);
}

exploder_after_load(num, players, starttime) {
  activate_exploder(num, players, starttime);
}