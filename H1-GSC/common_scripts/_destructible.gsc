/********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: common_scripts\_destructible.gsc
********************************************/

init() {
  level.destructiblespawnedentslimit = 50;
  level.destructiblespawnedents = [];
  find_destructibles();
}

destructible_create(var_0, var_1, var_2, var_3, var_4) {
  if(!isdefined(level.destructible_type))
    level.destructible_type = [];

  var_5 = level.destructible_type.size;
  var_5 = level.destructible_type.size;
  level.destructible_type[var_5] = spawnstruct();
  level.destructible_type[var_5].v["type"] = var_0;
  level.destructible_type[var_5].parts = [];
  level.destructible_type[var_5].parts[0][0] = spawnstruct();
  level.destructible_type[var_5].parts[0][0].v["modelName"] = self.model;
  level.destructible_type[var_5].parts[0][0].v["health"] = var_1;
  level.destructible_type[var_5].parts[0][0].v["validAttackers"] = var_2;
  level.destructible_type[var_5].parts[0][0].v["validDamageZone"] = var_3;
  level.destructible_type[var_5].parts[0][0].v["validDamageCause"] = var_4;
  level.destructible_type[var_5].parts[0][0].v["godModeAllowed"] = 1;
}

destructible_part(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = level.destructible_type.size - 1;
  var_11 = level.destructible_type[var_10].parts.size;
  var_12 = 0;
  destructible_info(var_11, var_12, var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

destructible_state(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = level.destructible_type.size - 1;
  var_8 = level.destructible_type[var_7].parts.size - 1;
  var_9 = level.destructible_type[var_7].parts[var_8].size;
  destructible_info(var_8, var_9, var_0, var_1, var_2, var_3, var_4, var_5, undefined, undefined, var_6);
}

destructible_fx(var_0, var_1, var_2) {
  var_1 = try_override_destructible_fx(var_1);

  if(!isdefined(var_2))
    var_2 = 1;

  var_3 = level.destructible_type.size - 1;
  var_4 = level.destructible_type[var_3].parts.size - 1;
  var_5 = level.destructible_type[var_3].parts[var_4].size - 1;
  level.destructible_type[var_3].parts[var_4][var_5].v["fx_filename"] = var_1;
  level.destructible_type[var_3].parts[var_4][var_5].v["fx_tag"] = var_0;
  level.destructible_type[var_3].parts[var_4][var_5].v["fx_useTagAngles"] = var_2;
}

destructible_loopfx(var_0, var_1, var_2) {
  var_1 = try_override_destructible_fx(var_1);
  var_3 = level.destructible_type.size - 1;
  var_4 = level.destructible_type[var_3].parts.size - 1;
  var_5 = level.destructible_type[var_3].parts[var_4].size - 1;
  level.destructible_type[var_3].parts[var_4][var_5].v["loopfx_filename"] = var_1;
  level.destructible_type[var_3].parts[var_4][var_5].v["loopfx_tag"] = var_0;
  level.destructible_type[var_3].parts[var_4][var_5].v["loopfx_rate"] = var_2;
}

try_override_destructible_fx(var_0) {
  if(!isdefined(level.destructible_effect_override))
    return var_0;

  var_1 = getarraykeys(level.destructible_effect_override);

  foreach(var_3 in var_1) {
    if(var_3 == var_0)
      return level.destructible_effect_override[var_3];
  }

  return var_0;
}

destructible_healthdrain(var_0, var_1, var_2, var_3) {
  var_4 = level.destructible_type.size - 1;
  var_5 = level.destructible_type[var_4].parts.size - 1;
  var_6 = level.destructible_type[var_4].parts[var_5].size - 1;
  level.destructible_type[var_4].parts[var_5][var_6].v["healthdrain_amount"] = var_0;
  level.destructible_type[var_4].parts[var_5][var_6].v["healthdrain_interval"] = var_1;
  level.destructible_type[var_4].parts[var_5][var_6].v["badplace_radius"] = var_2;
  level.destructible_type[var_4].parts[var_5][var_6].v["badplace_team"] = var_3;
}

destructible_sound(var_0, var_1) {
  var_2 = level.destructible_type.size - 1;
  var_3 = level.destructible_type[var_2].parts.size - 1;
  var_4 = level.destructible_type[var_2].parts[var_3].size - 1;

  if(!isdefined(level.destructible_type[var_2].parts[var_3][var_4].v["sound"])) {
    level.destructible_type[var_2].parts[var_3][var_4].v["sound"] = [];
    level.destructible_type[var_2].parts[var_3][var_4].v["soundCause"] = [];
  }

  var_5 = level.destructible_type[var_2].parts[var_3][var_4].v["sound"].size;
  level.destructible_type[var_2].parts[var_3][var_4].v["sound"][var_5] = var_0;
  level.destructible_type[var_2].parts[var_3][var_4].v["soundCause"][var_5] = var_1;
}

destructible_loopsound(var_0, var_1) {
  var_2 = level.destructible_type.size - 1;
  var_3 = level.destructible_type[var_2].parts.size - 1;
  var_4 = level.destructible_type[var_2].parts[var_3].size - 1;

  if(!isdefined(level.destructible_type[var_2].parts[var_3][var_4].v["loopsound"])) {
    level.destructible_type[var_2].parts[var_3][var_4].v["loopsound"] = [];
    level.destructible_type[var_2].parts[var_3][var_4].v["loopsoundCause"] = [];
  }

  var_5 = level.destructible_type[var_2].parts[var_3][var_4].v["loopsound"].size;
  level.destructible_type[var_2].parts[var_3][var_4].v["loopsound"][var_5] = var_0;
  level.destructible_type[var_2].parts[var_3][var_4].v["loopsoundCause"][var_5] = var_1;
}

destructible_anim(var_0, var_1, var_2, var_3) {
  var_4 = level.destructible_type.size - 1;
  var_5 = level.destructible_type[var_4].parts.size - 1;
  var_6 = level.destructible_type[var_4].parts[var_5].size - 1;

  if(!isdefined(var_3)) {
    level.destructible_type[var_4].parts[var_5][var_6].v["anim"] = var_0;
    level.destructible_type[var_4].parts[var_5][var_6].v["animTree"] = var_1;
    level.destructible_type[var_4].parts[var_5][var_6].v["animType"] = var_2;
  } else {
    level.destructible_type[var_4].parts[var_5][var_6].v["partAnim"] = var_0;
    level.destructible_type[var_4].parts[var_5][var_6].v["partAnimTree"] = var_1;
    level.destructible_type[var_4].parts[var_5][var_6].v["partAnimType"] = var_2;
  }
}

destructible_physics() {
  var_0 = level.destructible_type.size - 1;
  var_1 = level.destructible_type[var_0].parts.size - 1;
  var_2 = level.destructible_type[var_0].parts[var_1].size - 1;
  level.destructible_type[var_0].parts[var_1][var_2].v["physics"] = 1;
}

destructible_explode(var_0, var_1, var_2, var_3, var_4) {
  var_5 = level.destructible_type.size - 1;
  var_6 = level.destructible_type[var_5].parts.size - 1;
  var_7 = level.destructible_type[var_5].parts[var_6].size - 1;
  level.destructible_type[var_5].parts[var_6][var_7].v["explode_force_min"] = var_0;
  level.destructible_type[var_5].parts[var_6][var_7].v["explode_force_max"] = var_1;
  level.destructible_type[var_5].parts[var_6][var_7].v["explode_range"] = var_2;
  level.destructible_type[var_5].parts[var_6][var_7].v["explode_mindamage"] = var_3;
  level.destructible_type[var_5].parts[var_6][var_7].v["explode_maxdamage"] = var_4;
}

destructible_info(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = level.destructible_type.size - 1;
  level.destructible_type[var_12].parts[var_0][var_1] = spawnstruct();
  level.destructible_type[var_12].parts[var_0][var_1].v["modelName"] = var_3;
  level.destructible_type[var_12].parts[var_0][var_1].v["tagName"] = var_2;
  level.destructible_type[var_12].parts[var_0][var_1].v["health"] = var_4;
  level.destructible_type[var_12].parts[var_0][var_1].v["validAttackers"] = var_5;
  level.destructible_type[var_12].parts[var_0][var_1].v["validDamageZone"] = var_6;
  level.destructible_type[var_12].parts[var_0][var_1].v["validDamageCause"] = var_7;
  level.destructible_type[var_12].parts[var_0][var_1].v["alsoDamageParent"] = var_8;
  level.destructible_type[var_12].parts[var_0][var_1].v["physicsOnExplosion"] = var_9;
  level.destructible_type[var_12].parts[var_0][var_1].v["grenadeImpactDeath"] = var_10;
  level.destructible_type[var_12].parts[var_0][var_1].v["godModeAllowed"] = 0;

  if(!isdefined(var_11))
    level.destructible_type[var_12].parts[var_0][var_1].v["createEntityForAnimation"] = 0;
  else
    level.destructible_type[var_12].parts[var_0][var_1].v["createEntityForAnimation"] = var_11;
}

find_destructibles() {
  common_scripts\utility::array_thread(getentarray("destructible", "targetname"), ::setup_destructibles);
}

precache_destructibles() {
  if(isdefined(level.destructible_type[self.destuctableinfo].parts)) {
    for (var_0 = 0; var_0 < level.destructible_type[self.destuctableinfo].parts.size; var_0++) {
      for (var_1 = 0; var_1 < level.destructible_type[self.destuctableinfo].parts[var_0].size; var_1++) {
        if(level.destructible_type[self.destuctableinfo].parts[var_0].size <= var_1) {
          continue;
        }
        if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_0][var_1].v["modelName"]))
          precachemodel(level.destructible_type[self.destuctableinfo].parts[var_0][var_1].v["modelName"]);

        if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_0][var_1].v["fx_filename"]))
          level.destructible_type[self.destuctableinfo].parts[var_0][var_1].v["fx"] = loadfx(level.destructible_type[self.destuctableinfo].parts[var_0][var_1].v["fx_filename"]);

        if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_0][var_1].v["loopfx_filename"]))
          level.destructible_type[self.destuctableinfo].parts[var_0][var_1].v["loopfx"] = loadfx(level.destructible_type[self.destuctableinfo].parts[var_0][var_1].v["loopfx_filename"]);
      }
    }
  }
}

