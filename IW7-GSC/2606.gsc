/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2606.gsc
***************************************/

setmodelfromarray(var_00) {
  self setModel(var_0[randomint(var_0.size)]);
}

precachemodelarray(var_00) {
  for(var_01 = 0; var_01 < var_0.size; var_1++) {
    precachemodel(var_0[var_01]);
  }
}

attachhead(var_00, var_01) {
  if(!isDefined(level.character_head_index)) {
    level.character_head_index = [];
  }

  if(!isDefined(level.character_head_index[var_00])) {
    level.character_head_index[var_00] = randomint(var_1.size);
  }

  var_02 = (level.character_head_index[var_00] + 1) % var_1.size;

  if(isDefined(self.script_char_index)) {
    var_02 = self.script_char_index % var_1.size;
  }

  level.character_head_index[var_00] = var_02;
  self attach(var_1[var_02], "", 1);
  self.headmodel = var_1[var_02];
}

attachhat(var_00, var_01) {
  if(!isDefined(level.character_hat_index)) {
    level.character_hat_index = [];
  }

  if(!isDefined(level.character_hat_index[var_00])) {
    level.character_hat_index[var_00] = randomint(var_1.size);
  }

  var_02 = (level.character_hat_index[var_00] + 1) % var_1.size;
  level.character_hat_index[var_00] = var_02;
  self attach(var_1[var_02]);
  self.hatmodel = var_1[var_02];
}

new() {
  self detachall();
  var_00 = self.anim_gunhand;

  if(!isDefined(var_00)) {
    return;
  }
  self.anim_gunhand = "none";
  self[[anim.putguninhand]](var_00);
}

save() {
  var_0["gunHand"] = self.anim_gunhand;
  var_0["gunInHand"] = self.anim_guninhand;
  var_0["model"] = self.model;
  var_0["hatModel"] = self.hatmodel;

  if(isDefined(self.name)) {
    var_0["name"] = self.name;
  }
  else {}

  var_01 = self getattachsize();

  for(var_02 = 0; var_02 < var_01; var_2++) {
    var_0["attach"][var_02]["model"] = self getattachmodelname(var_02);
    var_0["attach"][var_02]["tag"] = self getattachtagname(var_02);
  }

  return var_00;
}

load(var_00) {
  self detachall();
  self.anim_gunhand = var_0["gunHand"];
  self.anim_guninhand = var_0["gunInHand"];
  self setModel(var_0["model"]);
  self.hatmodel = var_0["hatModel"];

  if(isDefined(var_0["name"])) {
    self.name = var_0["name"];
  }
  else {}

  var_01 = var_0["attach"];
  var_02 = var_1.size;

  for(var_03 = 0; var_03 < var_02; var_3++) {
    self attach(var_1[var_03]["model"], var_1[var_03]["tag"]);
  }
}

precache(var_00) {
  if(isDefined(var_0["name"])) {} else {}

  precachemodel(var_0["model"]);
  var_01 = var_0["attach"];
  var_02 = var_1.size;

  for(var_03 = 0; var_03 < var_02; var_3++) {
    precachemodel(var_1[var_03]["model"]);
  }
}

get_random_character(var_00, var_01, var_02) {
  var_03 = undefined;
  var_04 = strtok(self.classname, "_");

  if(!scripts\engine\utility::issp()) {
    if(isDefined(self.pers["modelIndex"]) && self.pers["modelIndex"] < var_00) {
      return self.pers["modelIndex"];
    }

    var_03 = randomint(var_00);
    self.pers["modelIndex"] = var_03;
    return var_03;
  } else if(var_4.size <= 2)
    return randomint(var_00);

  var_05 = "auto";

  if(isDefined(self.script_char_index)) {
    var_03 = self.script_char_index;
  }
  else if(isDefined(var_01)) {
    var_03 = get_randomly_weighted_character(var_01);
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
    var_03 = get_least_used_index(var_02, var_05);

    if(!isDefined(var_03)) {
      var_03 = randomint(var_2.size);
    }
  }

  if(!isDefined(level.character_index_cache[var_05][var_2[var_03]])) {
    level.character_index_cache[var_05][var_2[var_03]] = 0;
  }

  level.character_index_cache[var_05][var_2[var_03]]++;
  return var_03;
}

get_least_used_index(var_00, var_01) {
  var_02 = [];
  var_03 = 999999;
  var_2[0] = 0;

  for(var_04 = 0; var_04 < var_0.size; var_4++) {
    if(!isDefined(level.character_index_cache[var_01][var_0[var_04]])) {
      level.character_index_cache[var_01][var_0[var_04]] = 0;
    }

    var_05 = level.character_index_cache[var_01][var_0[var_04]];

    if(var_05 > var_03) {
      continue;
    }
    if(var_05 < var_03) {
      var_02 = [];
      var_03 = var_05;
    }

    var_2[var_2.size] = var_04;
  }

  return random(var_02);
}

initialize_character_group(var_00, var_01, var_02) {
  for(var_03 = 0; var_03 < var_02; var_3++) {
    level.character_index_cache[var_00][var_01][var_03] = 0;
  }
}

get_random_weapon(var_00) {
  return randomint(var_00);
}

random(var_00) {
  return var_0[randomint(var_0.size)];
}

get_randomly_weighted_character(var_00) {
  var_01 = randomfloat(1);

  for(var_02 = 0; var_02 < var_0.size; var_2++) {
    if(var_01 < var_0[var_02]) {
      return var_02;
    }
  }

  return 0;
}