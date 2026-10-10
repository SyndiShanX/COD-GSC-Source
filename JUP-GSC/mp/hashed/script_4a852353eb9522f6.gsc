/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4a852353eb9522f6.gsc
*************************************************/

#using scripts\cp_mp\armor;
#namespace namespace_8e943b1ae0e1a01b;

function function_cdf4890b38273393(player, position, pickedcallback) {
  var_276f41532514ddcc = function_aebdf233df00e83d(player);
  item = function_59ce33cc585f367e(position, (0, 0, 0), player);
  player thread function_d81f5f7fa0dddb1e(var_276f41532514ddcc, pickedcallback);
  return item;
}

function private function_aebdf233df00e83d(player) {
  count = player scripts\cp_mp\armor::function_20b8437058079297();
  return count;
}

function private function_59ce33cc585f367e(position, rotation, player) {
  item = spawnscriptable("brloot_armor_plate", position, rotation, 0);

  if(!isDefined(item)) {
    return;
  }

  function_e4d73eb84e34c49f(item);
  item.count = 1;
  return item;
}

function private function_e4d73eb84e34c49f(instance) {
  assertex(isDefined(level.br_pickups), "<dev string:x1c>");
  assertex(isDefined(level.br_pickups.scriptables), "<dev string:x67>");
  assertex(!isDefined(instance.brpickupscriptableid), "<dev string:xad>");
  id = level.br_pickups.scriptablescurid;
  instance.brpickupscriptableid = id;
  level.br_pickups.scriptables[id] = instance;
  level.br_pickups.scriptablescurid++;
}

function private function_d81f5f7fa0dddb1e(var_8e973702bc8bb72a, pickedcallback) {
  self endon("death_or_disconnect");
  currentvalue = function_aebdf233df00e83d(self);

  while(var_8e973702bc8bb72a == currentvalue) {
    currentvalue = function_aebdf233df00e83d(self);

    if(currentvalue < var_8e973702bc8bb72a) {
      var_8e973702bc8bb72a = currentvalue;
    }

    waitframe();
  }

  self[[pickedcallback]]();
}

function function_d92343be83930b25(player, equipcallback) {
  var_f9bd260cd70a6187 = player.armorhealth;
  player thread function_dca51bc9d625ec23(var_f9bd260cd70a6187, equipcallback);
}

function private function_dca51bc9d625ec23(var_f840b1fd8f763c57, equipcallback) {
  self endon("death_or_disconnect");

  while(var_f840b1fd8f763c57 == self.armorhealth) {
    waitframe();

    if(self.armorhealth < var_f840b1fd8f763c57) {
      var_f840b1fd8f763c57 = self.armorhealth;
    }
  }

  self[[equipcallback]]();
}