setup_destructibles(var_0) {
  if(!isdefined(var_0))
    var_0 = 0;

  var_1 = undefined;
  self.modeldummyon = 0;
  add_damage_owner_recorder();
  self.destuctableinfo = common_scripts\_destructible_types::maketype(self.destructible_type);

  if(!var_0)
    precache_destructibles();

  if(isdefined(level.destructible_type[self.destuctableinfo].parts)) {
    self.destructible_parts = [];

    for (var_2 = 0; var_2 < level.destructible_type[self.destuctableinfo].parts.size; var_2++) {
      self.destructible_parts[var_2] = spawnstruct();
      self.destructible_parts[var_2].v["currentState"] = 0;

      if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_2][0].v["health"]))
        self.destructible_parts[var_2].v["health"] = level.destructible_type[self.destuctableinfo].parts[var_2][0].v["health"];

      if(var_2 == 0) {
        continue;
      }
      var_3 = level.destructible_type[self.destuctableinfo].parts[var_2][0].v["modelName"];
      var_4 = level.destructible_type[self.destuctableinfo].parts[var_2][0].v["tagName"];
      self attach(var_3, var_4);

      if(self.modeldummyon)
        self.modeldummy attach(var_3, var_4);
    }
  }

  if(self.classname != "script_vehicle")
    self setcandamage(1);

  thread setup_destructible_entities();
  thread connecttraverses();
  thread destructible_think();
}

