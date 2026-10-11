/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_ef36a50d9b4627d.gsc
************************************************/

#using script_4948cdf739393d2d;
#using script_4f9a55dee6aebc8f;
#using script_64acb6ce534155b7;
#using script_744cad313ed0a87e;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\dmz_task_utils;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace namespace_348001a7426cedd2;

function function_7aae8cb0d8b0ac6a(data) {
  level.poiprops = spawnStruct();
  level.poiprops.circleradius = getdvarint(@ "hash_35e83d2a6cda99b8", 2000);
  level.poiprops.pointradius = getdvarint(@ "hash_b3b453252c46e3b0", 1000);
  level.poiprops.pointradiussq = level.poiprops.pointradius * level.poiprops.pointradius;
  level.poiprops.var_ed2e5cf91bff3a6f = getdvarfloat(@ "hash_75c1cf1a1116077d", 0.65);
  level.poiprops.headicon = "ui_map_icon_boss_juggernaut";
  level.poiprops.uavcapture = getdvarint(@ "hash_b22e8fbab2a4e00a", 0);
  data.createfunc = &function_fefd14a6940e2b99;
}

function function_fefd14a6940e2b99(activity, owner) {
  task = task_create(activity);
  task.owner = owner;
  owner.task = task;
  task.players = [];
  task.funcs["onInit"] = &function_380918284873494;
  task.funcs["onPlayerAssigned"] = &function_dd6410a59565d135;
  task.funcs["onPlayerJoined"] = &function_5f7cd2f25352a816;
  task.funcs["onPlayerRemoved"] = &function_12a444ed47d9c24d;
  task.funcs["onTeamStart"] = &function_a5870532237f7ad;
  task.funcs["onPlayerExitVolume"] = &function_bb405816fb180a81;
  task.funcs["onPlayerExitTimeout"] = &function_e09f977d133bac40;
  task.funcs["onPlayerReenterVolume"] = &function_a0e410e1941cb7a;
  task.ref = "br_poi";
  task.refindex = namespace_1eb3c4e0e28fac71::getquesttableindex(task.ref);
  task.spawntrap = 0;
  task.tier = task.owner namespace_bd614c3c2275579a::function_b7a9796c95aa8e8d();

  if(task.tier == "black") {
    task.mission_index = 20;
    task.mission_complete = 21;
    task.mission_fail = 36;
    task.mission_fail_warning = 0;
  } else {
    task.mission_index = 20;
    task.mission_complete = 21;
    task.mission_fail = 36;
    task.mission_fail_warning = 0;
  }

  return task;
}

function function_380918284873494() {
  task = self;
  task.activity.origin = task.owner.origin;
  circlelocation = task.owner.missiontrigger.origin;
  task.circlecenter = circlelocation;
  task.circleradius = level.poiprops.circleradius;

  if(level.var_dd1138d16246e714) {
    task.owner.var_67587a308d2aa143 = 1;
    circleradius = getdvarint(@ "hash_456cced132e54c3d", 138);
    task.owner.var_6dbd65fc3942bf53 = spawn("trigger_radius", task.owner.loadout[0].origin, 0, circleradius, 62);
    var_c6b7900c1fa0a1b6 = task.owner.var_6dbd65fc3942bf53.origin;
    vfxscriptable = spawn("script_model", var_c6b7900c1fa0a1b6);
    vfxscriptable setModel("stronghold_control_point");
    vfxscriptable.angles = task.owner.loadout[0].angles;
    vfxscriptable setscriptablepartstate("flag", "idle");
    task.owner.var_6dbd65fc3942bf53.vfxnamemod = vfxscriptable;
  }
}

