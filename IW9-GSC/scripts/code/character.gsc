/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\code\character.gsc
***********************************************/

setmodelfromarray(a) {
  if(!scripts\common\utility::issp())
    self setModel(a[randomint(a.size)]);
  else {
    if(!isDefined(level.character_model_cache))
      level.character_model_cache = [];

    model = get_least_used_model(a);

    if(!isDefined(model))
      model = a[randomint(a.size)];

    level.character_model_cache["last_used"] = model;
    level.character_model_cache[model]++;
    self setModel(model);
  }
}

get_least_used_model(array) {
  _id_54330A29683DF9BD = [];
  _id_5F2C77FFE38CF853 = 999999;
  _id_54330A29683DF9BD[0] = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
    if(!isDefined(level.character_model_cache[array[_id_AC0E594AC96AA3A8]]))
      level.character_model_cache[array[_id_AC0E594AC96AA3A8]] = 0;

    _id_BE3639147941E00A = level.character_model_cache[array[_id_AC0E594AC96AA3A8]];

    if(_id_BE3639147941E00A > _id_5F2C77FFE38CF853) {
      continue;
    }
    if(_id_BE3639147941E00A < _id_5F2C77FFE38CF853) {
      _id_54330A29683DF9BD = [];
      _id_5F2C77FFE38CF853 = _id_BE3639147941E00A;
    }

    _id_54330A29683DF9BD[_id_54330A29683DF9BD.size] = _id_AC0E594AC96AA3A8;
  }

  _id_CB8E2003144AC503 = random(_id_54330A29683DF9BD);
  return array[_id_CB8E2003144AC503];
}

precachemodelarray(a) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < a.size; _id_AC0E594AC96AA3A8++)
    precachemodel(a[_id_AC0E594AC96AA3A8]);
}

attachhead(_id_0E1B8A2CDA2A36F9, _id_7556F3E1BB0846BC) {
  if(!isDefined(level.character_head_index))
    level.character_head_index = [];

  if(!isDefined(level.character_head_index[_id_0E1B8A2CDA2A36F9]))
    level.character_head_index[_id_0E1B8A2CDA2A36F9] = randomint(_id_7556F3E1BB0846BC.size);

  index = (level.character_head_index[_id_0E1B8A2CDA2A36F9] + 1) % _id_7556F3E1BB0846BC.size;

  if(isDefined(self.script_char_index))
    index = self.script_char_index % _id_7556F3E1BB0846BC.size;

  level.character_head_index[_id_0E1B8A2CDA2A36F9] = index;
  self attach(_id_7556F3E1BB0846BC[index], "", 1);
  self.headmodel = _id_7556F3E1BB0846BC[index];
}

attachhat(_id_CB1B71997EBF2A1A, _id_827C5E69D673CE17) {
  if(!isDefined(level.character_hat_index))
    level.character_hat_index = [];

  if(!isDefined(level.character_hat_index[_id_CB1B71997EBF2A1A]))
    level.character_hat_index[_id_CB1B71997EBF2A1A] = randomint(_id_827C5E69D673CE17.size);

  index = (level.character_hat_index[_id_CB1B71997EBF2A1A] + 1) % _id_827C5E69D673CE17.size;
  level.character_hat_index[_id_CB1B71997EBF2A1A] = index;
  self attach(_id_827C5E69D673CE17[index]);
  self.hatmodel = _id_827C5E69D673CE17[index];
}

new() {
  self detachall();
  _id_4D089A4A3FE1C8D1 = self.anim_gunhand;

  if(!isDefined(_id_4D089A4A3FE1C8D1)) {
    return;
  }
  self.anim_gunhand = "none";
  self[[anim.putguninhand]](_id_4D089A4A3FE1C8D1);
}

save() {
  info["gunHand"] = self.anim_gunhand;
  info["gunInHand"] = self.anim_guninhand;
  info["model"] = self.model;
  info["hatModel"] = self.hatmodel;

  if(isDefined(self.name))
    info["name"] = self.name;
  else {}

  _id_076651B5D03AD861 = self getattachsize();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_076651B5D03AD861; _id_AC0E594AC96AA3A8++) {
    info["attach"][_id_AC0E594AC96AA3A8]["model"] = self getattachmodelname(_id_AC0E594AC96AA3A8);
    info["attach"][_id_AC0E594AC96AA3A8]["tag"] = self getattachtagname(_id_AC0E594AC96AA3A8);
  }

  return info;
}

