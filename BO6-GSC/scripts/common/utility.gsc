/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\utility.gsc
**************************************/

#using scripts\anim\shared;
#using scripts\asm\asm_bb;
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\dof;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_paths;
#using scripts\engine\flags;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace utility;

function issp() {
  if(!isDefined(level.issp)) {
    mapname = getDvar(@ "g_mapname");
    substring = "";

    for(i = 0; i < min(mapname.size, 3); i++) {
      substring += mapname[i];
    }

    level.issp = substring != "mp_" && substring != "zm_";
  }

  return level.issp;
}

function ismp() {
  return isstartstr(getDvar(@ "g_mapname"), "mp_") || isDefined(level.mapname) && isstartstr(level.mapname, "mp_");
}

function iszm() {
  return isstartstr(getDvar(@ "g_mapname"), "zm_") || isDefined(level.mapname) && isstartstr(level.mapname, "zm_");
}

function function_c88d082fda96f51b(ent) {
  if(level.var_222eeb7fbf311452[ent getentitynumber()] === ent) {
    return true;
  }

  return false;
}

function function_68d5b3e37629956a(ent) {
  if(!isDefined(ent) || !isent(ent)) {
    return;
  }

  if(!isDefined(level.var_222eeb7fbf311452)) {
    level.var_222eeb7fbf311452 = [];
  }

  level.var_222eeb7fbf311452[ent getentitynumber()] = ent;
}

function make_weapon_model(basename, attachments, viewmodel, precache) {
  if(!isDefined(attachments)) {
    attachments = [];
  }

  if(!isDefined(viewmodel)) {
    viewmodel = 0;
  }

  if(isDefined(level.fnbuildweaponspecial) && isDefined([[level.fnbuildweaponspecial]](basename))) {
    weapon = [[level.fnbuildweaponspecial]](basename);
  } else {
    weapon = [[level.fnbuildweapon]](basename, attachments);
  }

  if(isent(self) && !isDefined(precache)) {
    self setModel(getweaponmodel(weapon));
  }

  attachmentmodels = getweaponattachmentworldmodels(weapon);

  foreach(model in attachmentmodels) {
    if(viewmodel) {
      array = strtok(model, "_");

      foreach(i, tok in array) {
        if(i == 0) {
          model = tok;
          continue;
        }

        if(tok == "wm") {
          model += "_vm";
          continue;
        }

        model = model + "_" + tok;
      }
    }

    if(precache) {
      precachemodel(model);
      continue;
    }

    self attach(model);
  }

  if(!precache) {
    switch (basename) {
      case #"hash_bf2d3ffce9ef56d1":
        self hidepart("j_b_loader");
        self hidepart("j_b_loader_01");
        self hidepart("j_b_loader_02");
        self hidepart("j_b_loader_03");
        self hidepart("j_b_loader_04");
        self hidepart("j_b_loader_05");
        self hidepart("j_b_loader_06");
        break;
      case #"hash_9703d13dcfc6b555":
        self hidepart("j_shell");
        self hidepart("j_shell_fired");
        break;
    }

    foreach(model in attachmentmodels) {
      part = "tag_sight_on";

      if(has_part(model, part)) {
        if(issubstr(model, "reflex")) {
          self hidepart(part);
          continue;
        }

        if(issubstr(model, "holo")) {
          self hidepart(part);
          continue;
        }

        if(issubstr(model, "acog")) {
          self hidepart(part);
          continue;
        }

        if(issubstr(model, "scope")) {
          self hidepart(part);
        }
      }
    }
  }
}

function private has_part(model, part) {
  numparts = getnumparts(model);

  for(i = 0; i < numparts; i++) {
    if(part == getpartname(model, i)) {
      return true;
    }
  }

  return false;
}

function make_weapon_and_attach(basename, attachments, tagname, viewmodel, precache) {
  if(!precache) {
    isvalid = 0;

    if(isent(self) || isai(self)) {
      isvalid = 1;
    }

    assert(isvalid, "<dev string:x24>");
  }

  if(!isDefined(attachments)) {
    attachments = [];
  }

  if(!isDefined(viewmodel)) {
    viewmodel = 0;
  }

  if(isDefined(level.fnbuildweaponspecial) && isDefined([[level.fnbuildweaponspecial]](basename))) {
    weapon = [[level.fnbuildweaponspecial]](basename);
  } else {
    weapon = [[level.fnbuildweapon]](basename, attachments);
  }

  if(!precache) {
    if(isDefined(tagname)) {
      self attach(getweaponmodel(basename), tagname);
    } else {
      self attach(getweaponmodel(basename));
    }
  }

  self.attachedweaponmodels[0] = basename;
  attachmentmodels = getweaponattachmentworldmodels(weapon);
  lasermodelindex = undefined;
  var_ecce528020dacdb0 = undefined;

  for(i = 0; i < attachmentmodels.size; i++) {
    if(var_ecce528020dacdb0) {
      model = attachmentmodels[lasermodelindex];
    } else {
      model = attachmentmodels[i];
    }

    if(!isDefined(var_ecce528020dacdb0) && isstartstr(model, "att_wm_laser")) {
      lasermodelindex = i;
      continue;
    }

    if(viewmodel) {
      array = strtok(model, "_");

      foreach(i, tok in array) {
        if(i == 0) {
          model = tok;
          continue;
        }

        if(tok == "wm") {
          model += "_vm";
          continue;
        }

        model = model + "_" + tok;
      }
    }

    if(precache) {
      precachemodel(model);
    } else {
      self attach(model);
      self.attachedweaponmodels[self.attachedweaponmodels.size] = model;
    }

    if(!isDefined(var_ecce528020dacdb0) && isDefined(lasermodelindex) && i == attachmentmodels.size - 1) {
      i -= 1;
      var_ecce528020dacdb0 = 1;
    }
  }

  if(!precache) {
    switch (basename) {
      case #"hash_bf2d3ffce9ef56d1":
        self hidepart("j_b_loader");
        self hidepart("j_b_loader_01");
        self hidepart("j_b_loader_02");
        self hidepart("j_b_loader_03");
        self hidepart("j_b_loader_04");
        self hidepart("j_b_loader_05");
        self hidepart("j_b_loader_06");
        break;
      case #"hash_9703d13dcfc6b555":
        self hidepart("j_shell");
        self hidepart("j_shell_fired");
        break;
    }

    foreach(model in attachmentmodels) {
      part = "tag_sight_on";

      if(has_part(model, part)) {
        if(issubstr(model, "reflex")) {
          self hidepart(part);
          continue;
        }

        if(issubstr(model, "holo")) {
          self hidepart(part);
          continue;
        }

        if(issubstr(model, "acog")) {
          self hidepart(part);
        }
      }
    }
  }
}

function make_weapon_random(weaponname, var_d829bc3fd4695a45, attachment_combos, camos, randomizereticle) {
  attachments = get_random_attachments(var_d829bc3fd4695a45, attachment_combos);
  weapon = [[level.fnbuildweapon]](weaponname, attachments);

  if(getdvarint(@ "hash_45281f93550798")) {
    if(!isDefined(weapon)) {
      complete_weapon = weaponname;

      foreach(attachment in attachments) {
        complete_weapon += "<dev string:x63>" + attachment;
      }

      iprintlnbold(complete_weapon + "<dev string:x68>");
      return [[level.fnbuildweapon]](weaponname);
    }

    has_tag_clip = undefined;
    attachment_models = getweaponattachmentworldmodels(weapon);

    foreach(attachment_model in attachment_models) {
      part_num = getnumparts(attachment_model);

      for(i = 0; i < part_num; i++) {
        if(getpartname(attachment_model, i) == "<dev string:x7c>") {
          has_tag_clip = 1;
          break;
        }
      }
    }

    if(!isDefined(has_tag_clip) && !issubstr(weaponname, "<dev string:x88>") && !issubstr(weaponname, "<dev string:x90>") && !issubstr(weaponname, "<dev string:x98>")) {
      iprintlnbold(getcompleteweaponname(weapon) + "<dev string:xa0>");
    }

    var_ac46e6a0a5ae17d6 = 1;

    foreach(possibility in var_d829bc3fd4695a45) {
      probability_100 = 0;

      if(isint(possibility[0]) && possibility[0] == 100) {
        probability_100 = -1;
      }

      var_ac46e6a0a5ae17d6 *= possibility.size + probability_100;
    }

    println("<dev string:xbb>" + weaponname + "<dev string:xca>" + var_ac46e6a0a5ae17d6);
  }

  if(isDefined(camos) && camos.size > 0 && cointoss()) {
    weapon = weapon withcamo(camos[randomint(camos.size)]);
  }

  if(randomizereticle) {
    foreach(attachment in attachments) {
      if(isstartstr(attachment, "acog")) {
        weapon = weapon withreticle(randomint(8));
        continue;
      }

      if(isstartstr(attachment, "hybrid_west")) {
        weapon = weapon withreticle(randomint(8));
        continue;
      }

      if(isstartstr(attachment, "thermalsnpr")) {
        weapon = weapon withreticle(randomint(8));
        continue;
      }

      if(isstartstr(attachment, "thermal")) {
        weapon = weapon withreticle(randomint(8));
        continue;
      }

      if(isstartstr(attachment, "holo")) {
        weapon = weapon withreticle(randomint(11));
        continue;
      }

      if(isstartstr(attachment, "reflex")) {
        weapon = weapon withreticle(randomint(12));
        continue;
      }

      if(isstartstr(attachment, "minireddot")) {
        weapon = weapon withreticle(randomint(10));
        continue;
      }

      if(isstartstr(attachment, "snprscope")) {
        weapon = weapon withreticle(randomint(13));
        continue;
      }

      if(isstartstr(attachment, "vzscope")) {
        weapon = weapon withreticle(randomint(13));
      }
    }
  }

  return weapon;
}

function get_random_attachments(var_d829bc3fd4695a45, attachment_combos) {
  assert(isDefined(var_d829bc3fd4695a45), "<dev string:xdd>");

  if(isDefined(attachment_combos) && attachment_combos.size > 0) {
    if(var_d829bc3fd4695a45.size < 1) {
      return attachment_combos[randomint(attachment_combos.size)];
    }

    if(randomint(4) == 0) {
      return attachment_combos[randomint(attachment_combos.size)];
    }
  }

  attachments = [];

  if(var_d829bc3fd4695a45.size < 1) {
    return attachments;
  }

  foreach(i, type in var_d829bc3fd4695a45) {
    if(isint(var_d829bc3fd4695a45[i][0])) {
      if(randomint(100) < var_d829bc3fd4695a45[i][0]) {
        if(level.script == "nightwar" && i == "scopes") {
          newtype = [];

          foreach(s, scope in type) {
            if(!issubstr(type[s], "therm") && !issubstr(type[s], "nvg")) {
              newtype[newtype.size] = scope;
            }
          }

          type = newtype;
        }

        if(type.size > 1) {
          attachments[attachments.size] = type[randomint(type.size - 1) + 1];
        }
      }

      continue;
    }

    return attachments;
  }

  ub_entry = undefined;
  grip_entry = undefined;

  foreach(i, attachment in attachments) {
    if(isstartstr(attachment, "grip")) {
      grip_entry = i;
      continue;
    }

    if(issubstr(attachment, "ub_") || issubstr(attachment, "glmini")) {
      ub_entry = i;
    }
  }

  if(isDefined(ub_entry) && isDefined(grip_entry)) {
    if(randomint(3) == 0) {
      attachments[ub_entry] = undefined;

      if(isint(ub_entry)) {
        function_cdc669dbc8ea2101(attachments);
      }
    } else {
      attachments[grip_entry] = undefined;

      if(isint(grip_entry)) {
        function_cdc669dbc8ea2101(attachments);
      }
    }
  }

  return attachments;
}

function get_weapon_weighted(weapons, definedprobabilities) {
  probabilities = [];
  keys = getarraykeys(definedprobabilities);

  foreach(i, weapon in weapons) {
    index = function_f02c63b99c9614c9(keys, weapon);

    if(isDefined(index)) {
      probabilities[probabilities.size] = definedprobabilities[keys[index]];
      continue;
    }

    probabilities[probabilities.size] = 0;
  }

  probability_total = 0;

  foreach(probability in probabilities) {
    probability_total += probability;
  }

  if(probability_total > 100) {
    println("<dev string:x10e>" + probability_total);
  }

  if(probability_total < 100) {
    remaining = 100 - probability_total;
    empty_entries = 0;

    foreach(probability in probabilities) {
      if(probability == 0) {
        empty_entries += 1;
      }
    }

    if(empty_entries > 0) {
      split_probability = remaining / empty_entries;

      foreach(i, probability in probabilities) {
        if(probability == 0) {
          probabilities[i] = split_probability;
        }
      }
    }
  }

  diceroll = randomint(100);

  foreach(i, probability in probabilities) {
    if(i > 0) {
      probabilities[i] = probability + probabilities[i - 1];
    }

    if(diceroll < probabilities[i]) {
      return weapons[i];
    }
  }

  if(getdvarint(@ "hash_45281f93550798")) {
    if(weapons.size > 1) {
      println("<dev string:x149>");
    }
  }

  return weapons[0];
}

function shouldskipfirstraise() {
  if(!isDefined(level.skipfirstraise)) {
    level.skipfirstraise = getdvarint(@ "scr_game_weapon_skip_first_raise", 0) == 1;
  }

  return istrue(level.skipfirstraise);
}

function removeconflictingattachments(attachments, defaults, weapon_base_name) {
  if(issp()) {
    if(isDefined(weapon_base_name)) {
      if(!issubstr(weapon_base_name, "iw9_") || issubstr(weapon_base_name, "iw9_") && !getdvarint(@ "hash_23a1118f1a92bcdd", 0)) {
        return removeconflictingdefaultattachment_new(attachments, defaults, weapon_base_name);
      }
    }

    defaults = removeconflictingdefaultattachment(attachments, defaults);
    defaults = removeconflictingdefaultattachment(attachments, defaults, "bar", "front_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "barlong", "slide_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "barcust", "guard_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "stock", "back_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "cal", "mag_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "drums", "mag_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "xmag", "mag_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "xmags", "mag_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "rack", "mag_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "mmags", "mag_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "box_", "mag_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "xmagslrg", "xmags_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "mag_", "xmags_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "rack", "ammo_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "thermal", "snprscope");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "acog", "snprscope");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "reflex", "snprscope");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "holo", "snprscope");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "hybrid", "snprscope");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "vzscope", "snprscope");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "minireddot", "snprscope");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "thermal", "ironsdefault_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "acog", "ironsdefault_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "reflex", "ironsdefault_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "holo", "ironsdefault_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "hybrid", "ironsdefault_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "vzscope", "ironsdefault_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "minireddot", "ironsdefault_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "scope", "ironsdefault_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "snprscope", "ironsdefault_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "irons", "ironsdefault_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "wounded_", "grip");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "grip", "gripcust_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "griprail", "grip_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "ironsdefault_", "snprscope");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "thermal", "iw8_ironsdefault_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "acog", "iw8_ironsdefault_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "reflex", "iw8_ironsdefault_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "holo", "iw8_ironsdefault_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "hybrid", "iw8_ironsdefault_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "vzscope", "iw8_ironsdefault_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "minireddot", "iw8_ironsdefault_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "scope", "iw8_ironsdefault_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "snprscope", "iw8_ironsdefault_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "irons", "iw8_ironsdefault_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "bar", "iw8_front_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "stock", "iw8_back_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "barlong", "iw8_slide_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "cal", "iw8_mag_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "drums", "iw8_mag_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "xmags", "iw8_mag_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "rack", "iw8_mag_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "mmags", "iw8_mag_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "box_", "iw8_mag_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "barsil", "bar_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "barbrake", "bar_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "barcomp", "bar_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "bartube", "bar_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "bar", "barsil_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "ub", "select");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "ub", "iw9_select");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "ub", "grip");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "glmini", "select");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "glmini", "iw9_select");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "stockno", "stock");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "stock", "stockr");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "stockr", "stock");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "stockp", "stockno_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "fourx", "ironsdefault");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "snscope", "ironsdefault");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "iw9_minireddot", "ironsdefault");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "pgolf1_scope", "ironsdefault");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "mike24_scope", "ironsdefault");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "shscope", "ironsdefault");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "arscope", "ironsdefault");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "dmscope", "ironsdefault");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "hybrid", "ironsdefault");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "fourx", "iw9_ironsdefault");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "holo", "iw9_ironsdefault");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "hybrid", "iw9_ironsdefault");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "reflex", "iw9_ironsdefault");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "thermal", "iw9_ironsdefault");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "arscope", "iw9_ironsdefault");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "iw9_minireddot", "iw9_ironsdefault");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "piscope", "iw9_ironsdefault");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "dmscope", "iw9_ironsdefault");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "vzscope", "iw9_ironsdefault");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "drum_", "mag_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "mag_", "mag_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "belt_", "mag_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "mag_", "belt_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "mag_", "drum_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "magheligrip_", "magheli_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "grip", "magheligrip_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "ballistics", "ammo_");
  } else {
    if(isDefined(weapon_base_name)) {
      if(!issubstr(weapon_base_name, "iw9_") || issubstr(weapon_base_name, "iw9_") && !getdvarint(@ "hash_23a1118f1a92bcdd", 0)) {
        return removeconflictingdefaultattachment_new(attachments, defaults, weapon_base_name);
      }
    }

    defaults = removeconflictingdefaultattachment(attachments, defaults, "bar", "front_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "barlong", "slide_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "barcust", "guard_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "stock", "back_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "cal", "mag_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "drums", "mag_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "xmags", "mag_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "rack", "mag_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "rack", "ammo_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "thermal", "scope");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "acog", "scope");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "reflex", "scope");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "holo", "scope");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "grip", "grip_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "rec_", "rec_");
    defaults = removeconflictingdefaultattachment(attachments, defaults, "toprail_", "toprail_");
  }

  return defaults;
}

