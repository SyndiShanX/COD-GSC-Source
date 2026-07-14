/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_1ddfc951cf926b09.gsc
*****************************************************/

#using script_157e7fec25404847;
#using script_1aae2eb1ef28b239;
#using script_31805e8ef07bfa53;
#using script_50cece4fabbdcc75;
#using script_69192f0994851b83;
#using scripts\common\devgui;
#using scripts\engine\utility;
#namespace activity_voting;

function function_fe743354b955ecce(player) {
  if(!isDefined(player)) {
    assertmsg("<dev string:x24>");
    return;
  }

  focusedactivity = namespace_37b952684c0bbb5::function_bfa2d92c8914b8e8(player);

  if(!isDefined(focusedactivity)) {
    println("<dev string:x67>" + "<dev string:xc7>" + "<dev string:x11d>");
    return;
  }

  function_43ce254d78ce0541(focusedactivity, player);
}

function function_43ce254d78ce0541(activityinstance, player) {
  if(!function_3132d4079d56b2c8(activityinstance, player)) {
    return;
  }

  function_30643c44505bfbd1(activityinstance);

  if(function_97e1eb0c360405c0(activityinstance, player)) {
    println("<dev string:x138>");
    return;
  }

  function_c619a7d55647ba27(activityinstance, player);
  var_30ee16771492dae3 = function_cb6bd2591c05ffee(activityinstance, player);
  function_1525c61d9c81863e(activityinstance, player, var_30ee16771492dae3);
  function_4be34ca53898be45(activityinstance, player);
}

function function_ac666ae2ca5c08a2(activityinstance, player) {
  if(!function_3132d4079d56b2c8(activityinstance, player)) {
    return;
  }

  function_30643c44505bfbd1(activityinstance);

  if(function_e9ebeaa7222efc4f(activityinstance, player)) {
    function_38a71171ff3de8fe(activityinstance, player);
    function_c619a7d55647ba27(activityinstance, player);
    function_4be34ca53898be45(activityinstance, player, 1);
  }
}

function function_5063077487bc1661(activityinstance, player) {
  if(!function_3132d4079d56b2c8(activityinstance, player)) {
    return;
  }

  function_30643c44505bfbd1(activityinstance);

  if(function_e9ebeaa7222efc4f(activityinstance, player)) {
    function_ee6788a01f7db17e(activityinstance, player);
  }
}

function function_345916ac13233fc9(activityinstance, player) {
  if(!isDefined(activityinstance)) {
    println("<dev string:x1a1>");
    return;
  }

  function_12580b6117b369a0(activityinstance, player);
  function_a91812a905a81f40(activityinstance, player, "(\x1b\xd1\xb4v\xb4\xd1\xe5+\xb7\x8eYR\xacs\xea\xc6:_\x1a,n\xc6\xcacced");
}

function function_e9ebeaa7222efc4f(activityinstance, player) {
  if(!(isDefined(activityinstance) && isDefined(activityinstance.var_87fd05c3c5ab8632))) {
    return false;
  }

  return function_7bd6eb17262aa705(activityinstance, player) == "\x1c\x99'\xa4\x8b'5[\xf5k\ao\xce\x858uE5p\xc8z[\x11g\xa7I?\x01\x88";
}

function function_3068bcfe15a7afa9(activityinstance, votingpoolsize) {
  relevantinfostruct = spawnStruct();
  relevantinfostruct.votingpoolsize = votingpoolsize;
  return activity_common::runactivityfunction(activityinstance, 8, relevantinfostruct);
}

function function_3fc86bc28875b7a9(relevantinfostruct) {
  assert(isDefined(relevantinfostruct), "<dev string:x1ec>");
  return relevantinfostruct.votingpoolsize;
}

function private function_1525c61d9c81863e(activityinstance, player, var_30ee16771492dae3) {
  votename = "\xd5\"\xd2\xae\xe2\n\x1c\x195\x82\xd3\xd5^Y\xcf[&\xc5\xe1\x94Q$O]\x1au{y\xb6\xbf\xda\t\xac";
  votes = function_4f25b39d7e098edf(activityinstance, player);
  voterpool = function_3ddcce55295f7107(activityinstance, player);
  var_533265a3fe429ed7 = function_ca638a7cf758e83(activityinstance, votename, votes, voterpool, player, var_30ee16771492dae3);
  namespace_59dbf6a1bb28a43f::announceactivitymoment(activityinstance, "\x9fr\xd4\xc0,\xe68H", var_533265a3fe429ed7);

  function_ed6b988e1bdf1fde(activityinstance, player);
}

