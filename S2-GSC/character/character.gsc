/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: character\character\\-\641.gsc
*********************************************/

setmodelfromarray(param_00) {
  self setModel(param_00[randomint(param_00.size)]);
}

precachemodelarray(param_00) {
  for(var_01 = 0; var_01 < param_00.size; var_01++) {
    precachemodel(param_00[var_01]);
  }
}

attachhead(param_00, param_01) {
  if(!isDefined(level.character_head_index)) {
    level.character_head_index = [];
  }

  if(!isDefined(level.character_head_index[param_00])) {
    level.character_head_index[param_00] = randomint(param_01.size);
  }

  var_02 = level.character_head_index[param_00] + 1 % param_01.size;
  level.character_head_index[param_00] = var_02;
  setplayerheadmodel(param_01[var_02]);
}

setplayerheadmodel(param_00) {
  if(isDefined(self.headmodel)) {
    self detach(self.headmodel);
  }

  self attach(param_00, "", 1);
  self.headmodel = param_00;
}

attachhat(param_00, param_01) {
  if(!isDefined(level.character_hat_index)) {
    level.character_hat_index = [];
  }

  if(!isDefined(level.character_hat_index[param_00])) {
    level.character_hat_index[param_00] = randomint(param_01.size);
  }

  var_02 = level.character_hat_index[param_00] + 1 % param_01.size;
  level.character_hat_index[param_00] = var_02;
  self attach(param_01[var_02]);
  self.hatmodel = param_01[var_02];
}

new() {
  self detachall();
  var_00 = self.var_0E14;
  if(!isDefined(var_00)) {
    return;
  }

  self.var_0E14 = "none";
  self[[level.put_guninhand]](var_00);
}

save() {
  var_00["gunHand"] = self.var_0E14;
  var_00["gunInHand"] = self.var_0E15;
  var_00["model"] = self.var_0106;
  var_00["hatModel"] = self.hatmodel;
  if(isDefined(self.var_0109)) {
    var_00["name"] = self.var_0109;
  } else {}

  var_01 = self getattachsize();
  for(var_02 = 0; var_02 < var_01; var_02++) {
    var_00["attach"][var_02]["model"] = self getattachmodelname(var_02);
    var_00["attach"][var_02]["tag"] = self getattachtagname(var_02);
  }

  return var_00;
}

load(param_00) {
  self detachall();
  self.var_0E14 = param_00["gunHand"];
  self.var_0E15 = param_00["gunInHand"];
  self setModel(param_00["model"]);
  self.hatmodel = param_00["hatModel"];
  if(isDefined(param_00["name"])) {
    self.var_0109 = param_00["name"];
  } else {}

  var_01 = param_00["attach"];
  var_02 = var_01.size;
  for(var_03 = 0; var_03 < var_02; var_03++) {
    self attach(var_01[var_03]["model"], var_01[var_03]["tag"]);
  }
}

func_0136(param_00) {
  if(isDefined(param_00["name"])) {} else {}

  precachemodel(param_00["model"]);
  var_01 = param_00["attach"];
  var_02 = var_01.size;
  for(var_03 = 0; var_03 < var_02; var_03++) {
    precachemodel(var_01[var_03]["model"]);
  }
}

get_random_character(param_00) {
  if(isDefined(self.var_003A)) {
    var_01 = strtok(self.var_003A, "_");
  } else {
    var_01 = [];
  }

  if(!common_scripts\utility::issp()) {
    if(isDefined(self.var_012C["modelIndex"]) && self.var_012C["modelIndex"] < param_00) {
      return self.var_012C["modelIndex"];
    }

    var_02 = randomint(param_00);
    self.var_012C["modelIndex"] = var_02;
    return var_02;
  } else if(var_02.size <= 2) {
    return randomint(var_01);
  }

  var_03 = "auto";
  var_02 = undefined;
  var_04 = var_01[2];
  if(!isDefined(level.character_index_cache)) {
    level.character_index_cache = [];
  }

  if(!isDefined(level.character_index_cache[var_04])) {
    level.character_index_cache[var_04] = [];
  }

  if(!isDefined(level.character_index_cache[var_04][var_02])) {
    initialize_character_group(var_04, var_02, param_00);
  }

  if(!isDefined(var_03)) {
    var_03 = get_least_used_index(var_04, var_02);
    if(!isDefined(var_03)) {
      var_03 = randomint(5000);
    }
  }

  while(var_03 >= param_00) {
    var_03 = var_03 - param_00;
  }

  level.character_index_cache[var_04][var_02][var_03]++;
  return var_03;
}

get_least_used_index(param_00, param_01) {
  var_02 = [];
  var_03 = level.character_index_cache[param_00][param_01][0];
  var_02[0] = 0;
  for(var_04 = 1; var_04 < level.character_index_cache[param_00][param_01].size; var_04++) {
    if(level.character_index_cache[param_00][param_01][var_04] > var_03) {
      continue;
    }

    if(level.character_index_cache[param_00][param_01][var_04] < var_03) {
      var_02 = [];
      var_03 = level.character_index_cache[param_00][param_01][var_04];
    }

    var_02[var_02.size] = var_04;
  }

  return random(var_02);
}

initialize_character_group(param_00, param_01, param_02) {
  for(var_03 = 0; var_03 < param_02; var_03++) {
    level.character_index_cache[param_00][param_01][var_03] = 0;
  }
}

get_random_weapon(param_00) {
  return randomint(param_00);
}

random(param_00) {
  return param_00[randomint(param_00.size)];
}

func_5563(param_00, param_01) {
  var_02 = function_0060(param_00);
  var_03 = 1;
  foreach(var_05 in var_02) {
    if(var_05 == param_01) {
      var_03 = 0;
      break;
    }
  }

  return var_03;
}

func_1D32(param_00, param_01) {
  var_02 = param_00;
  if(isDefined(param_01)) {
    foreach(var_04 in param_01) {
      if(!func_5563(param_00, var_04)) {
        var_02 = var_02 + "+" + var_04;
      }
    }
  }

  return var_02;
}