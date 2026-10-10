/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_655983f8cdbe29a9.gsc
*************************************************/

#using script_185660037b9236c1;
#using script_2342b8aad723994e;
#using script_2707474774db34b;
#using script_3ab210ea917601e7;
#using script_41387eecc35b88bf;
#using script_4386d9962a41afc1;
#using script_64351208cb856df9;
#using scripts\common\data_tracker;
#using scripts\engine\utility;
#using scripts\mp\utility\lui_game_event_aggregator;
#namespace namespace_2554c2c2cdfe946a;

function function_6a7daea470efc1d9() {
  function_8b5b2a3392fc7e2a("VoteCast", &function_eb603ecd0264ebff);
  function_8b5b2a3392fc7e2a("VoteEnd", &function_67cfb9f49c173a55);
  function_8b5b2a3392fc7e2a("VoterLeft", &function_fc0c08e86e69f523);
  function_8b5b2a3392fc7e2a("VoterJoined", &function_a04e24f1e02f64a3);
  function_8b5b2a3392fc7e2a("PlayerJoin", &function_364921384956c883);
  function_8b5b2a3392fc7e2a("PlayerLeave", &function_74463513226ae6d8);
  level thread function_926d53d0ef3b934f();
}

function private function_926d53d0ef3b934f() {
  waittillframeend();
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&function_f13d5e60313341a2);
  namespace_c31609f90efcf2ca::function_a99987c7bf114da4(&function_c6c8135d5098c8bd);
}

function function_f13d5e60313341a2(notification, value) {
  var_a358a73419e73edc = self;

  if(isDefined(notification)) {
    switch (notification) {
      case #"hash_9fd64c8b171158f":
        function_60a8777312cc62d7(var_a358a73419e73edc);
        break;
    }
  }
}

function function_83d789bbe0f2a395(var_6f8af5eb76deac21) {
  assertex(isDefined(var_6f8af5eb76deac21), "<dev string:x1c>");
  return int(floor(var_6f8af5eb76deac21.var_6128c35fcd588a91 / 2)) + 1;
}

function function_eb603ecd0264ebff(var_119d717380769cab) {
  votename = var_119d717380769cab.votename;
  activityinstance = var_119d717380769cab.activityinstance;

  if(votename == "ActivityVoteName_SquadAbandonVote") {
    activitycategory = namespace_68dc261109a9503f::function_511be8bcaede8b52(activityinstance);

    if(activitycategory == "Contract") {
      function_cfe3ee6afa35b1ed(var_119d717380769cab);
    } else {
      println("<dev string:x75>");
    }

    return;
  }

  assertmsg("<dev string:xc8>" + default_to(votename, "<dev string:xdf>") + "<dev string:xec>");
}

function function_67cfb9f49c173a55(var_e3debb20afae825d) {
  votename = var_e3debb20afae825d.votename;
  activityinstance = var_e3debb20afae825d.activityinstance;
  println("<dev string:x100>" + votename);
  activitycategory = namespace_68dc261109a9503f::function_511be8bcaede8b52(activityinstance);

  if(votename == "ActivityVoteName_SquadAbandonVote") {
    if(activitycategory == "Contract") {
      function_35b527a921bdf073(var_e3debb20afae825d);
    } else {
      println("<dev string:x75>");
    }

    return;
  }

  assertmsg("<dev string:xc8>" + default_to(votename, "<dev string:xdf>") + "<dev string:xec>");
}

function function_fc0c08e86e69f523(var_ddfe971f6eba42f7) {
  votename = var_ddfe971f6eba42f7.votename;
  activityinstance = var_ddfe971f6eba42f7.activityinstance;
  activitycategory = namespace_68dc261109a9503f::function_511be8bcaede8b52(activityinstance);

  if(votename == "ActivityVoteName_SquadAbandonVote") {
    if(activitycategory == "Contract") {
      function_eb665b5004d1fee1(var_ddfe971f6eba42f7);
    } else {
      println("<dev string:x75>");
    }

    return;
  }

  assertmsg("<dev string:xc8>" + default_to(votename, "<dev string:xdf>") + "<dev string:xec>");
}

function function_a04e24f1e02f64a3(var_d07fa562a0968e77) {
  votename = var_d07fa562a0968e77.votename;
  activityinstance = var_d07fa562a0968e77.activityinstance;
  activitycategory = namespace_68dc261109a9503f::function_511be8bcaede8b52(activityinstance);

  if(votename == "ActivityVoteName_SquadAbandonVote") {
    if(activitycategory == "Contract") {
      function_ac52181dfb097d61(var_d07fa562a0968e77);
    } else {
      println("<dev string:x75>");
    }

    return;
  }

  assertmsg("<dev string:xc8>" + default_to(votename, "<dev string:xdf>") + "<dev string:xec>");
}

function function_cfe3ee6afa35b1ed(var_119d717380769cab) {
  var_a106a7879b77cf82 = var_119d717380769cab.votes;
  squadmates = var_119d717380769cab.var_9cc718b114d4f1f;
  var_606f34fc1ead5c7a = var_119d717380769cab.var_606f34fc1ead5c7a;
  activityinstance = var_119d717380769cab.activityinstance;

  if(var_606f34fc1ead5c7a) {
    return;
  }

  var_ebbf760b3a1c31c8 = function_6cd86b4ad51f706f(squadmates);
  var_981d063c4d4f4efd = array_difference(var_ebbf760b3a1c31c8, var_a106a7879b77cf82);
  var_be9b3cf0ecae71c3 = function_5a840337aed72780(activityinstance, squadmates.size);
  function_bc0f3d487294cad5(var_981d063c4d4f4efd, activityinstance);
  function_c31a48687806ff04(var_ebbf760b3a1c31c8, activityinstance, var_a106a7879b77cf82.size, var_be9b3cf0ecae71c3);
  function_b80a437fe56905e(var_ebbf760b3a1c31c8, var_a106a7879b77cf82, var_be9b3cf0ecae71c3);
}