load(info) {
  self detachall();
  self.anim_gunhand = info["gunHand"];
  self.anim_guninhand = info["gunInHand"];
  self setModel(info["model"]);
  self.hatmodel = info["hatModel"];

  if(isDefined(info["name"]))
    self.name = info["name"];
  else {}

  _id_DB5548BB3BC60B0C = info["attach"];
  _id_076651B5D03AD861 = _id_DB5548BB3BC60B0C.size;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_076651B5D03AD861; _id_AC0E594AC96AA3A8++)
    self attach(_id_DB5548BB3BC60B0C[_id_AC0E594AC96AA3A8]["model"], _id_DB5548BB3BC60B0C[_id_AC0E594AC96AA3A8]["tag"]);
}

precache(info) {
  if(isDefined(info["name"])) {} else {}

  precachemodel(info["model"]);
  _id_DB5548BB3BC60B0C = info["attach"];
  _id_076651B5D03AD861 = _id_DB5548BB3BC60B0C.size;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_076651B5D03AD861; _id_AC0E594AC96AA3A8++)
    precachemodel(_id_DB5548BB3BC60B0C[_id_AC0E594AC96AA3A8]["model"]);
}

get_random_character(amount, _id_9AE4F464A199E25F, characters, _id_0B878B1B0A71A3F0) {
  index = undefined;

  if(isDefined(_id_0B878B1B0A71A3F0))
    _id_AC883B2DB64CE180 = strtok(_id_0B878B1B0A71A3F0, "_");
  else
    _id_AC883B2DB64CE180 = strtok(self.classname, "_");

  if(!scripts\common\utility::issp()) {
    if(isDefined(self.pers["modelIndex"]) && self.pers["modelIndex"] < amount)
      return self.pers["modelIndex"];

    index = randomint(amount);
    self.pers["modelIndex"] = index;
    return index;
  } else if(_id_AC883B2DB64CE180.size <= 2)
    return randomint(amount);

  group = "auto";

  if(isDefined(self.script_char_index))
    index = self.script_char_index;
  else if(isDefined(_id_9AE4F464A199E25F))
    index = get_randomly_weighted_character(_id_9AE4F464A199E25F);

  if(isDefined(self.script_char_group))
    group = "group_" + self.script_char_group;

  if(!isDefined(level.character_index_cache))
    level.character_index_cache = [];

  if(!isDefined(level.character_index_cache[group]))
    level.character_index_cache[group] = [];

  if(!isDefined(index)) {
    index = get_least_used_index(characters, group);

    if(!isDefined(index))
      index = randomint(characters.size);
  }

  if(!isDefined(level.character_index_cache[group][characters[index]]))
    level.character_index_cache[group][characters[index]] = 0;

  level.character_index_cache[group][characters[index]]++;
  return index;
}

get_least_used_index(characters, group) {
  _id_54330A29683DF9BD = [];
  _id_5F2C77FFE38CF853 = 999999;
  _id_54330A29683DF9BD[0] = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < characters.size; _id_AC0E594AC96AA3A8++) {
    if(!isDefined(level.character_index_cache[group][characters[_id_AC0E594AC96AA3A8]]))
      level.character_index_cache[group][characters[_id_AC0E594AC96AA3A8]] = 0;

    _id_176FE67170E3AF18 = level.character_index_cache[group][characters[_id_AC0E594AC96AA3A8]];

    if(_id_176FE67170E3AF18 > _id_5F2C77FFE38CF853) {
      continue;
    }
    if(_id_176FE67170E3AF18 < _id_5F2C77FFE38CF853) {
      _id_54330A29683DF9BD = [];
      _id_5F2C77FFE38CF853 = _id_176FE67170E3AF18;
    }

    _id_54330A29683DF9BD[_id_54330A29683DF9BD.size] = _id_AC0E594AC96AA3A8;
  }

  return random(_id_54330A29683DF9BD);
}

initialize_character_group(_id_DEC9BCCE93873125, group, amount) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < amount; _id_AC0E594AC96AA3A8++)
    level.character_index_cache[_id_DEC9BCCE93873125][group][_id_AC0E594AC96AA3A8] = 0;
}

get_random_weapon(amount) {
  return randomint(amount);
}

random(array) {
  return array[randomint(array.size)];
}

get_randomly_weighted_character(_id_9AE4F464A199E25F) {
  _id_057BFDD29E55F96A = randomfloat(1);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_9AE4F464A199E25F.size; _id_AC0E594AC96AA3A8++) {
    if(_id_057BFDD29E55F96A < _id_9AE4F464A199E25F[_id_AC0E594AC96AA3A8])
      return _id_AC0E594AC96AA3A8;
  }

  return 0;
}