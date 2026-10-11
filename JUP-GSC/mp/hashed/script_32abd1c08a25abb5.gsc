/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_32abd1c08a25abb5.gsc
*************************************************/

#using script_37d9a569491ff1e0;
#using script_59ff79d681bb860c;
#using script_d74ae0b4aa21186;
#using scripts\cp_mp\armor;
#using scripts\engine\utility;
#namespace equip_armor;

function function_eda57308516bfc5f() {
  return function_bffb5b682a4ef6a2(&evaluatescore, &createaction);
}

function evaluatescore(bot) {
  if(!bot function_fc5d9d6dc490ce2e()) {
    return 0;
  }

  if(bot.armorhealth >= self.constants.var_ae436a56f4dc7add) {
    return 0;
  }

  nearbyevent = bot namespace_5524884c16a95af2::getevent();
  nearbyevent namespace_5524884c16a95af2::keepenemies(bot);
  threatmodifier = self.constants.var_71bdba3f5c7a939d[self.constants.var_71bdba3f5c7a939d.size - 1];

  if(nearbyevent.result.size > 0) {
    player = nearbyevent.result[0];
    threatmodifier = function_9d1ab012058221bb(distance(player.origin, bot.origin), self.constants.var_a8d37f0ea66f877f, self.constants.var_71bdba3f5c7a939d);
  }

  return self.constants.basescore + threatmodifier;
}

function createaction(bot) {
  return createactionbase("Equip Armor", undefined, "upper body", "", &actionprocess, self, &function_f4caae7e8af9d32c);
}

function actionprocess(bot) {
  if(!bot function_fc5d9d6dc490ce2e()) {
    return "Can't equip";
  }

  bot botsetflag("ignore_script_weapon", 0);
  bot scripts\cp_mp\armor::tryusearmor(1);
  bot waittill_any_in_array_or_timeout(["insertArmorComplete"], 5);
}

function function_fc5d9d6dc490ce2e() {
  return istrue(level.allowarmor) && !istrue(self.insertingarmorplate) && scripts\cp_mp\armor::function_20b8437058079297() > 0 && scripts\cp_mp\armor::caninsertarmor() && !self isswitchingweapon();
}

function function_f4caae7e8af9d32c(action) {
  if(function_d57dd414963503d1()) {
    self botsetflag("ignore_script_weapon", 1);
  }
}