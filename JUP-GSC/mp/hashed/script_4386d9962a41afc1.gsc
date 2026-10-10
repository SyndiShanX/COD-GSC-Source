/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4386d9962a41afc1.gsc
*************************************************/

#using script_185660037b9236c1;
#using script_220d0eb95a8fab7d;
#using script_2707474774db34b;
#using script_41387eecc35b88bf;
#using scripts\common\devgui;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;
#using scripts\mp\utility\teams;
#namespace namespace_9fe96b983bb4b476;

function function_60a8777312cc62d7(player) {
  if(!isDefined(player)) {
    assertmsg("<dev string:x1c>");
    return;
  }

  focusedactivity = function_deb5a4d2a7bda5e9(player);

  if(!isDefined(focusedactivity)) {
    println("<dev string:x5f>" + "<dev string:xbf>" + "<dev string:x115>");
    return;
  }

  function_90edaba623c87c34(focusedactivity, player);
}

function function_90edaba623c87c34(activityinstance, player) {
  if(!function_6ebc53f792333cf5(activityinstance, player)) {
    return;
  }

  function_6a99c0e5fb21729c(activityinstance);

  if(function_e9433db9d33e1279(activityinstance, player)) {
    println("<dev string:x130>");
    return;
  }

  function_abaa57eec7d4c532(activityinstance, player);
  var_606f34fc1ead5c7a = function_16e0486e6ff0b40f(activityinstance, player);
  function_ddc88c261e9b3637(activityinstance, player, var_606f34fc1ead5c7a);
  function_55038a5fbb28f66c(activityinstance, player);
}

function function_c9afc8e2fd64917(activityinstance, player) {
  if(!function_6ebc53f792333cf5(activityinstance, player)) {
    return;
  }

  function_6a99c0e5fb21729c(activityinstance);

  if(function_a10d5774bdcd3b0a(activityinstance, player)) {
    function_23516e860dddbf1b(activityinstance, player);
    function_abaa57eec7d4c532(activityinstance, player);
    function_55038a5fbb28f66c(activityinstance, player, 1);
  }
}

function function_df7f1a29325af528(activityinstance, player) {
  if(!function_6ebc53f792333cf5(activityinstance, player)) {
    return;
  }

  function_6a99c0e5fb21729c(activityinstance);

  if(function_a10d5774bdcd3b0a(activityinstance, player)) {
    function_30b211b56a55ca0b(activityinstance, player);
  }
}

function function_2086dfaf421ea734(activityinstance, player) {
  if(!isDefined(activityinstance)) {
    println("<dev string:x199>");
    return;
  }

  function_a68f6703c78f0051(activityinstance, player);
  function_bbbdd2dc3be2f04d(activityinstance, player, "ActivityVoteResult_Cancelled");
}

function function_a10d5774bdcd3b0a(activityinstance, player) {
  if(!isDefined(activityinstance) || !isDefined(activityinstance.var_ced013ef63e76a7b)) {
    return false;
  }

  return function_2a87b98d1f58ddbc(activityinstance, player) == "ActivityVoteResult_InProgress";
}

function function_5a840337aed72780(activityinstance, var_6128c35fcd588a91) {
  var_6f8af5eb76deac21 = spawnStruct();
  var_6f8af5eb76deac21.var_6128c35fcd588a91 = var_6128c35fcd588a91;
  return function_104adc18c0d699c3(activityinstance, 8, var_6f8af5eb76deac21);
}

function function_2d4b61447e3a46b0(var_6f8af5eb76deac21) {
  assertex(isDefined(var_6f8af5eb76deac21), "<dev string:x1e4>");
  return var_6f8af5eb76deac21.var_6128c35fcd588a91;
}

function private function_ddc88c261e9b3637(activityinstance, player, var_606f34fc1ead5c7a) {
  votename = "ActivityVoteName_SquadAbandonVote";
  votes = function_f90897ff85a28f1a(activityinstance, player);
  var_9cc718b114d4f1f = function_37ffb7a5350616ca(player);
  var_7f59d74a1e866246 = function_355cd23c6cbf8dda(activityinstance, votename, votes, var_9cc718b114d4f1f, player, var_606f34fc1ead5c7a);
  function_735ee8e9d0f1b00b(activityinstance, "VoteCast", var_7f59d74a1e866246);

  function_26b72cfbd71e82f(activityinstance, player);
}

