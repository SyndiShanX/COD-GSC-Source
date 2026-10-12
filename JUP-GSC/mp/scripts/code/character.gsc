/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\code\character.gsc
***********************************************/

#using scripts\common\utility;
#namespace character;

function get_least_used_model(array) {
  lowest_indices = [];
  lowest_use = 999999;
  lowest_indices[0] = 0;

  for(i = 0; i < array.size; i++) {
    if(!isDefined(level.character_model_cache[array[i]])) {
      level.character_model_cache[array[i]] = 0;
    }

    model_count = level.character_model_cache[array[i]];

    if(model_count > lowest_use) {
      continue;
    }

    if(model_count < lowest_use) {
      lowest_indices = [];
      lowest_use = model_count;
    }

    lowest_indices[lowest_indices.size] = i;
  }

  assertex(lowest_indices.size, "<dev string:x1c>");
  rnd = random(lowest_indices);
  return array[rnd];
}

function precachemodelarray(a) {
  for(i = 0; i < a.size; i++) {
    precachemodel(a[i]);
  }
}

function attachhead(headalias, var_7556f3e1bb0846bc) {
  if(isDefined(level.var_ccf5af826b36fa06)) {
    if(!isDefined(self.characterinfo)) {
      self.characterinfo = spawnStruct();
      self.characterinfo.headalias = headalias;
      self.characterinfo.var_7556f3e1bb0846bc = var_7556f3e1bb0846bc;
    }
  }

  if(!isDefined(level.character_head_index)) {
    level.character_head_index = [];
  }

  if(!isDefined(level.character_head_index[headalias])) {
    level.character_head_index[headalias] = randomint(var_7556f3e1bb0846bc.size);
  }

  assert(level.character_head_index[headalias] < var_7556f3e1bb0846bc.size);
  index = (level.character_head_index[headalias] + 1) % var_7556f3e1bb0846bc.size;

  if(isDefined(self.script_char_index)) {
    index = self.script_char_index % var_7556f3e1bb0846bc.size;
  }

  level.character_head_index[headalias] = index;
  self attach(var_7556f3e1bb0846bc[index], "", 1);
  self.headmodel = var_7556f3e1bb0846bc[index];
}

function attachhat(hatalias, var_827c5e69d673ce17) {
  if(!isDefined(level.character_hat_index)) {
    level.character_hat_index = [];
  }

  if(!isDefined(level.character_hat_index[hatalias])) {
    level.character_hat_index[hatalias] = randomint(var_827c5e69d673ce17.size);
  }

  assert(level.character_hat_index[hatalias] < var_827c5e69d673ce17.size);
  index = (level.character_hat_index[hatalias] + 1) % var_827c5e69d673ce17.size;
  level.character_hat_index[hatalias] = index;
  self attach(var_827c5e69d673ce17[index]);
  self.hatmodel = var_827c5e69d673ce17[index];
}

function new() {
  self detachall();
  oldgunhand = self.anim_gunhand;

  if(!isDefined(oldgunhand)) {
    return;
  }

  self.anim_gunhand = "none";
  self[[anim.putguninhand]](oldgunhand);
}

function save() {
  info["gunHand"] = self.anim_gunhand;
  info["gunInHand"] = self.anim_guninhand;
  info["model"] = self.model;
  info["hatModel"] = self.hatmodel;

  if(isDefined(self.name)) {
    info["name"] = self.name;
    println("<dev string:x58>", self.name);
  } else {
    println("<dev string:x6f>");
  }

  attachsize = self getattachsize();

  for(i = 0; i < attachsize; i++) {
    info["attach"][i]["model"] = self getattachmodelname(i);
    info["attach"][i]["tag"] = self getattachtagname(i);
  }

  return info;
}

function load(info) {
  self detachall();
  self.anim_gunhand = info["gunHand"];
  self.anim_guninhand = info["gunInHand"];
  self setModel(info["model"]);
  self.hatmodel = info["hatModel"];

  if(isDefined(info["name"])) {
    self.name = info["name"];
    println("<dev string:x89>", self.name);
  } else {
    println("<dev string:xa0>");
  }

  attachinfo = info["attach"];
  attachsize = attachinfo.size;

  for(i = 0; i < attachsize; i++) {
    self attach(attachinfo[i]["model"], attachinfo[i]["tag"]);
  }
}

function precache(info) {
  if(isDefined(info["name"])) {
    println("<dev string:xba>", info["<dev string:xd5>"]);
  } else {
    println("<dev string:xdd>");
  }

  precachemodel(info["model"]);
  attachinfo = info["attach"];
  attachsize = attachinfo.size;

  for(i = 0; i < attachsize; i++) {
    precachemodel(attachinfo[i]["model"]);
  }
}

function initialize_character_group(prefix, group, amount) {
  for(i = 0; i < amount; i++) {
    level.character_index_cache[prefix][group][i] = 0;
  }
}

function get_random_weapon(amount) {
  return randomint(amount);
}

function random(array) {
  return array[randomint(array.size)];
}