function private function_a91812a905a81f40(activityinstance, player, voteresult) {
  votename = "\xd5\"\xd2\xae\xe2\n\x1c\x195\x82\xd3\xd5^Y\xcf[&\xc5\xe1\x94Q$O]\x1au{y\xb6\xbf\xda\t\xac";
  votes = function_4f25b39d7e098edf(activityinstance, player);
  voterpool = function_3ddcce55295f7107(activityinstance, player);
  var_7345cf318f515611 = function_8e0945987a8c8657(activityinstance, votename, votes, voterpool, voteresult);
  namespace_59dbf6a1bb28a43f::announceactivitymoment(activityinstance, "\x94\xa1s\xc4\xd4\x12?", var_7345cf318f515611);

  function_cb4a0eae3110eb5(activityinstance, player);
}

function private function_38a71171ff3de8fe(activityinstance, player) {
  votename = "\xd5\"\xd2\xae\xe2\n\x1c\x195\x82\xd3\xd5^Y\xcf[&\xc5\xe1\x94Q$O]\x1au{y\xb6\xbf\xda\t\xac";
  votes = function_4f25b39d7e098edf(activityinstance, player);
  voterpool = function_3ddcce55295f7107(activityinstance, player);
  var_46ac8f852f5386d7 = function_3a3e1527efbff951(activityinstance, votename, votes, voterpool, player);
  namespace_59dbf6a1bb28a43f::announceactivitymoment(activityinstance, "\xc9\xed\xf6\b\xba8\xbc\xc6g", var_46ac8f852f5386d7);

  function_fd8480985e4208dc(activityinstance, player);
}

function private function_ee6788a01f7db17e(activityinstance, player) {
  votename = "\xd5\"\xd2\xae\xe2\n\x1c\x195\x82\xd3\xd5^Y\xcf[&\xc5\xe1\x94Q$O]\x1au{y\xb6\xbf\xda\t\xac";
  votes = function_4f25b39d7e098edf(activityinstance, player);
  voterpool = function_3ddcce55295f7107(activityinstance, player);
  var_9127d99f00378797 = function_ea92fd3e14578329(activityinstance, votename, votes, voterpool, player);
  namespace_59dbf6a1bb28a43f::announceactivitymoment(activityinstance, "\xb5\xcc\xa0\x94|\x11\xbfcm\xabL", var_9127d99f00378797);

  function_baa338ff8af9f55c(activityinstance, player);
}

function private function_3132d4079d56b2c8(activityinstance, player) {
  if(!isDefined(activityinstance)) {
    println("<dev string:x249>");
    return false;
  }

  if(!isDefined(player)) {
    assertmsg("<dev string:x2bf>");
    return false;
  }

  if(!isDefined(function_aabc3de641b36215(player))) {
    assertmsg("<dev string:x2f0>");
    return false;
  }

  return true;
}

function private function_30643c44505bfbd1(activityinstance) {
  if(isDefined(activityinstance) && !isDefined(activityinstance.var_87fd05c3c5ab8632)) {
    activityinstance.var_87fd05c3c5ab8632 = [];
  }
}

function private function_c619a7d55647ba27(activityinstance, player) {
  squadid = function_aabc3de641b36215(player);
  abandonvotes = function_4f25b39d7e098edf(activityinstance, player);
  activityinstance.var_87fd05c3c5ab8632[squadid] = function_681485737125d4a8(abandonvotes, player);
}

function private function_4be34ca53898be45(activityinstance, player, isplayerleavingvote = 0) {
  voteresult = function_7bd6eb17262aa705(activityinstance, player, isplayerleavingvote);

  if(voteresult == "\x0f\xc4\xb0\x1e_C\xb6\x03\x99\x03\xa2R\x05\x8b\x0e\xe5w.\xd8b\x18\xaf\xec?\x9c\xfc") {
    function_a91812a905a81f40(activityinstance, player, "\x0f\xc4\xb0\x1e_C\xb6\x03\x99\x03\xa2R\x05\x8b\x0e\xe5w.\xd8b\x18\xaf\xec?\x9c\xfc");
    function_12580b6117b369a0(activityinstance, player);
    activity_participation::function_8ef13db61a93e631(activityinstance, player);
  } else if(voteresult == "(\x1b\xd1\xb4v\xb4\xd1\xe5+\xb7\x8eYR\xacs\xea\xc6:_\x1a,n\xc6\xcacced") {
    function_345916ac13233fc9(activityinstance, player);
  }

  return voteresult;
}