function function_dd6410a59565d135(teamname, player) {
  task = self;
  teams = [teamname];
  var_aa128e29d7c10074 = scripts\cp_mp\utility\game_utility::isaigameparticipant(player);

  if(level.poiprops.uavcapture) {
    task namespace_b8f885001f04bb5::function_dd6410a59565d135(teamname, player, 1);
    task.holdpoint.var_3c83e6760ebc0979 = 1;
    task.holdpoint.var_554291b6257ea5d0 = 1;
  }

  namespace_9823ee6035594d67::function_d95dbf57b47734d9(task.owner, 1);
  task thread scripts\mp\gametypes\activity_manager::function_a33c10c0682918bd(task.owner.missiontrigger, 9000);

  if(!istrue(task.owner.spawnedboss)) {
    task.owner notify("brStronghold_spawnBoss");
    task.owner waittill("brStronghold_spawnedBoss");
  }

  task.target = task.owner.var_837c4b569aa8a376[randomint(task.owner.var_837c4b569aa8a376.size)];

  if(!istrue(task.var_93b326b65f998145)) {
    task.var_93b326b65f998145 = 1;
    task thread function_92efd6eb7ec14081();
    task function_b005a227c7052bab();
    players = [player];
    namespace_bd614c3c2275579a::function_ac7dce0a21508d6e("blacksite_jugg_warn", players);
  }

  if(var_aa128e29d7c10074) {
    task thread function_5cbd566bcb47d26e();
    task function_5f7cd2f25352a816(player);
    return;
  }

  task thread function_5cbd566bcb47d26e(player);
  task thread function_682e6a05a3109ea1(player);
  task function_a92867e16c21da22(teamname);
  task function_5f7cd2f25352a816(player);
}

function function_5f7cd2f25352a816(player) {
  task = self;

  if(!isDefined(array_find(task.players, player))) {
    size = task.players.size;
    task.players[size] = player;
  }

  if(level.poiprops.uavcapture) {
    namespace_b8f885001f04bb5::function_b380232fafd74325(player, 1);
  }

  var_aa128e29d7c10074 = scripts\cp_mp\utility\game_utility::isaigameparticipant(player);

  if(var_aa128e29d7c10074) {
    return;
  }

  var_d0cb4e7edbd1a617 = player getclientomnvar("ui_br_stronghold_mission");

  if(isDefined(task.target)) {
    players = task.players;

    if(isDefined(task.players)) {
      if(randomint(100) > 50) {
        namespace_bd614c3c2275579a::function_ac7dce0a21508d6e("blacksite_jugg_defend", players);
      } else {
        namespace_bd614c3c2275579a::function_ac7dce0a21508d6e("blacksite_jugg_engage", players);
      }
    }
  }

  player thread scripts\mp\hud_message::showsplash("stronghold_operation_person_of_interest");
  wait 4;

  if(!isDefined(player) || !array_contains(task.players, player)) {
    return;
  }

  if(var_d0cb4e7edbd1a617 == player getclientomnvar("ui_br_stronghold_mission")) {
    player setclientomnvar("ui_br_stronghold_mission", task.mission_index);

    if(!istrue(level.var_870abcbf773fbd8c)) {
      player setclientomnvar("ui_br_stronghold_mission_timer", 0);
      return;
    }

    player setclientomnvar("ui_br_stronghold_mission_timer", task.endtime);
  }
}

function function_12a444ed47d9c24d(player) {
  task = self;
  var_aa128e29d7c10074 = scripts\cp_mp\utility\game_utility::isaigameparticipant(player);
  task.players = array_remove(task.players, player);

  if(var_aa128e29d7c10074) {
    return;
  }

  if(level.poiprops.uavcapture) {
    namespace_b8f885001f04bb5::function_7204f8ab0ccdb640(player, 1);
  }

  player setclientomnvar("ui_br_stronghold_mission", task.mission_fail);
}

function function_a5870532237f7ad(teamname) {
  assert(1, "<dev string:x1c>");
}

function function_ad51a965d4943b34(teamname, omnvarstate, var_775b616d3bf0bf29, var_dc862207eee24f1) {
  task = self;
  var_6e3c5fd99f4fcfb1 = array_contains(task.teams, teamname);
  var_5f8fc154303502fa = getteamarray(teamname);

  if(!level.poiprops.uavcapture || var_dc862207eee24f1) {
    teaminfo = level.var_1b7407dffe81e6e8.teamsinfo[teamname];

    if(isDefined(teaminfo)) {
      teaminfo.activities = array_remove(teaminfo.activities, task.activity.id);
      teaminfo.active = 0;
    }
  }

  foreach(player in var_5f8fc154303502fa) {
    if(scripts\cp_mp\utility\game_utility::isaigameparticipant(player)) {
      continue;
    }

    if(omnvarstate == task.mission_complete) {
      player thread scripts\mp\hud_message::showsplash("stronghold_operation_person_of_interest_completed");
      player setclientomnvar("ui_br_stronghold_mission", omnvarstate);
      continue;
    }

    var_c02dfd04f86a87ae = player getclientomnvar("ui_br_stronghold_mission");

    if(var_6e3c5fd99f4fcfb1 || var_c02dfd04f86a87ae == 19) {
      if(istrue(var_775b616d3bf0bf29)) {
        player thread scripts\mp\hud_message::showsplash("stronghold_operation_person_of_interest_failed");
      }

      player setclientomnvar("ui_br_stronghold_mission", 36);
    }
  }
}