function removeconflictingdefaultattachment_new(attachment_array, default_array, weapon_base_name, var_872c3c3b9442921a = 1) {
  defaults_filtered = default_array;
  attach_1 = undefined;
  var_21ca68c81ef4b7cc = undefined;
  var_43a66262e08982f8 = undefined;
  attach_2 = undefined;
  var_cb10d512983d5c6b = undefined;
  var_cee1879c8c5375f = undefined;
  var_283db49f3d7bf4fb = undefined;
  var_e12ac324cb87db7f = undefined;
  weap = makeweaponfromstring(weapon_base_name);
  final_attachments = defaults_filtered;

  if(var_872c3c3b9442921a) {
    for(i = 0; i < default_array.size - 1; i++) {
      attach_1 = default_array[i];
      var_21ca68c81ef4b7cc = getattachmentslot(weap, attach_1);

      for(j = i + 1; j < default_array.size; j++) {
        attach_2 = default_array[j];

        if(attach_1 == attach_2) {
          continue;
        }

        var_cb10d512983d5c6b = getattachmentslot(weap, attach_2);

        if(var_21ca68c81ef4b7cc == var_cb10d512983d5c6b && var_21ca68c81ef4b7cc != "other") {
          var_43a66262e08982f8 = getattachmentslotpriority(weap, attach_1);
          var_cee1879c8c5375f = getattachmentslotpriority(weap, attach_2);

          if(var_43a66262e08982f8 >= var_cee1879c8c5375f) {
            final_attachments = arrayremove(final_attachments, attach_2);
          }
        }

        var_283db49f3d7bf4fb = _attachmentblocks(weap, attach_1, attach_2);
        var_e12ac324cb87db7f = _attachmentblocks(weap, attach_2, attach_1);

        if(var_283db49f3d7bf4fb && var_e12ac324cb87db7f) {
          defaults_filtered = arrayremove(defaults_filtered, attach_2);
          continue;
        }

        if(var_283db49f3d7bf4fb) {
          defaults_filtered = arrayremove(defaults_filtered, attach_2);
          continue;
        }

        if(var_e12ac324cb87db7f) {
          defaults_filtered = arrayremove(defaults_filtered, attach_1);
        }
      }
    }
  }

  attach_1 = undefined;
  var_21ca68c81ef4b7cc = undefined;
  var_43a66262e08982f8 = undefined;
  attach_2 = undefined;
  var_cb10d512983d5c6b = undefined;
  var_cee1879c8c5375f = undefined;
  var_283db49f3d7bf4fb = undefined;
  var_e12ac324cb87db7f = undefined;
  final_attachments = defaults_filtered;

  foreach(attach_1 in attachment_array) {
    if(issubstr(attach_1, "|")) {
      [attach_1] = strtok(attach_1, "|");
    }

    var_21ca68c81ef4b7cc = getattachmentslot(weap, attach_1);

    foreach(attach_2 in defaults_filtered) {
      if(issubstr(attach_2, "|")) {
        [attach_2] = strtok(attach_2, "|");
      }

      var_cb10d512983d5c6b = getattachmentslot(weap, attach_2);

      if(var_21ca68c81ef4b7cc == var_cb10d512983d5c6b && var_21ca68c81ef4b7cc != "other") {
        var_43a66262e08982f8 = getattachmentslotpriority(weap, attach_1);
        var_cee1879c8c5375f = getattachmentslotpriority(weap, attach_2);

        if(var_43a66262e08982f8 >= var_cee1879c8c5375f) {
          final_attachments = arrayremove(final_attachments, attach_2);
        }
      }

      var_283db49f3d7bf4fb = _attachmentblocks(weap, attach_1, attach_2);
      var_e12ac324cb87db7f = _attachmentblocks(weap, attach_2, attach_1);

      if(var_283db49f3d7bf4fb && var_e12ac324cb87db7f) {
        final_attachments = arrayremove(final_attachments, attach_2);
        continue;
      }

      if(var_283db49f3d7bf4fb) {
        final_attachments = arrayremove(final_attachments, attach_2);
      }
    }
  }

  return final_attachments;
}

function removeconflictingdefaultattachment(attachment_array, default_array, attachment_string, default_string) {
  if(!isDefined(attachment_string)) {
    foreach(attachment in attachment_array) {
      tok = strtok(attachment, "_")[0];

      if(tok == "iw8" || tok == "iw9" || tok == "jup") {
        tok = strtok(attachment, "_")[1];

        foreach(def in default_array) {
          if(!isDefined(strtok(def, "_")[1])) {
            continue;
          }

          if(tok == strtok(def, "_")[1]) {
            default_array = arrayremove(default_array, def);
            continue;
          }

          if(issubstr(attachment, "scope") && issubstr(def, "scope")) {
            default_array = arrayremove(default_array, def);
          }
        }

        continue;
      }

      foreach(def in default_array) {
        if(tok == strtok(def, "_")[0]) {
          default_array = arrayremove(default_array, def);
          continue;
        }

        if(issubstr(attachment, "scope") && issubstr(def, "scope")) {
          default_array = arrayremove(default_array, def);
        }
      }
    }

    return default_array;
  }

  remove_default_string = undefined;

  foreach(attachment in attachment_array) {
    if(issubstr(attachment, default_string)) {
      remove_default_string = 1;
    }

    if(isstartstr(attachment, attachment_string) || remove_default_string) {
      for(i = 0; i < default_array.size; i++) {
        if(issubstr(default_array[i], default_string)) {
          default_array[i] = undefined;

          if(isint(i)) {
            function_cdc669dbc8ea2101(default_array);
          }

          return default_array;
        }
      }
    }
  }

  return default_array;
}

function private _attachmentblocks(weaponasset, attachment1, attachment2) {
  basetypesblocked = getattachmentbasetypesblocked(weaponasset, attachment1);

  if(basetypesblocked.size > 0 && arraycontains(basetypesblocked, getattachmentbasetype(weaponasset, attachment2))) {
    return true;
  }

  attachment1slot = getattachmentslot(weaponasset, attachment1);
  attachment2slot = getattachmentslot(weaponasset, attachment2);

  if(attachment1slot == attachment2slot) {
    if(attachment1slot != "other" || attachment1 == attachment2) {
      return true;
    }
  }

  slotsblocked = getattachmentslotsblocked(weaponasset, attachment1);

  if(slotsblocked.size > 0 && arraycontains(slotsblocked, attachment2slot)) {
    return true;
  }

  attachmentsblocked = getattachmentsblocked(weaponasset, attachment1);

  if(attachmentsblocked.size > 0 && arraycontains(attachmentsblocked, attachment2)) {
    return true;
  }

  return false;
}

