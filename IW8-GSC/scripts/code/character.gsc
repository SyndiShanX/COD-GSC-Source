/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\code\character.gsc
***********************************************/

function setmodelfromarray(var_0) {
  if(!scripts\common\utility::issp()) {
    self setModel(var_0[randomint(var_0.size)]);
    return;
  }

  if(!isDefined(level.character_model_cache)) {
    level.character_model_cache = [];
  }

  var_1 = get_least_used_model(var_0);

  if(!isDefined(var_1)) {
    var_1 = var_0[randomint(var_0.size)];
  }

  level.character_model_cache["last_used"] = var_1;
  level.character_model_cache[var_1]++;
  self setModel(var_1);
}

function get_least_used_model(var_0) {
  var_1 = [];
  var_2 = 999999;
  var_1 = 0;

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(!isDefined(level.character_model_cache[var_0[var_3]])) {
      level.character_model_cache[var_0[var_3]] = 0;
    }

    var_4 = level.character_model_cache[var_0[var_3]];

    if(var_4 > var_2) {
      continue;
    }

    if(var_4 < var_2) {
      var_1 = [];
      var_2 = var_4;
    }

    var_1 = var_3;
  }

  var_5 = random(var_1);
  return var_0[var_5];
}

function precachemodelarray(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    precachemodel(var_0[var_1]);
  }
}

function attachhead(var_0, var_1) {
  if(!isDefined(level.character_head_index)) {
    level.character_head_index = [];
  }

  if(!isDefined(level.character_head_index[var_0])) {
    level.character_head_index[var_0] = randomint(var_1.size);
  }

  var_2 = (level.character_head_index[var_0] + 1) % var_1.size;

  if(isDefined(self.script_char_index)) {
    var_2 = self.script_char_index % var_1.size;
  }

  level.character_head_index[var_0] = var_2;
  self attach(var_1[var_2], "", 1);
  self.headmodel = var_1[var_2];
}

function attachhat(var_0, var_1) {
  if(!isDefined(level.character_hat_index)) {
    level.character_hat_index = [];
  }

  if(!isDefined(level.character_hat_index[var_0])) {
    level.character_hat_index[var_0] = randomint(var_1.size);
  }

  var_2 = (level.character_hat_index[var_0] + 1) % var_1.size;
  level.character_hat_index[var_0] = var_2;
  self attach(var_1[var_2]);
  self.hatmodel = var_1[var_2];
}

function new() {
  self detachall();
  var_0 = self.anim_gunhand;

  if(!isDefined(var_0)) {
    return;
  }

  self.anim_gunhand = "none";
  self[[anim.putguninhand]](var_0);
}

function save() {
  GscBinSkip1(0x45, "gunHand", self.anim_gunhand);
}

function load(var_0) {
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

function precache(var_0) {
  if(isDefined(var_0["name"])) {}

  precachemodel(var_0["model"]);
  var_1 = var_0["attach"];
  var_2 = var_1.size;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    precachemodel(var_1[var_3]["model"]);
  }
}

function get_random_character(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(isDefined(var_3)) {
    var_5 = strtok(var_3, "_");
  } else {
    var_5 = strtok(self.classname, "_");
  }

  if(!scripts\common\utility::issp()) {
    if(isDefined(self.pers["modelIndex"]) && self.pers["modelIndex"] < var_1) {
      return self.pers["modelIndex"];
    }

    var_5 = randomint(var_1);
    self.pers["modelIndex"] = var_5;
    return var_5;
  } else if(var_5.size <= 2) {
    return randomint(var_1);
  }

  var_6 = "auto";

  if(isDefined(self.script_char_index)) {
    var_5 = self.script_char_index;
  } else if(isDefined(var_2)) {
    var_5 = get_randomly_weighted_character(var_2);
  }

  if(isDefined(self.script_char_group)) {
    var_6 = "group_" + self.script_char_group;
  }

  if(!isDefined(level.character_index_cache)) {
    level.character_index_cache = [];
  }

  if(!isDefined(level.character_index_cache[var_6])) {
    level.character_index_cache[var_6] = [];
  }

  if(!isDefined(var_5)) {
    var_5 = get_least_used_index(var_3, var_6);

    if(!isDefined(var_5)) {
      var_5 = randomint(var_3.size);
    }
  }

  if(!isDefined(level.character_index_cache[var_6][var_3[var_5]])) {
    level.character_index_cache[var_6][var_3[var_5]] = 0;
  }

  level.character_index_cache[var_6][var_3[var_5]]++;
  return var_5;
}

function get_least_used_index(var_0, var_1) {
  var_2 = [];
  var_3 = 999999;
  var_2 = 0;

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

    var_2 = var_4;
  }

  return random(var_2);
}

function initialize_character_group(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < var_2; var_3++) {
    level.character_index_cache[var_0][var_1][var_3] = 0;
  }
}

function get_random_weapon(var_0) {
  return randomint(var_0);
}

function random(var_0) {
  return var_0[randomint(var_0.size)];
}

function get_randomly_weighted_character(var_0) {
  var_1 = randomfloat(1);

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_1 < var_0[var_2]) {
      return var_2;
    }
  }

  return 0;
}