function function_bb405816fb180a81(player) {
  task = self;
  player.var_e09c6ea56555f1ed = 1;
  var_aa128e29d7c10074 = scripts\cp_mp\utility\game_utility::isaigameparticipant(player);

  if(!var_aa128e29d7c10074) {
    player setclientomnvar("ui_br_stronghold_mission", task.mission_fail_warning);
  }

  exittimeout = gettime() + 9000;

  if(!var_aa128e29d7c10074) {
    player setclientomnvar("ui_br_stronghold_mission_timer", exittimeout);
  }
}

function function_a0e410e1941cb7a(player) {
  task = self;
  player.var_e09c6ea56555f1ed = undefined;
  var_aa128e29d7c10074 = scripts\cp_mp\utility\game_utility::isaigameparticipant(player);

  if(!var_aa128e29d7c10074) {
    player setclientomnvar("ui_br_stronghold_mission", task.mission_index);

    if(!istrue(level.var_870abcbf773fbd8c)) {
      player setclientomnvar("ui_br_stronghold_mission_timer", 0);
      return;
    }

    player setclientomnvar("ui_br_stronghold_mission_timer", task.endtime);
  }
}

function function_e09f977d133bac40(player) {
  task = self;
  task function_12a444ed47d9c24d(player);

  if(level.poiprops.uavcapture) {
    namespace_b8f885001f04bb5::function_7204f8ab0ccdb640(player, 1);
  }

  player.var_e09c6ea56555f1ed = undefined;
  player.var_ed5a962d857703ec = undefined;

  if(isDefined(level.var_fc0e8c2ea4f84613)) {
    task[[level.var_fc0e8c2ea4f84613]](player);
  }
}

function private function_947515fbdc68b22b(teamname, failed, var_dc862207eee24f1) {
  if(!isDefined(failed)) {
    failed = 0;
  }

  if(!isDefined(var_dc862207eee24f1)) {
    var_dc862207eee24f1 = 0;
  }

  task = self;
  task notify("task_ended");

  if(!level.poiprops.uavcapture || var_dc862207eee24f1) {
    namespace_9823ee6035594d67::function_be5a531f97b7c07e(task.owner);
  }

  deletetask = 0;
  fortress = task.owner;
  teams = task.teams;

  if(isDefined(fortress.var_e2bdca417396359)) {
    teams = array_combine_unique(teams, fortress.var_e2bdca417396359);
  }

  foreach(team in teams) {
    teamcompleted = 0;

    if(isDefined(teamname)) {
      teamcompleted = team == teamname;
    }

    omnvarstate = task.mission_fail;

    if(teamcompleted) {
      deletetask = 1;
      omnvarstate = task.mission_complete;
    }

    task function_ad51a965d4943b34(team, omnvarstate, failed, var_dc862207eee24f1);
  }

  if(isDefined(task.headicon)) {
    deleteheadicon(task.headicon);
  }

  if(!level.poiprops.uavcapture || var_dc862207eee24f1) {
    task.players = [];
    task.teams = [];
    task function_2476daefa3384c5e();
    task function_629ed367d1393020();

    if(!isDefined(failed)) {
      failed = 0;
    }

    task.starttime = undefined;

    if(task.activity.tasks.size >= 1 && (deletetask || failed)) {
      task.owner.missiontrigger notify("activity_ended");
      level.var_1b7407dffe81e6e8.activities[task.activity.id] = undefined;
      task.activity.tasks = undefined;
    }
  }

  if(isDefined(level.var_3afacc0c3b10b7fe)) {
    task.owner[[level.var_3afacc0c3b10b7fe]](teamname, !istrue(failed));
  }

  if(level.var_dd1138d16246e714 && omnvarstate == task.mission_complete) {
    task.owner thread scripts\mp\gametypes\activity_manager::function_821fa443949531c9(task.owner.missiontrigger, "hold");
  }
}

