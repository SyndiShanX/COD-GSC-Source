/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3691c0b107a6701c.gsc
*************************************************/

#using script_185660037b9236c1;
#using script_18a1a0633babca10;
#using script_2047cdbf5176ba0;
#using script_220d0eb95a8fab7d;
#using script_252bd483a6677ac;
#using script_2d7c98a7d021a0a8;
#using script_3691c0b107a6701c;
#using script_39d11000e476a42a;
#using script_3ab210ea917601e7;
#using script_3d06753b3fc22d30;
#using script_41387eecc35b88bf;
#using script_4fa7e9e11630166c;
#using script_4fdefae8b7bcdf73;
#using script_5f2d8c30a1a0e928;
#using script_617646b8ffe3042c;
#using script_64351208cb856df9;
#using script_791b30ce26ece56c;
#using script_7956d56c4922bd1;
#using script_7e41e37180e554f;
#using script_838faaae00b43c;
#using scripts\asm\shared\mp\utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\team_assimilation;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#using scripts\ob\points;
#namespace namespace_f1502c404076e9bf;

function function_b1568160c3017867(params) {
  if(function_b4aab17620ddfba8("a")) {
    function_447c6ab4bea16b52("contract", "REV_OB_TEAM_HUNT", &namespace_325330503813833a::function_f0c8a91c808c17dc, &namespace_78f835bfd4a00278::function_fd69cf02ba4d90a2);
  }

  if(function_b4aab17620ddfba8("b")) {
    function_447c6ab4bea16b52("contract", "REV_OB_TEAM_HUNT", &namespace_325330503813833a::function_f0c8a91c808c17dc, &namespace_18438c24222e0aa8::function_fd69cf02ba4d90a2);
  }

  if(function_b4aab17620ddfba8("c")) {
    function_447c6ab4bea16b52("contract", "REV_OB_TEAM_HUNT", &namespace_325330503813833a::function_f0c8a91c808c17dc, &namespace_24aadd73c1e4a3fc::function_fd69cf02ba4d90a2);
  }

  if(function_b4aab17620ddfba8("d")) {
    function_447c6ab4bea16b52("contract", "REV_OB_TEAM_HUNT", &namespace_325330503813833a::function_f0c8a91c808c17dc, &namespace_24bdc55631dc5a5c::function_fd69cf02ba4d90a2);
  }

  if(function_b4aab17620ddfba8("f")) {
    function_447c6ab4bea16b52("contract", "REV_OB_TEAM_HUNT", &namespace_325330503813833a::function_f0c8a91c808c17dc, &namespace_d0532c68ea00a668::function_fd69cf02ba4d90a2);
  }

  if(function_b4aab17620ddfba8("g")) {
    function_447c6ab4bea16b52("contract", "REV_OB_TEAM_HUNT", &namespace_325330503813833a::function_f0c8a91c808c17dc, &namespace_b90be98f4e4b8234::function_fd69cf02ba4d90a2);
  }

  if(function_b4aab17620ddfba8("h")) {
    function_447c6ab4bea16b52("contract", "REV_OB_TEAM_HUNT", &namespace_325330503813833a::function_f0c8a91c808c17dc, &namespace_90cb51074653cfd4::function_fd69cf02ba4d90a2);
  }

  if(function_b4aab17620ddfba8("i")) {
    function_447c6ab4bea16b52("contract", "REV_OB_TEAM_HUNT", &namespace_325330503813833a::function_f0c8a91c808c17dc, &namespace_d687ce4fe57c14a8::function_fd69cf02ba4d90a2);
  }
}

