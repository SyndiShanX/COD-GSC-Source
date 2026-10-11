/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3ac7886f9e4eceef.gsc
*************************************************/

#using script_185660037b9236c1;
#using script_41387eecc35b88bf;
#using script_756e1a95e0937249;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_a1fa5fb7614c23b6;

function function_8dd9dcec6a76bffa(var_d3f89f07fe3fa0ab) {
  var_d3f89f07fe3fa0ab.var_3018e528588498a7 = function_223a972e008c4a09(@ "hash_b4d9cc34a6dfdb1e", @ "hash_81082cac2b614784", @ "hash_a1b265eb01d79455", @ "hash_5d106e01221747b7", @ "hash_a9292d2b9ef1340b", @ "hash_1a2224f7169c7f1b", @ "hash_29a8ff93834df7b8", "ACTIVITY NEXUS LOG ");
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

  var_d7cdddccaaf35828 = getdvarint(@ "hash_ec6951bf3fb06da", 0) == 1;
  var_b3c17d892911cfb = !isDefined(logtext) || !isstring(logtext) || !isDefined(associateddvar) || getdvarint(associateddvar, 0) == 0;

  if(var_d7cdddccaaf35828 || var_b3c17d892911cfb) {
    return;
  }

  logtext = "( " + gettime() + " ) " + logtext;

  if(isDefined(relevantactivityinstance) && isstruct(relevantactivityinstance) && isactivityinstance(relevantactivityinstance)) {
    logtext += function_68e0a0bea0dd792c(relevantactivityinstance);
  }

  if(isDefined(relevantplayerlist) && isarray(relevantplayerlist)) {
    if(relevantplayerlist.size > 0) {
      logtext += " Relevant Players: ";
      playerstrings = [];

      foreach(player in relevantplayerlist) {
        if(isPlayer(player)) {
          playerstrings[playerstrings.size] = function_269d961b1ae43523(player);
        }
      }

      if(playerstrings.size > 0) {
        allplayerstrings = scripts\engine\utility::string_join(playerstrings, ",");
        logtext += allplayerstrings;
      }
    }
  }

  var_3018e528588498a7 = function_5f6cd9351f89d1d6();
  playtest_logger::function_275c43d7dd5c74d6(logtext, loglevel, var_3018e528588498a7);
}

function function_68e0a0bea0dd792c(activityinstance) {
  return " activity: type = " + getactivitytype(activityinstance) + " variant = " + function_a4748b32a824c79c(activityinstance) + " id = " + activityinstance.id + " state = " + getactivitystate(activityinstance) + " participants: " + activityinstance.playerparticipants.size;
}

function function_2a1e9879f71ab677(var_aee74cee3c1dc918) {
  return getdvarint(@ "hash_ec6951bf3fb06da", 0) == 0 && getdvarint(var_aee74cee3c1dc918, 0) == 1;
}

function private function_269d961b1ae43523(player) {
  activityplayerstring = " player: name = " + player.name + " guid = " + player.guid;
  teamstring = default_to(player.team, "undefined");
  squadidstring = default_to(player.sessionsquadid, "undefined");
  activityplayerstring = activityplayerstring + " team = " + teamstring + " ";
  activityplayerstring = activityplayerstring + " squadID = " + squadidstring;
  return activityplayerstring;
}

function private function_5f6cd9351f89d1d6() {
  var_d3f89f07fe3fa0ab = function_efe441752cd7303d();
  return var_d3f89f07fe3fa0ab.var_3018e528588498a7;
}