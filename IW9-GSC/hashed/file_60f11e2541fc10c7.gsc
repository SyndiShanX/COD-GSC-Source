/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_60f11e2541fc10c7.gsc
***********************************************/

_id_CDF4890B38273393(player, position, _id_102C577D9965BD66) {
  _id_276F41532514DDCC = _id_AEBDF233DF00E83D(player);
  item = _id_59CE33CC585F367E(position, (0, 0, 0), player);
  player thread _id_D81F5F7FA0DDDB1E(_id_276F41532514DDCC, _id_102C577D9965BD66);
  return item;
}

_id_AEBDF233DF00E83D(player) {
  count = player _id_07C40FA80892A721::_id_0600F6CF462E983F();
  return count;
}

_id_59CE33CC585F367E(position, rotation, player) {
  item = spawnscriptable("brloot_armor_plate", position, rotation, 0);

  if(!isDefined(item)) {
    return;
  }
  _id_E4D73EB84E34C49F(item);
  item.count = 1;
  return item;
}

_id_E4D73EB84E34C49F(instance) {
  id = level.br_pickups.scriptablescurid;
  instance.brpickupscriptableid = id;
  level.br_pickups.scriptables[id] = instance;
  level.br_pickups.scriptablescurid++;
}

_id_D81F5F7FA0DDDB1E(_id_8E973702BC8BB72A, _id_102C577D9965BD66) {
  self endon("death_or_disconnect");
  currentvalue = _id_AEBDF233DF00E83D(self);

  while(_id_8E973702BC8BB72A == currentvalue) {
    currentvalue = _id_AEBDF233DF00E83D(self);

    if(currentvalue < _id_8E973702BC8BB72A)
      _id_8E973702BC8BB72A = currentvalue;

    waitframe();
  }

  self[[_id_102C577D9965BD66]]();
}

_id_D92343BE83930B25(player, _id_C1670B84179D4350) {
  _id_F9BD260CD70A6187 = player.armorhealth;
  player thread _id_DCA51BC9D625EC23(_id_F9BD260CD70A6187, _id_C1670B84179D4350);
}

_id_DCA51BC9D625EC23(_id_F840B1FD8F763C57, _id_C1670B84179D4350) {
  self endon("death_or_disconnect");

  while(_id_F840B1FD8F763C57 == self.armorhealth) {
    waitframe();

    if(self.armorhealth < _id_F840B1FD8F763C57)
      _id_F840B1FD8F763C57 = self.armorhealth;
  }

  self[[_id_C1670B84179D4350]]();
}