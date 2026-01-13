/**************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\code\character.gsc
**************************************/

setmodelfromarray(var_0) {
  self setModel(var_0[randomint(var_0.size)]);
}

precachemodelarray(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    precachemodel(var_0[var_1]);
  }
}

attachhead(var_0, var_1) {
  if(!isDefined(level.character_head_index)) {
    level.character_head_index = [];
  }

  if(!isDefined(level.character_head_index[var_0])) {
    level.character_head_index[var_0] = randomint(var_1.size);
  }

  var_2 = level.character_head_index[var_0] + 1 % var_1.size;
  if(isDefined(self.script_char_index)) {
    var_2 = self.script_char_index % var_1.size;
  }

  level.character_head_index[var_0] = var_2;
  self attach(var_1[var_2], "", 1);
  self.headmodel = var_1[var_2];
}

attachhat(var_0, var_1) {
  if(!isDefined(level.character_hat_index)) {
    level.character_hat_index = [];
  }

  if(!isDefined(level.character_hat_index[var_0])) {
    level.character_hat_index[var_0] = randomint(var_1.size);
  }

  var_2 = level.character_hat_index[var_0] + 1 % var_1.size;
  level.character_hat_index[var_0] = var_2;
  self attach(var_1[var_2]);
  self.hatmodel = var_1[var_2];
}

new() {
  self detachall();
  var_0 = self.anim_gunhand;
  if(!isDefined(var_0)) {
    return;
  }

  self.anim_gunhand = "none";
  self[[level.putguninhand]](var_0);
}

save() {
  var_0["gunHand"] = self.anim_gunhand;
  var_0["gunInHand"] = self.anim_guninhand;
  var_0["model"] = self.model;
  var_0["hatModel"] = self.hatmodel;
  if(isDefined(self.name)) {
    var_0["name"] = self.name;
  }

  var_1 = self getscoreremaining();
  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_0["attach"][var_2]["model"] = self getscoreperminute(var_2);
    var_0["attach"][var_2]["tag"] = self getattachtagname(var_2);
  }

  return var_0;
}

load(var_0) {
  self detachall();
  self.anim_gunhand = var_0["gunHand"];
  self.anim_guninhand = var_0["gunInHand"];
  self setModel(var_0["model"]);
  self.hatmodel = var_0["hatModel"];
  if(isDefined(var_0["name"])) {
    self.name = var_0["name"];
  }

  var_1 = var_0["attach"];
  var_2 = var_1.size;
  for(var_3 = 0; var_3 < var_2; var_3++) {
    self attach(var_1[var_3]["model"], var_1[var_3]["tag"]);
  }
}

precache(var_0) {
  if(isDefined(var_0["name"])) {}

  precachemodel(var_0["model"]);
  var_1 = var_0["attach"];
  var_2 = var_1.size;
  for(var_3 = 0; var_3 < var_2; var_3++) {
    precachemodel(var_1[var_3]["model"]);
  }
}

get_random_character(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = strtok(self.classname, "_");
  if(!scripts\engine\utility::issp()) {
    if(isDefined(self.pers["modelIndex"]) && self.pers["modelIndex"] < var_0) {
      return self.pers["modelIndex"];
    }

    var_3 = randomint(var_0);
    self.pers["modelIndex"] = var_3;
    return var_3;
  } else if(var_4.size <= 2) {
    return randomint(var_0);
  }

  var_5 = "auto";
  if(isDefined(self.script_char_index)) {
    var_3 = self.script_char_index;
  } else if(isDefined(var_1)) {
    var_3 = get_randomly_weighted_character(var_1);
  }

  if(isDefined(self.script_char_group)) {
    var_5 = "group_" + self.script_char_group;
  }

  if(!isDefined(level.character_index_cache)) {
    level.character_index_cache = [];
  }

  if(!isDefined(level.character_index_cache[var_5])) {
    level.character_index_cache[var_5] = [];
  }

  if(!isDefined(var_3)) {
    var_3 = get_least_used_index(var_2, var_5);
    if(!isDefined(var_3)) {
      var_3 = randomint(var_2.size);
    }
  }

  if(!isDefined(level.character_index_cache[var_5][var_2[var_3]])) {
    level.character_index_cache[var_5][var_2[var_3]] = 0;
  }

  level.character_index_cache[var_5][var_2[var_3]]++;
  return var_3;
}

get_least_used_index(var_0, var_1) {
  var_2 = [];
  var_3 = 999999;
  var_2[0] = 0;
  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    if(!isDefined(level.character_index_cache[var_1][var_0[var_4]])) {
      level.character_index_cache[var_1][var_0[var_4]] = 0;
    }

    var_5 = level.character_index_cache[var_1][var_0[var_4]];
    if(var_5 > var_3) {
      continue;
    }

    if(var_5 < var_3) {
      var_2 = [];
      var_3 = var_5;
    }

    var_2[var_2.size] = var_4;
  }

  return random(var_2);
}

initialize_character_group(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < var_2; var_3++) {
    level.character_index_cache[var_0][var_1][var_3] = 0;
  }
}

get_random_weapon(var_0) {
  return randomint(var_0);
}

random(var_0) {
  return var_0[randomint(var_0.size)];
}

get_randomly_weighted_character(var_0) {
  var_1 = randomfloat(1);
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_1 < var_0[var_2]) {
      return var_2;
    }
  }

  return 0;
}