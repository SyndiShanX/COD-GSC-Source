/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: codescripts\character.gsc
********************************/

setmodelfromarray(var_0) {
  self setmodel(var_0[randomint(var_0.size)]);
}

precachemodelarray(var_0) {
  for (var_1 = 0; var_1 < var_0.size; var_1++)
    precachemodel(var_0[var_1]);
}

attachhead(var_0, var_1) {
  if(!isdefined(level.character_head_index))
    level.character_head_index = [];

  if(!isdefined(level.character_head_index[var_0]))
    level.character_head_index[var_0] = randomint(var_1.size);

  var_2 = (level.character_head_index[var_0] + 1) % var_1.size;

  if(isdefined(self.script_char_index))
    var_2 = self.script_char_index % var_1.size;

  level.character_head_index[var_0] = var_2;
  setheadmodel(var_1[var_2]);
}

setheadmodel(var_0) {
  if(isdefined(self.headmodel))
    self detach(self.headmodel);

  self attach(var_0, "", 1);
  self.headmodel = var_0;
}

attachhat(var_0, var_1) {
  if(!isdefined(level.character_hat_index))
    level.character_hat_index = [];

  if(!isdefined(level.character_hat_index[var_0]))
    level.character_hat_index[var_0] = randomint(var_1.size);

  var_2 = (level.character_hat_index[var_0] + 1) % var_1.size;
  level.character_hat_index[var_0] = var_2;
  self attach(var_1[var_2]);
  self.hatmodel = var_1[var_2];
}

new() {
  self detachall();
  var_0 = self.anim_gunhand;

  if(!isdefined(var_0)) {
    return;
  }
  self.anim_gunhand = "none";
  self[[anim.putguninhand]](var_0);
}

save() {
  var_0["gunHand"] = self.anim_gunhand;
  var_0["gunInHand"] = self.anim_guninhand;
  var_0["model"] = self.model;
  var_0["hatModel"] = self.hatmodel;

  if(isdefined(self.name))
    var_0["name"] = self.name;
  else {}

  var_1 = self getattachsize();

  for (var_2 = 0; var_2 < var_1; var_2++) {
    var_0["attach"][var_2]["model"] = self getattachmodelname(var_2);
    var_0["attach"][var_2]["tag"] = self getattachtagname(var_2);
  }

  return var_0;
}

load(var_0) {
  self detachall();
  self.anim_gunhand = var_0["gunHand"];
  self.anim_guninhand = var_0["gunInHand"];
  self setmodel(var_0["model"]);
  self.hatmodel = var_0["hatModel"];

  if(isdefined(var_0["name"]))
    self.name = var_0["name"];
  else {}

  var_1 = var_0["attach"];
  var_2 = var_1.size;

  for (var_3 = 0; var_3 < var_2; var_3++)
    self attach(var_1[var_3]["model"], var_1[var_3]["tag"]);
}

precache(var_0) {
  if(isdefined(var_0["name"])) {} else {}

  precachemodel(var_0["model"]);
  var_1 = var_0["attach"];
  var_2 = var_1.size;

  for (var_3 = 0; var_3 < var_2; var_3++)
    precachemodel(var_1[var_3]["model"]);
}

get_random_character(var_0) {
  if(isdefined(self.classname))
    var_1 = strtok(self.classname, "_");
  else
    var_1 = [];

  if(!common_scripts\utility::issp()) {
    if(isdefined(self.pers["modelIndex"]) && self.pers["modelIndex"] < var_0)
      return self.pers["modelIndex"];

    var_2 = randomint(var_0);
    self.pers["modelIndex"] = var_2;
    return var_2;
  } else if(var_1.size <= 2)
    return randomint(var_0);

  var_3 = "auto";
  var_2 = undefined;
  var_4 = var_1[2];

  if(isdefined(self.script_char_index))
    var_2 = self.script_char_index;

  if(isdefined(self.script_char_group)) {
    var_5 = "grouped";
    var_3 = "group_" + self.script_char_group;
  }

  if(!isdefined(level.character_index_cache))
    level.character_index_cache = [];

  if(!isdefined(level.character_index_cache[var_4]))
    level.character_index_cache[var_4] = [];

  if(!isdefined(level.character_index_cache[var_4][var_3]))
    initialize_character_group(var_4, var_3, var_0);

  if(!isdefined(var_2)) {
    var_2 = get_least_used_index(var_4, var_3);

    if(!isdefined(var_2))
      var_2 = randomint(5000);
  }

  while (var_2 >= var_0)
    var_2 = var_2 - var_0;

  level.character_index_cache[var_4][var_3][var_2]++;
  return var_2;
}

get_least_used_index(var_0, var_1) {
  var_2 = [];
  var_3 = level.character_index_cache[var_0][var_1][0];
  var_2[0] = 0;

  for (var_4 = 1; var_4 < level.character_index_cache[var_0][var_1].size; var_4++) {
    if(level.character_index_cache[var_0][var_1][var_4] > var_3) {
      continue;
    }
    if(level.character_index_cache[var_0][var_1][var_4] < var_3) {
      var_2 = [];
      var_3 = level.character_index_cache[var_0][var_1][var_4];
    }

    var_2[var_2.size] = var_4;
  }

  return random(var_2);
}

initialize_character_group(var_0, var_1, var_2) {
  for (var_3 = 0; var_3 < var_2; var_3++)
    level.character_index_cache[var_0][var_1][var_3] = 0;
}

get_random_weapon(var_0) {
  return randomint(var_0);
}

random(var_0) {
  return var_0[randomint(var_0.size)];
}