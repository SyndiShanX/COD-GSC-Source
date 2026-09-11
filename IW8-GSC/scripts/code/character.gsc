/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\code\character.gsc
***********************************************/

function setmodelfromarray(var0) {
  if(!scripts\common\utility::issp()) {
    self setModel(var0[randomint(var0.size)]);
    return;
  }

  if(!isDefined(level.character_model_cache)) {
    level.character_model_cache = [];
  }

  var1 = get_least_used_model(var0);

  if(!isDefined(var1)) {
    var1 = var0[randomint(var0.size)];
  }

  level.character_model_cache["last_used"] = var1;
  level.character_model_cache[var1]++;
  self setModel(var1);
}

function get_least_used_model(var0) {
  var1 = [];
  var2 = 999999;
  var1 = 0;

  for(var3 = 0; var3 < var0.size; var3++) {
    if(!isDefined(level.character_model_cache[var0[var3]])) {
      level.character_model_cache[var0[var3]] = 0;
    }

    var4 = level.character_model_cache[var0[var3]];

    if(var4 > var2) {
      continue;
    }

    if(var4 < var2) {
      var1 = [];
      var2 = var4;
    }

    var1 = var3;
  }

  var5 = random(var1);
  return var0[var5];
}

function precachemodelarray(var0) {
  for(var1 = 0; var1 < var0.size; var1++) {
    precachemodel(var0[var1]);
  }
}

function attachhead(var0, var1) {
  if(!isDefined(level.character_head_index)) {
    level.character_head_index = [];
  }

  if(!isDefined(level.character_head_index[var0])) {
    level.character_head_index[var0] = randomint(var1.size);
  }

  var2 = (level.character_head_index[var0] + 1) % var1.size;

  if(isDefined(self.script_char_index)) {
    var2 = self.script_char_index % var1.size;
  }

  level.character_head_index[var0] = var2;
  self attach(var1[var2], "", 1);
  self.headmodel = var1[var2];
}

function attachhat(var0, var1) {
  if(!isDefined(level.character_hat_index)) {
    level.character_hat_index = [];
  }

  if(!isDefined(level.character_hat_index[var0])) {
    level.character_hat_index[var0] = randomint(var1.size);
  }

  var2 = (level.character_hat_index[var0] + 1) % var1.size;
  level.character_hat_index[var0] = var2;
  self attach(var1[var2]);
  self.hatmodel = var1[var2];
}

function new() {
  self detachall();
  var0 = self.anim_gunhand;

  if(!isDefined(var0)) {
    return;
  }

  self.anim_gunhand = "none";
  self[[anim.putguninhand]](var0);
}

function save() {
  GscBinSkip1(0x45, "gunHand", self.anim_gunhand);
}

function load(var0) {
  self detachall();
  self.anim_gunhand = var0["gunHand"];
  self.anim_guninhand = var0["gunInHand"];
  self setModel(var0["model"]);
  self.hatmodel = var0["hatModel"];

  if(isDefined(var0["name"])) {
    self.name = var0["name"];
  }

  var1 = var0["attach"];
  var2 = var1.size;

  for(var3 = 0; var3 < var2; var3++) {
    self attach(var1[var3]["model"], var1[var3]["tag"]);
  }
}

function precache(var0) {
  if(isDefined(var0["name"])) {}

  precachemodel(var0["model"]);
  var1 = var0["attach"];
  var2 = var1.size;

  for(var3 = 0; var3 < var2; var3++) {
    precachemodel(var1[var3]["model"]);
  }
}

function get_random_character(var0, var1, var2, var3) {
  var4 = undefined;

  if(isDefined(var3)) {
    var5 = strtok(var3, "_");
  } else {
    var5 = strtok(self.classname, "_");
  }

  if(!scripts\common\utility::issp()) {
    if(isDefined(self.pers["modelIndex"]) && self.pers["modelIndex"] < var1) {
      return self.pers["modelIndex"];
    }

    var5 = randomint(var1);
    self.pers["modelIndex"] = var5;
    return var5;
  } else if(var5.size <= 2) {
    return randomint(var1);
  }

  var6 = "auto";

  if(isDefined(self.script_char_index)) {
    var5 = self.script_char_index;
  } else if(isDefined(var2)) {
    var5 = get_randomly_weighted_character(var2);
  }

  if(isDefined(self.script_char_group)) {
    var6 = "group_" + self.script_char_group;
  }

  if(!isDefined(level.character_index_cache)) {
    level.character_index_cache = [];
  }

  if(!isDefined(level.character_index_cache[var6])) {
    level.character_index_cache[var6] = [];
  }

  if(!isDefined(var5)) {
    var5 = get_least_used_index(var3, var6);

    if(!isDefined(var5)) {
      var5 = randomint(var3.size);
    }
  }

  if(!isDefined(level.character_index_cache[var6][var3[var5]])) {
    level.character_index_cache[var6][var3[var5]] = 0;
  }

  level.character_index_cache[var6][var3[var5]]++;
  return var5;
}

function get_least_used_index(var0, var1) {
  var2 = [];
  var3 = 999999;
  var2 = 0;

  for(var4 = 0; var4 < var0.size; var4++) {
    if(!isDefined(level.character_index_cache[var1][var0[var4]])) {
      level.character_index_cache[var1][var0[var4]] = 0;
    }

    var5 = level.character_index_cache[var1][var0[var4]];

    if(var5 > var3) {
      continue;
    }

    if(var5 < var3) {
      var2 = [];
      var3 = var5;
    }

    var2 = var4;
  }

  return random(var2);
}

function initialize_character_group(var0, var1, var2) {
  for(var3 = 0; var3 < var2; var3++) {
    level.character_index_cache[var0][var1][var3] = 0;
  }
}

function get_random_weapon(var0) {
  return randomint(var0);
}

function random(var0) {
  return var0[randomint(var0.size)];
}

function get_randomly_weighted_character(var0) {
  var1 = randomfloat(1);

  for(var2 = 0; var2 < var0.size; var2++) {
    if(var1 < var0[var2]) {
      return var2;
    }
  }

  return 0;
}