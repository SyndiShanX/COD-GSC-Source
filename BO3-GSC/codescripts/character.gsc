/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: codescripts\character.gsc
*************************************************/

#namespace character;

function setmodelfromarray(a) {
  self setmodel(a[randomint(a.size)]);
}

function randomelement(a) {
  return a[randomint(a.size)];
}

function attachfromarray(a) {
  self attach(randomelement(a), "", 1);
}

function newcharacter() {
  self detachall();
  oldgunhand = self.anim_gunhand;
  if(!isdefined(oldgunhand)) {
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
  info["gearModel"] = self.gearmodel;
  if(isdefined(self.name)) {
    info["name"] = self.name;
    println("", self.name);
  } else {
    println("");
  }
  attachsize = self getattachsize();
  for (i = 0; i < attachsize; i++) {
    info["attach"][i]["model"] = self getattachmodelname(i);
    info["attach"][i]["tag"] = self getattachtagname(i);
  }
  return info;
}

function load(info) {
  self detachall();
  self.anim_gunhand = info["gunHand"];
  self.anim_guninhand = info["gunInHand"];
  self setmodel(info["model"]);
  self.hatmodel = info["hatModel"];
  self.gearmodel = info["gearModel"];
  if(isdefined(info["name"])) {
    self.name = info["name"];
    println("", self.name);
  } else {
    println("");
  }
  attachinfo = info["attach"];
  attachsize = attachinfo.size;
  for (i = 0; i < attachsize; i++) {
    self attach(attachinfo[i]["model"], attachinfo[i]["tag"]);
  }
}

function get_random_character(amount) {
  self_info = strtok(self.classname, "_");
  if(self_info.size <= 2) {
    return randomint(amount);
  }
  group = "auto";
  index = undefined;
  prefix = self_info[2];
  if(isdefined(self.script_char_index)) {
    index = self.script_char_index;
  }
  if(isdefined(self.script_char_group)) {
    type = "grouped";
    group = "group_" + self.script_char_group;
  }
  if(!isdefined(level.character_index_cache)) {
    level.character_index_cache = [];
  }
  if(!isdefined(level.character_index_cache[prefix])) {
    level.character_index_cache[prefix] = [];
  }
  if(!isdefined(level.character_index_cache[prefix][group])) {
    initialize_character_group(prefix, group, amount);
  }
  if(!isdefined(index)) {
    index = get_least_used_index(prefix, group);
    if(!isdefined(index)) {
      index = randomint(5000);
    }
  }
  while (index >= amount) {
    index = index - amount;
  }
  level.character_index_cache[prefix][group][index]++;
  return index;
}

function get_least_used_index(prefix, group) {
  lowest_indices = [];
  lowest_use = level.character_index_cache[prefix][group][0];
  lowest_indices[0] = 0;
  for (i = 1; i < level.character_index_cache[prefix][group].size; i++) {
    if(level.character_index_cache[prefix][group][i] > lowest_use) {
      continue;
    }
    if(level.character_index_cache[prefix][group][i] < lowest_use) {
      lowest_indices = [];
      lowest_use = level.character_index_cache[prefix][group][i];
    }
    lowest_indices[lowest_indices.size] = i;
  }
  assert(lowest_indices.size, "");
  return random(lowest_indices);
}

function initialize_character_group(prefix, group, amount) {
  for (i = 0; i < amount; i++) {
    level.character_index_cache[prefix][group][i] = 0;
  }
}

function random(array) {
  keys = getarraykeys(array);
  return array[keys[randomint(keys.size)]];
}