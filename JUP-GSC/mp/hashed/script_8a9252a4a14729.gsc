/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_8a9252a4a14729.gsc
***********************************************/

#using script_1749d06ff1abde13;
#using script_185660037b9236c1;
#using script_2047cdbf5176ba0;
#using script_220d0eb95a8fab7d;
#using script_2ab52a62bf9e853b;
#using script_38622ac8d1042f47;
#using script_39d11000e476a42a;
#using script_3ab210ea917601e7;
#using script_41387eecc35b88bf;
#using script_4fa7e9e11630166c;
#using script_533e5a559ac874bb;
#using script_565762e567ca9ac7;
#using script_64351208cb856df9;
#using script_6ef639b99fbddff7;
#using script_71baa084f5c3e987;
#using script_752d972488e1bcf3;
#using script_7956d56c4922bd1;
#using script_7cb0d28e8be0e9f7;
#using script_7e41e37180e554f;
#using script_8a9252a4a14729;
#using scripts\asm\shared\mp\utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\team_assimilation;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#namespace namespace_7f07235e0f3535e;

function function_7582e8d13ed3c196(params) {
  if(function_b4aab17620ddfba8("a")) {
    function_447c6ab4bea16b52("contract", "REV_OB_ASSASSINATION", &namespace_4b05af9596de25bf::function_efc0b660430f0537, &namespace_ee0c44b2b5ce4eb7::function_fd69cf02ba4d90a2);
  }

  if(function_b4aab17620ddfba8("b")) {
    function_447c6ab4bea16b52("contract", "REV_OB_ASSASSINATION", &namespace_4b05af9596de25bf::function_efc0b660430f0537, &namespace_10eb89dbae3b9a07::function_fd69cf02ba4d90a2);
  }

  if(function_b4aab17620ddfba8("c")) {
    function_447c6ab4bea16b52("contract", "REV_OB_ASSASSINATION", &namespace_4b05af9596de25bf::function_efc0b660430f0537, &namespace_242c8d9da8f14ad3::function_fd69cf02ba4d90a2);
  }

  if(function_b4aab17620ddfba8("d")) {
    function_447c6ab4bea16b52("contract", "REV_OB_ASSASSINATION", &namespace_4b05af9596de25bf::function_efc0b660430f0537, &namespace_4ca22f138e73d273::function_fd69cf02ba4d90a2);
  }

  if(function_b4aab17620ddfba8("e")) {
    function_447c6ab4bea16b52("contract", "REV_OB_ASSASSINATION", &namespace_4b05af9596de25bf::function_efc0b660430f0537, &namespace_5ea9848627a81537::function_fd69cf02ba4d90a2);
  }

  if(function_b4aab17620ddfba8("f")) {
    function_447c6ab4bea16b52("contract", "REV_OB_ASSASSINATION", &namespace_4b05af9596de25bf::function_efc0b660430f0537, &namespace_640e7d8769ad71c7::function_fd69cf02ba4d90a2);
  }

  if(function_b4aab17620ddfba8("g")) {
    function_447c6ab4bea16b52("contract", "REV_OB_ASSASSINATION", &namespace_4b05af9596de25bf::function_efc0b660430f0537, &namespace_4e4453cc1e6ea85b::function_fd69cf02ba4d90a2);
  }

  if(function_b4aab17620ddfba8("h")) {
    function_447c6ab4bea16b52("contract", "REV_OB_ASSASSINATION", &namespace_4b05af9596de25bf::function_efc0b660430f0537, &namespace_31ceb7e15880023b::function_fd69cf02ba4d90a2);
  }

  if(function_b4aab17620ddfba8("i")) {
    function_447c6ab4bea16b52("contract", "REV_OB_ASSASSINATION", &namespace_4b05af9596de25bf::function_efc0b660430f0537, &namespace_297cce142f234407::function_fd69cf02ba4d90a2);
  }
}

