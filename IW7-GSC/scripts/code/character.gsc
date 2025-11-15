/**************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\code\character.gsc
**************************************/

setmodelfromarray(param_00) {
  self setModel(param_00[randomint(param_00.size)]);
}

precachemodelarray(param_00) {
  for(var_01 = 0; var_01 < param_00.size; var_01++) {
    precachemodel(param_00[var_01]);
  }
}

attachhead(param_00, param_01) {
  if(!isDefined(level.character_head_index)) {
    level.character_head_index = [];
  }

  if(!isDefined(level.character_head_index[param_00])) {
    level.character_head_index[param_00] = randomint(param_01.size);
  }

  var_02 = level.character_head_index[param_00] + 1 % param_01.size;
  if(isDefined(self.script_char_index)) {
    var_02 = self.script_char_index % param_01.size;
  }

  level.character_head_index[param_00] = var_02;
  self attach(param_01[var_02], "", 1);
  self.headmodel = param_01[var_02];
}

attachhat(param_00, param_01) {
  if(!isDefined(level.character_hat_index)) {
    level.character_hat_index = [];
  }

  if(!isDefined(level.character_hat_index[param_00])) {
    level.character_hat_index[param_00] = randomint(param_01.size);
  }

  var_02 = level.character_hat_index[param_00] + 1 % param_01.size;
  level.character_hat_index[param_00] = var_02;
  self attach(param_01[var_02]);
  self.hatmodel = param_01[var_02];
}

new() {
  self detachall();
  var_00 = self.anim_gunhand;
  if(!isDefined(var_00)) {
    return;
  }

  self.anim_gunhand = "none";
  self[[level.putguninhand]](var_00);
}

save() {
  var_00["gunHand"] = self.anim_gunhand;
  var_00["gunInHand"] = self.anim_guninhand;
  var_00["model"] = self.model;
  var_00["hatModel"] = self.hatmodel;
  if(isDefined(self.name)) {
    var_00["name"] = self.name;
  } else {}

  var_01 = self getscoreremaining();
  for(var_02 = 0; var_02 < var_01; var_02++) {
    var_00["attach"][var_02]["model"] = self getscoreperminute(var_02);
    var_00["attach"][var_02]["tag"] = self getattachtagname(var_02);
  }

  return var_00;
}

load(param_00) {
  self detachall();
  self.anim_gunhand = param_00["gunHand"];
  self.anim_guninhand = param_00["gunInHand"];
  self setModel(param_00["model"]);
  self.hatmodel = param_00["hatModel"];
  if(isDefined(param_00["name"])) {
    self.name = param_00["name"];
  } else {}

  var_01 = param_00["attach"];
  var_02 = var_01.size;
  for(var_03 = 0; var_03 < var_02; var_03++) {
    self attach(var_01[var_03]["model"], var_01[var_03]["tag"]);
  }
}

precache(param_00) {
  if(isDefined(param_00["name"])) {} else {}

  precachemodel(param_00["model"]);
  var_01 = param_00["attach"];
  var_02 = var_01.size;
  for(var_03 = 0; var_03 < var_02; var_03++) {
    precachemodel(var_01[var_03]["model"]);
  }
}

get_random_character(param_00, param_01, param_02) {
  var_03 = undefined;
  var_04 = strtok(self.classname, "_");
  if(!scripts\engine\utility::issp()) {
    if(isDefined(self.pers["modelIndex"]) && self.pers["modelIndex"] < param_00) {
      return self.pers["modelIndex"];
    }

    var_03 = randomint(param_00);
    self.pers["modelIndex"] = var_03;
    return var_03;
  } else if(var_04.size <= 2) {
    return randomint(param_00);
  }

  var_05 = "auto";
  if(isDefined(self.script_char_index)) {
    var_03 = self.script_char_index;
  } else if(isDefined(param_01)) {
    var_03 = get_randomly_weighted_character(param_01);
  }

  if(isDefined(self.script_char_group)) {
    var_05 = "group_" + self.script_char_group;
  }

  if(!isDefined(level.character_index_cache)) {
    level.character_index_cache = [];
  }

  if(!isDefined(level.character_index_cache[var_05])) {
    level.character_index_cache[var_05] = [];
  }

  if(!isDefined(var_03)) {
    var_03 = get_least_used_index(param_02, var_05);
    if(!isDefined(var_03)) {
      var_03 = randomint(param_02.size);
    }
  }

  if(!isDefined(level.character_index_cache[var_05][param_02[var_03]])) {
    level.character_index_cache[var_05][param_02[var_03]] = 0;
  }

  level.character_index_cache[var_05][param_02[var_03]]++;
  return var_03;
}

get_least_used_index(param_00, param_01) {
  var_02 = [];
  var_03 = 999999;
  var_02[0] = 0;
  for(var_04 = 0; var_04 < param_00.size; var_04++) {
    if(!isDefined(level.character_index_cache[param_01][param_00[var_04]])) {
      level.character_index_cache[param_01][param_00[var_04]] = 0;
    }

    var_05 = level.character_index_cache[param_01][param_00[var_04]];
    if(var_05 > var_03) {
      continue;
    }

    if(var_05 < var_03) {
      var_02 = [];
      var_03 = var_05;
    }

    var_02[var_02.size] = var_04;
  }

  return random(var_02);
}

initialize_character_group(param_00, param_01, param_02) {
  for(var_03 = 0; var_03 < param_02; var_03++) {
    level.character_index_cache[param_00][param_01][var_03] = 0;
  }
}

get_random_weapon(param_00) {
  return randomint(param_00);
}

random(param_00) {
  return param_00[randomint(param_00.size)];
}

get_randomly_weighted_character(param_00) {
  var_01 = randomfloat(1);
  for(var_02 = 0; var_02 < param_00.size; var_02++) {
    if(var_01 < param_00[var_02]) {
      return var_02;
    }
  }

  return 0;
}