add_damage_owner_recorder() {
  self.player_damage = 0;
  self.non_player_damage = 0;
  self.car_damage_owner_recorder = 1;
}

destructible_think() {
  self endon("stop_taking_damage");

  for (;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6);

    if(!isdefined(var_0)) {
      continue;
    }
    if(var_0 <= 0) {
      continue;
    }
    var_4 = getdamagetype(var_4);

    if(var_5 == "")
      var_5 = self.model;

    if(isdefined(var_6) && var_6 == "")
      var_6 = undefined;

    if(var_4 == "splash") {
      destructible_splash_damage(int(var_0), var_3, var_2, var_1, var_4);
      continue;
    }

    thread destructible_update_part(int(var_0), var_5, var_6, var_3, var_2, var_1, var_4);
  }
}

destructible_update_part(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isdefined(self.destructible_parts)) {
    return;
  }
  if(self.destructible_parts.size == 0) {
    return;
  }
  var_7 = -1;
  var_8 = -1;

  if(tolower(var_1) == tolower(self.model) && !isdefined(var_2)) {
    var_1 = self.model;
    var_2 = undefined;
    var_7 = 0;
    var_8 = 0;
  }

  for (var_9 = 0; var_9 < level.destructible_type[self.destuctableinfo].parts.size; var_9++) {
    var_8 = self.destructible_parts[var_9].v["currentState"];

    if(level.destructible_type[self.destuctableinfo].parts[var_9].size <= var_8) {
      continue;
    }
    if(!isdefined(level.destructible_type[self.destuctableinfo].parts[var_9][var_8].v["modelName"])) {
      continue;
    }
    if(tolower(level.destructible_type[self.destuctableinfo].parts[var_9][var_8].v["modelName"]) == tolower(var_1)) {
      if(level.destructible_type[self.destuctableinfo].parts[var_9][var_8].v["tagName"] == var_2) {
        var_7 = var_9;
        break;
      }
    }
  }

  if(var_7 < 0) {
    return;
  }
  var_10 = var_8;
  var_11 = 0;
  var_12 = 0;

  for (;;) {
    var_8 = self.destructible_parts[var_7].v["currentState"];

    if(!isdefined(level.destructible_type[self.destuctableinfo].parts[var_7][var_8])) {
      break;
    }

    if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_7][0].v["alsoDamageParent"])) {
      if(getdamagetype(var_6) != "splash") {
        var_13 = level.destructible_type[self.destuctableinfo].parts[var_7][0].v["alsoDamageParent"];
        var_14 = int(var_0 * var_13);
        thread notifydamageafterframe(var_14, var_5, var_4, var_3, var_6, "", "");
      }
    }

    if(!isdefined(level.destructible_type[self.destuctableinfo].parts[var_7][var_8].v["health"])) {
      break;
    }

    if(!isdefined(self.destructible_parts[var_7].v["health"])) {
      break;
    }

    if(var_11)
      self.destructible_parts[var_7].v["health"] = level.destructible_type[self.destuctableinfo].parts[var_7][var_8].v["health"];

    var_11 = 0;

    if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_7][var_8].v["grenadeImpactDeath"]) && var_6 == "impact")
      var_0 = 100000000;

    var_15 = isattackervalid(var_7, var_8, var_5);

    if(var_15) {
      var_16 = isvaliddamagecause(var_7, var_8, var_6);

      if(var_16) {
        if(var_5 == level.player)
          self.player_damage = self.player_damage + var_0;
        else if(var_5 != self)
          self.non_player_damage = self.non_player_damage + var_0;

        self.destructible_parts[var_7].v["health"] = self.destructible_parts[var_7].v["health"] - var_0;
      }
    }

    if(self.destructible_parts[var_7].v["health"] > 0) {
      return;
    }
    var_0 = int(abs(self.destructible_parts[var_7].v["health"]));

    if(var_0 < 0) {
      return;
    }
    self.destructible_parts[var_7].v["currentState"]++;
    var_8 = self.destructible_parts[var_7].v["currentState"];
    var_17 = var_8 - 1;

    if(!isdefined(level.destructible_type[self.destuctableinfo].parts[var_7][var_17])) {
      return;
    }
    if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["explode_force_min"]))
      self.exploding = 1;

    if(isdefined(self.loopingsoundstopnotifies) && isdefined(self.loopingsoundstopnotifies[maps\_utility::string(var_7)])) {
      for (var_9 = 0; var_9 < self.loopingsoundstopnotifies[maps\_utility::string(var_7)].size; var_9++) {
        self notify(self.loopingsoundstopnotifies[maps\_utility::string(var_7)][var_9]);

        if(self.modeldummyon)
          self.modeldummy notify(self.loopingsoundstopnotifies[maps\_utility::string(var_7)][var_9]);
      }

      self.loopingsoundstopnotifies[maps\_utility::string(var_7)] = undefined;
    }

    if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_7][var_8])) {
      if(var_7 == 0) {
        var_18 = level.destructible_type[self.destuctableinfo].parts[var_7][var_8].v["modelName"];
        self setmodel(var_18);

        if(self.modeldummyon)
          self.modeldummy setmodel(var_18);
      } else {
        self detach(var_1, var_2);

        if(self.modeldummyon)
          self.modeldummy detach(var_1, var_2);

        var_1 = level.destructible_type[self.destuctableinfo].parts[var_7][var_8].v["modelName"];
        var_2 = level.destructible_type[self.destuctableinfo].parts[var_7][var_8].v["tagName"];

        if(isdefined(var_1) && isdefined(var_2)) {
          if(self.modeldummyon)
            self.modeldummy attach(var_1, var_2);

          self attach(var_1, var_2);
        }
      }
    }

    var_19 = get_dummy();

    if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["fx"])) {
      var_20 = level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["fx"];

      if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["fx_tag"])) {
        var_21 = level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["fx_tag"];
        self notify("FX_State_Change" + var_7);

        if(level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["fx_useTagAngles"]) {
          if(delayvfxonmultipleframes(var_19)) {
            if(!isdefined(self.playingfxpartscount))
              self.playingfxpartscount = 0;

            if(self.playingfxpartscount < 3)
              destructible_playfxontag_internal(var_20, var_19, var_21);
            else {
              while (self.playingfxpartscount >= 3)
                wait 0.05;

              destructible_playfxontag_internal(var_20, var_19, var_21);
            }
          } else
            playfxontag(var_20, var_19, var_21);
        } else {
          var_22 = var_19 gettagorigin(var_21);
          var_23 = var_22 + (0, 0, 100) - var_22;
          playfx(var_20, var_22, var_23);
        }
      } else {
        var_22 = var_19.origin;
        var_23 = var_22 + (0, 0, 100) - var_22;
        playfx(var_20, var_22, var_23);
      }
    }

    if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["loopfx"])) {
      var_24 = level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["loopfx"];
      var_25 = level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["loopfx_tag"];
      var_26 = level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["loopfx_rate"];
      self notify("FX_State_Change" + var_7);
      thread loopfx_ontag(var_24, var_25, var_26, var_7);
    }

    if(!isdefined(self.exploded)) {
      if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["anim"])) {
        var_27 = level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["anim"];
        var_28 = level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["animTree"];
        var_19 useanimtree(var_28);
        var_29 = level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["animType"];

        if(!isdefined(self.animsapplied))
          self.animsapplied = [];

        self.animsapplied[self.animsapplied.size] = var_27;

        if(isdefined(self.exploding)) {
          if(isdefined(self.animsapplied)) {
            for (var_9 = 0; var_9 < self.animsapplied.size; var_9++)
              var_19 clearanim(self.animsapplied[var_9], 0);
          }
        }

        if(var_29 == "setanim")
          var_19 setanim(var_27, 1.0, 1.0, 1.0);
        else if(var_29 == "setanimknob")
          var_19 setanimknob(var_27, 1.0, 1.0, 1.0);
        else {

        }
      }
    }

    if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["createEntityForAnimation"]) && level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["createEntityForAnimation"] && !isdefined(self.exploded)) {
      var_30 = createentity(var_7, var_17, self.destuctableinfo);

      if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["partAnim"])) {
        var_27 = level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["partAnim"];
        var_28 = level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["partAnimTree"];
        var_30 useanimtree(var_28);
        var_29 = level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["partAnimType"];

        if(!isdefined(self.animsapplied))
          self.animsapplied = [];

        self.animsapplied[self.animsapplied.size] = var_27;

        if(isdefined(self.exploding) && isdefined(self.animsapplied)) {
          for (var_9 = 0; var_9 < self.animsapplied.size; var_9++)
            var_30 clearanim(self.animsapplied[var_9], 0);
        }

        if(var_29 == "setanim")
          var_30 setanim(var_27, 1.0, 1.0, 1.0);
        else if(var_29 == "setanimknob")
          var_30 setanimknob(var_27, 1.0, 1.0, 1.0);
        else {

        }
      }
    }

    if(!isdefined(self.exploded)) {
      if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["sound"])) {
        for (var_9 = 0; var_9 < level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["sound"].size; var_9++) {
          var_31 = isvalidsoundcause("soundCause", var_7, var_17, var_9, var_6);

          if(var_31) {
            var_32 = level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["sound"][var_9];
            var_33 = level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["tagName"];
            var_19 thread maps\_utility::play_sound_on_tag(var_32, var_33);
          }
        }
      }
    }

    if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["loopsound"])) {
      for (var_9 = 0; var_9 < level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["loopsound"].size; var_9++) {
        var_31 = isvalidsoundcause("loopsoundCause", var_7, var_17, var_9, var_6);

        if(var_31) {
          var_34 = level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["loopsound"][var_9];
          var_35 = level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["tagName"];
          thread play_loop_sound_on_destructible(var_34, var_35);

          if(!isdefined(self.loopingsoundstopnotifies))
            self.loopingsoundstopnotifies = [];

          if(!isdefined(self.loopingsoundstopnotifies[maps\_utility::string(var_7)]))
            self.loopingsoundstopnotifies[maps\_utility::string(var_7)] = [];

          var_36 = self.loopingsoundstopnotifies[maps\_utility::string(var_7)].size;
          self.loopingsoundstopnotifies[maps\_utility::string(var_7)][var_36] = "stop sound" + var_34;
        }
      }
    }

    if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["healthdrain_amount"])) {
      self notify("Health_Drain_State_Change" + var_7);
      var_37 = level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["healthdrain_amount"];
      var_38 = level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["healthdrain_interval"];
      var_39 = level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["modelName"];
      var_40 = level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["tagName"];
      var_41 = level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["badplace_radius"];
      var_42 = level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["badplace_team"];

      if(var_37 > 0)
        thread health_drain(var_37, var_38, var_7, var_39, var_40, var_41, var_42);
    }

    if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["explode_force_min"])) {
      var_12 = 1;
      var_43 = level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["explode_force_min"];
      var_44 = level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["explode_force_max"];
      var_45 = level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["explode_range"];
      var_46 = level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["explode_mindamage"];
      var_47 = level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["explode_maxdamage"];

      if(isdefined(var_5) && var_5 != self)
        self.attacker = var_5;

      thread explode(var_7, var_43, var_44, var_45, var_46, var_47);
    }

    if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_7][var_17].v["physics"])) {
      var_48 = var_3;
      var_49 = (0, 0, 0);

      if(isdefined(var_5)) {
        var_49 = var_5.origin;

        if(var_5 == level.player)
          var_49 = level.player geteye();

        var_48 = vectornormalize(var_3 - var_49);
        var_48 = maps\_utility::vector_multiply(var_48, 200);
      }

      thread physics_launch(var_7, var_17, var_3, var_48);
      return;
    }

    var_11 = 1;
  }
}