function private function_bbbdd2dc3be2f04d(activityinstance, player, voteresult) {
  votename = "ActivityVoteName_SquadAbandonVote";
  votes = function_f90897ff85a28f1a(activityinstance, player);
  var_9cc718b114d4f1f = function_37ffb7a5350616ca(player);
  var_7570a1bf222e764 = function_53a3019fd9a570ee(activityinstance, votename, votes, var_9cc718b114d4f1f, voteresult);
  function_735ee8e9d0f1b00b(activityinstance, "VoteEnd", var_7570a1bf222e764);

  function_fc57b4e33ab348a4(activityinstance, player);
}

function private function_23516e860dddbf1b(activityinstance, player) {
  votename = "ActivityVoteName_SquadAbandonVote";
  votes = function_f90897ff85a28f1a(activityinstance, player);
  var_9cc718b114d4f1f = function_37ffb7a5350616ca(player);
  var_67254a043c6e16a2 = function_7bd0928341049890(activityinstance, votename, votes, var_9cc718b114d4f1f, player);
  function_735ee8e9d0f1b00b(activityinstance, "VoterLeft", var_67254a043c6e16a2);

  function_a03ac72779102a0d(activityinstance, player);
}

function private function_30b211b56a55ca0b(activityinstance, player) {
  votename = "ActivityVoteName_SquadAbandonVote";
  votes = function_f90897ff85a28f1a(activityinstance, player);
  var_9cc718b114d4f1f = function_37ffb7a5350616ca(player);
  var_4cde85e68dd32e22 = function_8873bece95ecf770(activityinstance, votename, votes, var_9cc718b114d4f1f, player);
  function_735ee8e9d0f1b00b(activityinstance, "VoterJoined", var_4cde85e68dd32e22);

  function_3408f40ca8f1c14d(activityinstance, player);
}

function private function_6ebc53f792333cf5(activityinstance, player) {
  if(!isDefined(activityinstance)) {
    println("<dev string:x241>");
    return false;
  }

  if(!isDefined(player)) {
    assertmsg("<dev string:x2b7>");
    return false;
  }

  if(!isDefined(function_2ff949964e3aa834(player))) {
    assertmsg("<dev string:x2e8>");
    return false;
  }

  return true;
}

function private function_6a99c0e5fb21729c(activityinstance) {
  if(isDefined(activityinstance) && !isDefined(activityinstance.var_ced013ef63e76a7b)) {
    activityinstance.var_ced013ef63e76a7b = [];
  }
}

function private function_abaa57eec7d4c532(activityinstance, player) {
  squadid = function_2ff949964e3aa834(player);
  var_4dedd7975d526b67 = function_f90897ff85a28f1a(activityinstance, player);
  activityinstance.var_ced013ef63e76a7b[squadid] = function_8f9a51144ea9439(var_4dedd7975d526b67, player);
}

function private function_55038a5fbb28f66c(activityinstance, player, isplayerleavingvote) {
  if(!isDefined(isplayerleavingvote)) {
    isplayerleavingvote = 0;
  }

  voteresult = function_2a87b98d1f58ddbc(activityinstance, player, isplayerleavingvote);

  if(voteresult == "ActivityVoteResult_Success") {
    function_bbbdd2dc3be2f04d(activityinstance, player, "ActivityVoteResult_Success");
    function_a68f6703c78f0051(activityinstance, player);
    function_cfc0a56c1b2b3bd8(activityinstance, player);
  } else if(voteresult == "ActivityVoteResult_Cancelled") {
    function_2086dfaf421ea734(activityinstance, player);
  }

  return voteresult;
}

