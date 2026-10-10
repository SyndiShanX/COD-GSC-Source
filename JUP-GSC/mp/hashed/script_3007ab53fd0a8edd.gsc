/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3007ab53fd0a8edd.gsc
*************************************************/

#using script_150fee7943687302;
#using script_26ccbfe3954cacf4;
#using script_3fcc27c3656c46dc;
#using script_40e63dd222434655;
#using script_59ff79d681bb860c;
#using script_9963540126262c0;
#using script_d74ae0b4aa21186;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_armory_kiosk;
#using scripts\mp\utility\teams;
#namespace namespace_9dad6814012e55d1;

function function_eda57308516bfc5f() {
  return function_bffb5b682a4ef6a2(&evaluatescore);
}

function evaluatescore(bot) {
  if(!level.br_armory_kiosk_enabled) {
    return -100;
  }

  var_c065d1ca4804ea3a = function_1b5842b9b6465162(bot);

  if(!isDefined(var_c065d1ca4804ea3a)) {
    return -100;
  }

  self.var_df9d35d9b4bee654 = namespace_ca8eb8c7f624c164::createaction(var_c065d1ca4804ea3a.target);
  finalscore = var_c065d1ca4804ea3a.score * self.constants.var_2d40425ebda06605;
  return finalscore;
}

function function_1b5842b9b6465162(bot) {
  var_69590e67f030f9aa = "teamReviver";
  var_b6736234a4ac9bd1 = isDefined(level.var_6be7b375ec4a629c[0]["items"][var_69590e67f030f9aa]);

  if(!var_b6736234a4ac9bd1) {
    return undefined;
  }

  enoughmoney = bot.plundercount >= scripts\mp\gametypes\br_armory_kiosk::function_517b8730ddec7f59(var_69590e67f030f9aa);

  if(!enoughmoney) {
    return undefined;
  }

  var_10a39f1a0b6d2aa2 = namespace_95d8d8ec67e3e074::function_a5786099ca387b00();
  teammates = scripts\mp\utility\teams::getteamdata(bot.team, "players");
  var_38882a650f503344 = undefined;

  foreach(player in teammates) {
    if(!isDefined(player) || player == bot) {
      continue;
    }

    if(player iseliminated()) {
      if(!isai(player)) {
        var_38882a650f503344 = player;
        break;
      }

      if(!isDefined(var_38882a650f503344) && var_10a39f1a0b6d2aa2) {
        var_38882a650f503344 = player;
      }
    }
  }

  if(!isDefined(var_38882a650f503344)) {
    return undefined;
  }

  stations = bot namespace_bfa2898056f8354::getevent();

  if(stations.size == 0) {
    return undefined;
  }

  neareststation = bot nearestplace(stations, self.constants.var_87f34cf0d41d251d, self.constants.var_38a8985512b3e7b3, 0, self.constants.var_93bcc2b99d24433f, self.constants.var_5107f0b927dad2b);

  if(!isDefined(neareststation) || namespace_30e7da3797ac6a02::function_f7df7edcfce4b1f2(neareststation.target, bot)) {
    return undefined;
  }

  circle = bot function_e5b4b5992cddb221();
  var_79eef5a8e34ac410 = circle.radius - distance(neareststation.target.origin, circle.origin);
  var_e2d41d6be5320861 = function_9d1ab012058221bb(var_79eef5a8e34ac410, self.constants.var_79eef5a8e34ac410, self.constants.var_ca580a719e470379);
  neareststation.score += var_e2d41d6be5320861;
  target = spawnStruct();
  target.purchaseindex = var_38882a650f503344.sessionuimemberindex + 1;
  target.itemname = bot.name;
  target.channel = "br_team_revive";
  target.buystation = neareststation.target;
  result = spawnStruct();
  result.target = target;
  result.score = neareststation.score;
  return result;
}