delayvfxonmultipleframes(var_0) {
  return var_0.model == "vehicle_uaz_hardtop_dsr" && level.script == "icbm";
}

reduceplayingcount(var_0) {
  wait(var_0);
  self.playingfxpartscount--;
}

destructible_playfxontag_internal(var_0, var_1, var_2) {
  self.playingfxpartscount++;
  playfxontag(var_0, var_1, var_2);
  thread reduceplayingcount(0.05);
}

destructible_splash_damage(var_0, var_1, var_2, var_3, var_4) {
  if(var_0 <= 0) {
    return;
  }
  var_5 = [];
  var_6 = undefined;

  if(isdefined(level.destructible_type[self.destuctableinfo].parts)) {
    for (var_7 = 0; var_7 < level.destructible_type[self.destuctableinfo].parts.size; var_7++) {
      for (var_8 = 0; var_8 < level.destructible_type[self.destuctableinfo].parts[var_7].size; var_8++) {
        if(level.destructible_type[self.destuctableinfo].parts[var_7].size <= var_8) {
          continue;
        }
        if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_7][var_8].v["modelName"])) {
          var_9 = level.destructible_type[self.destuctableinfo].parts[var_7][var_8].v["modelName"];

          if(var_7 == 0) {
            var_10 = distance(var_1, self.origin);
            var_11 = undefined;
          } else {
            var_11 = level.destructible_type[self.destuctableinfo].parts[var_7][var_8].v["tagName"];
            var_10 = distance(var_1, self gettagorigin(var_11));
          }

          if(!isdefined(var_6) || var_10 < var_6)
            var_6 = var_10;

          var_12 = var_5.size;
          var_5[var_12] = spawnstruct();
          var_5[var_12].v["modelName"] = var_9;
          var_5[var_12].v["tagName"] = var_11;
          var_5[var_12].v["distance"] = var_10;
        }
      }
    }
  }

  if(!isdefined(var_6)) {
    return;
  }
  if(var_6 < 0) {
    return;
  }
  if(var_5.size <= 0) {
    return;
  }
  for (var_7 = 0; var_7 < var_5.size; var_7++) {
    var_13 = var_5[var_7].v["distance"] * 1.4;
    var_14 = var_0 - (var_13 - var_6);

    if(var_14 <= 0) {
      continue;
    }
    thread destructible_update_part(var_14, var_5[var_7].v["modelName"], var_5[var_7].v["tagName"], var_1, var_2, var_3, var_4);
  }
}