function private function_2a87b98d1f58ddbc(activityinstance, player, isplayerleavingvote) {
  if(!isDefined(isplayerleavingvote)) {
    isplayerleavingvote = 0;
  }

  if(function_16e0486e6ff0b40f(activityinstance, player)) {
    return "ActivityVoteResult_Success";
  }

  if(function_effade86a709128b(activityinstance, player, isplayerleavingvote)) {
    return "ActivityVoteResult_Cancelled";
  }

  return "ActivityVoteResult_InProgress";
}

function private function_f90897ff85a28f1a(activityinstance, player) {
  squadid = function_2ff949964e3aa834(player);
  return default_to(activityinstance.var_ced013ef63e76a7b[squadid], []);
}

function private function_a68f6703c78f0051(activityinstance, player) {
  if(!isDefined(activityinstance.var_ced013ef63e76a7b)) {
    function_6a99c0e5fb21729c(activityinstance);
  }

  squadid = function_2ff949964e3aa834(player);
  activityinstance.var_ced013ef63e76a7b[squadid] = undefined;
}

function private function_e9433db9d33e1279(activityinstance, player) {
  var_685116b63258d4a8 = function_f90897ff85a28f1a(activityinstance, player);
  return array_contains(var_685116b63258d4a8, player);
}

function private function_16e0486e6ff0b40f(activityinstance, player) {
  var_a2464c9946830d54 = function_287b76a301747f8b(activityinstance, player);
  squadmates = function_37ffb7a5350616ca(player);
  var_be9b3cf0ecae71c3 = function_5a840337aed72780(activityinstance, squadmates.size);
  return var_a2464c9946830d54 >= var_be9b3cf0ecae71c3;
}

function private function_effade86a709128b(activityinstance, player, isplayerleavingvote) {
  if(!isDefined(isplayerleavingvote)) {
    isplayerleavingvote = 0;
  }

  votes = function_1b00dbbd01a915b0(activityinstance, player);

  if(isplayerleavingvote) {
    votes = array_remove(votes, player);
  }

  return votes.size == 0;
}

function private function_287b76a301747f8b(activityinstance, player) {
  return function_1b00dbbd01a915b0(activityinstance, player).size;
}

function private function_1b00dbbd01a915b0(activityinstance, player) {
  var_a106a7879b77cf82 = function_f90897ff85a28f1a(activityinstance, player);
  squadmates = function_37ffb7a5350616ca(player);
  return function_50eabc100130bc0d(var_a106a7879b77cf82, squadmates);
}

function private function_37ffb7a5350616ca(player) {
  if(isDefined(level.var_6acae859049cee46)) {
    return level.var_6acae859049cee46[player.team][player.sessionsquadid].players;
  }

  return scripts\mp\utility\teams::getsquadmates(player.team, player.sessionsquadid, 1);
}

function private function_2ff949964e3aa834(player) {
  return player.sessionsquadid;
}

function private function_8f9a51144ea9439(votes, voter) {
  return function_6d6af8144a5131f1(votes, voter);
}

function private function_50eabc100130bc0d(votes, var_9cc718b114d4f1f) {
  if(!isDefined(votes)) {
    assertmsg("<dev string:x358>");
    return [];
  }

  if(!isDefined(var_9cc718b114d4f1f)) {
    assertmsg("<dev string:x384>");
    return [];
  }

  return array_intersection(votes, var_9cc718b114d4f1f);
}

function private function_2161d9e590b59c26(votes, var_9cc718b114d4f1f) {
  return function_50eabc100130bc0d(votes, var_9cc718b114d4f1f).size;
}

function private function_d573f6bacfd88ce1(activityinstance, votename, votes, var_9cc718b114d4f1f) {
  var_829045d6a6fb2398 = spawnStruct();
  var_829045d6a6fb2398.activityinstance = default_to(activityinstance, undefined);
  var_829045d6a6fb2398.votename = default_to(votename, undefined);
  var_829045d6a6fb2398.votes = function_50eabc100130bc0d(votes, var_9cc718b114d4f1f);
  var_829045d6a6fb2398.var_9cc718b114d4f1f = default_to(var_9cc718b114d4f1f, []);
  return var_829045d6a6fb2398;
}

