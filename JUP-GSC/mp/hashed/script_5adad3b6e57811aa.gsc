/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5adad3b6e57811aa.gsc
*************************************************/

#using script_37d9a569491ff1e0;
#using script_54a9e44119886147;
#using script_59ff79d681bb860c;
#using script_d74ae0b4aa21186;
#using scripts\engine\utility;
#namespace combat;

function function_eda57308516bfc5f() {
  return function_bffb5b682a4ef6a2(&evaluatescore);
}

function evaluatescore(bot) {
  if(getDvar(@ "bot_notarget") == "<dev string:x1c>") {
    return 0;
  }

  finalscore = 0;
  target = undefined;
  nearbyevent = bot namespace_5524884c16a95af2::getevent();
  nearbyevent namespace_5524884c16a95af2::keepenemies(bot);
  nearbyevent namespace_5524884c16a95af2::indistance(self.constants.nearbyenemydistance);

  foreach(player in nearbyevent.result) {
    if(!isai(player) && getDvar(@ "bot_notarget") == "<dev string:x23>") {
      continue;
    }

    distancetoplayer = distance(bot.origin, player.origin);

    if(distancetoplayer <= 1) {
      continue;
    }

    score = 0;
    basescore = function_9d1ab012058221bb(distancetoplayer, self.constants.var_96af88c97db9ed21, self.constants.var_49e2976ca0c853ef);

    if(bot function_3569a4bec8b9af17(player)) {
      score = basescore + self.constants.attackermodifier;
    } else if(bot botcanseeentity(player)) {
      score = basescore;
    } else if(distancetoplayer < self.constants.var_5dcbc5ccec64f7de) {
      var_c2c14ddfada133f3 = function_9d1ab012058221bb(distancetoplayer, self.constants.var_e3d1cf896f26ee33, self.constants.var_85a0650f30c0b0b9);
      score = basescore + var_c2c14ddfada133f3;
    }

    if(score > finalscore) {
      finalscore = score;
      target = player;
    }
  }

  if(isDefined(target)) {
    self.var_df9d35d9b4bee654 = namespace_41cf72abc6042f25::createaction(target);
  }

  return finalscore;
}