function private function_7bd6eb17262aa705(activityinstance, player, isplayerleavingvote = 0) {
  if(function_cb6bd2591c05ffee(activityinstance, player)) {
    return "\x0f\xc4\xb0\x1e_C\xb6\x03\x99\x03\xa2R\x05\x8b\x0e\xe5w.\xd8b\x18\xaf\xec?\x9c\xfc";
  }

  if(function_13fe67f4da0580a6(activityinstance, player, isplayerleavingvote)) {
    return "(\x1b\xd1\xb4v\xb4\xd1\xe5+\xb7\x8eYR\xacs\xea\xc6:_\x1a,n\xc6\xcacced";
  }

  return "\x1c\x99'\xa4\x8b'5[\xf5k\ao\xce\x858uE5p\xc8z[\x11g\xa7I?\x01\x88";
}

function private function_4f25b39d7e098edf(activityinstance, player) {
  squadid = function_aabc3de641b36215(player);
  return activityinstance.var_87fd05c3c5ab8632[squadid] ?? [];
}

function private function_12580b6117b369a0(activityinstance, player) {
  if(!isDefined(activityinstance.var_87fd05c3c5ab8632)) {
    function_30643c44505bfbd1(activityinstance);
  }

  squadid = function_aabc3de641b36215(player);
  activityinstance.var_87fd05c3c5ab8632[squadid] = undefined;
}

function private function_97e1eb0c360405c0(activityinstance, player) {
  var_93498c7441748e45 = function_4f25b39d7e098edf(activityinstance, player);
  return arraycontains(var_93498c7441748e45, player);
}

function private function_cb6bd2591c05ffee(activityinstance, player) {
  squadvotecount = function_97bed0d3c2538732(activityinstance, player);
  squadmates = function_3ddcce55295f7107(activityinstance, player);
  return squadvotecount == squadmates.size;
}

function private function_13fe67f4da0580a6(activityinstance, player, isplayerleavingvote = 0) {
  votes = function_e2e2b64d1cd36fc9(activityinstance, player);

  if(isplayerleavingvote) {
    votes = arrayremove(votes, player);
  }

  return votes.size == 0;
}

function private function_97bed0d3c2538732(activityinstance, player) {
  return function_e2e2b64d1cd36fc9(activityinstance, player).size;
}

function private function_e2e2b64d1cd36fc9(activityinstance, player) {
  squadvotes = function_4f25b39d7e098edf(activityinstance, player);
  squadmates = function_3ddcce55295f7107(activityinstance, player);
  return function_a79c08ef60dd5c04(squadvotes, squadmates);
}

function private function_3ddcce55295f7107(activityinstance, player) {
  if(isDefined(level.var_fc65ce2bb093f433)) {
    return level.var_fc65ce2bb093f433[player.team][player.sessionsquadid].players;
  }

  return namespace_37b952684c0bbb5::function_e8bf648cc92f890a(player);
}

function private function_aabc3de641b36215(player) {
  return player.sessionsquadid;
}

function private function_681485737125d4a8(votes, voter) {
  return utility::function_e86d2ca144f6bde8(votes, voter);
}

function private function_a79c08ef60dd5c04(votes, voterpool) {
  if(!isDefined(votes)) {
    assertmsg("<dev string:x360>");
    return [];
  }

  if(!isDefined(voterpool)) {
    assertmsg("<dev string:x38c>");
    return [];
  }

  return utility::array_intersection(votes, voterpool);
}

function private function_f6cb9a84e150639f(votes, voterpool) {
  return function_a79c08ef60dd5c04(votes, voterpool).size;
}

function private function_4aae86bc874d34d0(activityinstance, votename, votes, voterpool) {
  var_634c49679e1dc759 = spawnStruct();
  var_634c49679e1dc759.activityinstance = activityinstance ?? undefined;
  var_634c49679e1dc759.votename = votename ?? undefined;
  var_634c49679e1dc759.votes = function_a79c08ef60dd5c04(votes, voterpool);
  var_634c49679e1dc759.voterpool = voterpool ?? [];
  return var_634c49679e1dc759;
}

