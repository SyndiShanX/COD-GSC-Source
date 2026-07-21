/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\tac_ops\hvt_utility.gsc
***********************************************/

spawnhvt(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 1;
  var_1 = scripts\engine\utility::getStructArray("_encstr_B1190448CD80", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = undefined;
  var_3 = undefined;
  level.allowhvtspawn = 1;

  while(!isDefined(var_2)) {
    var_2 = scripts\mp\agents\agent_common::connectnewagent("_encstr_8BB007E03658CBCAE4", "_encstr_9A8507BA4040188D08");

    if(isDefined(var_2)) {
      foreach(var_5 in var_1) {
        if(var_5.script_label == var_0)
          var_3 = var_5.origin;
      }

      var_2 thread[[var_2 scripts\mp\agents\agent_utility::agentfunc("_encstr_8E8A06F7D987435E")]](var_3, (0, 0, 0));
      var_2.team = "_encstr_8E8405EA382B2A";
      var_2 scripts\mp\bots\bots_util::bot_set_difficulty("_encstr_BAAF081BD348D7E299C8");
      var_2.outlineid = scripts\mp\utility\outline::outlineenableforteam(var_2, var_2.team, "_encstr_9ABD15C87B5C489BD2AFFF95EF1AD5F0F49476C1E0B190", "_encstr_A7440781BA73D7D8C1");
      continue;
    }

    waitframe();
  }

  var_2.trackedobject = var_2 scripts\mp\gameobjects::createtrackedobject(var_2, (0, 0, 0));
  var_2.trackedobject.objidpingfriendly = 0;
  var_2.trackedobject.objidpingenemy = 1;
  var_2.trackedobject.objpingdelay = 4.0;
  var_2.trackedobject.visibleteam = "_encstr_ACFC091AE8AB2FCBE15119";
  var_2.invulnerable = 1;
  var_2.trackedobject scripts\mp\gameobjects::setobjectivestatusicons("_encstr_ADE9169F974911BF3A3A750FBABCAB4305A14CAF2AF07ADA");
  var_2 thread hvtclearmove(var_3);
  var_2 thread hvtdeathwatcher();

  if(!isDefined(level.hvtcount))
    level.hvtcount = 0;

  level.hvtcount++;
  var_2 scripts\mp\equipment::clearallequipment();
  level.to_ddhvt = var_2;
}

hvtclearmove(var_0) {
  self botsetscriptgoal(var_0, 20, "_encstr_99CC09DA9020C4ECD149AD");
  var_1 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();
}

hvtreveal(var_0) {
  var_0.killoutlineid = scripts\mp\utility\outline::outlineenableforteam(var_0, scripts\mp\utility\game::getotherteam(var_0.team)[0], "_encstr_96AE15674513800375C947242F6863285787EB2916E22F", "_encstr_A7440781BA73D7D8C1");
  var_0.trackedobject.visibleteam = "_encstr_9A19040BCDBC";
  var_0.trackedobject scripts\mp\gameobjects::setobjectivestatusicons("_encstr_ADE9169F974911BF3A3A750FBABCAB4305A14CAF2AF07ADA", "_encstr_82FD166339ABDBC568F5446787404AB3D533DA69C00B63FD");
  var_0 thread hvtdelayedendinvulnerability();
}

hvtdelayedendinvulnerability() {
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 1.0;
  self.invulnerable = 0;
}

hvtcleanup(var_0) {
  if(isDefined(var_0.killoutlineid))
    scripts\mp\utility\outline::outlinedisable(var_0.killoutlineid, var_0);

  if(isDefined(var_0.outlineid))
    scripts\mp\utility\outline::outlinedisable(var_0.outlineid, var_0);

  var_0 notify("_encstr_AF1D0C83CD25E96C58A05F255B48");
  var_0.nocorpse = 1;
  var_0 suicide();
}

hvtdeathwatcher() {
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AF1D0C83CD25E96C58A05F255B48");
  self waittill("_encstr_AD75063D571AE108");
  level.hvtkilled++;
  self.trackedobject scripts\mp\gameobjects::releaseid();

  if(level.hvtkilled == 1) {
    game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
    game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";

    if(isDefined(level.onphaseend))
      [[level.onphaseend]]("_encstr_9A8507BA4040188D08");

    setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", 0);
    setomnvar("_encstr_95E80DAE5ABEA11693190EB79637A3", -1);
  }
}

hvtthreatwatcher() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = 0;

  for(;;) {
    var_1 = self getnearestnode();
    self botsetscriptgoalnode(var_1, "_encstr_99CC09DA9020C4ECD149AD");
    wait 0.25;
  }
}