function function_f0c8a91c808c17dc() {
  level.huntprops = spawnStruct();
  level.huntprops.teamradius = getdvarint(@ "hash_8139abd8166ca4c1", 3000);
  level.huntprops.teamradiussq = level.huntprops.teamradius * level.huntprops.teamradius;
  level.huntprops.var_feb83d3eed59be1c = getdvarint(@ "hash_3bc96df279c751e9", 1000);
  level.huntprops.var_e3aa1de9d96e0086 = getdvarint(@ "hash_35f7a59b2616eb7d", 500);
  level.huntprops.var_58ef8eb47442fbe2 = getdvarint(@ "hash_e273b91103c40db4", 20);
  level.huntprops.var_6eff6b94778545a = getdvarint(@ "hash_b597c2eb9ed43e1b", 5);
  level.huntprops.timelimit = getdvarint(@ "hash_bdcd789b52a3bbbe", 300);
  level.huntprops.scoremaxdist = getdvarfloat(@ "hash_19a1f2ba34185227", 80000);
  level.huntprops.var_55a75ba6640b59f4 = getdvarint(@ "hash_b3f653e48ce2a8cf", 3000);
  level.huntprops.var_9fe72f3581fc4d1 = getdvarint(@ "hash_1d81a630b92605b8", 8000);
  level.huntprops.distmodifier = getdvarfloat(@ "hash_6640686452114bc4", 240);
  level.huntprops.var_5572778d2cffe0fd = getdvarfloat(@ "hash_3725fbb1feb2dc52", 40);
  level.huntprops.var_69873adaf95b11a = getdvarfloat(@ "hash_fb411f33cb8f4d02", 2.5);
  level.huntprops.var_e8fa4e2bd0433d43 = getdvarfloat(@ "hash_85f530defa2a7c6f", 60);
  level.huntprops.var_15b2bbc2239d50e1 = getdvarfloat(@ "hash_51bb4f27c725f721", 0.05);

  if(!isDefined(level.var_aab4fba7a041b281)) {
    level.var_aab4fba7a041b281 = [];
  }

  function_89384091f7a2dbd("REV_OB_TEAM_HUNT", 0, &function_e2c5ba0b5938975a);
  function_89384091f7a2dbd("REV_OB_TEAM_HUNT", 1, &function_f7a3d129963fe612);
  function_89384091f7a2dbd("REV_OB_TEAM_HUNT", 2, &function_129d15912921cc99);
  function_89384091f7a2dbd("REV_OB_TEAM_HUNT", 3, &function_28ae17cdb2e61f0f);
  function_89384091f7a2dbd("REV_OB_TEAM_HUNT", 5, &function_6ba7cb17933b089d);
}

function function_e2c5ba0b5938975a() {
  self endon("activity_ended");
  self endon("instance_destroyed");
  function_b6fc2c96b463c007(self);
}

function function_f7a3d129963fe612() {
  self.targetplayer = function_20f0caea2a03d942();

  if(!isDefined(self.targetplayer)) {
    function_e3c6eb5885dbbcbb(0, "noTarget");
    return;
  }

  self.hunterteam = self.var_6c29f2fdb0054bbe[0].team;
  self.targetteam = self.targetplayer.team;
  function_632b43ad8c51d71(1);
  function_c78fcbb8d5b8311c();
  function_32c382f03fecb524(1);
  function_67b14d51b7c11374();
  namespace_262d6474998a2356::function_61cd287166c3f695("REV_OB_TEAM_HUNT");
  namespace_262d6474998a2356::function_474722293c221d5c(level.huntprops.timelimit);
  thread namespace_277c27ef297ef569::function_1281c7fff9456e18("contract_teamhunt_begin");
  thread namespace_277c27ef297ef569::function_1281c7fff9456e18("contract_teamhunt_target_begin", getteamdata(self.targetteam, "players"));
  thread function_2c18821cd28921aa();
  thread function_312c17a5b62d29e4();
  thread function_fea5ccc47ca0515e();
  thread function_4933e17301571873();
  thread function_e8101a9498b9e3c4(level.huntprops.timelimit);
}