function function_efc0b660430f0537() {
  level.var_7e12f6eb4fcb4ea1 = spawnStruct();
  level.var_7e12f6eb4fcb4ea1.time = getdvarint(@ "hash_72660fac527aaeb5", 300);
  level.var_7e12f6eb4fcb4ea1.minsearchradius = getdvarint(@ "hash_6464566e8990a20", 5000);
  level.var_7e12f6eb4fcb4ea1.searchlimit = getdvarint(@ "hash_636d289d84f99e04", 30000);
  level.var_7e12f6eb4fcb4ea1.searchincrement = getdvarint(@ "hash_4ab47609d1497ece", 5000);
  level.var_7e12f6eb4fcb4ea1.circlerangemin = getdvarint(@ "hash_2edc6209fe22f4e1", 100);
  level.var_7e12f6eb4fcb4ea1.circlerangemax = getdvarint(@ "hash_2f005409fe4b50cf", 1000);
  level.var_7e12f6eb4fcb4ea1.var_3bd4a66a02968ecc = getdvarint(@ "hash_e2f1af059fbe1afb", 1500);
  level.var_7e12f6eb4fcb4ea1.var_5094b22fd45a3ef6 = getdvarint(@ "hash_b4061ee6c7f796bb", 2000);
  level.var_7e12f6eb4fcb4ea1.var_a3487335038df794 = getdvarint(@ "hash_42e7a23df0253c03", 3500);
  level.var_7e12f6eb4fcb4ea1.var_65dd392cafab8111 = getdvarint(@ "hash_11732dc10bbd785e", 2500);
  level.var_7e12f6eb4fcb4ea1.var_a12a720226632b47 = getdvarint(@ "hash_e39017944e7471a6", 5000);

  if(!isDefined(level.var_aab4fba7a041b281)) {
    level.var_aab4fba7a041b281 = [];
  }

  function_89384091f7a2dbd("REV_OB_ASSASSINATION", 0, &function_95bb73feb4a138ab);
  function_89384091f7a2dbd("REV_OB_ASSASSINATION", 1, &assassination_begin);
  function_89384091f7a2dbd("REV_OB_ASSASSINATION", 2, &function_68394fff4d44449b);
  function_89384091f7a2dbd("REV_OB_ASSASSINATION", 3, &function_6e628ff1a7e7eb75);
  function_89384091f7a2dbd("REV_OB_ASSASSINATION", 5, &function_4068fa9a397f767);
}

function function_95bb73feb4a138ab() {
  self endon("activity_ended");
  self endon("instance_destroyed");
  function_b6fc2c96b463c007(self);
}

function assassination_begin() {
  self endon("activity_ended");
  self endon("instance_destroyed");
  self.targetteam = function_84f35f18bc171c4b(self.playerparticipants[0]);

  if(isDefined(self.targetteam)) {
    self.hunterteam = self.playerparticipants[0].team;
    function_c7e3cd9f45114cc6(1);
    self.targetplayer = function_7509965d9b7b0783(self.targetteam);

    if(!isDefined(self.targetplayer)) {
      function_e730864bccf684a8(0, "noTarget");
      return;
    }

    function_6b6b6273f8180522("Assassination_Br");
    function_9ca12d228e28fc4e();
    function_e889ff375104a81a(1);
    namespace_262d6474998a2356::function_61cd287166c3f695("REV_OB_ASSASSINATION");
    namespace_262d6474998a2356::function_c661dba3e304266b(self.targetplayer getentitynumber());
    namespace_262d6474998a2356::function_474722293c221d5c(level.var_7e12f6eb4fcb4ea1.time);
    thread namespace_277c27ef297ef569::function_1281c7fff9456e18("contract_assassination_begin");
    thread namespace_277c27ef297ef569::function_1281c7fff9456e18("contract_assassination_target_begin", getteamdata(self.targetteam, "players"));
    thread function_11b1906c1ace5e9a(level.var_7e12f6eb4fcb4ea1.time);
    thread function_11347a2fac282ff1();
    thread function_580d66ea57c2bae4();
    thread function_3c7671eec6650e55();
    thread function_22d218a774d32f92();
    return;
  }

  function_e730864bccf684a8(0, "noTarget");
}

function function_68394fff4d44449b() {
  self endon("instance_destroyed");

  if(function_acaa75ca8754452e()) {
    function_af5604ce591768e1();
  }

  if(isDefined(self.targetteam)) {
    function_c7e3cd9f45114cc6(0);
    function_48919e173bf3f70d(0);
    function_e889ff375104a81a(0);
    self.targetteam = undefined;
    self.hunterteam = undefined;
    self.targetplayer = undefined;
  }
}

function function_6e628ff1a7e7eb75() {
  function_68394fff4d44449b();
}

function function_9ca12d228e28fc4e() {
  foreach(player in getteamdata(self.hunterteam, "players")) {
    function_cfd53c8f6878014f(player);
  }
}

function function_e889ff375104a81a(visible) {
  value = ter_op(istrue(visible), gettime() + level.var_7e12f6eb4fcb4ea1.time * 1000, 0);

  foreach(player in getteamdata(self.targetteam, "players")) {
    player setclientomnvar("ui_br_assassination_target_timer", value);
  }
}

