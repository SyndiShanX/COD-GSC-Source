/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7f01b0f20c9a2371.gsc
*************************************************/

#using script_1076881dd9127338;
#using script_37d9a569491ff1e0;
#using script_40e63dd222434655;
#using script_59ff79d681bb860c;
#using script_d74ae0b4aa21186;
#using scripts\engine\utility;
#using scripts\mp\bots\bots_gametype_br;
#namespace sniper_combat;

function function_eda57308516bfc5f() {
  return function_bffb5b682a4ef6a2(&evaluatescore);
}

function evaluatescore(bot) {
  targetstruct = function_1613f016af44e830(bot);

  if(!isDefined(targetstruct) || !isDefined(targetstruct.target)) {
    return 0;
  }

  target = targetstruct.target;
  targetname = getentityname(target);
  self.var_df9d35d9b4bee654 = createactionbase("sniper_combat", target, "main", targetname + "/" + target getentitynumber(), &actionprocess, self, &function_f4caae7e8af9d32c);
  return targetstruct.score;
}

function function_1613f016af44e830(bot) {
  if(getDvar(@ "bot_notarget") == "<dev string:x1c>") {
    return undefined;
  }

  var_49fffc1ce970e26d = isDefined(bot.primaryweaponobj) && bot namespace_bc2665cbe6cf4e1f::isammoenough(bot.primaryweaponobj, self.constants.var_d0708c53f9aedbbe);

  if(!var_49fffc1ce970e26d) {
    return undefined;
  }

  var_b01971ef554bac8 = bot namespace_1bebff3a2e9afaca::getevent();
  var_80d16926274a0f94 = getclosest(bot.origin, var_b01971ef554bac8);

  if(!isDefined(var_80d16926274a0f94)) {
    return undefined;
  }

  var_3b3d162ce953d1dc = var_80d16926274a0f94 get_target_array();
  var_5debf83062cf0194 = getclosest(bot.origin, var_3b3d162ce953d1dc, self.constants.var_b9de038abd473868);

  if(!isDefined(var_5debf83062cf0194)) {
    return undefined;
  }

  nearbyevent = bot namespace_5524884c16a95af2::getevent();
  nearbyevent namespace_5524884c16a95af2::keepenemies(bot);
  maxdistance = self.constants.var_96af88c97db9ed21[self.constants.var_96af88c97db9ed21.size - 1];
  nearbyevent namespace_5524884c16a95af2::indistance(maxdistance);
  finalscore = 0;
  target = undefined;

  foreach(player in nearbyevent.result) {
    if(!isbot(player) && getDvar(@ "bot_notarget") == "<dev string:x23>") {
      continue;
    }

    distancetoplayer = distance(bot.origin, player.origin);
    basescore = function_9d1ab012058221bb(distancetoplayer, self.constants.var_96af88c97db9ed21, self.constants.var_49e2976ca0c853ef);
    var_6ca288ca3f0ca3a0 = bot function_3569a4bec8b9af17(player);

    if(var_6ca288ca3f0ca3a0) {
      basescore += self.constants.attackermodifier;
    }

    if(basescore > finalscore && (var_6ca288ca3f0ca3a0 || bot botcanseeentity(player))) {
      finalscore = basescore;
      target = player;
    }
  }

  result = spawnStruct();
  result.score = finalscore;
  result.target = target;
  return result;
}

function actionprocess(bot) {
  assert(isPlayer(self.argument));
  target = self.argument;
  target endon("death_or_disconnect");
  bot allowmovement(0);
  bot botsetstance(bot getstance());
  bot setenemy(target);

  while(isvalidplayer(target)) {
    if(self.decision.constants.extragrenadethrow) {
      bot function_cf1a9e98122e3931(target);
    }

    wait 1;
  }
}

function function_f4caae7e8af9d32c(action) {
  if(function_d57dd414963503d1()) {
    self botsetstance("none");
    self allowmovement(1);
  }
}