isvalidsoundcause(var_0, var_1, var_2, var_3, var_4) {
  var_5 = level.destructible_type[self.destuctableinfo].parts[var_1][var_2].v[var_0][var_3];

  if(!isdefined(var_5))
    return 1;

  if(var_5 == var_4)
    return 1;

  return 0;
}

isattackervalid(var_0, var_1, var_2) {
  if(isdefined(self.forceexploding))
    return 1;

  if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_0][var_1].v["explode_force_min"])) {
    if(isdefined(self.dontallowexplode))
      return 0;
  }

  if(!isdefined(var_2))
    return 1;

  if(var_2 == self)
    return 1;

  var_3 = level.destructible_type[self.destuctableinfo].parts[var_0][var_1].v["validAttackers"];

  if(!isdefined(var_3))
    return 1;

  if(var_3 == "no_player") {
    if(var_2 != level.player)
      return 1;
  } else if(var_3 == "player_only") {
    if(var_2 == level.player)
      return 1;
  } else if(var_3 == "no_ai") {
    if(!isai(var_2))
      return 1;
  } else if(var_3 == "ai_only") {
    if(isai(var_2))
      return 1;
  } else {}

  return 0;
}

isvaliddamagecause(var_0, var_1, var_2) {
  if(!isdefined(var_2))
    return 1;

  var_3 = level.destructible_type[self.destuctableinfo].parts[var_0][var_1].v["godModeAllowed"];

  if(var_3 && (isdefined(self.godmode) && self.godmode || isdefined(self.script_bulletshield) && self.script_bulletshield && var_2 == "bullet"))
    return 0;

  var_4 = level.destructible_type[self.destuctableinfo].parts[var_0][var_1].v["validDamageCause"];

  if(!isdefined(var_4))
    return 1;

  if(var_4 == "no_melee" && var_2 == "melee")
    return 0;

  return 1;
}

