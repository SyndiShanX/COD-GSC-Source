/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_150fee7943687302.gsc
*************************************************/

#using script_3fcc27c3656c46dc;
#using script_40e63dd222434655;
#using script_59ff79d681bb860c;
#using script_9963540126262c0;
#using script_d74ae0b4aa21186;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_armory_kiosk;
#namespace buy_items;

function function_eda57308516bfc5f() {
  return function_bffb5b682a4ef6a2(&evaluatescore);
}

function evaluatescore(bot) {
  if(!level.br_armory_kiosk_enabled) {
    return -100;
  }

  var_14f8998b9e6f6bba = function_5b0291aeab99561b(bot);

  if(!isDefined(var_14f8998b9e6f6bba)) {
    return -100;
  }

  finalscore = var_14f8998b9e6f6bba.score;
  target = var_14f8998b9e6f6bba.target;
  self.var_df9d35d9b4bee654 = namespace_ca8eb8c7f624c164::createaction(target);
  return finalscore;
}

function function_5b0291aeab99561b(bot) {
  stations = bot namespace_bfa2898056f8354::getevent();

  if(stations.size == 0) {
    return undefined;
  }

  target = spawnStruct();
  var_ad2f80c3d8d4e44e = -100;
  var_efabc1f8231cc4f9 = undefined;
  var_343466bbc23688c9 = level.var_6be7b375ec4a629c[0];
  assert(isDefined(var_343466bbc23688c9) && isDefined(var_343466bbc23688c9["<dev string:x1c>"]));

  foreach(itemref, cost in var_343466bbc23688c9["items"]) {
    if(cost["cost"] <= 0 || bot.plundercount < cost["cost"]) {
      continue;
    }

    itemscore = scoreitem(bot, itemref);

    if(!isDefined(itemscore)) {
      continue;
    }

    if(itemscore > var_ad2f80c3d8d4e44e) {
      var_ad2f80c3d8d4e44e = itemscore;
      var_efabc1f8231cc4f9 = itemref;
    }
  }

  if(!isDefined(var_efabc1f8231cc4f9)) {
    return undefined;
  }

  target.purchaseindex = scripts\mp\gametypes\br_armory_kiosk::function_fe176342ed52b44f(var_efabc1f8231cc4f9);
  target.channel = "br_item_purchase";
  target.itemname = var_efabc1f8231cc4f9;
  neareststation = bot nearestplace(stations, self.constants.var_ea186a77c016a88d, self.constants.var_9551c1a2c6f5863, 0, self.constants.var_93bcc2b99d24433f, self.constants.var_5107f0b927dad2b);

  if(!isDefined(neareststation) || function_f7df7edcfce4b1f2(neareststation.target, bot)) {
    return undefined;
  }

  var_9073e5955eaebe2c = function_9d1ab012058221bb(function_1c51f7c46a848ddd(), self.constants.var_e23500dbd314bae2, self.constants.var_e58a5e1efeb78937);
  var_8aee78bd838ba612 = function_9d1ab012058221bb(bot.plundercount, self.constants.var_8e95bda6c02d6964, self.constants.var_2a7a0c76f330e72d);
  neareststation.score += var_9073e5955eaebe2c;
  neareststation.score += var_8aee78bd838ba612;
  circle = bot function_e5b4b5992cddb221();
  var_79eef5a8e34ac410 = circle.radius - distance(neareststation.target.origin, circle.origin);
  var_e2d41d6be5320861 = function_9d1ab012058221bb(var_79eef5a8e34ac410, self.constants.var_79eef5a8e34ac410, self.constants.var_ca580a719e470379);
  neareststation.score += var_e2d41d6be5320861;
  target.buystation = neareststation.target;
  result = spawnStruct();
  result.target = target;
  result.score = var_ad2f80c3d8d4e44e + neareststation.score;
  return result;
}

function scoreitem(bot, var_bf09a57af008acd6) {
  lootname = self.constants.var_e34f223c4f415ed0[var_bf09a57af008acd6];

  if(isDefined(lootname) && bot function_bbc2d6967287dc7(lootname)) {
    return self.constants.var_7d0fd6ff10edefd6[var_bf09a57af008acd6];
  }

  return undefined;
}

function function_f7df7edcfce4b1f2(buystation, bot) {
  if(!isDefined(buystation.var_19c6f51451310013)) {
    return false;
  }

  var_3f6f0f4c8e8d9b4c = 15000;
  var_ecc808e906f27f3 = buystation.var_19c6f51451310013[bot.entity_number];

  if(!isDefined(var_ecc808e906f27f3) || gettime() > var_ecc808e906f27f3 + var_3f6f0f4c8e8d9b4c) {
    buystation.var_19c6f51451310013[bot.entity_number] = undefined;
    return false;
  }

  return true;
}