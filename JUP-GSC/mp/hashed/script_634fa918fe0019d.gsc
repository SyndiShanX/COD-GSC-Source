/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_634fa918fe0019d.gsc
************************************************/

#using script_37d9a569491ff1e0;
#using script_40e63dd222434655;
#using script_4c9bd9a3bf3f8cf7;
#using script_54a9e44119886147;
#using script_59ff79d681bb860c;
#using script_d74ae0b4aa21186;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;
#using scripts\mp\utility\teams;
#namespace combat;

function function_eda57308516bfc5f() {
  return function_bffb5b682a4ef6a2(&evaluatescore, undefined, 500);
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
  inprematch = scripts\mp\gamelogic::inprematch();
  var_66b33f71b3567ef3 = 0;

  if(nearbyevent.result.size > 0) {
    circlepercent = function_1c51f7c46a848ddd();
    var_66b33f71b3567ef3 = function_9d1ab012058221bb(circlepercent, self.constants.var_e23500dbd314bae2, self.constants.var_58e441d166562d6e);
  }

  foreach(player in nearbyevent.result) {
    if(!isai(player) && getDvar(@ "bot_notarget") == "<dev string:x23>") {
      continue;
    }

    if(distance(bot.origin, player.origin) <= 1) {
      continue;
    }

    if(!bot isvalidtarget(player)) {
      continue;
    }

    score = 0;
    distancetoplayer = distance(bot.origin, player.origin);
    basescore = function_9d1ab012058221bb(distancetoplayer, self.constants.var_96af88c97db9ed21, self.constants.var_49e2976ca0c853ef);
    var_fa059f2b79794081 = bot function_3569a4bec8b9af17(player);

    if(var_fa059f2b79794081) {
      basescore += function_9d1ab012058221bb(distancetoplayer, self.constants.var_96af88c97db9ed21, self.constants.var_e3f6d868f3c297b2);
    }

    if(inprematch) {
      score = basescore;
    } else if(var_fa059f2b79794081 || bot botcanseeentity(player)) {
      score = basescore + var_66b33f71b3567ef3;
    } else if(isai(player) && distancetoplayer < self.constants.var_dfdfb13389358aee && !player namespace_c50b30148766aa59::function_6f6c5cb39cd095b0()) {
      var_c2c14ddfada133f3 = function_9d1ab012058221bb(distancetoplayer, self.constants.var_e3d1cf896f26ee33, self.constants.var_85a0650f30c0b0b9);
      score = basescore + var_66b33f71b3567ef3 + var_c2c14ddfada133f3;
    } else if(function_699bb9f5414b2149(bot, player)) {
      var_c2c14ddfada133f3 = function_9d1ab012058221bb(distancetoplayer, self.constants.var_e3d1cf896f26ee33, self.constants.var_85a0650f30c0b0b9);
      score = basescore + var_66b33f71b3567ef3 + var_c2c14ddfada133f3;
      score *= self.constants.var_d066abbf0bc74501;
    } else if(!isai(player)) {
      if(istrue(player.var_e54cc9323d3dc44e) && isDefined(self.constants.var_891066f3bc70edcb)) {
        var_df2e5586f7d31f26 = function_9d1ab012058221bb(distancetoplayer, self.constants.var_891066f3bc70edcb, self.constants.var_55bf1eec1bfddf31);
        score = basescore + var_df2e5586f7d31f26;
      }

      if(isDefined(level.br_circle) && isDefined(level.br_circle.circleinittime) && !istrue(player.var_e54cc9323d3dc44e)) {
        currentduration = (gettime() - level.br_circle.circleinittime) / 1000;
        var_3c1eda8db07ec036 = function_9d1ab012058221bb(currentduration, self.constants.var_115b29b18485de3, self.constants.var_631e50e6ec9a24a8);

        if(player.kills < var_3c1eda8db07ec036) {
          score = function_9d1ab012058221bb(distancetoplayer, self.constants.var_36d2e5e6b1e19a3, self.constants.var_f1ff9682c42f2749);
        }
      }
    }

    if(istrue(player.inlaststand)) {
      score += self.constants.laststandmodifier;
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

function function_699bb9f5414b2149(bot, player) {
  bots = scripts\mp\utility\teams::getteamdata(bot.team, "alivePlayers");

  foreach(teammate in bots) {
    if(teammate == bot || !isvalidplayer(teammate)) {
      continue;
    }

    if(isDefined(teammate.scriptenemy) && teammate.scriptenemy == player) {
      return true;
    }
  }

  return false;
}