getdamagetype(var_0) {
  if(!isdefined(var_0))
    return "unknown";

  var_0 = tolower(var_0);

  switch (var_0) {
    case "mod_crush":
    case "mod_melee":
    case "melee":
      return "melee";
    case "bullet":
    case "mod_rifle_bullet":
    case "mod_pistol_bullet":
      return "bullet";
    case "splash":
    case "mod_explosive":
    case "mod_projectile_splash":
    case "mod_projectile":
    case "mod_grenade_splash":
    case "mod_grenade":
      return "splash";
    case "mod_impact":
      return "impact";
    case "unknown":
      return "unknown";
    default:
      return "unknown";
  }
}

loopfx_ontag(var_0, var_1, var_2, var_3) {
  var_4 = get_dummy();
  self endon("FX_State_Change" + var_3);
  self endon("delete_destructible");
  level endon("putout_fires");

  for (;;) {
    var_4 = get_dummy();
    playfxontag(var_0, var_4, var_1);
    wait(var_2);
  }
}

health_drain(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("Health_Drain_State_Change" + var_2);
  level endon("putout_fires");
  wait(var_1);
  self.healthdrain = 1;
  var_7 = undefined;

  if(isdefined(var_5) && isdefined(var_6)) {
    var_7 = "" + gettime();

    if(!isdefined(self.disablebadplace)) {
      if(var_6 == "both")
        badplace_cylinder(var_7, 0, self.origin, var_5, 128, "allies", "axis");
      else
        badplace_cylinder(var_7, 0, self.origin, var_5, 128, var_6);
    }
  }

  while (self.destructible_parts[var_2].v["health"] > 0) {
    self notify("damage", var_0, self, (0, 0, 0), (0, 0, 0), "MOD_UNKNOWN", var_3, var_4);
    wait(var_1);
  }

  if(isdefined(var_5) && isdefined(var_6))
    badplace_delete(var_7);
}

physics_launch(var_0, var_1, var_2, var_3) {
  var_4 = get_model_from_part(var_0, var_1);
  var_5 = get_last_model_from_part(var_0);
  var_6 = get_tag_from_part(var_0, var_1);

  if(!ismodelattached(var_4, var_6)) {
    return;
  }
  self detach(var_4, var_6);

  if(self.modeldummyon)
    self.modeldummy detach(var_4, var_6);

  if(level.destructiblespawnedents.size >= level.destructiblespawnedentslimit)
    physics_object_remove(level.destructiblespawnedents[0]);

  var_7 = spawn("script_model", self gettagorigin(var_6));
  var_7.angles = self gettagangles(var_6);
  var_7 setmodel(var_5);
  level.destructiblespawnedents[level.destructiblespawnedents.size] = var_7;
  var_7 physicslaunchclient(var_2, var_3);
}

