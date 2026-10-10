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

function activitynexuslog(logtext, associateddvar, var_d29cf130d2798a76, var_8e1b151809066835, loglevel) {
  if(!isDefined(associateddvar)) {
    associateddvar = @ "hash_4a93c7546965668";
  }

  if(!isDefined(var_d29cf130d2798a76)) {
    var_d29cf130d2798a76 = undefined;
  }

  if(!isDefined(var_8e1b151809066835)) {
    var_8e1b151809066835 = undefined;
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

  if(isDefined(var_d29cf130d2798a76) && isstruct(var_d29cf130d2798a76) && isactivityinstance(var_d29cf130d2798a76)) {
    logtext += function_68e0a0bea0dd792c(var_d29cf130d2798a76);
  }

  if(isDefined(var_8e1b151809066835) && isarray(var_8e1b151809066835)) {
    if(var_8e1b151809066835.size > 0) {
      logtext += " Relevant Players: ";
      playerstrings = [];

      foreach(player in var_8e1b151809066835) {
        if(isPlayer(player)) {
          playerstrings[playerstrings.size] = function_269d961b1ae43523(player);
        }
      }

      if(playerstrings.size > 0) {
        var_f5a169d68ced49d9 = scripts\engine\utility::string_join(playerstrings, ",");
        logtext += var_f5a169d68ced49d9;
      }
    }
  }

  var_3018e528588498a7 = function_5f6cd9351f89d1d6();
  playtest_logger::function_275c43d7dd5c74d6(logtext, loglevel, var_3018e528588498a7);
}

function function_68e0a0bea0dd792c(activityinstance) {
  return " activity: type = " + function_de53ed8e35d0ed7a(activityinstance) + " variant = " + function_a4748b32a824c79c(activityinstance) + " id = " + activityinstance.id + " state = " + function_73bd348a2ec322cf(activityinstance) + " participants: " + activityinstance.var_6c29f2fdb0054bbe.size;
}

function function_2a1e9879f71ab677(var_aee74cee3c1dc918) {
  return getdvarint(@ "hash_ec6951bf3fb06da", 0) == 0 && getdvarint(var_aee74cee3c1dc918, 0) == 1;
}

function private function_269d961b1ae43523(player) {
  var_9f2932944bba9df8 = " player: name = " + player.name + " guid = " + player.guid;
  teamstring = default_to(player.team, "undefined");
  squadidstring = default_to(player.sessionsquadid, "undefined");
  var_9f2932944bba9df8 = var_9f2932944bba9df8 + " team = " + teamstring + " ";
  var_9f2932944bba9df8 = var_9f2932944bba9df8 + " squadID = " + squadidstring;
  return var_9f2932944bba9df8;
}

function private function_5f6cd9351f89d1d6() {
  var_d3f89f07fe3fa0ab = function_efe441752cd7303d();
  return var_d3f89f07fe3fa0ab.var_3018e528588498a7;
}