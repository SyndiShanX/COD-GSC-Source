/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_readystand_anims.gsc
**************************************/

#using_animtree("generic_human");

initreadystand() {
  anim.readystand_anims_inited = 1;
  level.scr_anim["generic"]["readystand_idle"][0] = % readystand_idle;
  level.scr_anim["generic"]["readystand_idle"][1] = % readystand_idle_twitch_1;
  level.scr_anim["generic"]["readystand_idle"][2] = % readystand_idle_twitch_2;
  level.scr_anim["generic"]["readystand_idle"][3] = % readystand_idle_twitch_3;
  level.scr_anim["generic"]["readystand_idle"][4] = % readystand_idle_twitch_4;
  level.scr_anim["generic"]["readystand_trans_2_cqb_1"] = % readystand_trans_2_cqb_1;
  level.scr_anim["generic"]["readystand_trans_2_cqb_2"] = % readystand_trans_2_cqb_2;
  level.scr_anim["generic"]["readystand_trans_2_cqb_3"] = % readystand_trans_2_cqb_3;
  level.scr_anim["generic"]["readystand_trans_2_cqb_4"] = % readystand_trans_2_cqb_4;
  level.scr_anim["generic"]["readystand_trans_2_cqb_6"] = % readystand_trans_2_cqb_6;
  level.scr_anim["generic"]["readystand_trans_2_cqb_7"] = % readystand_trans_2_cqb_7;
  level.scr_anim["generic"]["readystand_trans_2_cqb_8"] = % readystand_trans_2_cqb_8;
  level.scr_anim["generic"]["readystand_trans_2_cqb_9"] = % readystand_trans_2_cqb_9;
  level.scr_anim["generic"]["readystand_trans_2_run_1"] = % readystand_trans_2_run_1;
  level.scr_anim["generic"]["readystand_trans_2_run_2"] = % readystand_trans_2_run_2;
  level.scr_anim["generic"]["readystand_trans_2_run_3"] = % readystand_trans_2_run_3;
  level.scr_anim["generic"]["readystand_trans_2_run_4"] = % readystand_trans_2_run_4;
  level.scr_anim["generic"]["readystand_trans_2_run_6"] = % readystand_trans_2_run_6;
  level.scr_anim["generic"]["readystand_trans_2_run_7"] = % readystand_trans_2_run_7;
  level.scr_anim["generic"]["readystand_trans_2_run_8"] = % readystand_trans_2_run_8;
  level.scr_anim["generic"]["readystand_trans_2_run_9"] = % readystand_trans_2_run_9;
  anim.readyanimarray["stand"][0][0] = % readystand_idle;
  anim.readyanimarray["stand"][0][1] = % readystand_idle_twitch_1;
  anim.readyanimarray["stand"][0][2] = % readystand_idle_twitch_2;
  anim.readyanimarray["stand"][0][3] = % readystand_idle_twitch_3;
  anim.readyanimarray["stand"][0][4] = % readystand_idle_twitch_4;
  anim.readyanimweights["stand"][0][0] = 10;
  anim.readyanimweights["stand"][0][1] = 3;
  anim.readyanimweights["stand"][0][2] = 3;
  anim.readyanimweights["stand"][0][3] = 1;
  anim.readyanimweights["stand"][0][4] = 1;
  anim.covertrans["exposed_ready_cqb"] = [];
  anim.covertrans["exposed_ready_cqb"][1] = % cqb_trans_2_readystand_1;
  anim.covertrans["exposed_ready_cqb"][2] = % cqb_trans_2_readystand_2;
  anim.covertrans["exposed_ready_cqb"][3] = % cqb_trans_2_readystand_3;
  anim.covertrans["exposed_ready_cqb"][4] = % cqb_trans_2_readystand_4;
  anim.covertrans["exposed_ready_cqb"][6] = % cqb_trans_2_readystand_6;
  anim.covertrans["exposed_ready_cqb"][7] = % cqb_trans_2_readystand_7;
  anim.covertrans["exposed_ready_cqb"][8] = % cqb_trans_2_readystand_8;
  anim.covertrans["exposed_ready_cqb"][9] = % cqb_trans_2_readystand_9;
  anim.covertrans["exposed_ready"] = [];
  anim.covertrans["exposed_ready"][1] = % run_trans_2_readystand_1;
  anim.covertrans["exposed_ready"][2] = % run_trans_2_readystand_2;
  anim.covertrans["exposed_ready"][3] = % run_trans_2_readystand_3;
  anim.covertrans["exposed_ready"][4] = % run_trans_2_readystand_4;
  anim.covertrans["exposed_ready"][6] = % run_trans_2_readystand_6;
  anim.covertrans["exposed_ready"][7] = % run_trans_2_readystand_7;
  anim.covertrans["exposed_ready"][8] = % run_trans_2_readystand_8;
  anim.covertrans["exposed_ready"][9] = % run_trans_2_readystand_9;
  anim.coverexit["exposed_ready_cqb"] = [];
  anim.coverexit["exposed_ready_cqb"][1] = % readystand_trans_2_cqb_1;
  anim.coverexit["exposed_ready_cqb"][2] = % readystand_trans_2_cqb_2;
  anim.coverexit["exposed_ready_cqb"][3] = % readystand_trans_2_cqb_3;
  anim.coverexit["exposed_ready_cqb"][4] = % readystand_trans_2_cqb_4;
  anim.coverexit["exposed_ready_cqb"][6] = % readystand_trans_2_cqb_6;
  anim.coverexit["exposed_ready_cqb"][7] = % readystand_trans_2_cqb_7;
  anim.coverexit["exposed_ready_cqb"][8] = % readystand_trans_2_cqb_8;
  anim.coverexit["exposed_ready_cqb"][9] = % readystand_trans_2_cqb_9;
  anim.coverexit["exposed_ready"] = [];
  anim.coverexit["exposed_ready"][1] = % readystand_trans_2_run_1;
  anim.coverexit["exposed_ready"][2] = % readystand_trans_2_run_2;
  anim.coverexit["exposed_ready"][3] = % readystand_trans_2_run_3;
  anim.coverexit["exposed_ready"][4] = % readystand_trans_2_run_4;
  anim.coverexit["exposed_ready"][6] = % readystand_trans_2_run_6;
  anim.coverexit["exposed_ready"][7] = % readystand_trans_2_run_7;
  anim.coverexit["exposed_ready"][8] = % readystand_trans_2_run_8;
  anim.coverexit["exposed_ready"][9] = % readystand_trans_2_run_9;
  var_0 = [];
  var_0[0] = "exposed_ready";
  var_0[1] = "exposed_ready_cqb";

  for(var_1 = 1; var_1 <= 6; var_1++) {
    if(var_1 == 5) {
      continue;
    }
    for(var_2 = 0; var_2 < var_0.size; var_2++) {
      var_3 = var_0[var_2];

      if(isDefined(anim.covertrans[var_3]) && isDefined(anim.covertrans[var_3][var_1])) {
        anim.covertransdist[var_3][var_1] = getmovedelta(anim.covertrans[var_3][var_1], 0, 1);
        anim.covertransangles[var_3][var_1] = getangledelta(anim.covertrans[var_3][var_1], 0, 1);
      }

      if(isDefined(anim.coverexit[var_3]) && isDefined(anim.coverexit[var_3][var_1])) {
        if(animhasnotetrack(anim.coverexit[var_3][var_1], "code_move"))
          var_4 = getnotetracktimes(anim.coverexit[var_3][var_1], "code_move")[0];
        else
          var_4 = 1;

        anim.coverexitdist[var_3][var_1] = getmovedelta(anim.coverexit[var_3][var_1], 0, var_4);
        anim.coverexitangles[var_3][var_1] = getangledelta(anim.coverexit[var_3][var_1], 0, 1);
      }
    }
  }

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];
    anim.covertranslongestdist[var_3] = 0;

    for(var_1 = 1; var_1 <= 6; var_1++) {
      if(var_1 == 5 || !isDefined(anim.covertrans[var_3]) || !isDefined(anim.covertrans[var_3][var_1])) {
        continue;
      }
      var_5 = lengthsquared(anim.covertransdist[var_3][var_1]);

      if(anim.covertranslongestdist[var_3] < var_5)
        anim.covertranslongestdist[var_3] = var_5;
    }

    anim.covertranslongestdist[var_3] = sqrt(anim.covertranslongestdist[var_3]);
  }

  if(!isDefined(anim.longestexposedapproachdist))
    anim.longestexposedapproachdist = 0;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    for(var_1 = 7; var_1 <= 9; var_1++) {
      if(isDefined(anim.covertrans[var_3]) && isDefined(anim.covertrans[var_3][var_1])) {
        anim.covertransdist[var_3][var_1] = getmovedelta(anim.covertrans[var_3][var_1], 0, 1);
        anim.covertransangles[var_3][var_1] = getangledelta(anim.covertrans[var_3][var_1], 0, 1);
      }

      if(isDefined(anim.coverexit[var_3]) && isDefined(anim.coverexit[var_3][var_1])) {
        var_4 = getnotetracktimes(anim.coverexit[var_3][var_1], "code_move")[0];
        anim.coverexitdist[var_3][var_1] = getmovedelta(anim.coverexit[var_3][var_1], 0, var_4);
        anim.coverexitangles[var_3][var_1] = getangledelta(anim.coverexit[var_3][var_1], 0, 1);
      }
    }

    for(var_1 = 1; var_1 <= 9; var_1++) {
      if(!isDefined(anim.covertrans[var_3]) || !isDefined(anim.covertrans[var_3][var_1])) {
        continue;
      }
      var_6 = length(anim.covertransdist[var_3][var_1]);

      if(var_6 > anim.longestexposedapproachdist)
        anim.longestexposedapproachdist = var_6;
    }
  }

  thread create_default_entries();
}

