/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_77873e194e406c6d.gsc
*****************************************************/

#using script_1aae2eb1ef28b239;
#using script_507576ed5f2c7201;
#using scripts\engine\utility;
#namespace namespace_72e72f5e51e6e4b3;

function function_355e281ae0dc5a13(var_d2eb8aba5c657d96) {
  var_d2eb8aba5c657d96.var_a08a050c30b2e7e = playtest_logger::function_b89c03b46070f714(@ "hash_b4d9cc34a6dfdb1e", @ "hash_81082cac2b614784", @ "hash_a1b265eb01d79455", @ "hash_5d106e01221747b7", @ "hash_a9292d2b9ef1340b", @ "hash_1a2224f7169c7f1b", @ "hash_29a8ff93834df7b8", "\x92\x01K\xc5\xf3B\x02\xe4@?\xe6\xe14\xa6\x8c\xc3v3\xa7");
}

function activitynexuslog(logtext, associateddvar, relevantactivityinstance, relevantplayerlist, loglevel) {
  if(!isDefined(associateddvar)) {
    associateddvar = @ "hash_4a93c7546965668";
  }

  if(!isDefined(relevantactivityinstance)) {
    relevantactivityinstance = undefined;
  }

  if(!isDefined(relevantplayerlist)) {
    relevantplayerlist = undefined;
  }

  if(!isDefined(loglevel)) {
    loglevel = 1;
  }

  var_27ef8fa2ebe0e61d = getdvarint(@ "hash_ec6951bf3fb06da", 0) == 1;
  var_a2ac4b959820ff2 = !isDefined(logtext) || !isstring(logtext) || !isDefined(associateddvar) || getdvarint(associateddvar, 0) == 0;

  if(var_27ef8fa2ebe0e61d || var_a2ac4b959820ff2) {
    return;
  }

  logtext = "<dev string:x24>" + gettime() + "<dev string:x2a>" + logtext;

  if(isDefined(relevantactivityinstance) && isstruct(relevantactivityinstance) && namespace_59dbf6a1bb28a43f::isactivityinstance(relevantactivityinstance)) {
    logtext += function_38d95e6ab839aae5(relevantactivityinstance);
  }

  if(isDefined(relevantplayerlist) && isarray(relevantplayerlist)) {
    if(relevantplayerlist.size > 0) {
      logtext += "<dev string:x31>";
      playerstrings = [];

      foreach(player in relevantplayerlist) {
        if(isPlayer(player)) {
          playerstrings[playerstrings.size] = function_c7c7ea10990cd8c2(player);
        }
      }

      if(playerstrings.size > 0) {
        allplayerstrings = function_43734668ca51504("<dev string:x48>", playerstrings);
        logtext += allplayerstrings;
      }
    }
  }

  var_a08a050c30b2e7e = function_a8da33ff33fffccf();
  playtest_logger::function_38f885efb5ac081b(logtext, loglevel, var_a08a050c30b2e7e);
}

function function_38d95e6ab839aae5(activityinstance) {
  return "I\xfc\xb1M1\x95\xb0[#\xec\xdes\xe6\x04\xbd\xc8w\xf1" + activityinstance.type + "\xd2\x16\xfb\x97\x82\x18c\xcd!\xf5\xf1" + activityinstance.varianttag + "\x12\xdf\x82\xd7\xab\xe1" + activityinstance.id + "1\x16WyK\x9bH\xcab" + activityinstance.state + "S\xd5.\x1b\x9d|\xdfS\xc5\x98\xa2\x7f\xe7.!" + activityinstance.playerparticipants.size;
}

function function_72a545c3f4d63582(var_57e9464cfd078251) {
  return getdvarint(@ "hash_ec6951bf3fb06da", 0) == 0 && getdvarint(var_57e9464cfd078251, 0) == 1;
}

function private function_c7c7ea10990cd8c2(player) {
  playerguid = utility::callsharedfunc(#"player", #"getPlayerGuid", player);
  playername = player.name ?? "\x9b\xf6@\xe6a\xade\b2e3\xa5\xdcY\x8c";
  activityplayerstring = "\xa3\xb3\x96\xff\xc3\vG\xe7h1\b\x8b\x1d\xa4J\x13" + playername + "\xbeP\xc8l\xec[LZ" + playerguid;
  teamstring = player.team ?? "\xed\x1d\va\x1e\xf6\xe5\x88\x8a";
  squadidstring = player.sessionsquadid ?? "\xed\x1d\va\x1e\xf6\xe5\x88\x8a";
  activityplayerstring = activityplayerstring + "\xd8\xf3N\xc7\x06]\x80\xect\xd6\xb3" + teamstring + "\xda";
  activityplayerstring = activityplayerstring + "S\xaav\vA\t\x9c\xdd\xe8\x9f/" + squadidstring;
  return activityplayerstring;
}

function private function_a8da33ff33fffccf() {
  var_d2eb8aba5c657d96 = level.activities;
  return var_d2eb8aba5c657d96.var_a08a050c30b2e7e;
}