function function_c78fcbb8d5b8311c() {
  self.objectiveiconid = namespace_5ab9942d4e45708d::function_36a95c9de2ace25a("jup_ob_objectivemarker_teamhunt", 1, 1);
  scripts\cp_mp\utility\game_utility::function_6b6b6273f8180522("Hostage_Dmz", self.origin, level.huntprops.teamradius + level.huntprops.var_e3aa1de9d96e0086);

  foreach(player in getteamdata(self.hunterteam, "players")) {
    function_cfd53c8f6878014f(player);
  }
}

function function_20f0caea2a03d942() {
  origin = self.var_6c29f2fdb0054bbe[0].origin;
  hunterteam = self.var_6c29f2fdb0054bbe[0].team;
  targetplayer = undefined;
  maxscore = -1;

  foreach(player in level.players) {
    if(player.team != hunterteam && isreallyalive(player) && !function_4c9b6c46c1d875b0(player.team)) {
      scores = function_49df6ae49b0cbe54(player, origin);
      totalplayerscore = 0;

      foreach(score in scores) {
        totalplayerscore += score;
      }

      if(totalplayerscore > maxscore) {
        maxscore = totalplayerscore;
        targetplayer = player;
      }
    }
  }

  return targetplayer;
}

function function_49df6ae49b0cbe54(player, origin) {
  scores = [];
  dist = distance(origin, player.origin);
  maxdist = level.huntprops.scoremaxdist;
  distscore = max(level.huntprops.distmodifier * (1 - dist / maxdist), 0);
  teamplayers = getteamdata(player.team, "players");
  var_6d038a7052e9467c = 0;

  foreach(player in teamplayers) {
    if(player scripts\mp\utility\perk::_hasperk("specialty_ghost")) {
      var_6d038a7052e9467c++;
    }
  }

  var_4aa32c116c698ff6 = level.huntprops.var_5572778d2cffe0fd * (teamplayers.size - var_6d038a7052e9467c);
  scores["generic"] = distscore + var_4aa32c116c698ff6;
  scores["agents"] = level.huntprops.var_69873adaf95b11a * ter_op(isDefined(player.agentkills), player.agentkills, 0);
  scores["operators"] = level.huntprops.var_e8fa4e2bd0433d43 * ter_op(isDefined(player.pers["kills"]), player.pers["kills"], 0);
  scores["valuables"] = level.huntprops.var_15b2bbc2239d50e1 * player scripts\ob\points::function_b86115649d705017();
  return scores;
}

function function_4c9b6c46c1d875b0(team) {
  foreach(player in level.var_aab4fba7a041b281) {
    if(player.team == team) {
      return true;
    }
  }

  return false;
}

function function_198b93e2019051cf(visible) {
  if(istrue(visible) && isDefined(self.threat_level)) {
    entitynumber = self.targetplayer getentitynumber();
    entitynumber += 1;
    value = self.threat_level << 8 | entitynumber;
  } else {
    value = 0;
  }

  foreach(player in getteamdata(self.targetteam, "players")) {
    player setclientomnvar("ui_br_assassination_target", value);
  }
}

function function_fea5ccc47ca0515e() {
  self endon("activity_ended");
  self endon("instance_destroyed");

  while(isDefined(self.targetplayer)) {
    closestplayer = getclosest(self.targetplayer.origin, getteamdata(self.hunterteam, "players"));
    dist = distance(closestplayer.origin, self.targetplayer.origin);

    if(dist > level.huntprops.var_9fe72f3581fc4d1) {
      self.threat_level = 0;
    } else if(dist > level.huntprops.var_55a75ba6640b59f4) {
      self.threat_level = 1;
    } else {
      self.threat_level = 2;
    }

    function_198b93e2019051cf(1);
    wait 1;
  }
}

function function_88f9e05f8b30fafb(issuccess, reason) {
  if(issuccess) {
    thread namespace_277c27ef297ef569::function_1281c7fff9456e18("contract_teamhunt_target_eliminated", getteamdata(self.targetteam, "players"));
    return;
  }

  if(isDefined(reason) && reason == "noTarget") {
    thread namespace_277c27ef297ef569::function_1281c7fff9456e18("contract_teamhunt_warning");
    return;
  }

  thread namespace_277c27ef297ef569::function_1281c7fff9456e18("contract_teamhunt_failure");
  thread namespace_277c27ef297ef569::function_1281c7fff9456e18("contract_teamhunt_target_survive", getteamdata(self.targetteam, "players"));
}

