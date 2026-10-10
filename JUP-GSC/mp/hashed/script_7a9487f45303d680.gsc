/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7a9487f45303d680.gsc
*************************************************/

#using script_59ff79d681bb860c;
#using script_67bad8bd9685e057;
#using script_7bf46d34c10761a4;
#using script_d74ae0b4aa21186;
#using scripts\engine\utility;
#using scripts\mp\gameobjects;
#namespace capture_flag_gw;

function function_eda57308516bfc5f() {
  return function_bffb5b682a4ef6a2(&evaluatescore);
}

function evaluatescore(bot) {
  score = namespace_4c49d1b7e0800f5::evaluatescore(bot);

  if(score == 0) {
    return 0;
  }

  flag = self.var_df9d35d9b4bee654.argument;
  self.var_df9d35d9b4bee654 = createactionbase("Capture Flag GW", flag, "main", "", &actionprocess, self);
  return self.constants.basescore;
}

function actionprocess(bot) {
  assert(isDefined(self.argument));
  flag = self.argument;
  self.decision.var_13b45daa3e1c211a = flag;
  var_9920c1b439193f77 = 16;

  while(bot.team != flag scripts\mp\gameobjects::getownerteam()) {
    nodes = namespace_ef3d9df38f736e0::function_62f98fd3d37278dc(flag, 1);

    if(nodes.size == 0) {
      var_1018c65664d1acb7 = 200;
      var_a3f666a60afd099e = 50;
      createnode = spawnStruct();
      createnode.origin = namespace_4c49d1b7e0800f5::function_6f7d8428f06122a7(flag.curorigin, var_1018c65664d1acb7, var_a3f666a60afd099e, var_9920c1b439193f77);
      nodes[nodes.size] = createnode;
    }

    randompoint = array_random(nodes);
    bot setscriptgoal(randompoint.origin, var_9920c1b439193f77);
    result = waittill_any_ents_or_timeout_return(15, bot, "bad_path", bot, "long_path", bot, "goal");

    if(result == "goal") {
      wait 1;
    }
  }
}