function function_48919e173bf3f70d(visible) {
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

function function_3c7671eec6650e55() {
  self endon("activity_ended");
  self endon("instance_destroyed");
  self.targetplayer waittill("death_or_disconnect");
  function_e730864bccf684a8(1);
}

function function_11347a2fac282ff1() {
  self endon("activity_ended");
  self endon("instance_destroyed");

  while(true) {
    function_7f15bee19d4fe7ad(self.targetplayer);
    function_98e4ffc78350980a();
    function_48919e173bf3f70d(1);
    wait 10;
  }
}

function function_22d218a774d32f92() {
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
      function_e730864bccf684a8(0);
      return;
    }

    wait 1;
  }
}

function function_f8b99a032bec8b6f(team) {
  teamsize = 0;
  teamcenter = (0, 0, 0);

  foreach(teammate in getteamdata(team, "players")) {
    if(isreallyalive(teammate)) {
      teamsize++;
      teamcenter += teammate.origin;
    }
  }

  if(teamsize != 0) {
    teamcenter /= teamsize;
  }

  return [teamcenter, teamsize];
}

function function_bd4dc62040a7da16(player, searchradius) {
  playerlist = [];
  hunterteam = player.team;
  potentiallist = undefined;
  list1 = level.var_aab4fba7a041b281;
  list2 = getteamdata(hunterteam, "players");
  excludedteams = array_combine(list1, list2);

  if(isDefined(searchradius)) {
    potentiallist = get_array_of_closest(player.origin, level.players, excludedteams, undefined, searchradius, level.var_7e12f6eb4fcb4ea1.minsearchradius);
  } else {
    potentiallist = get_array_of_closest(player.origin, level.players, excludedteams, undefined, undefined, undefined);
  }

  foreach(potentialtarget in potentiallist) {
    if(isreallyalive(potentialtarget)) {
      playerlist[playerlist.size] = potentialtarget;
    }
  }

  return playerlist;
}

function function_f289bd23237b0b42(playerlist, var_29f6d200784f77b3, hunterteamsize) {
  bestteam = undefined;
  teamsize = 0;
  teammarked = [];

  foreach(potentialtarget in playerlist) {
    if(istrue(teammarked[potentialtarget.team])) {
      continue;
    }

    teammarked[potentialtarget.team] = 1;
    targetteamsize = 0;

    foreach(teammate in getteamdata(potentialtarget.team, "players")) {
      if(isreallyalive(teammate)) {
        targetteamsize++;
      }
    }

    if(targetteamsize == 0) {
      continue;
    }

    if(!isDefined(bestteam)) {
      bestteam = potentialtarget.team;
      teamsize = targetteamsize;
      continue;
    }

    difference = abs(hunterteamsize - teamsize);
    targetdifference = abs(hunterteamsize - targetteamsize);

    if(targetdifference < difference) {
      bestteam = potentialtarget.team;
      teamsize = targetteamsize;
      continue;
    } else if(targetdifference > difference) {
      continue;
    }

    if(teamsize < targetteamsize) {
      bestteam = potentialtarget.team;
      teamsize = targetteamsize;
      continue;
    } else if(teamsize > targetteamsize) {
      continue;
    }

    [currentteamcenter] = function_f8b99a032bec8b6f(potentialtarget.team);
    [var_76e3e3800077282f] = function_f8b99a032bec8b6f(bestteam);

    if(distance2d(var_29f6d200784f77b3, currentteamcenter) < distance2d(var_29f6d200784f77b3, var_76e3e3800077282f)) {
      bestteam = potentialtarget.team;
      teamsize = targetteamsize;
    }
  }

  return bestteam;
}

function function_84f35f18bc171c4b(player) {
  playerlist = [];
  bestteam = undefined;
  searchradius = level.var_7e12f6eb4fcb4ea1.minsearchradius;
  hunterteaminfo = function_f8b99a032bec8b6f(player.team);
  var_29f6d200784f77b3 = hunterteaminfo[0];
  hunterteamsize = hunterteaminfo[1];

  while(!isDefined(bestteam) && searchradius < level.var_7e12f6eb4fcb4ea1.searchlimit) {
    playerlist = function_bd4dc62040a7da16(player, searchradius);
    bestteam = function_f289bd23237b0b42(playerlist, var_29f6d200784f77b3, hunterteamsize);
    searchradius += level.var_7e12f6eb4fcb4ea1.searchincrement;
  }

  if(!isDefined(bestteam)) {
    playerlist = function_bd4dc62040a7da16(player);
    bestteam = function_f289bd23237b0b42(playerlist, var_29f6d200784f77b3, hunterteamsize);
  }

  return bestteam;
}