function function_a0b2f814bf08507f(weaponname, origin, weaponattachments, angles = (0, 0, 0), spawnflags = 0, camoid) {
  assert(isDefined(origin), "<dev string:x176>");

  if(getdvarint(@ "hash_4589562a903db3e0") && isstartstr(weaponname, "iw8_")) {
    print("<dev string:x1a8>" + weaponname);
  }

  weaponattachments = weaponattachments ?? [];
  defaults = getweapondefaultattachments(weaponname);
  defaults = removeconflictingattachments(weaponattachments, defaults, weaponname);
  weaponattachments = arraycombine(defaults, weaponattachments);
  attachmentstring = "";

  foreach(attachment in weaponattachments) {
    attachmentstring = attachmentstring + "+" + attachment;
  }

  if(isDefined(camoid)) {
    attachmentstring += "+camo|" + camoid;
  }

  weapon = spawn("weapon_" + weaponname + attachmentstring, origin, spawnflags);
  weapon.angles = angles;
  level thread callsharedfunc(#"loot", #"dropWeaponPost", weapon);
  return weapon;
}

function private function_295d140a604847b8(weapon) {
  struct = spawnStruct();
  struct.origin = weapon.origin;
  struct.angles = weapon.angles;
  struct.targetname = weapon.targetname;
  struct.bulletweapon = function_41bec0232e24ee41(weapon.classname, "weapon_");
  struct.spawnflags = weapon.spawnflags;
  addstruct(struct);
}

function fixplacedweapons() {
  level.placedweapons = [];

  weapons = [];
  entities = getEntArray();

  foreach(ent in entities) {
    if(!isDefined(ent.classname)) {
      continue;
    }

    if(isstartstr(ent.classname, "weapon_")) {
      weapons[weapons.size] = ent;
    }
  }

  foreach(weapon in weapons) {
    if(isent(weapon) && weapon.spawnflags & 32) {
      function_295d140a604847b8(weapon);
      weapon delete();
      continue;
    }

    weaponattachments = strtok(weapon.classname, "+");
    weaponname = getsubstr(weaponattachments[0], 7, weaponattachments[0].size);
    weaponattachments[0] = undefined;

    if(isint(0)) {
      function_cdc669dbc8ea2101(weaponattachments);
    }

    weaponcamoid = weapon.script_camo;

    if(isDefined(level.var_78443cb099dedf63)) {
      weaponfixed = [[level.var_78443cb099dedf63]](weaponname, weapon.origin, weaponattachments, weapon.angles, weapon.spawnflags, weaponcamoid);
    } else {
      weaponfixed = function_a0b2f814bf08507f(weaponname, weapon.origin, weaponattachments, weapon.angles, weapon.spawnflags, weaponcamoid);
    }

    if(isDefined(weapon.targetname)) {
      weaponfixed.targetname = weapon.targetname;
    }

    if(isDefined(weapon.script_noteworthy)) {
      weaponfixed.script_noteworthy = weapon.script_noteworthy;
    }

    if(isDefined(weapon.script_namenumber)) {
      weaponfixed.script_namenumber = weapon.script_namenumber;
    }

    if(isDefined(weapon.script_parameters)) {
      weaponfixed.script_parameters = weapon.script_parameters;
    }

    if(isDefined(weapon.script_label)) {
      weaponfixed.script_label = weapon.script_label;
    }

    if(isDefined(weapon.script_ammo_alt_clip)) {
      weaponfixed.script_ammo_alt_clip = weapon.script_ammo_alt_clip;
    }

    if(isDefined(weapon.script_ammo_alt_extra)) {
      weaponfixed.script_ammo_alt_extra = weapon.script_ammo_alt_extra;
    }

    if(isDefined(weapon.script_ammo_clip)) {
      weaponfixed.script_ammo_clip = weapon.script_ammo_clip;
    }

    if(isDefined(weapon.script_ammo_extra)) {
      weaponfixed.script_ammo_extra = weapon.script_ammo_extra;
    } else if(isDefined(weapon.script_ammo_clip)) {
      weaponfixed.script_ammo_extra = 0;
    }

    if(isDefined(weapon.script_ammo_max)) {
      weaponfixed.script_ammo_max = weapon.script_ammo_max;
    }

    if(isDefined(weapon.var_d61fe0ab5f896da5)) {
      weaponfixed.var_d61fe0ab5f896da5 = weapon.var_d61fe0ab5f896da5;
    }

    hasub = function_9955d5b2a1d97c43(weapon);
    weaponfixed shared::setscriptammo(weaponname, weapon, hasub);
    thread callsharedfunc(#"loot", #"dropWeaponPost", weaponfixed);

    level.placedweapons[level.placedweapons.size] = weaponfixed;

    weapon delete();
  }
}

function spawn_damage_proxy(parentent, model, offsetorigin, offsetangles, tag) {
  assert(isent(parentent));
  assert(isDefined(model));

  if(!isDefined(offsetorigin)) {
    offsetorigin = (0, 0, 0);
  }

  if(!isDefined(offsetangles)) {
    offsetangles = (0, 0, 0);
  }

  damageproxy = spawn("script_model", coordtransform(offsetorigin, parentent.origin, parentent.angles));

  if(!isDefined(damageproxy)) {
    iprintln("<dev string:x1ef>" + parentent.origin[0] + "<dev string:x20f>" + parentent.origin[1] + "<dev string:x20f>" + parentent.origin[2] + "<dev string:x215>");

    return undefined;
  }

  damageproxy.angles = combineangles(parentent.angles, offsetangles);
  damageproxy setModel(model);
  damageproxy.health = 999999;
  damageproxy.takedamage = 1;
  damageproxy hide();
  damageproxy function_f721683d9ae86377(1);
  damageproxy setCanDamage(1);

  if(isDefined(tag)) {
    damageproxy linkTo(parentent, tag, offsetorigin, offsetangles);
  } else {
    damageproxy linkTo(parentent);
  }

  parentent thread damage_proxy_cleanup(damageproxy);
  damageproxy thread function_9e0058b45819027c(parentent);
  return damageproxy;
}

function private function_9e0058b45819027c(owner) {
  self endon("death_or_disconnect");
  owner endon("death_or_disconnect");

  while(true) {
    self waittill("damage", amount, attacker, direction_vec, damageloc, meansofdeath, modelname, attachtagname, partname, dflags, objweapon, origin, angles, normal, inflictor, time);
    owner notify("damage", amount, attacker, direction_vec, damageloc, meansofdeath, modelname, attachtagname, partname, dflags, objweapon, origin, angles, normal, inflictor, time);
    self.health = 999999;
  }
}

function private damage_proxy_cleanup(linked) {
  self waittill("death_or_disconnect");

  if(isDefined(linked)) {
    linked delete();
  }
}

function lookatentity(ent, intensity) {
  actual_intensity = 1;

  if(isDefined(intensity)) {
    actual_intensity = intensity;
  }

  self.entitylookingat = ent;

  if(isDefined(ent)) {
    self.lookingatent = 1;
    self setlookatentity(ent, actual_intensity);
    return;
  }

  self.lookingatent = 0;
  self setlookatentity();
}

function civ_glancedownpath(duration) {
  if(!isDefined(self.pathgoalpos)) {
    return;
  }

  self.internal_entitytolookat = self.entitylookingat;
  lookatentity();
  internal_civglancedownpath(gettime(), duration);
  lookatentity(self.internal_entitytolookat);
  self.internal_entitytolookat = undefined;
  self notify("glance_finished");
}

function private internal_civglancedownpath(starttime, duration) {
  var_9d04c47cb9bb461 = 2500;
  lookdownpathdist = self.lookdownpathdist ?? 75;

  while(starttime + duration > gettime()) {
    glanceatpos = self getposonpath(lookdownpathdist);
    glanceatpos += (0, 0, 60);

    if(distancesquared(self.origin, glanceatpos) < var_9d04c47cb9bb461) {
      break;
    }

    self setlookat(glanceatpos);
    waitframe();
  }

  self stoplookat();
}

function glancestop() {
  self stoplookat();
}

function lookatpos(pos, intensity) {
  self notify("newLookAt");

  if(!isDefined(intensity)) {
    intensity = 1;
  }

  if(!isDefined(pos)) {
    self stoplookat();
    return;
  }

  self setlookat(pos, intensity);
}

function isweaponepic(weapon) {
  attachments = getweaponattachments(weapon);

  if(!isDefined(attachments)) {
    return false;
  }

  foreach(attachment in attachments) {
    if(issubstr(attachment, "epic")) {
      return true;
    }
  }

  return false;
}

function isdamageweapon(weapon) {
  objweapon = self.damageweapon;

  if(!isDefined(objweapon)) {
    return false;
  }

  if(isnullweapon(objweapon)) {
    return false;
  }

  if(objweapon.basename != getweaponbasename(weapon)) {
    return false;
  }

  return true;
}

function setrecoilscale(scaler, scaleoverride) {
  if(!isDefined(scaler)) {
    scaler = 0;
  }

  if(!isDefined(self.recoilscale)) {
    self.recoilscale = scaler;
  } else {
    self.recoilscale += scaler;
  }

  if(isDefined(scaleoverride)) {
    if(scaleoverride < self.recoilscale) {
      scaleoverride = self.recoilscale;
    }

    scale = 100 - scaleoverride;
  } else {
    scale = 100 - self.recoilscale;
  }

  scale = int(clamp(scale, 0, 255));

  if(scale == 100) {
    self player_recoilscaleoff();
    return;
  }

  self player_recoilscaleon(scale);
}

function meleegrab_ksweapon_used() {
  assert(isPlayer(self));
  killstreak_weaps = ["mars_killstreak", "iw7_jackal_support_designator"];
  currentweapon = self getcurrentweapon();

  if(arraycontains(killstreak_weaps, currentweapon.basename)) {
    return true;
  }

  if(self isdroppingweapon()) {
    return true;
  }

  if(self israisingweapon()) {
    if(arraycontains(killstreak_weaps, currentweapon.basename)) {
      return true;
    }
  }

  return false;
}

function wasdamagedbyoffhandshield() {
  if(self.damagemod != "MOD_MELEE") {
    return false;
  }

  objweapon = self.damageweapon;

  if(!isDefined(objweapon) || objweapon.type != "shield") {
    return false;
  }

  return true;
}

function shouldburnfromdamage(damageweapon) {
  if(issubstr(damageweapon.basename, "molotov") || damageweapon.isdragonsbreath || self.var_30465dead0b9fadb || self.shouldburnfromdamage || function_51251d8c19498b74(damageweapon)) {
    return true;
  }

  return false;
}

function function_51251d8c19498b74(damageweapon) {
  weaponmetadata = level.weaponmetadata[getxhashasset(damageweapon.basename)];
  return weaponmetadata.elementdamagetype == "fire" && weaponmetadata.var_e02edeb9004f44ac;
}

function wasdamagedbyexplosive() {
  if(isDefined(self.damagemod)) {
    if(isexplosivedamagemod(self.damagemod)) {
      return true;
    }

    if(isDefined(self.damageweapon) && shouldburnfromdamage(self.damageweapon) && !self.var_30465dead0b9fadb) {
      return true;
    }

    if(wasdamagedbyoffhandshield()) {
      return true;
    }

    if(isDefined(self.attacker) && self.damagemod == "MOD_MELEE" && isDefined(self.attacker.unittype) && self.attacker.unittype == "c8") {
      return true;
    }
  }

  if(gettime() - anim.lastcarexplosiontime <= 50) {
    rangesq = anim.lastcarexplosionrange * anim.lastcarexplosionrange * 1.2 * 1.2;

    if(distancesquared(self.origin, anim.lastcarexplosiondamagelocation) < rangesq) {
      var_abf45e9f7b58c8e1 = rangesq * 0.5 * 0.5;
      self.maydoupwardsdeath = distancesquared(self.origin, anim.lastcarexplosionlocation) < var_abf45e9f7b58c8e1;
      return true;
    }
  }

  return false;
}

function getdamagetype(smeansofdeath) {
  if(!isDefined(smeansofdeath)) {
    return #"unknown";
  }

  switch (smeansofdeath) {
    case #"hash_5f1054c48d66fd1c":
    case #"hash_966768b3f0c94767":
      return #"bullet";
    case #"hash_a5123f4d02745600":
    case #"hash_abb1587cdc6def23":
      return #"melee";
    case #"hash_3c20f39c73a1422b":
    case #"hash_571e46e17a3cf2e3":
    case #"hash_66cb246f3e55fbe2":
    case #"hash_a86d8c43482948a4":
    case #"hash_a911a1880d996edb":
    case #"hash_c22b13f81bed11f0":
      return #"splash";
    case #"hash_b1078ff213fddba6":
      return #"impact";
    case #"hash_1b5395c651f95456":
    case #"hash_61e42661ac27b9f2":
    default:
      return #"unknown";
  }
}

function isprotectedbyriotshield(enemy) {
  if(isDefined(enemy.hasriotshield) && enemy.hasriotshield) {
    enemytome = self.origin - enemy.origin;
    metoenemy = vectorNormalize((enemytome[0], enemytome[1], 0));
    enemyfacing = anglesToForward(enemy.angles);
    angletome = vectordot(enemyfacing, enemytome);

    if(enemy.hasriotshieldequipped) {
      if(angletome > 0.766) {
        return true;
      }
    } else if(angletome < -0.766) {
      return true;
    }
  }

  return false;
}

function isprotectedbyaxeblock(source) {
  enemy_blocked = 0;
  currentweapon = self getcurrentweapon();
  var_dc29c4f465152879 = self adsButtonPressed();
  enemy_in_front = 0;
  melee_in_hand = 0;
  var_6af90177149d6506 = 0;
  playerforwardvector = anglesToForward(self.angles);
  playertoenemyvector = vectorNormalize(source.origin - self.origin);
  dotproduct = vectordot(playertoenemyvector, playerforwardvector);

  if(dotproduct > 0.5) {
    enemy_in_front = 1;
  }

  if(currentweapon.basename == "iw6_axe_mp" || currentweapon.basename == "iw7_axe_zm") {
    var_6af90177149d6506 = self getcurrentweaponclipammo();
    melee_in_hand = 1;
  }

  if(melee_in_hand && var_dc29c4f465152879 && enemy_in_front && var_6af90177149d6506 > 0) {
    self setweaponammoclip(currentweapon, var_6af90177149d6506 - 1);
    self playSound("crate_impact");
    earthquake(0.75, 0.5, self.origin, 100);
    enemy_blocked = 1;
  }

  return enemy_blocked;
}

function isairdropmarker(weaponname) {
  switch (weaponname) {
    case #"hash_2f9061ae7f4b0174":
    case #"hash_6b6ba32b55308fd1":
    case #"hash_73258c6de50c988a":
    case #"hash_abb7a2d7e9d5a6ff":
    case #"hash_e64f015026a52907":
    case #"hash_e861ccef0beefbbb":
      return 1;
    default:
      return 0;
  }
}

function isdestructibleweapon(weapon) {
  if(!isDefined(weapon)) {
    assertmsg("<dev string:x21b>");
    return false;
  }

  switch (weapon) {
    case #"hash_5e7c026ffa426ef2":
    case #"hash_a2f8ba701e9cf4d4":
    case #"hash_b6aeb2ab5add627b":
    case #"hash_e06c18584a141cef":
      return true;
  }

  return false;
}

function enable_teamflashbangimmunity() {
  thread enable_teamflashbangimmunity_proc();
}

function private enable_teamflashbangimmunity_proc() {
  self endon("death");

  while(true) {
    self.teamflashbangimmunity = 1;
    wait 0.05;
  }
}

function disable_teamflashbangimmunity() {
  self.teamflashbangimmunity = undefined;
}

function setflashbangimmunity(immune) {
  self.flashbangimmunity = immune;
}

function getcamotablecolumnindex(columnname) {
  switch (columnname) {
    case #"hash_34b6339587dcb48b":
      return 0;
    case #"hash_1a71dd59b555167":
      return 1;
    case #"hash_f545dd6e3ce1266f":
      return 2;
    case #"hash_7398d228375ae0d1":
      return 3;
    default:
      return undefined;
  }
}

function getdifficulty() {
  assert(isDefined(level.gameskill));

  if(level.gameskill < 1) {
    return "easy";
  }

  if(level.gameskill < 2) {
    return "medium";
  }

  if(level.gameskill < 3) {
    return "hard";
  }

  return "fu";
}

function clear_movement_speed() {
  self aiclearscriptdesiredspeed();
}

function flashbangstop() {
  self.flashendtime = undefined;
}

function enable_cqbwalk(autoenabled) {
  if(self.type == "dog") {
    return;
  }

  if(!isDefined(autoenabled)) {
    self.cqbenabled = 1;
  }

  self.turnrate = 0.2;
  demeanor_override("cqb");
}

function disable_cqbwalk() {
  if(self.type == "dog") {
    return;
  }

  self.cqbenabled = undefined;
  self.turnrate = 0.3;

  if(isDefined(self.cqb_point_of_interest)) {
    self.cqb_point_of_interest = undefined;
    self function_e885c7bb61b04474(0);
  }

  self notify("<dev string:x25a>");

  clear_demeanor_override();
}

function demeanor_override(demeanor) {
  self demeanoroverride(demeanor);
}

function clear_demeanor_override() {
  self cleardemeanoroverride();
}

function isweaponinitialized(objweapon) {
  assert(isweapon(objweapon));
  weaponname = getcompleteweaponname(objweapon);
  return isDefined(self.weaponinfo[weaponname]);
}

function initweapon(objweapon) {
  assert(isweapon(objweapon));
  weaponname = getcompleteweaponname(objweapon);
  self.weaponinfo[weaponname] = spawnStruct();
  self.weaponinfo[weaponname].position = "none";
  self.weaponinfo[weaponname].hasclip = 1;

  if(issp()) {
    self.weaponinfo[weaponname].useclip = objweapon function_d4b37be81fe8abbf();
    return;
  }

  self.weaponinfo[weaponname].useclip = 0;
}

function get_doublejumpenergy() {
  if(!isDefined(self.doublejumpenergy)) {
    return self energy_getenergy(0);
  }

  return self.doublejumpenergy;
}

function set_doublejumpenergy(value) {
  if(!isDefined(self.doublejumpenergy)) {
    self energy_setenergy(0, value);
    return;
  }

  self.doublejumpenergy = value;
}

function get_doublejumpenergyrestorerate() {
  if(!isDefined(self.doublejumpenergyrestorerate)) {
    return self energy_getrestorerate(0);
  }

  return self.doublejumpenergyrestorerate;
}

function set_doublejumpenergyrestorerate(value) {
  if(!isDefined(self.doublejumpenergyrestorerate)) {
    self energy_setrestorerate(0, value);
    return;
  }

  self.doublejumpenergyrestorerate = value;
}

function playerarmorenabled() {
  return getdvarint(@ "hash_bfa6bedc37206c58");
}

function playerhelmetenabled() {
  return getdvarint(@ "hash_425e93b8de8f141c");
}

function groundpos(origin, up) {
  return drop_to_ground(origin, 0, -100000, up);
}

function vehicle_detachfrompath() {
  vehicle_code::vehicle_pathdetach();
}

function vehicle_resumepath() {
  thread vehicle_paths::vehicle_resumepathvehicle();
}

function vehicle_dynamicpath(node, var_847b4b4977c8450) {
  vehicle::vehicle_paths(node, var_847b4b4977c8450);
}

function getvehiclespawner(value, key, allowundefined) {
  spawners = getvehiclespawnerarray(value, key);

  if(!allowundefined) {
    assert(spawners.size == 1);
  }

  return spawners[0];
}

function getvehiclespawnerarray(value, key) {
  return vehicle_code::_getvehiclespawnerarray(value, key);
}

function function_d0e6aed2d8648374(start_pos, vel, accel, contentoverride, ignoreents, max_time = 8, delta_time = 0.15, debug_color, var_afe7fa4c43ea8c61 = 0) {
  level endon("game_ended");

  debug_render = getdvarint(@ "hash_f6e0be2a1a634e44", 0);

  if(debug_render) {
    debug_duration_frames = getdvarint(@ "hash_d69378863f107ad1", 1);
    debug_radius = getdvarfloat(@ "hash_67b9f0ba27a83e72", 0);

    if(!isDefined(debug_color)) {
      debug_color = (1, 0.65, 0);
    }
  }

  if(!isDefined(accel)) {
    accel = (0, 0, -1 * getdvarfloat(@ "bg_gravity", 800));
  }

  position = start_pos;
  position_prev = start_pos;
  t = 0;
  var_9b21fd8bac1a558a = max_time / delta_time;
  b_hit = 0;
  v = undefined;

  for(i = 0; i <= var_9b21fd8bac1a558a; i++) {
    t += delta_time;
    position = start_pos + vel * t + accel * 0.5 * t * t;
    trace = trace::ray_trace(position_prev, position, ignoreents, contentoverride);

    if(isDefined(trace["position"]) && trace["position"] != position) {
      b_hit = 1;
      position = trace["position"];
    }

    if(debug_render) {
      if(debug_radius > 0) {
        cylinder(position, position_prev, debug_radius, debug_color, 0, debug_duration_frames);
      } else {
        line(position, position_prev, debug_color, 1, 1, debug_duration_frames);
      }
    }

    position_prev = position;

    if(b_hit) {
      break;
    }
  }

  v = vel + accel * t;

  if(b_hit && var_afe7fa4c43ea8c61 > 0) {
    thread draw_circle(position, var_afe7fa4c43ea8c61, debug_color, 1, 1, debug_duration_frames);
  }

  result = spawnStruct();
  result.position = position;
  result.travel_time = t;
  result.velocity = v;
  result.b_hit = b_hit;
  result.trace = trace;
  return result;
}

function is_map_using_locales_only() {
  mapname = getDvar(@ "g_mapname");

  if(mapname == "mp_donesk" || mapname == "mp_locale_test") {
    return true;
  }

  return false;
}

function iswegameplatform() {
  if(!isDefined(level.iswegameplatform)) {
    level.iswegameplatform = getdvarint(@ "g_wegame_platform", 0) > 0;
  }

  return level.iswegameplatform;
}

function function_3a444812a9926ec(source, target) {
  distanceinches = distance(source, target);
  distancemeters = distanceinches * 0.0254;
  return distancemeters;
}

function playerwithindistance(player, point, distance) {
  actualdistancesquared = distancesquared(player.origin, point);
  maxdistancesquared = distance * distance;

  if(actualdistancesquared <= maxdistancesquared) {
    return true;
  }

  return false;
}

function function_92fc197c20834b39(player, point, distance) {
  actualdistancesquared = distance2dsquared(player.origin, point);
  maxdistancesquared = distance * distance;

  if(actualdistancesquared <= maxdistancesquared) {
    return true;
  }

  return false;
}

function function_db36b3921345bdf4(player, point, distancesquared) {
  actualdistancesquared = distancesquared(player.origin, point);

  if(actualdistancesquared <= distancesquared) {
    return true;
  }

  return false;
}

function playersnear(point, distance) {
  return charactersnear(point, distance, 1);
}

function agentsnear(point, distance) {
  return charactersnear(point, distance, 0);
}

function charactersnear(point, distance, playersonly) {
  playercontents = physics_createcontents(["physicscontents_characterproxy"]);
  radiusvector = (distance, distance, distance);
  aabbmin = point - radiusvector;
  aabbmax = point + radiusvector;
  hits = physics_aabbbroadphasequery(aabbmin, aabbmax, playercontents, []);

  if(!isDefined(playersonly)) {
    return hits;
  }

  filteredhits = [];

  foreach(hit in hits) {
    if(isPlayer(hit) == playersonly) {
      filteredhits[filteredhits.size] = hit;
    }
  }

  return filteredhits;
}

function playersincylinder(point, radius, var_39608ff9f170fda3, halfheightoverride = 1000, var_7d41775d8f6afcf3, ignorelaststand) {
  return function_d63fe6a4c08ba6f5(point, radius, halfheightoverride, ignorelaststand, var_39608ff9f170fda3, var_7d41775d8f6afcf3);
}

function function_f754506ecfae9afb(point, radius, var_8925d7e90df06109, cylinderhalfheight = 1000, includeplayers) {
  ignoreplayers = includeplayers === 0;
  return function_51b8ce76eb43aed5(point, radius, cylinderhalfheight, undefined, ignoreplayers, var_8925d7e90df06109);
}

function playersinsphere(point, radius, excludedplayers) {
  return getplayersinradius(point, radius, undefined, undefined, excludedplayers);
}

function function_1b1340a94b43b874(point, radius, includeplayers) {
  if(includeplayers === 0) {
    return getaiarrayinradius(point, radius);
  }

  return getplayersandaiarrayinradius(point, radius);
}

function trycall(functionpointer, ...) {
  if(!isDefined(functionpointer)) {
    return;
  }

  return [[functionpointer]](flat_args(vararg, varargcount));
}

function spawncorpsehider() {
  if(!(level.var_ce11fa8b9f14341d ?? iswegameplatform())) {
    return;
  }

  corpsetable_index = 0;
  corpsetable_mapname = 1;
  corpsetable_model = 2;
  corpsetable_loc = 3;
  corpsetable_rot = 4;
  corpsetable_collision = 5;
  corpsetablename = "sp/hideCorpseTable.csv";
  curmapname = tolower(getDvar(@ "g_mapname"));
  var_d374f94865e7eef9 = tablelookupgetnumrows(corpsetablename);

  for(i = 0; i < var_d374f94865e7eef9; i++) {
    if(curmapname == tolower(tablelookupbyrow(corpsetablename, i, corpsetable_mapname))) {
      modelname = tablelookupbyrow(corpsetablename, i, corpsetable_model);
      arrloc = strtok(tablelookupbyrow(corpsetablename, i, corpsetable_loc), "_");
      arrrot = strtok(tablelookupbyrow(corpsetablename, i, corpsetable_rot), "_");
      icollision = int(tablelookupbyrow(corpsetablename, i, corpsetable_collision));
      model = spawn("script_model", (float(arrloc[0]), float(arrloc[1]), float(arrloc[2])));
      model setModel(modelname);
      model.angles = (float(arrrot[0]), float(arrrot[1]), float(arrrot[2]));

      if(icollision > 0) {
        model solid();
        continue;
      }

      model notsolid();
    }
  }
}

function function_de1f80d93273abf5() {
  if(isstruct(self) || !isDefined(self)) {
    return false;
  }

  if(isent(self) && !self isscriptable()) {
    return false;
  }

  if(!isent(self) && !self isscriptableinstance()) {
    return false;
  }

  return true;
}

function function_9f2c41c1dcc8c94(part, state) {
  if(isent(self) && self isscriptable() || !isent(self) && self isscriptableinstance()) {
    if(self getscriptablehaspart(part)) {
      if(self getscriptableparthasstate(part, state)) {
        curstate = self getscriptablepartstate(part, 1);

        if(curstate == state) {
          return true;
        }
      }
    }
  }

  return false;
}

function function_30dbabe3200518b(name, key) {
  var_b8ebf0322b4c95e2 = getentitylessscriptablearray(name, key);
  assert(var_b8ebf0322b4c95e2.size < 2, "<dev string:x26b>" + name + "<dev string:x298>" + getxhashsourcename(key) + "<dev string:x2a6>");

  if(var_b8ebf0322b4c95e2.size == 1) {
    return var_b8ebf0322b4c95e2[0];
  }

  return undefined;
}

function function_b3fc2f9ce7786d99(name, key) {
  var_b8ebf0322b4c95e2 = getscriptablearray(name, key);
  assert(var_b8ebf0322b4c95e2.size < 2, "<dev string:x26b>" + name + "<dev string:x298>" + getxhashsourcename(key) + "<dev string:x2a6>");

  if(var_b8ebf0322b4c95e2.size == 1) {
    return var_b8ebf0322b4c95e2[0];
  }

  return undefined;
}

function function_7c10ea82c1e305b8(part, state) {
  if(isent(self) && self isscriptable() || !isent(self) && self isscriptableinstance()) {
    if(self getscriptablehaspart(part)) {
      if(self getscriptableparthasstate(part, state)) {
        self setscriptablepartstate(part, state, 1);
        return true;
      }
    }
  }

  return false;
}

function scriptable_setparententity(parent, offset, angles) {
  assert(isDefined(self) && self isscriptableinstance());
  assert(isent(parent));

  if(isDefined(offset) && isDefined(angles)) {
    self scriptablesetparententity(parent, offset, angles);
  } else if(isDefined(offset)) {
    self scriptablesetparententity(parent, offset);
  } else {
    self scriptablesetparententity(parent);
  }

  self.linkedparent = parent;

  if(!isDefined(parent.linkedchildren)) {
    parent.linkedchildren = [];
  }

  parent.linkedchildren[parent.linkedchildren.size] = self;

  if(parent.linkedchildren.size % 10 == 0) {
    parent.linkedchildren = function_5713d46873b29625(parent.linkedchildren);
  }
}

function scriptable_clearparententity() {
  assert(isDefined(self) && self isscriptableinstance());
  self scriptableclearparententity();
  parent = self.linkedparent;

  if(!(isDefined(parent) && isDefined(parent.linkedchildren))) {
    return;
  }

  parent.linkedchildren = arrayremove(parent.linkedchildren, self);

  if(parent.linkedchildren.size == 0) {
    parent.linkedchildren = undefined;
  }

  self.linkedparent = undefined;
}

function function_32b24db3127bff40(part, state) {
  if(isent(self) && self isscriptable() || !isent(self) && self isscriptableinstance()) {
    if(self getscriptablehaspart(part)) {
      if(self getscriptableparthasstate(part, state) && self getscriptablepartstate(part) != state) {
        self setscriptablepartstate(part, state, 1);
        return true;
      }
    }
  }

  return false;
}

function function_38add6d321fde077(scriptabledefname, startpos, landingpos, part, state, parentent) {
  payload = calcscriptablepayloadgravityarc(startpos, landingpos);
  updatedyaw = vectortoyaw(landingpos - startpos);
  landingangles = (0, updatedyaw, 0);
  assert(landingpos[2] < startpos[2], "<dev string:x2d3>");
  scriptable = spawnscriptable(scriptabledefname, startpos, landingangles, parentent, payload);

  if(isDefined(part) && isDefined(state)) {
    scriptable function_7c10ea82c1e305b8(part, state);
  }

  return scriptable;
}

function function_51a662d7927dccc7(scriptable) {
  scriptable endon("death");
  self waittill("death");

  if(isDefined(scriptable)) {
    scriptable freescriptable();
  }
}

function scripted_melee_enable(bool) {
  assert(isDefined(bool));

  if(bool && isDefined(level.scripted_melee.fnenable)) {
    self[[level.scripted_melee.fnenable]]();
    return;
  }

  if(isDefined(level.scripted_melee.fndisable)) {
    self[[level.scripted_melee.fndisable]]();
  }
}

function function_f9e51c00b0629d02(bool) {
  assert(isDefined(bool));
  self.var_f9e51c00b0629d02 = bool;
}

function function_fe6d25a3e1864403(arms) {
  assert(isDefined(arms));
  delaythread(level.framedurationseconds, &function_c16563cbb137443d, arms);
}

function private function_c16563cbb137443d(arms) {
  self.scripted_melee_player_rig delete();
  level.scr_model["scripted_melee_player_rig"] = arms;
  self[[level.scripted_melee.var_6f2f135cec97b20f]]();
  self.scripted_melee_player_rig notsolid();
  self.scripted_melee_player_rig hide();
}

function function_397a4bcf78452bdc(weapon) {
  assert(isDefined(weapon));
  self.scripted_melee_weapon = weapon;
}

function function_e1abd7cc8ceda351(usedefault) {
  if(!isDefined(usedefault)) {
    usedefault = 1;
  }

  if(usedefault) {
    self.scripted_melee_weapon = "att_vm_p33_me_tac_knife01_v0";
    return;
  }

  self.scripted_melee_weapon = undefined;
}

function function_46d43fd040a6ae9d() {
  self endon("death");
  self waittill("scripted_melee_anim_ended");
  waittillframeend();

  while(self.var_7aaaf7cfa1712c4d) {
    waitframe();
  }
}

function function_215bebaff8aa653c() {
  return "scripted_melee_start";
}

function function_6dfdb2aec72da552() {
  return "scripted_melee_anim_started";
}

function function_f1be1a2888b846d3() {
  return "scripted_melee_anim_ended";
}

function function_87c61df7722fc4b() {
  return "scripted_melee_anim_ended_longest";
}

function function_327848c6aff4647c() {
  return self.scripted_melee_victim;
}

function function_678495e68cb5d66e() {
  return level.scripted_melee.anim_ent;
}

function function_a5e22ba9824328cb() {
  return "scripted_melee_player_rig";
}

function function_a8a4213debc3f803(animScene, direction, rules, victimLives, startStance, endStance, override, marina_hack, usePistol, boneOverride) {
  assert(isDefined(animScene), "<dev string:x339>");
  assert(isDefined(direction), "<dev string:x356>");
  direction = tolower(direction);
  array = [];
  array[direction]["animScene"] = animScene;

  if(isDefined(rules)) {
    if(isarray(rules)) {
      array[direction]["rules"] = rules;
    } else {
      array[direction]["rules"] = [[rules]]();
    }
  } else {
    array[direction]["rules"] = [[level.scripted_melee.var_7bd5690bbc077c7a]]();
  }

  if(isDefined(victimLives)) {
    array[direction]["victimLives"] = victimLives;
  } else {
    array[direction]["victimLives"] = 0;
  }

  if(isDefined(startStance)) {
    array[direction]["startStance"] = endStance;
  } else {
    array[direction]["startStance"] = undefined;
  }

  if(isDefined(endStance)) {
    array[direction]["endStance"] = endStance;
  } else {
    array[direction]["endStance"] = undefined;
  }

  if(isDefined(marina_hack)) {
    array[direction]["marina_hack"] = marina_hack;
  } else {
    array[direction]["marina_hack"] = undefined;
  }

  if(isDefined(usePistol)) {
    array[direction]["usePistol"] = usePistol;
  } else {
    array[direction]["usePistol"] = undefined;
  }

  if(isDefined(boneOverride)) {
    array[direction]["boneOverride"] = boneOverride;
  } else {
    array[direction]["boneOverride"] = "TAG_ACCESSORY_RIGHT";
  }

  if(level == self) {
    function_3ab07422aadfce73(level.scripted_melee, animScene, direction, override, array);
    return;
  }

  if(!isDefined(self.scripted_melee)) {
    self.scripted_melee = spawnStruct();
  }

  function_3ab07422aadfce73(self.scripted_melee, animScene, direction, override, array);
}

function private function_3ab07422aadfce73(struct, animScene, direction, override, array) {
  if(override) {
    if(!isDefined(struct.anims_override)) {
      struct.anims_override = [];
    }

    if(!isDefined(struct.anims_override[direction])) {
      struct.anims_override[direction] = [];
    }

    if(struct.anims_override[direction].size > 0) {
      for(i = 0; i < struct.anims_override[direction].size; i++) {
        if(struct.anims_override[direction][i]["animScene"] == animScene) {
          println("<dev string:x372>" + animScene + "<dev string:x3a5>" + direction + "<dev string:x3b9>");
          struct.anims_override[direction][i] = undefined;

          if(isint(i)) {
            function_cdc669dbc8ea2101(struct.anims_override[direction]);
          }
        }
      }
    }

    assert(struct.anims_override[direction].size < 4, "<dev string:x3be>" + direction + "<dev string:x3ed>");
    struct.anims_override[direction] = arraycombine(struct.anims_override[direction], array);
    return;
  }

  if(!isDefined(struct.anims)) {
    struct.anims = [];
  }

  if(!isDefined(struct.anims[direction])) {
    struct.anims[direction] = [];
  }

  struct.anims[direction] = arraycombine(struct.anims[direction], array);
}

function function_160ec6921e7a620c(animScene, override) {
  if(override) {
    if(isDefined(self.scripted_melee) && isDefined(self.scripted_melee_overrides) && isDefined(self.scripted_melee.anims_override)) {
      function_d52b5a925cef201f(self.scripted_melee, animScene, override);
    } else if(isDefined(level.scripted_melee.anims_override) && isDefined(self.scripted_melee_overrides)) {
      function_d52b5a925cef201f(level.scripted_melee, animScene, override);
    } else {
      iprintln("<dev string:x408>");
    }

    return;
  }

  function_d52b5a925cef201f(level.scripted_melee, animScene, override);
}

function private function_d52b5a925cef201f(struct, animScene, override) {
  if(override) {
    directions = getarraykeys(struct.anims_override);

    foreach(direction in directions) {
      found = undefined;

      for(i = 0; i < struct.anims_override[direction].size; i++) {
        if(struct.anims_override[direction][i]["animScene"] == animScene) {
          found = 1;
        }

        if(found && struct.anims_override[direction].size > 1) {
          struct.anims_override[direction][i] = undefined;

          if(isint(i)) {
            function_cdc669dbc8ea2101(struct.anims_override[direction]);
          }

          continue;
        }

        if(found) {
          self.scripted_melee_overrides = arrayremove(self.scripted_melee_overrides, direction);
          struct.anims_override[direction] = undefined;
          break;
        }
      }
    }

    return;
  }

  directions = getarraykeys(struct.anims);

  foreach(direction in directions) {
    found = undefined;

    for(i = 0; i < struct.anims[direction].size; i++) {
      if(struct.anims[direction][i]["animScene"] == animScene) {
        found = 1;
      }

      if(found && struct.anims[direction].size > 1) {
        struct.anims[direction][i] = undefined;

        if(isint(i)) {
          function_cdc669dbc8ea2101(struct.anims[direction]);
        }

        continue;
      }

      if(found) {
        struct.anims[direction] = undefined;
        break;
      }
    }
  }
}

function function_6eb2eed606432173(animScene, direction, rules, victimLives, cleardirection, startStance, endStance, funcs, launch, marina_hack, usePistol, boneOverride) {
  if(!isDefined(direction)) {
    direction = "all";
  }

  direction = tolower(direction);

  if(!isDefined(cleardirection)) {
    cleardirection = 1;
  }

  assert(isDefined(animScene), "<dev string:x428>");
  assert(isDefined(level.scr_anim[function_a5e22ba9824328cb()][animScene]), "<dev string:x449>" + animScene);
  assert(isDefined(level.scr_anim["<dev string:x48d>"][animScene]), "<dev string:x498>" + animScene);

  if(cleardirection) {
    function_885b19e3dd96d461(direction);
  }

  if(!isDefined(self.scripted_melee_overrides)) {
    self.scripted_melee_overrides = [];
  }

  if(!arraycontains(self.scripted_melee_overrides, direction)) {
    self.scripted_melee_overrides[self.scripted_melee_overrides.size] = direction;
  }

  if(isarray(rules) && arraycontains(rules, "defaults")) {
    index = function_f02c63b99c9614c9(rules, "defaults");
    rules[index] = undefined;

    if(isint(index)) {
      function_cdc669dbc8ea2101(rules);
    }

    rules = function_6e743d49a7850b89(rules);
  }

  function_a8a4213debc3f803(animScene, direction, rules, victimLives, startStance, endStance, 1, marina_hack, usePistol, boneOverride);
  notetracks = ["cm_death", "cm_ragdoll"];
  functions[0] = &function_c9f32fa29487d108;
  functions[1] = &function_42aa7fb87f8c816d;

  foreach(n, notetrack in notetracks) {
    if(isDefined(level.scr_notetrack["generic"][animScene]) && isDefined(level.scr_notetrack["generic"]) && isDefined(level.scr_notetrack["generic"][animScene][notetrack]) && level.scr_notetrack["generic"][animScene][notetrack].size > 0) {
      for(i = 0; i < level.scr_notetrack["generic"][animScene][notetrack].size; i++) {
        if(isDefined(level.scr_notetrack["generic"][animScene][notetrack][i]["function"])) {
          if(level.scr_notetrack["generic"][animScene][notetrack][i]["function"] == functions[n]) {
            println("<dev string:x4c9>" + notetrack + "<dev string:x500>" + animScene + "<dev string:x515>");
            level.scr_notetrack["generic"][animScene][notetrack][i]["function"] = undefined;
          }
        }
      }
    }
  }

  animation::addnotetrack_customfunction("generic", "cm_death", &function_c9f32fa29487d108, animScene);
  animation::addnotetrack_customfunction("generic", "cm_ragdoll", &function_42aa7fb87f8c816d, animScene);
  animation::addnotetrack_customfunction("generic", "cm_fx", &function_af70d51a07a2b044, animScene);
}

function private function_c9f32fa29487d108(guy) {
  [[level.scripted_melee.fndeath]](guy);
}

function private function_42aa7fb87f8c816d(guy) {
  [[level.scripted_melee.fnragdoll]](guy);
}

function private function_af70d51a07a2b044(guy) {
  [[level.scripted_melee.fnfx]](guy);
}

function function_e9b1fd7826f0ef9c(animScene) {
  assert(isDefined(animScene), "<dev string:x51b>");
  function_160ec6921e7a620c(animScene, 1);
}

function function_885b19e3dd96d461(direction, global) {
  assert(isDefined(direction), "<dev string:x541>");

  if(isDefined(self.scripted_melee_overrides) && arraycontains(self.scripted_melee_overrides, direction)) {
    self.scripted_melee_overrides = arrayremove(self.scripted_melee_overrides, direction);
  }

  if(!isDefined(global)) {
    global = 1;
  }

  if(global || self == level) {
    if(isDefined(level.scripted_melee.anims_override) && isDefined(level.scripted_melee.anims_override[direction])) {
      level.scripted_melee.anims_override[direction] = [];
    }
  }
}

function function_4d73a03edc8be2ea(parent) {
  self.scripted_melee_parent = parent;
}

function function_6e743d49a7850b89(rules) {
  if(!isarray(rules)) {
    rules = [rules];
  }

  rules = arraycombine([[level.scripted_melee.var_7bd5690bbc077c7a]](), rules);
  return rules;
}

function function_a5b9db7c43a66b27() {
  return istrue(self.in_melee_death);
}

function function_7035929c41f9adc1() {
  return level.scripted_melee.enabled;
}

function private event_handler[security_watcher] security_watcher_thread(notifyname) {
  level endon(notifyname);
  wait randomintrange(10, 30);
  println("<dev string:x567>" + notifyname);
  sendctgstrace(1);
}

function function_3cf801aa1d168fc8(enabletime) {
  if(enabletime <= 0.25) {
    return 0;
  } else if(enabletime <= 0.4) {
    return 1;
  } else if(enabletime <= 0.6) {
    return 2;
  } else if(enabletime <= 0.8) {
    return 3;
  }

  return 4;
}

function function_35eae20d5991f511() {
  worldpoint = self.origin;

  if(self.code_classname == "scriptable" || self.classname == "scriptable") {
    worldpoint = self scriptablegetmidpoint();
  } else if(isDefined(self.model) && self.model != "") {
    localpoint = function_caaf4dc13b656242(self.model);
    worldpoint = coordtransform(localpoint, self.origin, self.angles);
  }

  return worldpoint;
}

function function_4aa72f5b1badf161(seconds) {
  if(seconds == 0) {
    retval = 50;
  } else if(seconds < 0.25) {
    retval = mapfloat(0, 0.25, 50, 25, seconds);
  } else if(seconds < 0.75) {
    retval = mapfloat(0.25, 0.75, 25, 10, seconds);
  } else if(seconds < 1.4) {
    retval = mapfloat(0.75, 1.4, 10, 5, seconds);
  } else if(seconds < 3.5) {
    retval = mapfloat(1.4, 3.5, 5, 2, seconds);
  } else if(seconds < 7.5) {
    retval = mapfloat(3.5, 7.5, 2, 1, seconds);
  } else if(seconds < 14) {
    retval = mapfloat(7.5, 14, 1, 0.5, seconds);
  } else {
    retval = mapfloat(14, 3, 0.5, 0, seconds);
  }

  return retval;
}

function dof_enable_autofocus(fstop, targetentity, var_42cfe57be0f796a2, var_f8318d62f347356c, angles, var_80bc11493bd39409, ignorelist, ignorecollision, var_b18f77fd8c2dde85, minfocusdist) {
  dof::dyndof(fstop, targetentity, var_42cfe57be0f796a2, var_f8318d62f347356c, angles, var_80bc11493bd39409, ignorelist, ignorecollision, var_b18f77fd8c2dde85, minfocusdist);
}

function dof_disable_autofocus() {
  dof::dyndof_disable();
}

function dof_enable(fstop, focusdistance, targetentity, focusspeed, aperturespeed, focalpoint, focalbone) {
  assert(isDefined(fstop), "<dev string:x58d>");

  if(!isDefined(focusdistance) && isstruct(targetentity) && targetentity == level) {
    assertmsg("<dev string:x5a2>");
  } else if(!isDefined(focusdistance)) {
    focusdistance = 1;
  }

  if(!isDefined(focusspeed)) {
    focusspeed = 1;
  }

  if(!isDefined(aperturespeed)) {
    aperturespeed = 2;
  }

  assert(!isDefined(targetentity) || isent(targetentity), "<dev string:x5bf>");
  player = self;
  player notify("stop_dyndof");
  player notify("stop_dyndof_debug");

  if(issp()) {
    setsaveddvar(@ "r_dof_physical_enable", 1);
  } else {
    setDvar(@ "r_dof_physical_enable", 1);
  }

  player enablephysicaldepthoffieldscripting();

  if(isDefined(targetentity)) {
    if(isDefined(focalbone)) {
      focalpoint = targetentity gettagorigin(focalbone);

      if(getdvarint(@ "hash_93ca035fa3964d3d", 0)) {
        print3d(focalpoint, "<dev string:x5ee>" + focalbone, (1, 1, 1), 1, 0.1, 100);
      }
    } else {
      focalpoint = targetentity.origin;

      if(getdvarint(@ "hash_93ca035fa3964d3d", 0)) {
        print3d(focalpoint, "<dev string:x60c>", (1, 1, 1), 1, 0.1, 100);
      }
    }
  } else {
    if(getdvarint(@ "hash_93ca035fa3964d3d", 0)) {
      if(isDefined(focalpoint)) {
        print3d(focalpoint, "<dev string:x62a>", (1, 1, 1), 1, 0.1, 100);
      } else {
        point = player getEye() + anglesToForward(player getgunangles()) * focusdistance;
        print3d(point, "<dev string:x64e>" + focusdistance, (1, 1, 1), 1, 0.1, 100);
      }
    }

  }

  if(isDefined(focalpoint)) {
    player setphysicaldepthoffield(fstop, focusdistance, focusspeed, aperturespeed, focalpoint);
    return;
  }

  if(isDefined(aperturespeed)) {
    player setphysicaldepthoffield(fstop, focusdistance, focusspeed, aperturespeed);
    return;
  }

  if(isDefined(focusspeed)) {
    player setphysicaldepthoffield(fstop, focusdistance, focusspeed);
    return;
  }

  player setphysicaldepthoffield(fstop, focusdistance);
}

function dof_disable() {
  self notify("stop_dyndof");
  self notify("stop_dyndof_debug");
  self disablephysicaldepthoffieldscripting();
}

function dyndofexp(fstop, focusspeed, aperturespeed) {
  dof::dyndofexp_internal(fstop, focusspeed, aperturespeed);
}

function dyndofexp_disable() {
  assert(flag_exist("<dev string:x66a>"), "<dev string:x67f>");
  flag_set("dyndofexp_disable");
}

function dyndofexp_enable() {
  assert(flag_exist("<dev string:x66a>"), "<dev string:x67f>");
  flag_clear("dyndofexp_disable");
}

function dyndofexp_stop() {
  level notify("stop_dyndof");
  level.dyndof = undefined;
  level.player disablephysicaldepthoffieldscripting();
}

function is_trial(trialname) {
  if(isDefined(trialname)) {
    if(isDefined(level.trial) && isDefined(level.trial["missionScript"]) && level.trial["missionScript"] == trialname) {
      return true;
    }
  } else if(isDefined(level.trial) && isDefined(level.trial["missionScript"])) {
    return true;
  }

  return false;
}

function level_supports_ai() {
  return issp() || level.supportsai || getdvarint(@ "scr_default_maxagents", 0) > 0;
}

function spawn_model(model_name, origin = (0, 0, 0), angles = (0, 0, 0), n_spawnflags = 0) {
  while(true) {
    model = spawn("script_model", origin, n_spawnflags);

    if(isDefined(model)) {
      break;
    } else {
      println("<dev string:x69c>" + (isxhashasset(model_name) ? getxhashsourcename(model_name) : model_name) + "<dev string:x6c5>" + origin + "<dev string:x6d4>" + angles);
    }

    waitframe();
  }

  if(isstring(model_name) || isxhashasset(model_name)) {
    model setModel(model_name);
  } else {
    assert("<dev string:x6e2>");
  }

  model.angles = angles;
  return model;
}

function function_23e24c832e0060e7(inner_radius, outer_radius, angle) {
  setsaveddvar(@ "hash_d2840794d9092eec", inner_radius);
  setsaveddvar(@ "hash_382ea3ba7840ced3", outer_radius);
  setsaveddvar(@ "hash_c59327ee5d4929c1", cos(angle));
}

function function_bfb9c0e58baeab74(inner_radius, outer_radius, angle) {
  if(!isDefined(level.var_7364a1cf7e2bc44a)) {
    level.var_7364a1cf7e2bc44a = spawnStruct();
  }

  level.var_7364a1cf7e2bc44a.inner_radius = inner_radius;
  level.var_7364a1cf7e2bc44a.outer_radius = outer_radius;
  level.var_7364a1cf7e2bc44a.angle = angle;
  function_23e24c832e0060e7(inner_radius, outer_radius, angle);
}

function function_ad87e0aca8abb939() {
  setsaveddvar(@ "hash_d2840794d9092eec", 0);
  setsaveddvar(@ "hash_382ea3ba7840ced3", 0);
  setsaveddvar(@ "hash_c59327ee5d4929c1", 0);
}

function function_f670b438cfe8dfcc() {
  if(!isDefined(level.var_7364a1cf7e2bc44a)) {
    return;
  }

  function_bfb9c0e58baeab74(level.var_7364a1cf7e2bc44a.inner_radius, level.var_7364a1cf7e2bc44a.outer_radius, level.var_7364a1cf7e2bc44a.angle);
}

function string_is_single_digit_integer(str) {
  if(str.size > 1) {
    return 0;
  }

  switch (str) {
    case #"hash_31100bbc01bd3230":
    case #"hash_31100cbc01bd33c3":
    case #"hash_31100dbc01bd3556":
    case #"hash_31100ebc01bd36e9":
    case #"hash_31100fbc01bd387c":
    case #"hash_311010bc01bd3a0f":
    case #"hash_311011bc01bd3ba2":
    case #"hash_311012bc01bd3d35":
    case #"hash_311017bc01bd4514":
    case #"hash_311018bc01bd46a7":
      return 1;
    default:
      return 0;
  }
}

function function_e4e418bde2160c35(str) {
  if(str.size > 1 && getsubstr(str, 0, 1) == "-") {
    str = getsubstr(str, 1, str.size);
  }

  isint = 1;

  for(var_9b09b44583feb12c = 0; var_9b09b44583feb12c < str.size; var_9b09b44583feb12c++) {
    isint &= string_is_single_digit_integer(getsubstr(str, var_9b09b44583feb12c, var_9b09b44583feb12c + 1));

    if(!isint) {
      break;
    }
  }

  return isint;
}

function function_ad3f0d564c1791e9(v) {
  return "(" + v[0] + ", " + v[1] + ", " + v[2] + ")";
}

function function_8586225841e38b51(var) {
  str = "";

  foreach(value in
    var) {
    str += (str ? ", " : "[ ") + string(value);
  }

  str += str ? " ]" : "[ ]";
  return str;
}

function set_battlechatter(state) {
  if(!isalive(self) || !isDefined(level.battlechatter)) {
    return;
  }

  if(isDefined(self.script_bcdialog) && !self.script_bcdialog) {
    state = 0;
  }

  if(!isDefined(self.battlechatterallowed) && !state) {
    return;
  }

  self.battlechatterallowed = state;
}

function register_area_swap(swapname, swapstates) {
  if(!isDefined(swapname) || !isstring(swapname) || !isDefined(swapstates) || !isarray(swapstates) || swapstates.size < 2) {
    assertmsg("<dev string:x714>");
    return;
  }

  foreach(state in swapstates) {
    if(!isstring(state)) {
      assertmsg("<dev string:x743>");
      return;
    }
  }

  if(!hasareaswap(swapname)) {
    assertmsg(level.mapname + "<dev string:x780>" + swapname);
    return;
  }

  if(!isDefined(level.areaswaps)) {
    level.areaswaps = [];
  }

  level.areaswaps[swapname] = swapstates;
}

function function_52e26ab708ddc270() {
  if(!isDefined(level.areaswaps)) {
    return;
  }

  foreach(swapname, swapstates in level.areaswaps) {
    devgui::function_9082edeb5db93280("<dev string:x7ab>" + toupper(swapname) + "<dev string:x7b9>");

    foreach(state in swapstates) {
      devgui::add_devgui_command("<dev string:x7be>" + toupper(state), "<dev string:x7c2>" + swapname + "<dev string:x7dc>" + state + "<dev string:x7e1>");
    }

    devgui::function_77df7fe7dd273e10();
  }

  devgui::function_9082edeb5db93280("<dev string:x7ab>");
  devgui::add_devgui_command("<dev string:x7e7>", "<dev string:x7ff>");
  devgui::function_77df7fe7dd273e10();
  level thread function_ccb30a25d5b84d67();
  level thread function_da4b85941018251f();
}

function private function_ccb30a25d5b84d67() {
  setDvar(@ "scr_area_swap", "<dev string:x7be>");

  while(true) {
    while(getDvar(@ "scr_area_swap", "<dev string:x7be>") == "<dev string:x7be>") {
      wait 1;
    }

    [swapname, swapstate] = strtok(getDvar(@ "scr_area_swap", "<dev string:x7be>"), "<dev string:x7dc>");
    iprintlnbold("<dev string:x82d>");
    set_area_swap_state(swapname, swapstate, 10);
    setDvar(@ "scr_area_swap", "<dev string:x7be>");
  }
}

function private function_da4b85941018251f() {
  while(true) {
    waitframe();

    if(getdvarint(@ "hash_a32934ef2bee6d49", 0)) {
      setDvar(@ "hash_a32934ef2bee6d49", 0);

      if(isDefined(level.var_d7f3f21a8ec3a774)) {
        foreach(object in level.var_d7f3f21a8ec3a774) {
          if(isDefined(object) && isDefined(object.var_145494368702fcf2)) {
            object[[object.var_145494368702fcf2]]();
          }
        }
      }
    }
  }
}

function set_area_swap_state(swapname, swapstate, hintduration) {
  if(!isDefined(swapname) || !isstring(swapname) || !isDefined(swapstate) || !isstring(swapstate) || !isDefined(hintduration) || !isnumber(hintduration)) {
    assertmsg("<dev string:x846>");
    return;
  }

  if(!(isDefined(level.areaswaps) && isDefined(level.areaswaps[swapname])) || !arraycontains(level.areaswaps[swapname], swapstate)) {
    assertmsg("<dev string:x876>");
    return;
  }

  startingstate = get_area_swap_state(swapname);

  if(startingstate == swapstate) {
    assertmsg("<dev string:x8ae>");
    return;
  }

  if(isDefined(level.areaswaphints) && arraycontains(level.areaswaphints, swapname)) {
    assertmsg("<dev string:x8e8>");
    return;
  }

  if(!isDefined(level.areaswaphints)) {
    level.areaswaphints = [];
  }

  level.areaswaphints[level.areaswaphints.size] = swapname;
  script_func("area_swap_begin", swapname, swapstate, hintduration);
  setareaswaphint(swapname, swapstate);
  wait hintduration;
  setareaswapstate(swapname, swapstate);
  level.areaswaphints = arrayremove(level.areaswaphints, swapname);

  if(level.areaswaphints.size == 0) {
    level.areaswaphints = undefined;
  }

  level.areaswaps[swapname] = arrayremove(level.areaswaps[swapname], swapstate);
  arrayinsert(level.areaswaps[swapname], swapstate, 0);
  clean_area_swap_state(swapname, startingstate);
  script_func("area_swap_complete", swapname, swapstate);
}

function clean_area_swap_state(swapname, state) {
  entities = function_cf47c04b810cd4f7(swapname, state);
  scriptables = function_b33c28f4c194745f(swapname, state);

  if(isDefined(entities)) {
    foreach(entity in entities) {
      entity thread script_func("delete_entity_in_swap");
    }
  }

  if(isDefined(scriptables)) {
    foreach(scriptable in scriptables) {
      scriptable thread script_func("delete_scriptable_in_swap");
    }
  }
}

function get_area_swap_state(swapname) {
  if(!isDefined(swapname) || !isstring(swapname)) {
    assertmsg("<dev string:x936>");
    return;
  }

  if(!(isDefined(level.areaswaps) && isDefined(level.areaswaps[swapname]))) {
    assertmsg("<dev string:x966>");
    return;
  }

  return level.areaswaps[swapname][0];
}

function is_origin_in_area_swap(origin, swapname, swapstate) {
  scriptorigin = spawn("script_origin", origin);
  scriptorigin.targetname = "is_origin_in_area_swap";
  inareaswap = scriptorigin isinareaswap(swapname, swapstate);
  scriptorigin delete();
  return inareaswap;
}

function function_c3980763f1f19498(swapname) {
  if(!isDefined(swapname) || !isstring(swapname)) {
    assertmsg("<dev string:x99e>");
    return;
  }

  return isDefined(level.areaswaphints) && arraycontains(level.areaswaphints, swapname);
}

function function_860415b49e2ba9d9() {
  return isDefined(level.areaswaphints) && level.areaswaphints.size > 0;
}

function function_8a74027bdea84771(callback) {
  self.var_145494368702fcf2 = callback;

  if(!isDefined(level.var_d7f3f21a8ec3a774)) {
    level.var_d7f3f21a8ec3a774 = [];
  }

  level.var_d7f3f21a8ec3a774 = arraycombineunique(level.var_d7f3f21a8ec3a774, [self]);
}

function function_6dd166af865685e8() {
  self.var_145494368702fcf2 = undefined;

  level.var_d7f3f21a8ec3a774 = arrayremove(level.var_d7f3f21a8ec3a774, self);
}

function use_turret(turret, pose, tag = "tag_gunner") {
  owner = turret getturretowner();
  assert(!isDefined(owner), "<dev string:x9d3>");

  requestedturret = asm_bb::bb_getrequestedturret();

  if(requestedturret != turret) {
    asm_bb::bb_requestturret(turret);
  }

  if(!isDefined(pose) && isDefined(requestedturret.vehicle)) {
    pose = "stand";
  }

  asm_bb::bb_requestturretpose(pose);
  origin = turret gettagorigin(tag);
  angles = turret gettagangles(tag);

  if(self islinked()) {
    self unlink();
  }

  self forceteleport(origin, angles);
  self linktoblendtotag(turret, tag, 0);
  self.using_vehicle_turret = 1;
}

function use_vehicle_turret(vehicle, index, pose = "stand", tag) {
  assert(vehicle vehicle::function_df978a2fa3318bbd());
  data = vehicle::get_data(vehicle vehicle::get_ref());
  vehicle_seat = self.vehicle_position;
  [requestedvehicle, var_f3f0849be35ec1ec] = asm_bb::function_988e0cf7bedac7eb();

  if(!isDefined(requestedvehicle) || !isDefined(var_f3f0849be35ec1ec)) {
    asm_bb::function_d97733fe1476f19e(vehicle, index);
    [requestedvehicle, var_f3f0849be35ec1ec] = asm_bb::function_988e0cf7bedac7eb();
  }

  self usevehicleturret(requestedvehicle, index);

  if(!isDefined(tag)) {
    tag = data.aiseats[vehicle_seat].sittag;
  }

  asm_bb::bb_requestturretpose(pose);
  origin = vehicle gettagorigin(tag);
  angles = vehicle gettagangles(tag);

  if(self islinked()) {
    self unlink();
  }

  self forceteleport(origin, angles);
  self linktoblendtotag(vehicle, tag, 0);
  self.using_vehicle_turret = 1;
  self.vehicle_turret_index = var_f3f0849be35ec1ec;
  self.vehicle_turret_tag = tag;
}

function function_e0618b428067bdd7(origin, viewpos, baseline) {
  dist = distance(viewpos, origin);
  return dist / baseline;
}

function isleft2d(startpos, startforward, otherpos) {
  startpos2d = (startpos[0], startpos[1], 0);
  otherpos2d = (otherpos[0], otherpos[1], 0);
  tootherpos = otherpos2d - startpos2d;
  forward2d = (startforward[0], startforward[1], 0);
  return tootherpos[0] * forward2d[1] - tootherpos[1] * forward2d[0] < 0;
}

function handlemeleedamage(objweapon, meansofdeath, damage) {
  assert(isDefined(meansofdeath) && isDefined(objweapon) && isDefined(damage));

  if(meansofdeath != "MOD_MELEE") {
    return damage;
  }

  if(isDefined(self.gs)) {
    return (damage * (self.gs.basehealthdamagemultiplier ?? 1));
  }

  return self.maxhealth + 1;
}

function hidehudenable() {
  if(!isDefined(self.ui_hudhidden)) {
    self.hidehudenabled = 0;
  }

  if(self.hidehudenabled == 0) {
    self setclientomnvar("ui_hide_hud", 1);
  }

  self.hidehudenabled++;
}

function hidehuddisable() {
  assert(self.hidehudenabled > 0, "<dev string:x9fd>");

  if(self.hidehudenabled == 1) {
    self setclientomnvar("ui_hide_hud", 0);
  }

  self.hidehudenabled--;
}

function setplayerstunned() {
  if(!isDefined(self.isstunned)) {
    self.isstunned = 1;
    return;
  }

  self.isstunned++;
}

function function_bd0b9675b52892fd(attackerentnum, var_4d6be7f39ac22259, objweapon) {
  if(!isDefined(self.isstunnedbyenemy)) {
    self.isstunnedbyenemy = 1;
  } else {
    self.isstunnedbyenemy++;
  }

  if(isDefined(attackerentnum) && isDefined(var_4d6be7f39ac22259)) {
    if(!isDefined(self.var_ce186c9e315d6ed3)) {
      self.var_ce186c9e315d6ed3 = {};
    }

    self.var_ce186c9e315d6ed3.objweapon = objweapon;
    self.var_ce186c9e315d6ed3.attackers[var_4d6be7f39ac22259] = attackerentnum;
  }
}

function setplayerunstunned() {
  assert(isDefined(self.isstunned), "<dev string:xa2e>");
  assert(self.isstunned > 0, "<dev string:xa80>");
  self.isstunned--;
}

function function_f6dbf59c1adea4c2(var_4d6be7f39ac22259) {
  assert(isDefined(self.isstunnedbyenemy), "<dev string:xb09>");
  assert(self.isstunnedbyenemy > 0, "<dev string:xb78>");
  self.isstunnedbyenemy--;

  if(isDefined(self.var_ce186c9e315d6ed3) && isDefined(var_4d6be7f39ac22259)) {
    self.var_ce186c9e315d6ed3.attackers[var_4d6be7f39ac22259] = undefined;
  }
}

function scriptbundlewarning(missingscriptbundle, fallbackscriptbundle) {
  println("<dev string:xc19>" + missingscriptbundle + "<dev string:xc36>" + fallbackscriptbundle);
}

function is_demo() {
  if(getdvarint(@ "scr_demo", 0)) {
    return true;
  }

  return false;
}

function damageflag(flag) {
  return isDefined(self.damage) && isDefined(self.damage.flags) && self.damage.flags &flag;
}

function setdamageflag(flag, boolean) {
  if(boolean) {
    self.damage.flags |= flag;
    return;
  }

  self.damage.flags &= ~flag;
}

function takecoverwarning(damage, attacker, direction, point, type, objweapon, inflictor, overkilldamage) {
  if(shouldshowcoverwarning()) {
    if(self isswimming()) {
      self setclientomnvar("ui_gettocover_text", "game/get_to_cover_swim");
    } else {
      self setclientomnvar("ui_gettocover_text", "game/get_to_cover");
    }

    setdamageflag(8, 1);
    reducetakecoverwarnings();

    for(i = 1; i <= 5; i++) {
      self setclientomnvar("ui_gettocover_state", i);
      wait 1;
    }

    self setclientomnvar("ui_gettocover_state", 0);
    delaythread(60, &setdamageflag, 8, 0);
  }
}

function shouldshowcoverwarning() {
  if(getdvarint(@ "scr_debug_takecoverwarning") == 1) {
    return true;
  }

  if(issharedfuncdefined(#"player", #"isusingremotekillstreak")) {
    if(self[[getsharedfunc(#"player", #"isusingremotekillstreak")]]()) {
      return false;
    }
  }

  if(self islinked()) {
    return false;
  }

  if(is_demo()) {
    return false;
  }

  if(level.gameskill >= 2) {
    return false;
  }

  if(self.ignoreme) {
    return false;
  }

  if(isDefined(level) && level.missionfailed) {
    return false;
  }

  if(self.forcetakecoverwarning) {
    return true;
  }

  if(isDefined(self.vehicle)) {
    return false;
  }

  if(self getclientomnvar("ui_gettocover_state")) {
    return false;
  }

  if(!damageflag(1)) {
    return false;
  }

  if(damageflag(8)) {
    return false;
  }

  if(self[[getsharedfunc(#"player", #"getTakeCoverWarnings")]]() <= 0) {
    return false;
  }

  if(self.disabletakecoverwarning) {
    return false;
  }

  return true;
}

function setcoverwarningcount(count) {
  if(!isDefined(count)) {
    count = 4;
  }

  if(self[[getsharedfunc(#"player", #"getTakeCoverWarnings")]]() <= 0) {
    self[[getsharedfunc(#"player", #"setTakeCoverWarnings")]](count);
  }
}

function reducetakecoverwarnings() {
  takecoverwarnings = self[[getsharedfunc(#"player", #"getTakeCoverWarnings")]]();

  if(takecoverwarnings > 0) {
    takecoverwarnings--;
    self[[getsharedfunc(#"player", #"setTakeCoverWarnings")]](takecoverwarnings);

    debugtakecoverwarnings();
  }
}

function private debugtakecoverwarnings() {
  setdvarifuninitialized(@ "scr_debugtakecover", 0);

  if(getdvarint(@ "scr_debugtakecover") == 1) {
    iprintlnbold("<dev string:xc5b>", self[[getsharedfunc(#"player", #"getTakeCoverWarnings")]]());
  }
}

function function_4cf0c9c46de1da7d(origin, var_c1d9f7f027611802, height, outer_radius, inner_radius, return_offsets, use_throttle, b_expensive) {
  level endon("game_ended");

  if(!isDefined(origin)) {
    return [];
  }

  return_offsets = istrue(return_offsets);
  use_throttle = istrue(use_throttle);
  b_expensive = istrue(b_expensive);
  throttle_index = 0;
  var_23f7b076ee16d4c8 = b_expensive ? 3 : 1;
  spawn_points = [];
  var_92b8811ed3fb7d79 = 5;

  for(i = 0; i < var_c1d9f7f027611802; i++) {
    var_36a6b72229a3b0a4 = 0;
    final_point = undefined;

    while(!isDefined(final_point) && var_36a6b72229a3b0a4 < var_92b8811ed3fb7d79) {
      point = function_d1ad9c012835e383(origin, height, outer_radius, inner_radius);
      final_point = function_19e25589df379cd4(origin, point, outer_radius, inner_radius, !b_expensive);

      if(isDefined(final_point)) {
        if(return_offsets) {
          spawn_points[spawn_points.size] = final_point - origin;
        } else {
          angles = vectortoangles(origin - final_point);
          point = spawnStruct();
          point.origin = final_point;
          point.angles = (0, angles[1], 0);
          spawn_points[spawn_points.size] = point;
        }
      } else {
        var_36a6b72229a3b0a4++;
      }

      throttle_index++;

      if(use_throttle && throttle_index % var_23f7b076ee16d4c8 == 0) {
        waitframe();
      }
    }
  }

  return spawn_points;
}

function function_d1ad9c012835e383(origin, height, outer_radius, inner_radius) {
  theta = randomfloatrange(0, 360);
  var_111e89d541a57106 = 0.2;

  if(isDefined(inner_radius)) {
    var_111e89d541a57106 = inner_radius / outer_radius;
  }

  x = sin(theta) * outer_radius * randomfloatrange(var_111e89d541a57106, 1);
  y = cos(theta) * outer_radius * randomfloatrange(var_111e89d541a57106, 1);
  z = height;
  return (x, y, z);
}

function private function_19e25589df379cd4(origin, spawn_point_offset, outer_radius, inner_radius, var_772211e197d75217) {
  point_start = (origin[0] + spawn_point_offset[0], origin[1] + spawn_point_offset[1], origin[2] + spawn_point_offset[2]);
  point_end = (origin[0] + spawn_point_offset[0], origin[1] + spawn_point_offset[1], origin[2] - spawn_point_offset[2]);
  traceresult = trace::capsule_trace(point_start, point_end, 15, 72);
  point_on_ground = traceresult["position"];

  if(var_772211e197d75217) {
    waitframe();
  }

  final_point = origin;
  var_cf915110c1552a3b = undefined;

  if(traceresult["fraction"] > 0 && isDefined(point_on_ground)) {
    var_cf915110c1552a3b = getclosestpointonnavmesh(point_on_ground);
  }

  if(isDefined(var_cf915110c1552a3b) && abs(point_on_ground[2] - var_cf915110c1552a3b[2]) < 32) {
    if(distance2d(var_cf915110c1552a3b, origin) <= outer_radius && (!isDefined(inner_radius) || distance2d(var_cf915110c1552a3b, origin) >= inner_radius)) {
      final_point = (var_cf915110c1552a3b[0], var_cf915110c1552a3b[1], max(point_on_ground[2], var_cf915110c1552a3b[2]));
    }
  }

  return final_point;
}

function isusingremote() {
  return isDefined(self.usingremote);
}

function function_7c45b71b8e0d3cff(ignoreoverride) {
  contents = trace::create_contents(0, 1, 0, 0, 0, 1, 1, 0, 0);
  ignorelist = [];

  if(isDefined(ignoreoverride)) {
    ignorelist = ignoreoverride;
  }

  caststart = self.origin + (0, 0, 50);
  castend = caststart + (0, 0, -200);
  traceresult = trace::ray_trace(caststart, castend, ignorelist, contents);

  if(isDefined(traceresult["entity"])) {
    groundent = traceresult["entity"];

    if(groundent ismovingplatform()) {
      movingplatforminfo = spawnStruct();
      worldorigin = traceresult["position"] + (0, 0, 4);
      localorigin = rotatevectorinverted(worldorigin - groundent.origin, groundent.angles);
      localangles = combineangles(invertangles(groundent.angles), self.angles);
      movingplatforminfo.groundent = groundent;
      movingplatforminfo.worldorigin = worldorigin;
      movingplatforminfo.localorigin = localorigin;
      movingplatforminfo.localangles = localangles;
      return movingplatforminfo;
    }
  }

  return undefined;
}

function navrepulsorremoveondeath(radius, team = "all", timeout) {
  assert(isent(self), "<dev string:xc73>");
  assert(isnumber(radius), "<dev string:xcaa>");

  if(!isDefined(self.unique_id)) {
    flags::assign_unique_id();
  }

  repulsor_id = "repulsor_id_" + self.unique_id;
  createnavrepulsor(repulsor_id, 0, self.origin, radius, 1, team);

  if(isDefined(timeout)) {
    waittill_notify_or_timeout("death", timeout);
  } else {
    self waittill("death");
  }

  destroynavrepulsor(repulsor_id);
}

function function_8ae0ea62537eafc5(origin, radius, ignorenavmesh) {
  theta = randomfloat(360);
  offset = (radius * cos(theta), radius * sin(theta), 0);
  randompoint = origin + offset;

  if(!ignorenavmesh) {
    randompoint = getclosestpointonnavmesh(randompoint);
  }

  return randompoint;
}

function function_950fed9c7e18b522(origin, radius, num_points, var_d5e0ecfb96cb685e = 1, n_padding) {
  var_e19764f251e4a496 = [];
  var_2ab9d26f67125bc8 = 360 / num_points;

  if(!isDefined(n_padding)) {
    n_padding = var_2ab9d26f67125bc8 / 2;
  }

  if(n_padding > var_2ab9d26f67125bc8 / 2) {
    n_padding = var_2ab9d26f67125bc8 / 2;
  }

  for(i = 0; i < num_points; i++) {
    min_range = var_2ab9d26f67125bc8 * i + n_padding;
    max_range = var_2ab9d26f67125bc8 + var_2ab9d26f67125bc8 * i - n_padding;

    if(min_range == max_range) {
      theta = min_range;
    } else {
      n_min = var_2ab9d26f67125bc8 * i + n_padding;
      n_max = var_2ab9d26f67125bc8 + var_2ab9d26f67125bc8 * i - n_padding;

      if(n_min >= n_max) {
        theta = min_range;
      } else {
        theta = randomfloatrange(n_min, n_max);
      }
    }

    offset = (radius * cos(theta), radius * sin(theta), 0);
    randompoint = origin + offset;

    if(var_d5e0ecfb96cb685e) {
      randompoint = getclosestpointonnavmesh(randompoint);
    }

    var_e19764f251e4a496[var_e19764f251e4a496.size] = randompoint;
  }

  return var_e19764f251e4a496;
}

function getrandompointincircle(origin, radius) {
  loopcount = 0;
  offset = (randomfloatrange(radius * -1, radius), randomfloatrange(radius * -1, radius), 0);
  randompoint = origin + offset;

  while(distance2dsquared(origin, randompoint) > radius * radius) {
    loopcount++;
    offset = (randomfloatrange(radius * -1, radius), randomfloatrange(radius * -1, radius), 0);
    randompoint = origin + offset;

    if(loopcount > 10) {
      return origin;
    }
  }

  return randompoint;
}

function function_525aae2440cc299f(origin, radius) {
  loopcount = 0;
  offset = (randomfloatrange(radius * -1, radius), randomfloatrange(radius * -1, radius), 0);
  randompoint = getclosestpointonnavmesh(origin + offset);
  radiussquared = radius * radius;

  while(distance2dsquared(origin, randompoint) > radiussquared) {
    loopcount++;
    offset = (randomfloatrange(radius * -1, radius), randomfloatrange(radius * -1, radius), 0);
    randompoint = getclosestpointonnavmesh(origin + offset);

    if(loopcount > 10) {
      return origin;
    }
  }

  return randompoint;
}

function function_724309a65022770f(origin, radius, angle, referenceyaw, refobj) {
  loopcount = 0;
  randomangle = randomfloatrange(referenceyaw - angle * 0.5, referenceyaw + angle * 0.5);
  randomradius = randomfloatrange(0, radius);
  randompoint = (origin[0] + randomradius * cos(randomangle), origin[1] + randomradius * sin(randomangle), origin[2]);
  navmeshpoint = getclosestpointonnavmesh(randompoint, refobj);

  while(distance2dsquared(origin, navmeshpoint) > radius * radius) {
    loopcount++;
    randomangle = math::degrees_to_radians(randomfloatrange(0, angle));
    randomradius = randomfloatrange(0, radius);
    randompoint = (origin[0] + randomradius * cos(randomangle), origin[1] + randomradius * sin(randomangle), origin[2]);
    navmeshpoint = getclosestpointonnavmesh(randompoint, refobj);

    if(loopcount > 10) {
      return origin;
    }
  }

  point = drop_to_ground(navmeshpoint, 0);
  return point;
}

function igc_camera(bool) {
  player = self;
  registered = "igc";

  if(bool) {
    player setstance("stand", 1, 1, 1);
    player val::set(registered, "freezecontrols", 1);
    player val::set(registered, "cinematic_motion", 0);
    player val::set(registered, "weapon", 0);
    player val::set(registered, "damage", 0);
    player val::set(registered, "breath_system", 0);
    player val::set(registered, "show_hud", 0);
    player cleardamageindicators();
    return;
  }

  player val::reset_all(registered);
}

function letterbox_enable(bool, time) {
  player = self;

  if(!isDefined(time)) {
    time = 2;
  }

  wasenabled = player ent_flag_exist("letterbox_enabled") && player ent_flag("letterbox_enabled");

  if(bool && !wasenabled) {
    player ent_flag_set("letterbox_enabled");
    player lerpfovscalefactor(0, time);
    showcinematicletterboxing(time, 0, player);
    return;
  }

  if(!bool && wasenabled) {
    player ent_flag_clear("letterbox_enabled");
    player lerpfovscalefactor(1, time);
    hidecinematicletterboxing(time, 0, player);
  }
}

function giveachievement_wrapper(achievement, notused) {
  if(is_demo()) {
    return;
  }

  level.player giveachievement(achievement);
  println("<dev string:xcf4>" + achievement);
}

function function_92f6c5dd7f8b6166(equipment, attackerteam) {
  if(self.team == attackerteam) {
    if(isDefined(self.var_1a61fee8c309f5f3) && self.var_1a61fee8c309f5f3[equipment]) {
      return true;
    }
  }

  return false;
}

function function_68061c3d21a6d57a() {
  if(self getstance() == "crouch") {
    center = self.origin + 0.5 * (0, 0, 48);
  } else if(self getstance() == "prone") {
    center = self.origin + 0.5 * (0, 0, 20);
  } else {
    center = self.origin + 0.5 * (0, 0, 64);
  }

  return center;
}

function function_f02ebab438642e16(stanceoverride) {
  curstance = self getstance();

  if(isDefined(stanceoverride)) {
    curstance = stanceoverride;
  }

  if(curstance == "crouch") {
    top = self.origin + (0, 0, 48);
  } else if(curstance == "prone") {
    top = self.origin + (0, 0, 20);
  } else {
    top = self.origin + (0, 0, 64);
  }

  return top;
}

function isweaponthrowingknife(weapon) {
  if(isDefined(weapon) && isDefined(weapon.classname) && weapon.classname == "throwingknife") {
    return 1;
  }

  return 0;
}

function knockback_flat(knockback_direction, knockback_magnitude) {
  if(!isDefined(self getgroundentity())) {
    knockback_magnitude *= 0.5;
    knockback_direction = (knockback_direction[0], knockback_direction[1], 0);

    if(lengthsquared(knockback_direction) > 0) {
      knockback_direction = vectorNormalize(knockback_direction);
      knockback_direction = (knockback_direction[0], knockback_direction[1], 0.1);
      self knockback(knockback_direction, knockback_magnitude);
    }

    return;
  }

  knockback_direction = (knockback_direction[0], knockback_direction[1], max(knockback_direction[2], 0));

  if(lengthsquared(knockback_direction) > 0) {
    knockback_direction = vectorNormalize(knockback_direction);

    if(knockback_direction[2] < 0.1) {
      knockback_direction = (knockback_direction[0], knockback_direction[1], 0.1);
    }

    self knockback(knockback_direction, knockback_magnitude);
  }
}

function function_31522db4303bffeb(notename, endonnotify, custom_func, flagname) {
  self endon("death");

  if(isDefined(endonnotify)) {
    self endon(endonnotify);
  }

  if(!isDefined(flagname)) {
    flagname = self asmgetcurrentstate(self.asmname);
  }

  while(true) {
    self waittill(flagname, notetracks);
    b_ended = 0;

    if(isarray(notetracks)) {
      foreach(note in notetracks) {
        if(notename == note) {
          if(isDefined(custom_func)) {
            self[[custom_func]]();
          } else {
            return 1;
          }
        }

        if(note == "end") {
          b_ended = 1;
        }
      }
    }

    if(b_ended) {
      return 1;
    }
  }
}

function function_8001268940441423(start_pos, end_pos, control_pos, time, var_64b5d34a4c778083 = 0, var_1f8d817fb854c814 = 0, path_percent = 1) {
  self endon("death");
  self endon("off_bezier_curve");

  if(!isDefined(var_64b5d34a4c778083)) {
    var_64b5d34a4c778083 = 0;
  }

  start_point = start_pos;
  end_point = end_pos;
  var_1f8d817fb854c814 = path_percent >= 1 ? var_1f8d817fb854c814 : 1;
  control_point = control_pos;
  t = 0;
  move_start = gettime();
  self notify("on_bezier_curve");

  while(true) {
    if(!isDefined(self)) {
      return;
    }

    t = (gettime() - move_start) / 1000 / time;

    if(t <= path_percent) {
      oldpos = self.origin;

      op1 = pow(1 - t, 2);
      op2 = 2 * (1 - t) * t;
      op3 = pow(t, 2);
      xdest = op1 * start_point[0] + op2 * control_point[0] + op3 * end_point[0];
      ydest = op1 * start_point[1] + op2 * control_point[1] + op3 * end_point[1];
      zdest = op1 * start_point[2] + op2 * control_point[2] + op3 * end_point[2];
      self.origin = (xdest, ydest, zdest);

      if(var_64b5d34a4c778083) {
        thread draw_line_for_time(self.origin, oldpos, 1, 1, 1, time * 10);
      }
    } else if(!var_1f8d817fb854c814) {
      self moveTo(end_point, 0.25);
      wait 0.25;
      break;
    } else {
      break;
    }

    waitframe();
  }

  self notify("off_bezier_curve");
}

function function_2159dd4196ff4b81(path_array, time_s, var_64d7cc0c0b4ec7ed = 0, var_360d3f0890420a2 = 0, var_dde09f95e982c945 = 0, var_ae5be1a2238765f3 = 0.5, path_accuracy = 0.5, var_64b5d34a4c778083 = 0) {
  self endon("death");
  self endon("stop_curve");

  if(path_array.size < 4) {
    if(var_dde09f95e982c945) {
      if(path_array.size == 3) {
        function_8001268940441423(path_array[0], path_array[2], path_array[1], time_s, var_64b5d34a4c778083, 1);
      } else if(path_array.size == 2) {
        function_8001268940441423(path_array[0], path_array[1], averagepoint(path_array), time_s, var_64b5d34a4c778083, 1);
      }
    }

    assert(var_dde09f95e982c945, "<dev string:xd05>" + path_array.size + "<dev string:xd4d>");
    return;
  }

  total_dist = 0;
  point_i = 1;

  while(point_i < path_array.size) {
    total_dist += distance(path_array[point_i - 1], path_array[point_i]);
    point_i += 1;
  }

  times = [];
  point_i = 1;

  while(point_i < path_array.size) {
    times[times.size] = distance(path_array[point_i - 1], path_array[point_i]) / total_dist * time_s;
    point_i += 1;
  }

  times[times.size] = level.framedurationseconds;
  tension = clamp(1 - var_ae5be1a2238765f3, 0.01, 1);
  alpha = clamp(path_accuracy, 0, 1);
  splineid = function_53253e8ea222ed60(path_array, times, 0, tension, alpha, 1);
  total_dist = function_176ae9ba12543764(splineid);
  var_c6b13c5ef8b9d064 = total_dist / time_s * level.framedurationseconds;
  thread function_8f5da7eab375e74a(splineid);

  if(var_64b5d34a4c778083) {
    childthread function_9f777c9a7fffb9fc(splineid, time_s, "stop_curve");
  }

  self notify("catmull_rom_spline_info", times);
  current_time = 0;

  while(current_time < time_s) {
    self.origin = function_2bf2352736fc6ac8(splineid, current_time);

    if(var_64d7cc0c0b4ec7ed) {
      self.angles = function_7062a9ae37ef4c8b(splineid, current_time);
    }

    if(!var_360d3f0890420a2) {
      delta = function_b9f720559b798d98(splineid, current_time, var_c6b13c5ef8b9d064);
      current_time += delta;
    } else {
      current_time += level.framedurationseconds;
    }

    waitframe();
  }

  self notify("stop_curve");
}

function private function_8f5da7eab375e74a(splineid) {
  waittill_any("stop_curve", "death");
  spline_destroy(splineid);
}

function follow_circle(radius, time, var_7c60f7c96ad6d35f, n_circles = 1, angle_rotation = undefined, b_drop_to_ground = 0, v_ground_offset = (0, 0, 0)) {
  self endon("death");
  self endon("interrupt_circle_move");
  assert(isDefined(var_7c60f7c96ad6d35f), "<dev string:xd8b>");
  t = 0;
  move_start = gettime();
  new_origin = self.origin;
  self notify("on_circle_move");

  if(!isvector(var_7c60f7c96ad6d35f)) {
    var_7c60f7c96ad6d35f endon("death");
    center = var_7c60f7c96ad6d35f.origin;
    var_84d3d4a079c414ef = 1;
  } else {
    center = var_7c60f7c96ad6d35f;
  }

  while(true) {
    t = (gettime() - move_start) / 1000 / time;

    if(t <= 1) {
      theta = n_circles * 360 * t;

      if(!isDefined(var_7c60f7c96ad6d35f)) {
        break;
      }

      if(var_84d3d4a079c414ef) {
        center = var_7c60f7c96ad6d35f.origin;
      }

      xdest = center[0] + cos(theta) * radius;
      ydest = center[1] + sin(theta) * radius;
      new_origin = (xdest, ydest, center[2]);

      if(isDefined(angle_rotation)) {
        offset_horizontal = new_origin - center;
        new_origin = coordtransform(offset_horizontal, center, angle_rotation);
      }

      if(b_drop_to_ground) {
        new_origin = getgroundposition(new_origin, 1) + v_ground_offset;
      }

      self.origin = new_origin;
    } else {
      break;
    }

    waitframe();
  }

  self notify("off_circle_move");
}

function function_bed40b09860f8227(enabled) {
  function_d5a54acde3e473ca(enabled);
  function_232160414793eaa0(enabled);
}

function function_d5a54acde3e473ca(enabled) {
  self allowmovement(!enabled);
  self allowprone(!enabled);
  self allowjump(!enabled);
  self allowmelee(!enabled);
}

function function_c13d09bc414864cb(enabled) {
  self allowfire(!enabled);
  self allowads(!enabled);

  if(!enabled) {
    self enableoffhandweapons();
    return;
  }

  self disableoffhandweapons();
}

function function_232160414793eaa0(enabled) {
  self freezecontrols(enabled);
  self freezelookcontrols(enabled);
}

function function_926999a67bc153f8(expected_string, compare) {
  if(isDefined(compare) && isDefined(expected_string)) {
    if(issubstr(compare, expected_string)) {
      return removesubstr(compare, expected_string);
    }
  }
}

function function_d0cb6b33aff40a94(basenamehash) {
  if(!isDefined(level.var_363840efc0e8a5a0)) {
    if(isDefined(level.gamemodebundle)) {
      bundlename = level.gamemodebundle.var_3a0206d545998851;
      assert(isDefined(bundlename));
      bundle = getscriptbundle(bundlename);
      level.var_363840efc0e8a5a0 = bundle.var_3a0206d545998851;
    }
  }

  if(issharedfuncdefined(basenamehash, #"overrideweaponname")) {
    overrideweaponname = callsharedfunc(basenamehash, #"overrideweaponname");

    if(isDefined(overrideweaponname)) {
      return overrideweaponname;
    }
  }

  return level.var_363840efc0e8a5a0[basenamehash].weaponref;
}

function function_73b3c68eaac7c8ff(string, a_substr) {
  if(!(isDefined(string) && isDefined(a_substr))) {
    return false;
  }

  if(!isarray(a_substr)) {
    a_substr = [a_substr];
  }

  foreach(substr in a_substr) {
    if(!issubstr(string, substr)) {
      return false;
    }
  }

  return true;
}

function function_630b286cb07bd032(string, a_substr) {
  if(!(isDefined(string) && isDefined(a_substr))) {
    return false;
  }

  if(!isarray(a_substr)) {
    a_substr = [a_substr];
  }

  foreach(substr in a_substr) {
    if(issubstr(string, substr)) {
      return true;
    }
  }

  return false;
}

function function_af749a6c1f8241f0(ent, lookatpoint, anglethreshold = 90) {
  entforward = anglesToForward(ent.angles);
  enttopoint = lookatpoint - ent.origin;
  anglediff = math::anglebetweenvectors(entforward, enttopoint);

  if(anglediff <= anglethreshold) {
    return true;
  }

  return false;
}

function function_476c996eed246db(ent, lookatpoint, duration, anglethreshold = 90, waitinterval = 0.5) {
  level endon("game_ended");
  ent endon("death");
  numloops = floor(duration / waitinterval);

  for(i = 0; i < numloops; i++) {
    lookingatpoint = function_af749a6c1f8241f0(ent, lookatpoint, anglethreshold);

    if(!lookingatpoint) {
      return false;
    }

    wait waitinterval;
  }

  return true;
}

function function_7158911332c109bb() {
  groundlocation = getgroundposition(self.origin, 1);
  waterheight = getwaterheightatlocation(groundlocation);

  if(groundlocation[2] < waterheight) {
    groundposition = (groundlocation[0], groundlocation[1], waterheight);
  }

  return groundlocation;
}

function function_c5d9978d36c9459e(hdrcolor) {
  var_76a96cf84b1772ad = strtok(hdrcolor, " ");
  assert(var_76a96cf84b1772ad.size == 4 || var_76a96cf84b1772ad.size == 3, "<dev string:xdaf>" + hdrcolor + "<dev string:xdbd>");
  rgbcolor = [];

  for(i = 0; i < 3; i++) {
    rgbcolor[i] = int(ceil(float(var_76a96cf84b1772ad[i]) * 255));
  }

  return rgbcolor;
}

function delay_notify(n_delay, str_notify, str_endon) {
  if(isDefined(str_endon)) {
    self endon(str_endon);
  }

  wait n_delay;

  if(isDefined(self)) {
    self notify(str_notify);
  }
}

function debugprinttoscreen(message, time, coordx, coordy, color) {
  if(!isDefined(time)) {
    time = 2;
  }

  if(!isDefined(coordx)) {
    coordx = 10;
  }

  if(!isDefined(coordy)) {
    coordy = 200;
  }

  if(!isDefined(color)) {
    color = (1, 1, 1);
  }

  if(isDefined(message)) {
    starttime = gettime();

    while(gettime() - starttime <= time * 1000) {
      printtoscreen2d(coordx, coordy, message, color, 2);
      waitframe();
    }
  }
}

function function_72ef0ebf3a428eb9(message, time, coordx, coordy, color) {
  if(!isDefined(level.debugmessages)) {
    thread function_3011e0b88a32d9f();
  }

  if(isDefined(message)) {
    if(!isDefined(time)) {
      time = 2;
    }

    if(!isDefined(coordx)) {
      coordx = 10;
    }

    if(!isDefined(coordy)) {
      coordy = 200;
    }

    if(!isDefined(color)) {
      color = (1, 1, 1);
    }

    debugmessage = spawnStruct();
    debugmessage.message = message;
    debugmessage.coordx = coordx;
    debugmessage.coordy = coordy;
    debugmessage.color = color;
    level.debugmessages[level.debugmessages.size] = debugmessage;
    wait time;
    level.debugmessages = arrayremove(level.debugmessages, debugmessage);
  }
}

function private function_3011e0b88a32d9f() {
  level.debugmessages = [];

  while(true) {
    for(i = 0; i < level.debugmessages.size; i++) {
      message = level.debugmessages[i].message;
      coordx = level.debugmessages[i].coordx;
      coordy = level.debugmessages[i].coordy;
      color = level.debugmessages[i].color;
      offsety = i * 20;
      printtoscreen2d(coordx, coordy + offsety, message, color, 2);
    }

    waitframe();
  }
}

function function_e00e472b5a03f8f1() {
  mapinfo = level.mapbundle;

  if(!isDefined(mapinfo)) {
    mapinfo = getmapscriptbundle();
  }

  if(isDefined(mapinfo)) {
    level.isnightmap = istrue(mapinfo.nightmap);

    if(level.isnightmap) {
      visionsetkillcamthirdpersonnight("killcam_night");
    }

    level.var_e54aa9fc8f17d734 = istrue(mapinfo.usenvgs);
    return;
  }

  println("<dev string:xdee>" + getDvar(@ "g_mapname"));
  level.isnightmap = 0;
  level.var_e54aa9fc8f17d734 = 0;
}

function isnightmap() {
  if(!isDefined(level.isnightmap)) {
    function_e00e472b5a03f8f1();
  }

  return istrue(level.isnightmap);
}

function function_2a082dafe6f4bd5b() {
  if(!isDefined(level.var_e54aa9fc8f17d734)) {
    function_e00e472b5a03f8f1();
  }

  return istrue(level.var_e54aa9fc8f17d734);
}

function function_21371fd45f8bcf8a(guid) {
  if(!isDefined(level.playerguidmap)) {
    level.playerguidmap = [];

    if(isDefined(level.player)) {
      playerarray = [level.player];
    } else {
      playerarray = level.players;
    }

    foreach(player in playerarray) {
      playerguid = callsharedfunc(#"player", #"getPlayerGuid", player);
      level.playerguidmap[playerguid] = player;
    }

    level callback::add(#"player_connect", &function_e75f63af976d85c2);
    level callback::add(#"player_disconnect", &function_263891ca905d979e);
  }

  return level.playerguidmap[guid];
}

function private function_e75f63af976d85c2(params) {
  player = self;
  playerguid = callsharedfunc(#"player", #"getPlayerGuid", player);
  level.playerguidmap[playerguid] = player;
}

function private function_263891ca905d979e(params) {
  player = self;
  playerguid = callsharedfunc(#"player", #"getPlayerGuid", player);
  level.playerguidmap[playerguid] = undefined;
}

function function_ce86ddbb7d60e9bd(position, shockwaveref, owner) {
  if(function_4042d2fbe6237835(#"hash_78be90a4a130ca3")) {
    return;
  }

  if(!isDefined(shockwaveref)) {
    return;
  }

  newshockwave = spawnshockwave(position, shockwaveref);

  if(isDefined(owner)) {
    newshockwave setentityowner(owner);
  }
}

function function_54fdde0a73217354(a_ents, var_7fdb5e6b2d9f73ec = 1, var_e4980e9f328c26c1 = 0) {
  var_ceca05bdac98ef87 = (0, 0, 0);

  if(!isarray(a_ents) || a_ents.size == 0) {
    assertmsg("<dev string:xe0d>");
    return undefined;
  }

  foreach(ent in a_ents) {
    if(!isDefined(ent.origin)) {
      assertmsg(ent + "<dev string:xe36>");
      return undefined;
    }
  }

  if(a_ents.size == 1) {
    key = getfirstarraykey(a_ents);
    origin = a_ents[key].origin;
    var_ceca05bdac98ef87 = var_e4980e9f328c26c1 ? origin : (origin[0], origin[1], 0);
  } else {
    var_cd3cf2cf3b927430 = int(floor(a_ents.size / 2));
    var_3a67fb50b33f1198 = arraysort(a_ents, undefined, &function_4655f27e948750f);
    var_876dbb769104e061 = arraysort(a_ents, undefined, &function_738731a22093b89e);
    var_49c5e579cf6c93c4 = var_3a67fb50b33f1198[var_cd3cf2cf3b927430].origin[0];
    mediany = var_876dbb769104e061[var_cd3cf2cf3b927430].origin[1];
    var_49c5e779cf6c982a = 0;

    if(var_e4980e9f328c26c1) {
      var_d0ad176824cdaa5e = arraysort(a_ents, undefined, &function_6796b0d93dde2c29);
      var_49c5e779cf6c982a = var_d0ad176824cdaa5e[var_cd3cf2cf3b927430].origin[2];
    }

    var_ceca05bdac98ef87 = (var_49c5e579cf6c93c4, mediany, var_49c5e779cf6c982a);

    if(a_ents.size % 2 == 0 && var_7fdb5e6b2d9f73ec) {
      var_ceca05bdac98ef87 += a_ents[var_cd3cf2cf3b927430 + 1].origin;
      var_ceca05bdac98ef87 *= 0.5;
    }
  }

  return var_ceca05bdac98ef87;
}

function function_11a2ebb045201379(a_ents, var_e4980e9f328c26c1 = 0) {
  averageposition = (0, 0, 0);

  if(!isarray(a_ents) || a_ents.size == 0) {
    assertmsg("<dev string:xe0d>");
    return undefined;
  }

  if(a_ents.size == 1) {
    key = getfirstarraykey(a_ents);
    origin = a_ents[key].origin;
    averageposition = var_e4980e9f328c26c1 ? origin : (origin[0], origin[1], 0);
  } else {
    foreach(ent in a_ents) {
      if(!isDefined(ent.origin)) {
        assertmsg(ent + "<dev string:xe36>");
        return undefined;
      }

      averageposition += ent.origin;
    }
  }

  z_val = var_e4980e9f328c26c1 ? averageposition[2] / a_ents.size : 0;
  return (averageposition[0] / a_ents.size, averageposition[1] / a_ents.size, z_val);
}

function private function_4655f27e948750f(ent1, ent2) {
  return ent1.origin[0] > ent2.origin[0];
}

function private function_738731a22093b89e(ent1, ent2) {
  return ent1.origin[1] > ent2.origin[1];
}

function private function_6796b0d93dde2c29(ent1, ent2) {
  return ent1.origin[2] > ent2.origin[2];
}

function function_f825237e0eda5adf(fallbacksuit = "t10_defaultsuit_mp") {
  suitoverride = getDvar(@ "hash_b89aa3fa4a8b1e2b", "");
  return level.gamemodebundle.playerdefaultsuit ?? (suitoverride != "" ? suitoverride : fallbacksuit);
}

function function_e02da4fab371fbcf() {
  return level.var_d5254adc8b328315 ?? (isdvardefined(@ "hash_23522f85d648456d") ? getDvar(@ "hash_23522f85d648456d") : function_f825237e0eda5adf());
}

function get_max_stock_ammo(weapon, var_9242df1bd50fa5f6 = 0) {
  if(level.gamemodebundle.var_1976506fada1193b) {
    if(var_9242df1bd50fa5f6) {
      max_stock_ammo = weaponmaxammo(weapon);
      return max_stock_ammo;
    } else {
      max_stock_ammo = weaponstartammo(weapon);
      return max_stock_ammo;
    }

    return;
  }

  max_stock_ammo = weaponmaxammo(weapon);
  return max_stock_ammo;
}

function function_b73ecb08dfaa1bc5(structvector) {
  return (structvector.x, structvector.y, structvector.z);
}

function function_3910ea89b328f77e(var_25d99aafdc05f3ba) {
  variantids = strtok(var_25d99aafdc05f3ba, " ", 1);

  if(variantids.size > 0) {
    return int(variantids[randomint(variantids.size)]);
  }

  return -1;
}

function function_eecfd867c5d343ba(patharray, var_6197e3bd24981847) {
  assert(isDefined(patharray) && patharray.size > 0, "<dev string:xe59>");

  if(!isDefined(patharray) || patharray.size == 0) {
    return undefined;
  }

  remainingdistance = var_6197e3bd24981847;
  var_ccecacbfba397018 = patharray[0];

  for(i = 1; i < patharray.size; i++) {
    nextnodeorigin = patharray[i];
    var_ae10f81cd6e347b5 = distance(var_ccecacbfba397018, nextnodeorigin);

    if(remainingdistance < var_ae10f81cd6e347b5) {
      targetnode = vectorlerp(var_ccecacbfba397018, nextnodeorigin, remainingdistance / var_ae10f81cd6e347b5);
      return [targetnode, i];
    }

    remainingdistance -= var_ae10f81cd6e347b5;
    var_ccecacbfba397018 = nextnodeorigin;
  }

  return [var_ccecacbfba397018, patharray.size - 1];
}

function function_969f9f5596dba07a(ent, callbackfunction) {
  if(isDefined(level.var_ff28e0c14ba90179)) {
    [[getsharedfunc(#"game", #"registerentincrushzones")]](ent);
    ent.var_a21f47f6f7811618 = callbackfunction;
  }
}

function function_a605d1fb62b31e70(ent) {
  if(isDefined(level.var_ff28e0c14ba90179)) {
    if(issharedfuncdefined(#"game", #"unregisterentfromcrushzones", 0)) {
      [[getsharedfunc(#"game", #"unregisterentfromcrushzones")]](ent);
    }

    ent.var_a21f47f6f7811618 = undefined;
  }
}