function function_35b527a921bdf073(var_e3debb20afae825d) {
  squadmates = var_e3debb20afae825d.var_9cc718b114d4f1f;
  voteresult = var_e3debb20afae825d.voteresult;
  var_ebbf760b3a1c31c8 = function_6cd86b4ad51f706f(squadmates);
  function_dfbfdbfaf2d22009(var_ebbf760b3a1c31c8);

  if(voteresult == "ActivityVoteResult_Success") {
    return;
  }

  if(voteresult == "ActivityVoteResult_Cancelled") {
    println("<dev string:x12e>");
  }
}

function function_eb665b5004d1fee1(var_ddfe971f6eba42f7) {
  var_a106a7879b77cf82 = var_ddfe971f6eba42f7.votes;
  squadmates = var_ddfe971f6eba42f7.var_9cc718b114d4f1f;
  var_221836e6a7cb1ba2 = var_ddfe971f6eba42f7.var_221836e6a7cb1ba2;
  var_f1a1a53b821f7add = array_remove(var_a106a7879b77cf82, var_221836e6a7cb1ba2);
  var_8dd686fbe6c35ee8 = array_remove(squadmates, var_221836e6a7cb1ba2);
  var_21a979337d190aff = function_6cd86b4ad51f706f(var_8dd686fbe6c35ee8);
  var_be9b3cf0ecae71c3 = function_5a840337aed72780(var_ddfe971f6eba42f7.activityinstance, var_8dd686fbe6c35ee8.size);
  function_b80a437fe56905e(var_21a979337d190aff, var_f1a1a53b821f7add, var_be9b3cf0ecae71c3);
}

function function_ac52181dfb097d61(var_d07fa562a0968e77) {
  var_a106a7879b77cf82 = var_d07fa562a0968e77.votes;
  squadmates = var_d07fa562a0968e77.var_9cc718b114d4f1f;
  var_335006ae8b51467a = var_d07fa562a0968e77.var_335006ae8b51467a;
  var_5016114507a764ee = function_6d6af8144a5131f1(squadmates, var_335006ae8b51467a);
  var_e012c70db5c8944b = function_6cd86b4ad51f706f(var_5016114507a764ee);
  var_be9b3cf0ecae71c3 = function_5a840337aed72780(var_d07fa562a0968e77.activityinstance, var_5016114507a764ee.size);
  function_b80a437fe56905e(var_e012c70db5c8944b, var_a106a7879b77cf82, var_be9b3cf0ecae71c3);
}

function function_c31a48687806ff04(players, activityinstance, votecount, var_3cfd3771899bec37) {
  var_d9505959b1887327 = votecount | var_3cfd3771899bec37 << 3;
  function_9e5dd3840e95f4a3(activityinstance, "abandon_vote_pending_cancellation_state", var_d9505959b1887327);
  activityinstance namespace_a93e7904fe28c5c4::function_1281c7fff9456e18("abandon_vote_pending_splash", players);
}

function function_bc0f3d487294cad5(players, activityinstance) {
  activityinstance namespace_a93e7904fe28c5c4::function_1281c7fff9456e18("abandon_vote_pending_vo", players);
}

function function_b80a437fe56905e(players, playersvoted, var_3cfd3771899bec37) {
  var_d9505959b1887327 = playersvoted.size | var_3cfd3771899bec37 << 3;

  foreach(player in players) {
    var_9aa013e99f8613fa = var_d9505959b1887327;

    foreach(voter in playersvoted) {
      if(player.clientid == voter.clientid) {
        var_9aa013e99f8613fa |= 64;
        break;
      }
    }

    player setclientomnvar("ui_br_contract_cancellation_state", var_9aa013e99f8613fa);
  }
}

function function_dfbfdbfaf2d22009(players) {
  foreach(player in players) {
    player setclientomnvar("ui_br_contract_cancellation_state", 0);
  }
}

function private function_c6c8135d5098c8bd(player) {
  focusedactivity = function_deb5a4d2a7bda5e9(player);
  function_c9afc8e2fd64917(focusedactivity, player);
}

function private function_74463513226ae6d8(var_6f8af5eb76deac21) {
  foreach(player in var_6f8af5eb76deac21.playerlist) {
    function_c9afc8e2fd64917(self, player);
  }
}

function private function_364921384956c883(var_6f8af5eb76deac21) {
  foreach(player in var_6f8af5eb76deac21.playerlist) {
    function_df7f1a29325af528(self, player);
  }
}

function private function_9e5dd3840e95f4a3(activityinstance, var_6c8dd7ef593a9ecc, dataint) {
  if(activityinstance data_tracker::function_6a26856f16c6a207(var_6c8dd7ef593a9ecc)) {
    activityinstance data_tracker::updatedata(var_6c8dd7ef593a9ecc, dataint);
    return;
  }

  activityinstance data_tracker::function_b584ae8dddb33821(var_6c8dd7ef593a9ecc, dataint);
}

function private function_6cd86b4ad51f706f(squadmates) {
  var_ebbf760b3a1c31c8 = [];

  foreach(squadmate in squadmates) {
    if(isPlayer(squadmate) && !isbot(squadmate)) {
      var_ebbf760b3a1c31c8[var_ebbf760b3a1c31c8.size] = squadmate;
    }
  }

  return var_ebbf760b3a1c31c8;
}