function private function_ca638a7cf758e83(activityinstance, votename, votes, voterpool, voter, var_30ee16771492dae3) {
  var_5da12b1587a94ab = function_4aae86bc874d34d0(activityinstance, votename, votes, voterpool);
  var_5da12b1587a94ab.voter = voter ?? undefined;
  var_5da12b1587a94ab.var_30ee16771492dae3 = var_30ee16771492dae3 ?? undefined;
  return var_5da12b1587a94ab;
}

function private function_8e0945987a8c8657(activityinstance, votename, votes, voterpool, voteresult) {
  var_ff2fe2a2a87263bf = function_4aae86bc874d34d0(activityinstance, votename, votes, voterpool);
  var_ff2fe2a2a87263bf.voteresult = voteresult ?? undefined;
  return var_ff2fe2a2a87263bf;
}

function private function_3a3e1527efbff951(activityinstance, votename, votes, voterpool, var_eb28b23c736683cb) {
  var_d92e657cfaadc919 = function_4aae86bc874d34d0(activityinstance, votename, votes, voterpool);
  var_d92e657cfaadc919.var_eb28b23c736683cb = var_eb28b23c736683cb;
  return var_d92e657cfaadc919;
}

function private function_ea92fd3e14578329(activityinstance, votename, votes, voterpool, var_c4c9eeb3ebfafeab) {
  var_6531b11ed63266a1 = function_4aae86bc874d34d0(activityinstance, votename, votes, voterpool);
  var_6531b11ed63266a1.var_c4c9eeb3ebfafeab = var_c4c9eeb3ebfafeab;
  return var_6531b11ed63266a1;
}

function private function_ed6b988e1bdf1fde(activityinstance, player) {
  squadmates = function_3ddcce55295f7107(activityinstance, player);
  numvotes = function_97bed0d3c2538732(activityinstance, player);
  println("<dev string:x3bc>" + "<dev string:x3e1>" + activityinstance.type + "<dev string:x3f9>" + activityinstance.varianttag + "<dev string:x409>" + numvotes + "<dev string:x419>" + squadmates.size + "<dev string:x42a>");
}

function private function_cb4a0eae3110eb5(activityinstance, player) {
  println("<dev string:x43c>" + "<dev string:x3e1>" + activityinstance.type + "<dev string:x3f9>" + activityinstance.varianttag + "<dev string:x467>" + player.sessionsquadid + "<dev string:x473>");
}

function private function_fd8480985e4208dc(activityinstance, player) {
  squadmates = function_3ddcce55295f7107(activityinstance, player);
  numvotes = function_97bed0d3c2538732(activityinstance, player);
  println("<dev string:x492>" + "<dev string:x3e1>" + activityinstance.type + "<dev string:x3f9>" + activityinstance.varianttag + "<dev string:x409>" + numvotes + "<dev string:x419>" + squadmates.size + "<dev string:x42a>");
}

function private function_baa338ff8af9f55c(activityinstance, player) {
  squadmates = function_3ddcce55295f7107(activityinstance, player);
  numvotes = function_97bed0d3c2538732(activityinstance, player);
  println("<dev string:x4ce>" + "<dev string:x3e1>" + activityinstance.type + "<dev string:x3f9>" + activityinstance.varianttag + "<dev string:x409>" + numvotes + "<dev string:x419>" + squadmates.size + "<dev string:x42a>");
}