physics_object_remove(var_0) {
  var_1 = [];

  for (var_2 = 0; var_2 < level.destructiblespawnedents.size; var_2++) {
    if(level.destructiblespawnedents[var_2] == var_0) {
      continue;
    }
    var_1[var_1.size] = level.destructiblespawnedents[var_2];
  }

  level.destructiblespawnedents = var_1;
  var_0 delete();
}

createentity(var_0, var_1, var_2) {
  var_3 = get_model_from_part(var_0, var_1);
  var_4 = get_last_model_from_part(var_0);
  var_5 = get_tag_from_part(var_0, var_1);

  if(!ismodelattached(var_3, var_5)) {
    return;
  }
  self detach(var_3, var_5);

  if(self.modeldummyon)
    self.modeldummy detach(var_3, var_5);

  var_6 = spawn("script_model", self gettagorigin(var_5));
  var_6.angles = self gettagangles(var_5);
  var_6 setmodel(var_4);
  var_6 linkto(self);

  if(!isdefined(self.partsspawnedents))
    self.partsspawnedents = [];

  self.partsspawnedents[self.partsspawnedents.size] = var_6;
  return var_6;
}

explode(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isdefined(self.exploded)) {
    return;
  }
  self.exploded = 1;

  if(self.classname == "script_vehicle" || self.code_classname == "script_vehicle")
    self notify("death");

  thread disconnecttraverses();
  thread destroy_destructible_entities();
  wait 0.05;
  var_6 = level.destructible_type[self.destuctableinfo].parts[var_0][self.destructible_parts[var_0].v["currentState"]].v["tagName"];

  if(isdefined(var_6))
    var_7 = self gettagorigin(var_6);
  else
    var_7 = self.origin;

  self notify("damage", var_5, self, (0, 0, 0), var_7, "MOD_EXPLOSIVE", "", "");
  waittillframeend;

  if(isdefined(self.partsspawnedents)) {
    foreach(var_9 in self.partsspawnedents)
    var_9 delete();
  }

  if(isdefined(level.destructible_type[self.destuctableinfo].parts)) {
    for (var_11 = level.destructible_type[self.destuctableinfo].parts.size - 1; var_11 >= 0; var_11--) {
      if(var_11 == var_0) {
        continue;
      }
      var_12 = self.destructible_parts[var_11].v["currentState"];

      if(var_12 >= level.destructible_type[self.destuctableinfo].parts[var_11].size)
        var_12 = level.destructible_type[self.destuctableinfo].parts[var_11].size - 1;

      var_13 = get_model_from_part(var_11, var_12);
      var_6 = get_tag_from_part(var_11, var_12);

      if(!isdefined(var_13)) {
        continue;
      }
      if(!isdefined(var_6)) {
        continue;
      }
      if(!ismodelattached(var_13, var_6)) {
        continue;
      }
      if(part_has_physics_exposion(var_11)) {
        apply_physics_explosion_to_part(var_11, var_12, var_6, var_7, var_1, var_2);
        continue;
      }

      self detach(var_13, var_6);

      if(self.modeldummyon)
        self.modeldummy detach(var_13, var_6);
    }
  }

  self notify("stop_taking_damage");
  wait 0.05;
  var_14 = var_7 + (0, 0, 80);

  if(getsubstr(level.destructible_type[self.destuctableinfo].v["type"], 0, 7) == "vehicle") {
    anim.lastcarexplosiontime = gettime();
    anim.lastcarexplosiondamagelocation = var_14;
    anim.lastcarexplosionlocation = var_7;
    anim.lastcarexplosionrange = var_3;
  }

  self radiusdamage(var_14, var_3, var_5, var_4, self);

  if(arcademode_car_kill())
    thread maps\_arcademode::arcademode_add_points(self.origin, 1, "explosive", 200);

  self notify("destroyed");
}

arcademode_car_kill() {
  if(!maps\_utility::arcademode())
    return 0;

  if(level.script == "ac130")
    return 0;

  if(isdefined(level.allcarsdamagedbyplayer))
    return 1;

  return maps\_gameskill::player_did_most_damage();
}

get_destructible_index(var_0, var_1, var_2) {
  if(var_1 >= 0)
    return level.destructible_type[self.destuctableinfo].parts[var_0][var_1].v[var_2];
  else if(var_1 == -1) {
    var_3 = undefined;

    for (var_4 = 0; var_4 < level.destructible_type[self.destuctableinfo].parts[var_0].size; var_4++) {
      if(isdefined(level.destructible_type[self.destuctableinfo].parts[var_0][var_4].v[var_2]))
        var_3 = level.destructible_type[self.destuctableinfo].parts[var_0][var_4].v[var_2];
    }

    return var_3;
  }
}

