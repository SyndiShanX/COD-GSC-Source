/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_60e4c40d98acb785.gsc
*************************************************/

#using script_59ff79d681bb860c;
#using script_d74ae0b4aa21186;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_quest_util;
#namespace perform_recon_contract;

function function_eda57308516bfc5f() {
  return function_bffb5b682a4ef6a2(&evaluatescore, undefined, 2000);
}

function evaluatescore(bot) {
  activequests = scripts\mp\gametypes\br_quest_util::getallactivequestsforteam(bot.team);
  reconquest = undefined;

  if(isDefined(activequests) && activequests.size > 0) {
    foreach(quest in activequests) {
      if(quest.instance.questcategory == "domination") {
        reconquest = quest;
        break;
      }
    }
  }

  if(!isDefined(reconquest)) {
    return 0;
  }

  assert(isDefined(reconquest.instance) && isDefined(reconquest.instance.subscribedlocale) && isDefined(reconquest.instance.subscribedlocale.radius));
  finaltarget = spawnStruct();
  finaltarget.centre = reconquest.origin;
  finaltarget.radius = reconquest.instance.subscribedlocale.radius;
  self.var_df9d35d9b4bee654 = createactionbase("Perform Recon Contract", finaltarget, "main", reconquest.instance.id, &actionprocess, self, &function_f4caae7e8af9d32c);
  higherscore = istrue(self.var_b32868a9471d2caa) || distance(bot.origin, reconquest.origin) <= finaltarget.radius;
  return ter_op(higherscore, self.constants.var_cf22d0ed88800557, self.constants.basescore);
}

function actionprocess(bot) {
  target = self.argument;
  assert(isDefined(target));
  self.decision.var_b32868a9471d2caa = 1;
  finalposition = scripts\mp\gametypes\br_circle::getrandompointincircle(target.centre, target.radius);

  if(finalposition[2] - target.centre[2] > 70) {
    finalposition = scripts\mp\gametypes\br_circle::getrandompointincircle(target.centre, target.radius, undefined, undefined, 0, 1);
  }

  while(true) {
    bot setscriptgoal(finalposition, 32);
    result = bot waittill_any_in_array_or_timeout(["goal", "bad_path"], 15);

    if(result == "goal") {
      break;
    }

    if(result != "timeout") {
      return result;
    }
  }
}

function function_f4caae7e8af9d32c(action) {
  action.decision.var_b32868a9471d2caa = undefined;
}