function private function_355cd23c6cbf8dda(activityinstance, votename, votes, var_9cc718b114d4f1f, voter, var_606f34fc1ead5c7a) {
  var_8a524fffb1608986 = function_d573f6bacfd88ce1(activityinstance, votename, votes, var_9cc718b114d4f1f);
  var_8a524fffb1608986.voter = default_to(voter, undefined);
  var_8a524fffb1608986.var_606f34fc1ead5c7a = default_to(var_606f34fc1ead5c7a, undefined);
  return var_8a524fffb1608986;
}

function private function_53a3019fd9a570ee(activityinstance, votename, votes, var_9cc718b114d4f1f, voteresult) {
  var_1b80ce1214a34892 = function_d573f6bacfd88ce1(activityinstance, votename, votes, var_9cc718b114d4f1f);
  var_1b80ce1214a34892.voteresult = default_to(voteresult, undefined);
  return var_1b80ce1214a34892;
}

function private function_7bd0928341049890(activityinstance, votename, votes, var_9cc718b114d4f1f, var_221836e6a7cb1ba2) {
  var_77b0135065515fcc = function_d573f6bacfd88ce1(activityinstance, votename, votes, var_9cc718b114d4f1f);
  var_77b0135065515fcc.var_221836e6a7cb1ba2 = var_221836e6a7cb1ba2;
  return var_77b0135065515fcc;
}

function private function_8873bece95ecf770(activityinstance, votename, votes, var_9cc718b114d4f1f, var_335006ae8b51467a) {
  var_21e6bf5f655206fc = function_d573f6bacfd88ce1(activityinstance, votename, votes, var_9cc718b114d4f1f);
  var_21e6bf5f655206fc.var_335006ae8b51467a = var_335006ae8b51467a;
  return var_21e6bf5f655206fc;
}

function private function_26b72cfbd71e82f(activityinstance, player) {
  squadmates = function_37ffb7a5350616ca(player);
  var_45a14dd1749cb60c = function_287b76a301747f8b(activityinstance, player);
  println("<dev string:x3b4>" + "<dev string:x3d9>" + function_de53ed8e35d0ed7a(activityinstance) + "<dev string:x3f1>" + function_a4748b32a824c79c(activityinstance) + "<dev string:x401>" + var_45a14dd1749cb60c + "<dev string:x411>" + squadmates.size + "<dev string:x422>");
}

function private function_fc57b4e33ab348a4(activityinstance, player) {
  println("<dev string:x434>" + "<dev string:x3d9>" + function_de53ed8e35d0ed7a(activityinstance) + "<dev string:x3f1>" + function_a4748b32a824c79c(activityinstance) + "<dev string:x45f>" + player.sessionsquadid + "<dev string:x46b>");
}

function private function_a03ac72779102a0d(activityinstance, player) {
  squadmates = function_37ffb7a5350616ca(player);
  var_45a14dd1749cb60c = function_287b76a301747f8b(activityinstance, player);
  println("<dev string:x48a>" + "<dev string:x3d9>" + function_de53ed8e35d0ed7a(activityinstance) + "<dev string:x3f1>" + function_a4748b32a824c79c(activityinstance) + "<dev string:x401>" + var_45a14dd1749cb60c + "<dev string:x411>" + squadmates.size + "<dev string:x422>");
}

function private function_3408f40ca8f1c14d(activityinstance, player) {
  squadmates = function_37ffb7a5350616ca(player);
  var_45a14dd1749cb60c = function_287b76a301747f8b(activityinstance, player);
  println("<dev string:x4c6>" + "<dev string:x3d9>" + function_de53ed8e35d0ed7a(activityinstance) + "<dev string:x3f1>" + function_a4748b32a824c79c(activityinstance) + "<dev string:x401>" + var_45a14dd1749cb60c + "<dev string:x411>" + squadmates.size + "<dev string:x422>");
}