function function_5cbd566bcb47d26e(player) {
  task = self;

  if(!istrue(level.var_870abcbf773fbd8c)) {
    return;
  }

  if(istrue(task.ticking)) {
    return;
  }

  level endon("game_ended");
  task endon("task_ended");
  task.owner.missiontrigger endon("deleted");
  task.owner.missiontrigger endon("activity_ended");
  waittime = task.owner.var_cab871d72c8eb111[0];
  task.ticking = 1;
  task.starttime = gettime();
  task.endtime = task.starttime + waittime * 1000;
  wait waittime;
  player.var_e09c6ea56555f1ed = undefined;
  player.var_ed5a962d857703ec = undefined;
  task thread function_947515fbdc68b22b(undefined, 1);
}

function function_682e6a05a3109ea1(player) {
  task = self;
  level endon("game_ended");
  task endon("task_ended");

  if(istrue(level.var_cb8bc435cfe43c4c) && istrue(task.owner.isblacksite)) {
    return;
  }

  task.owner.missiontrigger endon("deleted");
  task.owner.missiontrigger endon("activity_ended");
  origin = task.activity.origin + (0, 0, 40);

  while(scripts\mp\gametypes\br_circle_util::ispointinmulticircledanger(origin) || scripts\mp\gametypes\br_circle_util::function_a465e3c1371d7dab(origin)) {
    wait 0.5;
  }

  player.var_e09c6ea56555f1ed = undefined;
  player.var_ed5a962d857703ec = undefined;
  task thread function_947515fbdc68b22b(undefined, 1, 1);
}

function function_385995505b4fd624(dropstruct, player, fortress) {
  task = self;

  if(!level.poiprops.uavcapture) {
    fortress namespace_bd614c3c2275579a::function_5c26662d5381e975(player, undefined, "directional_uav", 0);
  }

  rewardcash = task.activity.cashreward;

  foreach(player in getteamdata(player.team, "players")) {
    player scripts\mp\gametypes\br_plunder::playerplunderpickup(rewardcash);
    player scripts\mp\gametypes\br_plunder::function_5a2284274d70f7d(1, rewardcash);
  }

  teamindex = scripts\engine\utility::array_find(level.allteamnamelist, player.team);

  foreach(player in level.players) {
    if(getdvarint(@ "hash_90582331a88cc477", 0)) {
      player thread scripts\mp\hud_message::showsplash("stronghold_complete_no_gamertags_blacksite");
    } else {
      player thread scripts\mp\hud_message::showsplash("stronghold_complete_blacksite", teamindex);
    }

    scripts\mp\gametypes\br_public::brleaderdialogplayer("blacksite_clear", player);
  }

  if(!istrue(fortress.isblacksite)) {
    if(!isDefined(level.var_f1073fbd45b59a06.var_68693acbfbb8f4f5)) {
      player namespace_bd614c3c2275579a::function_9d216f4cd30f141d(dropstruct, getteamarray(player.team, 0));
      return;
    }

    if(level.var_f1073fbd45b59a06.var_68693acbfbb8f4f5 < level.var_153bec2ca80c491a) {
      player namespace_bd614c3c2275579a::function_9d216f4cd30f141d(dropstruct, getteamarray(player.team, 0));
    }
  }
}

function function_92efd6eb7ec14081() {
  task = self;
  task endon("task_ended");
  task.target waittill("death");
  ent = task.target.lastattacker;
  player = ent;

  if(ent scripts\cp_mp\vehicles\vehicle::isvehicle() && isDefined(ent.owner)) {
    player = ent.owner;
  }

  isvalidplayer = isDefined(player) && isPlayer(player) && isalive(player);

  if(isvalidplayer) {
    dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
    function_a91d0874afb8a157(dropstruct, task.target, player);
    function_6f6f83ab76483811(task, player);
    task thread function_385995505b4fd624(dropstruct, player, task.owner);
    task thread function_947515fbdc68b22b(player.team);
    return;
  }

  task thread function_947515fbdc68b22b(undefined, 1);
}

function function_b005a227c7052bab() {
  task = self;
  task.headicon = createheadicon(task.target);
  setheadiconenemyimage(task.headicon, level.poiprops.headicon);
  setheadicondrawthroughgeo(task.headicon, 1);
  setheadiconsnaptoedges(task.headicon, 0);
  setheadiconmaxdistance(task.headicon, 2048);
  setheadiconnaturaldistance(task.headicon, 30);
  setheadiconzoffset(task.headicon, 10);
}

