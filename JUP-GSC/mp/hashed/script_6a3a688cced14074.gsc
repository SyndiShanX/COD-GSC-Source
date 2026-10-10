/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6a3a688cced14074.gsc
*************************************************/

#using script_37d9a569491ff1e0;
#using script_40e63dd222434655;
#using script_59ff79d681bb860c;
#using script_d74ae0b4aa21186;
#using scripts\engine\utility;
#using scripts\mp\killstreaks\killstreaks;
#namespace killstreak_uav;

function function_eda57308516bfc5f() {
  return function_bffb5b682a4ef6a2(&evaluatescore, &createaction, 2000);
}

function evaluatescore(bot) {
  if(!bot iskillstreakavailable("uav_bigmap")) {
    return 0;
  }

  nearbyevent = bot namespace_5524884c16a95af2::getevent();
  nearbyevent namespace_5524884c16a95af2::indistance(self.constants.var_df15d9eff00563be);
  var_b16f718206f54b7b = 0;

  foreach(player in nearbyevent.result) {
    if(function_40034c2faf09a87b(player)) {
      var_b16f718206f54b7b++;
    }
  }

  return self.constants.basescore + function_9d1ab012058221bb(var_b16f718206f54b7b, self.constants.var_e8b4534f27490bc4, self.constants.var_ffd2b6629c92a80d);
}

function createaction(bot) {
  return createactionbase("Killstreak UAV", undefined, "upper body", "", &actionprocess, self);
}

function actionprocess(bot) {
  bot scripts\mp\killstreaks\killstreaks::dokillstreakaction(undefined, 1);

  logstring("<dev string:x1c>" + bot.name + "<dev string:x2c>");
}