create_default_entries() {
  while(!isDefined(anim.archetypes))
    wait 0.1;

  var_0 = "exposed_ready";
  var_1 = "cover_trans_angles";
  anim.archetypes["soldier"][var_1][var_0] = [];

  for(var_2 = 0; var_2 < anim.archetypes["soldier"][var_1]["exposed"].size; var_2++)
    anim.archetypes["soldier"][var_1][var_0][var_2] = anim.archetypes["soldier"][var_1]["exposed"][var_2];

  var_1 = "cover_trans_dist";
  anim.archetypes["soldier"][var_1][var_0] = [];

  for(var_2 = 0; var_2 < anim.archetypes["soldier"][var_1]["exposed"].size; var_2++)
    anim.archetypes["soldier"][var_1][var_0][var_2] = anim.archetypes["soldier"][var_1]["exposed"][var_2];

  var_1 = "cover_exit_angles";
  anim.archetypes["soldier"][var_1][var_0] = [];

  for(var_2 = 0; var_2 < anim.archetypes["soldier"][var_1]["exposed"].size; var_2++)
    anim.archetypes["soldier"][var_1][var_0][var_2] = anim.archetypes["soldier"][var_1]["exposed"][var_2];

  var_1 = "cover_exit_dist";
  anim.archetypes["soldier"][var_1][var_0] = [];

  for(var_2 = 0; var_2 < anim.archetypes["soldier"][var_1]["exposed"].size; var_2++)
    anim.archetypes["soldier"][var_1][var_0][var_2] = anim.archetypes["soldier"][var_1]["exposed"][var_2];

  anim.archetypes["soldier"]["cover_trans"][var_0][1] = % run_trans_2_readystand_1;
  anim.archetypes["soldier"]["cover_trans"][var_0][2] = % run_trans_2_readystand_2;
  anim.archetypes["soldier"]["cover_trans"][var_0][3] = % run_trans_2_readystand_3;
  anim.archetypes["soldier"]["cover_trans"][var_0][4] = % run_trans_2_readystand_4;
  anim.archetypes["soldier"]["cover_trans"][var_0][6] = % run_trans_2_readystand_6;
  anim.archetypes["soldier"]["cover_trans"][var_0][7] = % run_trans_2_readystand_7;
  anim.archetypes["soldier"]["cover_trans"][var_0][8] = % run_trans_2_readystand_8;
  anim.archetypes["soldier"]["cover_trans"][var_0][9] = % run_trans_2_readystand_9;
  anim.archetypes["soldier"]["cover_exit"][var_0] = [];
  anim.archetypes["soldier"]["cover_exit"][var_0][1] = % readystand_trans_2_cqb_1;
  anim.archetypes["soldier"]["cover_exit"][var_0][2] = % readystand_trans_2_cqb_2;
  anim.archetypes["soldier"]["cover_exit"][var_0][3] = % readystand_trans_2_cqb_3;
  anim.archetypes["soldier"]["cover_exit"][var_0][4] = % readystand_trans_2_cqb_4;
  anim.archetypes["soldier"]["cover_exit"][var_0][6] = % readystand_trans_2_cqb_6;
  anim.archetypes["soldier"]["cover_exit"][var_0][7] = % readystand_trans_2_cqb_7;
  anim.archetypes["soldier"]["cover_exit"][var_0][8] = % readystand_trans_2_cqb_8;
  anim.archetypes["soldier"]["cover_exit"][var_0][9] = % readystand_trans_2_cqb_9;
  var_0 = "exposed_ready_cqb";
  var_1 = "cover_trans_angles";
  anim.archetypes["soldier"][var_1][var_0] = [];

  for(var_2 = 0; var_2 < anim.archetypes["soldier"][var_1]["exposed"].size; var_2++)
    anim.archetypes["soldier"][var_1][var_0][var_2] = anim.archetypes["soldier"][var_1]["exposed"][var_2];

  var_1 = "cover_trans_dist";
  anim.archetypes["soldier"][var_1][var_0] = [];

  for(var_2 = 0; var_2 < anim.archetypes["soldier"][var_1]["exposed"].size; var_2++)
    anim.archetypes["soldier"][var_1][var_0][var_2] = anim.archetypes["soldier"][var_1]["exposed"][var_2];

  var_1 = "cover_exit_angles";
  anim.archetypes["soldier"][var_1][var_0] = [];

  for(var_2 = 0; var_2 < anim.archetypes["soldier"][var_1]["exposed"].size; var_2++)
    anim.archetypes["soldier"][var_1][var_0][var_2] = anim.archetypes["soldier"][var_1]["exposed"][var_2];

  var_1 = "cover_exit_dist";
  anim.archetypes["soldier"][var_1][var_0] = [];

  for(var_2 = 0; var_2 < anim.archetypes["soldier"][var_1]["exposed"].size; var_2++)
    anim.archetypes["soldier"][var_1][var_0][var_2] = anim.archetypes["soldier"][var_1]["exposed"][var_2];

  anim.archetypes["soldier"]["cover_trans"][var_0][1] = % cqb_trans_2_readystand_1;
  anim.archetypes["soldier"]["cover_trans"][var_0][2] = % cqb_trans_2_readystand_2;
  anim.archetypes["soldier"]["cover_trans"][var_0][3] = % cqb_trans_2_readystand_3;
  anim.archetypes["soldier"]["cover_trans"][var_0][4] = % cqb_trans_2_readystand_4;
  anim.archetypes["soldier"]["cover_trans"][var_0][6] = % cqb_trans_2_readystand_6;
  anim.archetypes["soldier"]["cover_trans"][var_0][7] = % cqb_trans_2_readystand_7;
  anim.archetypes["soldier"]["cover_trans"][var_0][8] = % cqb_trans_2_readystand_8;
  anim.archetypes["soldier"]["cover_trans"][var_0][9] = % cqb_trans_2_readystand_9;
  anim.archetypes["soldier"]["cover_exit"][var_0] = [];
  anim.archetypes["soldier"]["cover_exit"][var_0][1] = % readystand_trans_2_cqb_1;
  anim.archetypes["soldier"]["cover_exit"][var_0][2] = % readystand_trans_2_cqb_2;
  anim.archetypes["soldier"]["cover_exit"][var_0][3] = % readystand_trans_2_cqb_3;
  anim.archetypes["soldier"]["cover_exit"][var_0][4] = % readystand_trans_2_cqb_4;
  anim.archetypes["soldier"]["cover_exit"][var_0][6] = % readystand_trans_2_cqb_6;
  anim.archetypes["soldier"]["cover_exit"][var_0][7] = % readystand_trans_2_cqb_7;
  anim.archetypes["soldier"]["cover_exit"][var_0][8] = % readystand_trans_2_cqb_8;
  anim.archetypes["soldier"]["cover_exit"][var_0][9] = % readystand_trans_2_cqb_9;
}