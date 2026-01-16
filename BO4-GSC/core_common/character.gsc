/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\character.gsc
***********************************************/

#include scripts\core_common\array_shared;

#namespace character;

setmodelfromarray(a) {
  self setModel(a[randomint(a.size)]);
}

randomelement(a) {
  return a[randomint(a.size)];
}

attachfromarray(a) {
  self attach(randomelement(a), "", 1);
}

newcharacter() {
  self detachall();
  oldgunhand = self.anim_gunhand;

  if(!isDefined(oldgunhand)) {
    return;
  }

  self.anim_gunhand = "none";
  self[[anim.putguninhand]](oldgunhand);
}

save() {
  info[#"gunhand"] = self.anim_gunhand;
  info[#"guninhand"] = self.anim_guninhand;
  info[#"model"] = self.model;
  info[#"hatmodel"] = self.hatmodel;
  info[#"gearmodel"] = self.gearmodel;

  if(isDefined(self.name)) {
    info[#"name"] = self.name;
    println("<dev string:x38>", self.name);
  } else {
    println("<dev string:x4e>");
  }

  attachsize = self getattachsize();

  for(i = 0; i < attachsize; i++) {
    info[#"attach"][i][#"model"] = self getattachmodelname(i);
    info[#"attach"][i][#"tag"] = self getattachtagname(i);
  }

  return info;
}

load(info) {
  self detachall();
  self.anim_gunhand = info[#"gunhand"];
  self.anim_guninhand = info[#"guninhand"];
  self setModel(info[#"model"]);
  self.hatmodel = info[#"hatmodel"];
  self.gearmodel = info[#"gearmodel"];

  if(isDefined(info[#"name"])) {
    self.name = info[#"name"];
    println("<dev string:x67>", self.name);
  } else {
    println("<dev string:x7d>");
  }

  attachinfo = info[#"attach"];
  attachsize = attachinfo.size;

  for(i = 0; i < attachsize; i++) {
    self attach(attachinfo[i][#"model"], attachinfo[i][#"tag"]);
  }
}

get_random_character(amount) {
  self_info = strtok(self.classname, "_");

  if(self_info.size <= 2) {
    return randomint(amount);
  }

  group = "auto";
  index = undefined;
  prefix = self_info[2];

  if(isDefined(self.script_char_index)) {
    index = self.script_char_index;
  }

  if(isDefined(self.script_char_group)) {
    type = "grouped";
    group = "group_" + self.script_char_group;
  }

  if(!isDefined(level.character_index_cache)) {
    level.character_index_cache = [];
  }

  if(!isDefined(level.character_index_cache[prefix])) {
    level.character_index_cache[prefix] = [];
  }

  if(!isDefined(level.character_index_cache[prefix][group])) {
    initialize_character_group(prefix, group, amount);
  }

  if(!isDefined(index)) {
    index = get_least_used_index(prefix, group);

    if(!isDefined(index)) {
      index = randomint(5000);
    }
  }

  while(index >= amount) {
    index -= amount;
  }

  level.character_index_cache[prefix][group][index]++;
  return index;
}

get_least_used_index(prefix, group) {
  lowest_indices = [];
  lowest_use = level.character_index_cache[prefix][group][0];
  lowest_indices[0] = 0;

  for(i = 1; i < level.character_index_cache[prefix][group].size; i++) {
    if(level.character_index_cache[prefix][group][i] > lowest_use) {
      continue;
    }

    if(level.character_index_cache[prefix][group][i] < lowest_use) {
      lowest_indices = [];
      lowest_use = level.character_index_cache[prefix][group][i];
    }

    lowest_indices[lowest_indices.size] = i;
  }

  assert(lowest_indices.size, "<dev string:x96>");
  return array::random(lowest_indices);
}

initialize_character_group(prefix, group, amount) {
  for(i = 0; i < amount; i++) {
    level.character_index_cache[prefix][group][i] = 0;
  }
}