function function_e3c6eb5885dbbcbb(issuccess, reason) {
  function_88f9e05f8b30fafb(issuccess, reason);
  endactivity(self, issuccess);
}

function function_312c17a5b62d29e4() {
  self endon("activity_ended");
  self endon("instance_destroyed");
  self.lastposition = self.targetplayer.origin;
  var_c7111e2f9f477bec = -999999;

  while(isDefined(self.targetplayer)) {
    var_f17269c0d177f1eb = -1;
    invehicle = self.targetplayer scripts\cp_mp\utility\player_utility::isinvehicle(0);

    if(invehicle) {
      var_f17269c0d177f1eb = level.huntprops.var_6eff6b94778545a;
    } else {
      var_f17269c0d177f1eb = level.huntprops.var_58ef8eb47442fbe2;
    }

    currenttime = gettime();

    if(currenttime - var_c7111e2f9f477bec > var_f17269c0d177f1eb * 1000) {
      radius = ter_op(invehicle, level.huntprops.var_feb83d3eed59be1c, level.huntprops.teamradius);
      circleorigin = function_f23330cab6d69794(self.lastposition, radius);
      circleorigin = (circleorigin[0], circleorigin[1], level.huntprops.teamradius + level.huntprops.var_e3aa1de9d96e0086);
      self.mapcircle moveTo(circleorigin, 1, 0.25, 0.25);
      thread function_aa76ed91575c776b();
      self.lastposition = self.targetplayer.origin;
      var_c7111e2f9f477bec = currenttime;
    }

    wait 1;
  }
}

function function_2c18821cd28921aa() {
  self endon("activity_ended");
  self endon("instance_destroyed");
  wait 3;

  while(true) {
    if(!isDefined(self.mapcircle) || !isDefined(self.objectiveiconid)) {
      return;
    }

    foreach(player in getteamdata(self.hunterteam, "players")) {
      distsq = distance2dsquared(player.origin, self.mapcircle.origin);
      showicon = distsq > self.mapcircle.origin[2] * self.mapcircle.origin[2];
      function_6a20e14667024546(player, showicon);
    }

    wait 1;
  }
}

function function_6a20e14667024546(player, visible) {
  if(isDefined(self.objectiveiconid)) {
    if(visible) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.objectiveiconid, player);
      return;
    }

    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self.objectiveiconid, player);
  }
}

function function_aa76ed91575c776b() {
  self endon("activity_ended");
  self endon("instance_destroyed");
  endtime = gettime() + 1200;

  while(gettime() < endtime && isDefined(self.mapcircle) && isDefined(self.mapcircle.origin)) {
    function_365b2c400644893a(self.mapcircle.origin);
    waitframe();
  }
}

function function_365b2c400644893a(location) {
  if(isDefined(self.objectiveiconid)) {
    objective_position(self.objectiveiconid, location);
  }
}

function function_f23330cab6d69794(origin, radius) {
  return origin + function_d553466cf817a4da() * radius;
}

function function_67b14d51b7c11374() {
  foreach(player in getteamdata(self.targetteam, "players")) {
    thread function_d8807a8a68c195d(player);
    thread function_e83560d0a3169507(player);
  }
}

function function_23cc8341ebe869a6() {
  teammates = [];

  foreach(teammate in getteamdata(self.targetteam, "players")) {
    if(isreallyalive(teammate) && !istrue(teammate.hunterkilled) && distancesquared(teammate.origin, self.targetplayer.origin) < level.huntprops.teamradiussq) {
      teammates[teammates.size] = teammate;
    }
  }

  return teammates;
}