get_tag_from_part(var_0, var_1) {
  return get_destructible_index(var_0, var_1, "tagName");
}

get_model_from_part(var_0, var_1) {
  return get_destructible_index(var_0, var_1, "modelName");
}

get_last_model_from_part(var_0) {
  return get_destructible_index(var_0, -1, "modelName");
}

apply_physics_explosion_to_part(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = level.destructible_type[self.destuctableinfo].parts[var_0][0].v["physicsOnExplosion"];
  var_7 = self gettagorigin(var_2);
  var_8 = vectornormalize(var_7 - var_3);
  var_8 = maps\_utility::vector_multiply(var_8, randomfloatrange(var_4, var_5) * var_6);
  thread physics_launch(var_0, var_1, var_7, var_8);
}

part_has_physics_exposion(var_0) {
  if(!isdefined(level.destructible_type[self.destuctableinfo].parts[var_0][0].v["physicsOnExplosion"]))
    return 0;

  return level.destructible_type[self.destuctableinfo].parts[var_0][0].v["physicsOnExplosion"] > 0;
}

ismodelattached(var_0, var_1) {
  var_2 = 0;
  var_0 = tolower(var_0);
  var_1 = tolower(var_1);

  if(!isdefined(var_1))
    return var_2;

  var_3 = self getattachsize();
  var_4 = [];

  for (var_5 = 0; var_5 < var_3; var_5++)
    var_4[var_5] = tolower(self getattachmodelname(var_5));

  for (var_5 = 0; var_5 < var_4.size; var_5++) {
    if(var_4[var_5] != var_0) {
      continue;
    }
    var_6 = tolower(self getattachtagname(var_5));

    if(var_1 != var_6) {
      continue;
    }
    var_2 = 1;
    break;
  }

  return var_2;
}

play_loop_sound_on_destructible(var_0, var_1) {
  var_2 = get_dummy();
  var_3 = spawn("script_origin", (0, 0, 0));

  if(isdefined(var_1))
    var_3.origin = var_2 gettagorigin(var_1);
  else
    var_3.origin = var_2.origin;

  if(soundexists(var_0))
    var_3 playloopsound(var_0);
  else {}

  var_2 thread force_stop_sound(var_0);
  var_2 waittill("stop sound" + var_0);
  var_3 stoploopsound(var_0);
  var_3 delete();
}

force_stop_sound(var_0) {
  self endon("stop sound" + var_0);
  level waittill("putout_fires");
  self notify("stop sound" + var_0);
}

notifydamageafterframe(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isdefined(level.notifydamageafterframe)) {
    return;
  }
  level.notifydamageafterframe = 1;
  waittillframeend;

  if(isdefined(self.exploded)) {
    level.notifydamageafterframe = undefined;
    return;
  }

  self notify("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  level.notifydamageafterframe = undefined;
}

get_dummy() {
  if(self.modeldummyon)
    var_0 = self.modeldummy;
  else
    var_0 = self;

  return var_0;
}

disable_explosion() {
  self.dontallowexplode = 1;
}

force_explosion() {
  self.dontallowexplode = undefined;
  self.forceexploding = 1;
  self notify("damage", 1000000000, self, self.origin, self.origin, "MOD_EXPLOSIVE", "", "");
}

get_traverse_disconnect_brush() {
  if(!isdefined(self.target))
    return undefined;

  var_0 = getent(self.target, "targetname");

  if(!isdefined(var_0))
    return undefined;

  if(!var_0.spawnflags & 1)
    return undefined;

  return var_0;
}

connecttraverses() {
  var_0 = get_traverse_disconnect_brush();

  if(!isdefined(var_0)) {
    return;
  }
  var_0 connectpaths();
  var_0.origin = var_0.origin - (0, 0, 10000);
}

disconnecttraverses() {
  var_0 = get_traverse_disconnect_brush();

  if(!isdefined(var_0)) {
    return;
  }
  var_0.origin = var_0.origin + (0, 0, 10000);
  var_0 disconnectpaths();
  var_0.origin = var_0.origin - (0, 0, 10000);
}

setup_destructible_entities() {
  var_0 = common_scripts\utility::get_linked_ents();

  foreach(var_2 in var_0) {
    if(!isdefined(var_2.script_noteworthy)) {
      continue;
    }
    switch (var_2.script_noteworthy) {
      case "destroyed":
        var_2.origin = var_2.origin - (0, 0, 10000);
        break;
    }
  }
}

destroy_destructible_entities() {
  var_0 = common_scripts\utility::get_linked_ents();

  foreach(var_2 in var_0) {
    if(!isdefined(var_2.script_noteworthy)) {
      continue;
    }
    switch (var_2.script_noteworthy) {
      case "destructible":
        var_2 delete();
        break;
      case "destroyed":
        var_2.origin = var_2.origin + (0, 0, 10000);
        break;
    }
  }
}

destructible_car_alarm() {}

destructible_fx_spawn_immediate(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {}

destructible_splash_damage_scaler(var_0) {}