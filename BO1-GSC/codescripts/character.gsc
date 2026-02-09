/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: codescripts\character.gsc
**************************************/

setModelFromArray(a) {
  self setModel(a[randomint(a.size)]);
}
precacheModelArray(a) {
  for(i = 0; i < a.size; i++) {
    precacheModel(a[i]);
  }
}
randomElement(a) {
  return a[randomint(a.size)];
}
attachFromArray(a) {
  self attach(randomElement(a), "", true);
}
new() {
  self detachAll();
  oldGunHand = self.anim_gunHand;
  if(!isDefined(oldGunHand)) {
    return;
  }
  self.anim_gunHand = "none";
  self[[anim.PutGunInHand]](oldGunHand);
}
save() {
  info["gunHand"] = self.anim_gunHand;
  info["gunInHand"] = self.anim_gunInHand;
  info["model"] = self.model;
  info["hatModel"] = self.hatModel;
  info["gearModel"] = self.gearModel;
  if(isDefined(self.name)) {
    info["name"] = self.name;
    println("Save: Guy has name ", self.name);
  } else
    println("save: Guy had no name!");
  attachSize = self getAttachSize();
  for(i = 0; i < attachSize; i++) {
    info["attach"][i]["model"] = self getAttachModelName(i);
    info["attach"][i]["tag"] = self getAttachTagName(i);
  }
  return info;
}
load(info) {
  self detachAll();
  self.anim_gunHand = info["gunHand"];
  self.anim_gunInHand = info["gunInHand"];
  self setModel(info["model"]);
  self.hatModel = info["hatModel"];
  self.gearModel = info["gearModel"];
  if(isDefined(info["name"])) {
    self.name = info["name"];
    println("Load: Guy has name ", self.name);
  } else
    println("Load: Guy had no name!");
  attachInfo = info["attach"];
  attachSize = attachInfo.size;
  for(i = 0; i < attachSize; i++) {
    self attach(attachInfo[i]["model"], attachInfo[i]["tag"]);
  }
}
precache(info) {
  if(isDefined(info["name"])) {
    println("Precache: Guy has name ", info["name"]);
  } else {
    println("Precache: Guy had no name!");
  }
  precacheModel(info["model"]);
  attachInfo = info["attach"];
  attachSize = attachInfo.size;
  for(i = 0; i < attachSize; i++) {
    precacheModel(attachInfo[i]["model"]);
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
  assertex(lowest_indices.size, "Tried to spawn a character but the lowest indices didn't exist");
  return random(lowest_indices);
}
initialize_character_group(prefix, group, amount) {
  for(i = 0; i < amount; i++) {
    level.character_index_cache[prefix][group][i] = 0;
  }
}
random(array) {
  return array[randomint(array.size)];
}