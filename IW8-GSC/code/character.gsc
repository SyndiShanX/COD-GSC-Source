/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: code\character.gsc
***********************************************/

setmodelfromarray(var_0) {
  if(!scripts\common\utility::issp())
    self setModel(var_0[randomint(var_0.size)]);
  else {
    if(!isDefined(level.character_model_cache))
      level.character_model_cache = [];

    var_1 = get_least_used_model(var_0);

    if(!isDefined(var_1))
      var_1 = var_0[randomint(var_0.size)];

    level.character_model_cache["_encstr_ADB90A015FEBE5199D325971"] = var_1;
    level.character_model_cache[var_1]++;
    self setModel(var_1);
  }
}

get_least_used_model(var_0) {
  var_1 = [];
  var_2 = 999999;
  var_1[0] = 0;

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(!isDefined(level.character_model_cache[var_0[var_3]]))
      level.character_model_cache[var_0[var_3]] = 0;

    var_4 = level.character_model_cache[var_0[var_3]];

    if(var_4 > var_2) {
      continue;
    }
    if(var_4 < var_2) {
      var_1 = [];
      var_2 = var_4;
    }

    var_1[var_1.size] = var_3;
  }

  var_5 = random(var_1);
  return var_0[var_5];
}

precachemodelarray(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++)
    precachemodel(var_0[var_1]);
}

attachhead(var_0, var_1) {
  if(!isDefined(level.character_head_index))
    level.character_head_index = [];

  if(!isDefined(level.character_head_index[var_0]))
    level.character_head_index[var_0] = randomint(var_1.size);

  var_2 = (level.character_head_index[var_0] + 1) % var_1.size;

  if(isDefined(self.script_char_index))
    var_2 = self.script_char_index % var_1.size;

  level.character_head_index[var_0] = var_2;
  self attach(var_1[var_2], "_encstr_B40101", 1);
  self.headmodel = var_1[var_2];
}

attachhat(var_0, var_1) {
  if(!isDefined(level.character_hat_index))
    level.character_hat_index = [];

  if(!isDefined(level.character_hat_index[var_0]))
    level.character_hat_index[var_0] = randomint(var_1.size);

  var_2 = (level.character_hat_index[var_0] + 1) % var_1.size;
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
  self.anim_gunhand = "_encstr_8BBA05185F8B99";
  self[[anim.putguninhand]](var_0);
}

save() {
  var_0["_encstr_A6B1080430CB4C271889"] = self.anim_gunhand;
  var_0["_encstr_A5800AAFCDA5E8EE8C802B0B"] = self.anim_guninhand;
  var_0["_encstr_A59306224004FA23"] = self.model;
  var_0["_encstr_9BD40910BBD82D3FB52152"] = self.hatmodel;

  if(isDefined(self.name))
    var_0["_encstr_84BA05A8CA852B"] = self.name;
  else {}

  var_1 = self getattachsize();

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_0["_encstr_A19A077135838FDED1"][var_2]["_encstr_A59306224004FA23"] = self getattachmodelname(var_2);
    var_0["_encstr_A19A077135838FDED1"][var_2]["_encstr_AF1904F3E3AC"] = self getattachtagname(var_2);
  }

  return var_0;
}

load(var_0) {
  self detachall();
  self.anim_gunhand = var_0["_encstr_A6B1080430CB4C271889"];
  self.anim_guninhand = var_0["_encstr_A5800AAFCDA5E8EE8C802B0B"];
  self setModel(var_0["_encstr_A59306224004FA23"]);
  self.hatmodel = var_0["_encstr_9BD40910BBD82D3FB52152"];

  if(isDefined(var_0["_encstr_84BA05A8CA852B"]))
    self.name = var_0["_encstr_84BA05A8CA852B"];
  else {}

  var_1 = var_0["_encstr_A19A077135838FDED1"];
  var_2 = var_1.size;

  for(var_3 = 0; var_3 < var_2; var_3++)
    self attach(var_1[var_3]["_encstr_A59306224004FA23"], var_1[var_3]["_encstr_AF1904F3E3AC"]);
}

precache(var_0) {
  if(isDefined(var_0["_encstr_84BA05A8CA852B"])) {} else {}

  precachemodel(var_0["_encstr_A59306224004FA23"]);
  var_1 = var_0["_encstr_A19A077135838FDED1"];
  var_2 = var_1.size;

  for(var_3 = 0; var_3 < var_2; var_3++)
    precachemodel(var_1[var_3]["_encstr_A59306224004FA23"]);
}

get_random_character(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(isDefined(var_3))
    var_5 = strtok(var_3, "_encstr_BA4C02DF");
  else
    var_5 = strtok(self.classname, "_encstr_BA4C02DF");

  if(!scripts\common\utility::issp()) {
    if(isDefined(self.pers["_encstr_A2670BC852BF632097D68D75A8"]) && self.pers["_encstr_A2670BC852BF632097D68D75A8"] < var_0)
      return self.pers["_encstr_A2670BC852BF632097D68D75A8"];

    var_4 = randomint(var_0);
    self.pers["_encstr_A2670BC852BF632097D68D75A8"] = var_4;
    return var_4;
  } else if(var_5.size <= 2)
    return randomint(var_0);

  var_6 = "_encstr_AD84055EA3D5D0";

  if(isDefined(self.script_char_index))
    var_4 = self.script_char_index;
  else if(isDefined(var_1))
    var_4 = get_randomly_weighted_character(var_1);

  if(isDefined(self.script_char_group))
    var_6 = "_encstr_A123070F0B327D488F" + self.script_char_group;

  if(!isDefined(level.character_index_cache))
    level.character_index_cache = [];

  if(!isDefined(level.character_index_cache[var_6]))
    level.character_index_cache[var_6] = [];

  if(!isDefined(var_4)) {
    var_4 = get_least_used_index(var_2, var_6);

    if(!isDefined(var_4))
      var_4 = randomint(var_2.size);
  }

  if(!isDefined(level.character_index_cache[var_6][var_2[var_4]]))
    level.character_index_cache[var_6][var_2[var_4]] = 0;

  level.character_index_cache[var_6][var_2[var_4]]++;
  return var_4;
}

get_least_used_index(var_0, var_1) {
  var_2 = [];
  var_3 = 999999;
  var_2[0] = 0;

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    if(!isDefined(level.character_index_cache[var_1][var_0[var_4]]))
      level.character_index_cache[var_1][var_0[var_4]] = 0;

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
  for(var_3 = 0; var_3 < var_2; var_3++)
    level.character_index_cache[var_0][var_1][var_3] = 0;
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
    if(var_1 < var_0[var_2])
      return var_2;
  }

  return 0;
}