function function_1d9b99487de8b3ab() {
  var_dbcd872624d6de5f = namespace_265c578c971c82f5::function_7a5a72c9a4717349();
  devgui::function_fc97f67ff432e7de(var_dbcd872624d6de5f + "<dev string:x508>");
  devgui::function_ddef1d43d4e5ef07("<dev string:x52e>", "<dev string:x552>", &function_e0567e4dedf01afe);
  devgui::function_ddef1d43d4e5ef07("<dev string:x577>", "<dev string:x5a2>", &function_86961d9c24d62c59);
  devgui::function_9c2be2438708a992();
  devgui::function_fc97f67ff432e7de(var_dbcd872624d6de5f + "<dev string:x5ca>");
  devgui::function_ddef1d43d4e5ef07("<dev string:x605>", "<dev string:x61e>", &function_57d44f1d87cbb951);
  devgui::function_ddef1d43d4e5ef07("<dev string:x635>", "<dev string:x552>", &function_e0567e4dedf01afe);
  devgui::function_ddef1d43d4e5ef07("<dev string:x660>", "<dev string:x695>", &function_9e1d460525e180ba);
  devgui::function_ddef1d43d4e5ef07("<dev string:x6c7>", "<dev string:x6fc>", &function_d34215acc5605a7);
  devgui::function_ddef1d43d4e5ef07("<dev string:x72e>", "<dev string:x763>", &function_84fe7b81e9754a18);
  devgui::function_ddef1d43d4e5ef07("<dev string:x795>", "<dev string:x7ba>", &function_7ac1a58b324aa1ee);
  devgui::function_ddef1d43d4e5ef07("<dev string:x7d4>", "<dev string:x7f9>", &function_967f0108294e1e6b);
  devgui::function_ddef1d43d4e5ef07("<dev string:x813>", "<dev string:x838>", &function_385fa25a801245bc);
  devgui::function_ddef1d43d4e5ef07("<dev string:x852>", "<dev string:x87c>", &function_cecd7fb289a1285c);
  devgui::function_ddef1d43d4e5ef07("<dev string:x894>", "<dev string:x8bf>", &function_1cb03e09a23c3f91);
  devgui::function_9c2be2438708a992();
  devgui::function_fc97f67ff432e7de(var_dbcd872624d6de5f + "<dev string:x8d8>");
  devgui::function_ddef1d43d4e5ef07("<dev string:x912>", "<dev string:x947>", &_info);
  devgui::function_ddef1d43d4e5ef07("<dev string:x635>", "<dev string:x552>", &function_e0567e4dedf01afe);
  devgui::function_ddef1d43d4e5ef07("<dev string:x950>", "<dev string:x97c>", &function_d2317ed58009dbd);
  devgui::function_ddef1d43d4e5ef07("<dev string:x9a9>", "<dev string:x9d5>", &function_9d24bb4a8256f254);
  devgui::function_ddef1d43d4e5ef07("<dev string:xa02>", "<dev string:xa2e>", &function_a1b2df1b9491c003);
  devgui::function_9c2be2438708a992();
}

function private function_e852472815b92434() {
  if(isDefined(level.players)) {
    return level.players[0];
  }

  return level.player;
}

function private _info() {
  return;
}

function private function_e0567e4dedf01afe() {
  hostplayer = function_e852472815b92434();

  if(isDefined(hostplayer) && isPlayer(hostplayer)) {
    function_fe743354b955ecce(hostplayer);
  }
}

function private function_d2317ed58009dbd() {
  player = level.players[1];

  if(isDefined(player)) {
    hostplayer = function_e852472815b92434();
    var_99fa825bb3d3691 = namespace_37b952684c0bbb5::function_bfa2d92c8914b8e8(hostplayer);
    function_43ce254d78ce0541(var_99fa825bb3d3691, player);
  }
}

function private function_9d24bb4a8256f254() {
  player = level.players[2];

  if(isDefined(player)) {
    hostplayer = function_e852472815b92434();
    var_99fa825bb3d3691 = namespace_37b952684c0bbb5::function_bfa2d92c8914b8e8(hostplayer);
    function_43ce254d78ce0541(var_99fa825bb3d3691, player);
  }
}

function private function_a1b2df1b9491c003() {
  player = level.players[3];

  if(isDefined(player)) {
    hostplayer = function_e852472815b92434();
    var_99fa825bb3d3691 = namespace_37b952684c0bbb5::function_bfa2d92c8914b8e8(hostplayer);
    function_43ce254d78ce0541(var_99fa825bb3d3691, player);
  }
}

function private function_86961d9c24d62c59() {
  hostplayer = function_e852472815b92434();

  if(isDefined(hostplayer) && isPlayer(hostplayer)) {
    var_99fa825bb3d3691 = namespace_37b952684c0bbb5::function_bfa2d92c8914b8e8(hostplayer);
    function_345916ac13233fc9(var_99fa825bb3d3691, hostplayer);
    iprintlnbold("<dev string:xa5b>");
  }
}

function private function_57d44f1d87cbb951() {
  function_8456c1fd47789d78(1);
  var_3d72c402d7c5eb86 = 3;

  for(i = 0; i < var_3d72c402d7c5eb86; i++) {
    function_bb9daa5b2a9ed6e0();
  }

  iprintlnbold("<dev string:xa95>" + var_3d72c402d7c5eb86 + "<dev string:xa9f>");
}