function function_781d567ca3db5852() {
  function_6e7290c8ee4f558b("<dev string:x500>");
  function_a9a864379a098ad6("<dev string:x526>", "<dev string:x54a>", &function_5f5e9bf7fe8e6eaf);
  function_a9a864379a098ad6("<dev string:x56f>", "<dev string:x59a>", &function_6017dcd09f997b8);
  function_fe953f000498048f();
  function_6e7290c8ee4f558b("<dev string:x5c2>");
  function_a9a864379a098ad6("<dev string:x5fd>", "<dev string:x616>", &function_d822738c9392a3a4);
  function_a9a864379a098ad6("<dev string:x62d>", "<dev string:x54a>", &function_5f5e9bf7fe8e6eaf);
  function_a9a864379a098ad6("<dev string:x658>", "<dev string:x68d>", &function_20715510ce25c247);
  function_a9a864379a098ad6("<dev string:x6bf>", "<dev string:x6f4>", &function_20715610ce25c47a);
  function_a9a864379a098ad6("<dev string:x726>", "<dev string:x75b>", &function_20715710ce25c6ad);
  function_a9a864379a098ad6("<dev string:x78d>", "<dev string:x7b2>", &function_3f8bf4c34fe29837);
  function_a9a864379a098ad6("<dev string:x7cc>", "<dev string:x7f1>", &function_3f8bf5c34fe29a6a);
  function_a9a864379a098ad6("<dev string:x80b>", "<dev string:x830>", &function_3f8bf6c34fe29c9d);
  function_a9a864379a098ad6("<dev string:x84a>", "<dev string:x874>", &function_602310868171d271);
  function_a9a864379a098ad6("<dev string:x88c>", "<dev string:x8b7>", &function_e30f9ce33ee435dc);
  function_fe953f000498048f();
  function_6e7290c8ee4f558b("<dev string:x8d0>");
  function_a9a864379a098ad6("<dev string:x90a>", "<dev string:x93f>", &_info);
  function_a9a864379a098ad6("<dev string:x62d>", "<dev string:x54a>", &function_5f5e9bf7fe8e6eaf);
  function_a9a864379a098ad6("<dev string:x948>", "<dev string:x974>", &function_da02cb35301e149c);
  function_a9a864379a098ad6("<dev string:x9a1>", "<dev string:x9cd>", &function_da02ce35301e1b35);
  function_a9a864379a098ad6("<dev string:x9fa>", "<dev string:xa26>", &function_da02cd35301e1902);
  function_fe953f000498048f();
}

function private _info() {
  return;
}

function private function_5f5e9bf7fe8e6eaf() {
  hostplayer = gethostplayer();

  if(isDefined(hostplayer) && isPlayer(hostplayer)) {
    function_60a8777312cc62d7(hostplayer);
  }
}

function private function_da02cb35301e149c() {
  player = level.players[1];

  if(isDefined(player)) {
    hostplayer = gethostplayer();
    var_9a57b22168b90b20 = function_deb5a4d2a7bda5e9(hostplayer);
    function_90edaba623c87c34(var_9a57b22168b90b20, player);
  }
}

function private function_da02ce35301e1b35() {
  player = level.players[2];

  if(isDefined(player)) {
    hostplayer = gethostplayer();
    var_9a57b22168b90b20 = function_deb5a4d2a7bda5e9(hostplayer);
    function_90edaba623c87c34(var_9a57b22168b90b20, player);
  }
}

function private function_da02cd35301e1902() {
  player = level.players[3];

  if(isDefined(player)) {
    hostplayer = gethostplayer();
    var_9a57b22168b90b20 = function_deb5a4d2a7bda5e9(hostplayer);
    function_90edaba623c87c34(var_9a57b22168b90b20, player);
  }
}

function private function_6017dcd09f997b8() {
  hostplayer = gethostplayer();

  if(isDefined(hostplayer) && isPlayer(hostplayer)) {
    var_9a57b22168b90b20 = function_deb5a4d2a7bda5e9(hostplayer);
    function_2086dfaf421ea734(var_9a57b22168b90b20, hostplayer);
    iprintlnbold("<dev string:xa53>");
  }
}

function private function_d822738c9392a3a4() {
  function_d03304e5566c46d(1);
  var_15aaab03bcacac6b = 3;

  for(i = 0; i < var_15aaab03bcacac6b; i++) {
    function_ad8674854251fb51();
  }

  iprintlnbold("<dev string:xa8d>" + var_15aaab03bcacac6b + "<dev string:xa97>");
}