function function_d8807a8a68c195d(player) {
  self endon("activity_ended");
  self endon("instance_destroyed");

  while(true) {
    player waittill_any_3("death_or_disconnect", "enter_live_ragdoll");
    player.hunterkilled = 1;

    if(player == self.targetplayer) {
      teammates = function_23cc8341ebe869a6();

      if(teammates.size == 0) {
        function_e3c6eb5885dbbcbb(1);
        return;
      }

      self.targetplayer = teammates[0];
    }
  }
}

function function_e83560d0a3169507(player) {
  self endon("activity_ended");
  self endon("instance_destroyed");
  player waittill("exfil_fully_completed");

  if(player == self.targetplayer) {
    teammates = function_23cc8341ebe869a6();

    if(teammates.size == 0) {
      function_e3c6eb5885dbbcbb(0);
      return;
    }

    self.targetplayer = teammates[0];
  }
}

function function_32c382f03fecb524(visible) {
  value = ter_op(istrue(visible), gettime() + level.huntprops.timelimit * 1000, 0);

  foreach(player in getteamdata(self.targetteam, "players")) {
    player setclientomnvar("ui_br_assassination_target_timer", value);
  }
}

function function_e8101a9498b9e3c4(time) {
  self endon("activity_ended");
  self endon("instance_destroyed");
  wait time;
  function_e3c6eb5885dbbcbb(0);
}

function function_9f716ccd2287c814() {
  foreach(teammate in getteamdata(self.targetteam, "players")) {
    teammate.hunterkilled = undefined;
  }
}

function function_129d15912921cc99() {
  self endon("instance_destroyed");

  if(function_acaa75ca8754452e()) {
    function_af5604ce591768e1();
  }

  if(isDefined(self.targetteam)) {
    function_632b43ad8c51d71(0);
    function_198b93e2019051cf(0);
    function_32c382f03fecb524(0);
    function_9f716ccd2287c814();
    self.targetplayer = undefined;
    self.hunterteam = undefined;
    self.targetteam = undefined;
    self.objectiveiconid = undefined;
  }
}

function function_28ae17cdb2e61f0f() {
  function_129d15912921cc99();
}

function function_4933e17301571873() {
  self endon("activity_ended");
  self endon("instance_destroyed");

  while(true) {
    var_189592790ba8be47 = 1;

    foreach(teammate in getteamdata(self.hunterteam, "players")) {
      if(isreallyalive(teammate) || isDefined(level.var_fd15b9ad0f909a26) && !teammate[[level.var_fd15b9ad0f909a26]]()) {
        var_189592790ba8be47 = 0;
        break;
      }
    }

    if(var_189592790ba8be47) {
      function_e3c6eb5885dbbcbb(0);
      return;
    }

    wait 1;
  }
}

function function_6ba7cb17933b089d() {
  self endon("instance_destroyed");
  var_6c1956fd6ce84917 = 1;
  var_cc7aa96a854fd8ee = namespace_71ca15b739deab72::function_3ae7f99339b96499(self.var_6c29f2fdb0054bbe[0].origin, var_6c1956fd6ce84917);
  return var_cc7aa96a854fd8ee;
}

function function_632b43ad8c51d71(var_92eea146514289f2) {
  var_b733333748d3f129 = scripts\mp\utility\teams::getteamdata(self.targetteam, "players");

  if(var_92eea146514289f2) {
    level.var_aab4fba7a041b281 = array_combine(level.var_aab4fba7a041b281, var_b733333748d3f129);

    foreach(player in var_b733333748d3f129) {
      scripts\mp\team_assimilation::function_bb4125d6847af349(player, "contract_target");
    }

    return;
  }

  level.var_aab4fba7a041b281 = array_remove_array(level.var_aab4fba7a041b281, var_b733333748d3f129);

  foreach(player in var_b733333748d3f129) {
    scripts\mp\team_assimilation::function_59cf08630dd70540(player, "contract_target");
  }
}