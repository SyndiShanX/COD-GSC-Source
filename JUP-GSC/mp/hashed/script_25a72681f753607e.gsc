/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_25a72681f753607e.gsc
*************************************************/

#using script_37d9a569491ff1e0;
#using script_40e63dd222434655;
#using script_59ff79d681bb860c;
#using script_d74ae0b4aa21186;
#using scripts\engine\utility;
#using scripts\mp\killstreaks\killstreaks;
#namespace killstreak_airstrike;

function function_eda57308516bfc5f() {
  return function_bffb5b682a4ef6a2(&evaluatescore);
}

function evaluatescore(bot) {
  strike = "toma_strike";

  if(!bot iskillstreakavailable(strike)) {
    strike = "precision_airstrike";

    if(!bot iskillstreakavailable(strike)) {
      return 0;
    }
  }

  maxscore = 0;
  target = undefined;
  nearbyevent = bot namespace_5524884c16a95af2::getevent();
  nearbyevent namespace_5524884c16a95af2::keepenemies(bot);
  nearbyevent namespace_5524884c16a95af2::indistance(self.constants.var_6b536e17b179b18c);

  foreach(player in nearbyevent.result) {
    if(isDefined(self.constants.targettype)) {
      switch (self.constants.targettype) {
        case #"hash_2138836c1b32895e":
          if(!isbot(player)) {
            continue;
          }

          break;
        case #"hash_207629acc9a1e5a":
          if(isbot(player)) {
            continue;
          }

          break;
        default:
          break;
      }
    }

    if(player function_f3b2bb1e37a0abae() && bot botcanseeentity(player)) {
      distancetoplayer = distance(bot.origin, player.origin);
      var_54e0ab2472351543 = function_9d1ab012058221bb(distancetoplayer, self.constants.var_ca44fa65dc21651a, self.constants.var_e6f117499091fd02);

      if(var_54e0ab2472351543 > maxscore) {
        maxscore = var_54e0ab2472351543;
        target = player;
      }
    }
  }

  if(isDefined(target)) {
    line(bot.origin, target.origin, (1, 0, 0), 1, 0, 600);

    self.var_df9d35d9b4bee654 = createaction(target.origin, strike);
    return (self.constants.basescore + maxscore);
  }

  return 0;
}

function function_f3b2bb1e37a0abae() {
  var_c7d42b381ba6869c = 20;

  if(!isDefined(self.var_3c6ae4971df01a1f) || gettime() >= self.var_3c6ae4971df01a1f + var_c7d42b381ba6869c) {
    self.var_3c6ae4971df01a1f = gettime();
    self.var_5eb7151348570383 = self sightconetrace((self.origin[0], self.origin[1], 6000)) > 0;
  }

  assert(isDefined(self.var_5eb7151348570383));
  return self.var_5eb7151348570383;
}

function createaction(targetpos, striketype) {
  return createactionbase("Killstreak air_strike", targetpos, "upper body", striketype + ":" + targetpos[0] + "," + targetpos[1] + "," + targetpos[2], &actionprocess, self);
}

function actionprocess(bot) {
  if(bot iskillstreakavailable("precision_airstrike")) {
    offsetvalue = randomintrange(200, 420);
    var_b2c06d4a5f630779 = (offsetvalue * random([-1, 1]), offsetvalue * random([-1, 1]), 0);
    bot.kstargetlocation = self.argument + var_b2c06d4a5f630779;
  } else {
    bot.kstargetlocation = self.argument;
  }

  bot scripts\mp\killstreaks\killstreaks::dokillstreakaction(undefined, 1);
}