function private function_d03304e5566c46d(force) {
  if(!isDefined(force)) {
    force = 0;
  }

  if(!force || isDefined(level.var_6acae859049cee46)) {
    return;
  }

  hostplayer = gethostplayer();
  level.var_6acae859049cee46 = [];
  level.var_6acae859049cee46[hostplayer.team] = [];
  level.var_6acae859049cee46[hostplayer.team][hostplayer.sessionsquadid] = spawnStruct();
  level.var_6acae859049cee46[hostplayer.team][hostplayer.sessionsquadid].players = [hostplayer];
}

function private function_ad8674854251fb51() {
  level.var_4f695def88a58b60 = default_to(level.var_4f695def88a58b60, 1);
  hostplayer = gethostplayer();
  fakeplayer = spawnStruct();
  fakeplayer.sessionsquadid = hostplayer.sessionsquadid;
  fakeplayer.team = hostplayer.team;
  fakeplayer.fakeid = level.var_4f695def88a58b60;
  players = level.var_6acae859049cee46[hostplayer.team][hostplayer.sessionsquadid].players;
  level.var_6acae859049cee46[hostplayer.team][hostplayer.sessionsquadid].players = array_add(players, fakeplayer);
  level.var_4f695def88a58b60++;
  return fakeplayer;
}

function private function_602310868171d271() {
  function_d03304e5566c46d();
  hostplayer = gethostplayer();
  fakeplayer = function_ad8674854251fb51();
  var_9a57b22168b90b20 = function_deb5a4d2a7bda5e9(hostplayer);
  function_df7f1a29325af528(var_9a57b22168b90b20, fakeplayer);
}

function private function_43f82d766b25b7b(var_254c3eaf98cbc328) {
  if(!isDefined(level.var_6acae859049cee46)) {
    return;
  }

  hostplayer = gethostplayer();

  if(!isDefined(hostplayer)) {
    return;
  }

  squadmember = level.var_6acae859049cee46[hostplayer.team][hostplayer.sessionsquadid].players[var_254c3eaf98cbc328];

  if(!isDefined(squadmember)) {
    return;
  }

  var_9a57b22168b90b20 = function_deb5a4d2a7bda5e9(hostplayer);
  function_90edaba623c87c34(var_9a57b22168b90b20, squadmember);
}

function private function_20715510ce25c247() {
  function_43f82d766b25b7b(1);
}

function private function_20715610ce25c47a() {
  function_43f82d766b25b7b(2);
}

function private function_20715710ce25c6ad() {
  function_43f82d766b25b7b(3);
}

function private function_e30f9ce33ee435dc(var_254c3eaf98cbc328) {
  if(!isDefined(level.var_6acae859049cee46)) {
    return;
  }

  hostplayer = gethostplayer();

  if(!isDefined(hostplayer)) {
    return;
  }

  var_254c3eaf98cbc328 = default_to(var_254c3eaf98cbc328, level.var_6acae859049cee46[hostplayer.team][hostplayer.sessionsquadid].players.size - 1);
  squadmember = level.var_6acae859049cee46[hostplayer.team][hostplayer.sessionsquadid].players[var_254c3eaf98cbc328];

  if(!isDefined(squadmember) || squadmember == hostplayer) {
    return;
  }

  var_9a57b22168b90b20 = function_deb5a4d2a7bda5e9(hostplayer);
  function_c9afc8e2fd64917(var_9a57b22168b90b20, squadmember);
  players = level.var_6acae859049cee46[hostplayer.team][hostplayer.sessionsquadid].players;
  level.var_6acae859049cee46[hostplayer.team][hostplayer.sessionsquadid].players = array_remove(players, squadmember);
}

function private function_3f8bf4c34fe29837() {
  function_e30f9ce33ee435dc(1);
}

function private function_3f8bf5c34fe29a6a() {
  function_e30f9ce33ee435dc(2);
}

function private function_3f8bf6c34fe29c9d() {
  function_e30f9ce33ee435dc(3);
}

# /