function private function_8456c1fd47789d78(force) {
  if(!isDefined(force)) {
    force = 0;
  }

  if(!force || isDefined(level.var_fc65ce2bb093f433)) {
    return;
  }

  hostplayer = function_e852472815b92434();
  level.var_fc65ce2bb093f433 = [];
  level.var_fc65ce2bb093f433[hostplayer.team] = [];
  level.var_fc65ce2bb093f433[hostplayer.team][hostplayer.sessionsquadid] = spawnStruct();
  level.var_fc65ce2bb093f433[hostplayer.team][hostplayer.sessionsquadid].players = [hostplayer];
}

function private function_bb9daa5b2a9ed6e0() {
  if(!isDefined(level.var_1a9f367c4a393825)) {
    level.var_1a9f367c4a393825 = 1;
  }

  hostplayer = function_e852472815b92434();
  fakeplayer = spawnStruct();
  fakeplayer.sessionsquadid = hostplayer.sessionsquadid;
  fakeplayer.team = hostplayer.team;
  fakeplayer.fakeid = level.var_1a9f367c4a393825;
  players = level.var_fc65ce2bb093f433[hostplayer.team][hostplayer.sessionsquadid].players;
  level.var_fc65ce2bb093f433[hostplayer.team][hostplayer.sessionsquadid].players = utility::array_add(players, fakeplayer);
  level.var_1a9f367c4a393825++;
  return fakeplayer;
}

function private function_cecd7fb289a1285c() {
  function_8456c1fd47789d78();
  hostplayer = function_e852472815b92434();
  fakeplayer = function_bb9daa5b2a9ed6e0();
  var_99fa825bb3d3691 = namespace_37b952684c0bbb5::function_bfa2d92c8914b8e8(hostplayer);
  function_5063077487bc1661(var_99fa825bb3d3691, fakeplayer);
}

function private function_9dea9db80a695b8a(fakesquadmemberindex) {
  if(!isDefined(level.var_fc65ce2bb093f433)) {
    return;
  }

  hostplayer = function_e852472815b92434();

  if(!isDefined(hostplayer)) {
    return;
  }

  squadmember = level.var_fc65ce2bb093f433[hostplayer.team][hostplayer.sessionsquadid].players[fakesquadmemberindex];

  if(!isDefined(squadmember)) {
    return;
  }

  var_99fa825bb3d3691 = namespace_37b952684c0bbb5::function_bfa2d92c8914b8e8(hostplayer);
  function_43ce254d78ce0541(var_99fa825bb3d3691, squadmember);
}

function private function_9e1d460525e180ba() {
  function_9dea9db80a695b8a(1);
}

function private function_d34215acc5605a7() {
  function_9dea9db80a695b8a(2);
}

function private function_84fe7b81e9754a18() {
  function_9dea9db80a695b8a(3);
}

function private function_1cb03e09a23c3f91(fakesquadmemberindex) {
  if(!isDefined(level.var_fc65ce2bb093f433)) {
    return;
  }

  hostplayer = function_e852472815b92434();

  if(!isDefined(hostplayer)) {
    return;
  }

  if(!isDefined(fakesquadmemberindex)) {
    fakesquadmemberindex = level.var_fc65ce2bb093f433[hostplayer.team][hostplayer.sessionsquadid].players.size - 1;
  }

  squadmember = level.var_fc65ce2bb093f433[hostplayer.team][hostplayer.sessionsquadid].players[fakesquadmemberindex];

  if(!isDefined(squadmember) || squadmember == hostplayer) {
    return;
  }

  var_99fa825bb3d3691 = namespace_37b952684c0bbb5::function_bfa2d92c8914b8e8(hostplayer);
  function_ac666ae2ca5c08a2(var_99fa825bb3d3691, squadmember);
  players = level.var_fc65ce2bb093f433[hostplayer.team][hostplayer.sessionsquadid].players;
  level.var_fc65ce2bb093f433[hostplayer.team][hostplayer.sessionsquadid].players = arrayremove(players, squadmember);
}

function private function_7ac1a58b324aa1ee() {
  function_1cb03e09a23c3f91(1);
}

function private function_967f0108294e1e6b() {
  function_1cb03e09a23c3f91(2);
}

function private function_385fa25a801245bc() {
  function_1cb03e09a23c3f91(3);
}

# /