function function_a91d0874afb8a157(dropstruct, boss, player) {
  var_87d58fdcedcfe1b6 = getdvarint(@ "hash_623a5fbf8a2eda3e", 1);
  var_9d966f1ac46cfb6a = getdvarint(@ "hash_763d715ff5888239", 0);
  var_6a2e08f957d1b294 = getscriptcachecontents("blacksite_boss_backpack", 0);
  var_df2f68507645906f = ["brloot_super_munitionsbox", "brloot_super_armorbox"];
  teammatecount = undefined;
  teammates = scripts\mp\utility\teams::getteamdata(player.team, "players");

  if(isDefined(teammates)) {
    teammatecount = teammates.size;
  }

  if(var_87d58fdcedcfe1b6 >= 0) {
    for(i = 0; i < var_87d58fdcedcfe1b6; i++) {
      randomindex = randomintrange(0, 25);
      var_6a2e08f957d1b294 = getscriptcachecontents("blacksite_boss_backpack", randomindex);

      if(isDefined(teammatecount)) {
        for(i = 0; i < teammatecount; i++) {
          var_6a2e08f957d1b294[var_6a2e08f957d1b294.size] = var_df2f68507645906f[i % var_df2f68507645906f.size];
        }
      }

      function_a47bc792e66b0fb7(dropstruct, boss, var_6a2e08f957d1b294);
    }
  } else if(isDefined(teammatecount)) {
    for(i = 0; i < teammatecount; i++) {
      randomindex = randomintrange(0, 25);
      var_6a2e08f957d1b294 = getscriptcachecontents("blacksite_boss_backpack", randomindex);
      var_6a2e08f957d1b294[var_6a2e08f957d1b294.size] = var_df2f68507645906f[i % var_df2f68507645906f.size];

      if(!istrue(var_9d966f1ac46cfb6a)) {
        if(array_contains(var_6a2e08f957d1b294, "brloot_killstreak_auav")) {
          var_6a2e08f957d1b294 = array_remove(var_6a2e08f957d1b294, "brloot_killstreak_auav");
        }
      }

      function_a47bc792e66b0fb7(dropstruct, boss, var_6a2e08f957d1b294);
    }
  } else {
    function_a47bc792e66b0fb7(dropstruct, boss, var_6a2e08f957d1b294);
  }

  if(var_9d966f1ac46cfb6a) {
    dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, boss.origin, boss.angles, boss);
    spawned = scripts\mp\gametypes\br_pickups::spawnpickup("brloot_killstreak_auav", dropinfo);

    if(isDefined(spawned)) {
      spawned setscriptablepartstate("brloot_killstreak_auav", "dropped");
    }
  }
}

function function_a47bc792e66b0fb7(dropstruct, boss, var_6a2e08f957d1b294) {
  count = undefined;

  foreach(lootdrop in var_6a2e08f957d1b294) {
    dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, boss.origin, boss.angles, boss);
    count = level.br_pickups.counts[lootdrop];
    spawned = scripts\mp\gametypes\br_pickups::spawnpickup(lootdrop, dropinfo, count);

    if(isDefined(spawned)) {
      spawned setscriptablepartstate(lootdrop, "dropped");
    }
  }
}

function function_b2616afcad011728(deathdata) {
  if(!isDefined(level.var_153bec2ca80c491a) || level.var_153bec2ca80c491a <= 0) {
    return;
  }

  fortress = namespace_9823ee6035594d67::function_c0a211a69f5f8f2f(deathdata.victim.origin);

  if(!isDefined(fortress)) {
    return;
  }

  if(istrue(fortress.isblacksite) && scripts\mp\gametypes\activity_manager::function_a2dcdcd112310e33(self.team, fortress)) {
    task = fortress.task;

    if(isDefined(task) && isDefined(task.target)) {
      if(isDefined(task.players)) {
        players = task.players;

        if(deathdata.victim br_public::isplayerinorgoingtogulag()) {
          players = array_remove(task.players, deathdata.victim);
        }

        var_72ec576edbf14909 = [];

        foreach(player in players) {
          if(player.team == deathdata.victim.team && player != deathdata.victim) {
            var_72ec576edbf14909[var_72ec576edbf14909.size] = player;
          }
        }

        if(players.size > 0) {
          if(var_72ec576edbf14909.size > 0) {
            namespace_bd614c3c2275579a::function_ac7dce0a21508d6e("blacksite_jugg_single_kill", players);
            return;
          }

          if(var_72ec576edbf14909.size <= 0) {
            namespace_bd614c3c2275579a::function_ac7dce0a21508d6e("blacksite_jugg_team_kill", players);
          }
        }
      }
    }
  }
}