function function_7509965d9b7b0783(targetteam) {
  targetplayer = undefined;
  [targetteamcenter] = function_f8b99a032bec8b6f(targetteam);

  foreach(player in getteamdata(targetteam, "players")) {
    if(!isreallyalive(player)) {
      continue;
    }

    if(!isDefined(targetplayer)) {
      targetplayer = player;
      continue;
    }

    if(distance2d(targetteamcenter, player.origin) < distance2d(targetteamcenter, targetplayer.origin)) {
      targetplayer = player;
    }
  }

  assert(isDefined(targetplayer));
  return targetplayer;
}

function function_7f15bee19d4fe7ad(targetplayer) {
  search_location = (targetplayer.origin[0], targetplayer.origin[1], level.var_7e12f6eb4fcb4ea1.var_5094b22fd45a3ef6);
  search_location += scripts\engine\math::random_vector_2d() * randomfloatrange(level.var_7e12f6eb4fcb4ea1.circlerangemin, level.var_7e12f6eb4fcb4ea1.circlerangemax);
  function_6e148c8da2e4db13(search_location);
}

function function_98e4ffc78350980a() {
  hunterplayers = [];

  foreach(player in getteamdata(self.hunterteam, "players")) {
    if(isreallyalive(player)) {
      hunterplayers[hunterplayers.size] = player;
    }
  }

  if(hunterplayers.size == 0) {
    function_4584ad1c0e2c58ec(level.var_7e12f6eb4fcb4ea1.var_a3487335038df794);
    self.threat_level = 0;
    return;
  }

  closestdist = undefined;

  foreach(player in hunterplayers) {
    dist = distance2d(player.origin, self.targetplayer.origin);

    if(!isDefined(closestdist) || dist < closestdist) {
      closestdist = dist;
    }
  }

  if(closestdist > level.var_7e12f6eb4fcb4ea1.var_a12a720226632b47) {
    function_4584ad1c0e2c58ec(level.var_7e12f6eb4fcb4ea1.var_a3487335038df794);
    self.threat_level = 0;
    return;
  }

  if(closestdist > level.var_7e12f6eb4fcb4ea1.var_65dd392cafab8111) {
    function_4584ad1c0e2c58ec(level.var_7e12f6eb4fcb4ea1.var_5094b22fd45a3ef6);
    self.threat_level = 1;
    return;
  }

  function_4584ad1c0e2c58ec(level.var_7e12f6eb4fcb4ea1.var_3bd4a66a02968ecc);
  self.threat_level = 2;
}

function function_8002632f8d8eccde(issuccess, reason) {
  if(issuccess) {
    thread namespace_277c27ef297ef569::function_1281c7fff9456e18("contract_assassination_target_eliminated", getteamdata(self.targetteam, "players"));
    return;
  }

  if(isDefined(reason) && reason == "noTarget") {
    thread namespace_277c27ef297ef569::function_1281c7fff9456e18("contract_assassination_warning");
    return;
  }

  thread namespace_277c27ef297ef569::function_1281c7fff9456e18("contract_assassination_failure");
  thread namespace_277c27ef297ef569::function_1281c7fff9456e18("contract_assassination_target_survive", getteamdata(self.targetteam, "players"));
}

function function_e730864bccf684a8(issuccess, reason) {
  function_8002632f8d8eccde(issuccess, reason);
  endactivity(self, issuccess);
}

function function_4068fa9a397f767() {
  self endon("instance_destroyed");
  var_6c1956fd6ce84917 = 1;
  var_cc7aa96a854fd8ee = namespace_71ca15b739deab72::function_3ae7f99339b96499(self.playerparticipants[0].origin, var_6c1956fd6ce84917);
  return var_cc7aa96a854fd8ee;
}

function function_11b1906c1ace5e9a(time) {
  self endon("activity_ended");
  self endon("instance_destroyed");
  wait time;
  function_e730864bccf684a8(0);
}

function function_580d66ea57c2bae4() {
  self endon("activity_ended");
  self endon("instance_destroyed");
  self.targetplayer waittill("exfil_fully_completed");
  function_e730864bccf684a8(0);
}

function function_c7e3cd9f45114cc6(var_92eea146514289f2) {
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