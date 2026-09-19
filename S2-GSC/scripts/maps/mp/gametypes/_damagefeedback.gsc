/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_damagefeedback.gsc
*********************************************************/

init() {}

_id_A102(var_0, var_1) {
  if(!isPlayer(self) || !isDefined(var_0)) {
    return;
  }
  switch (var_0) {
    case "resupply_equipment":
    case "resupply_bullets":
    case "resupply_throwingknife":
    case "resupply_launcher":
    case "resupply_scorestreak":
    case "resupply_intel":
    case "escalation_activated":
      if(!level.hardcoremode)
        setdamagepickupclientomnvar(var_0);

      break;
    case "killshot_deadeye_headshot":
    case "killshot_deadeye":
    case "hitdeadeye_headshot":
    case "hitdeadeye":
    case "standard_nosound":
    case "killshot_nosound":
    case "hitjuggernaut":
    case "hitlightarmor":
    case "hitriotshield":
    case "hittacticalmask":
    case "hitfireshield":
    case "hitblastshield":
      _id_865B(var_0);
      break;
    case "weakpoint":
      if(isDefined(level._id_585D) && level._id_585D)
        _id_865B("headshot");

      break;
    case "headshot":
      if(isDefined(level._id_585D) && level._id_585D)
        _id_865B("headshot");
      else if(!level._id_258F)
        _id_865B("standard");
      else
        _id_865B("headshot");

      break;
    case "hitmorehealth":
      _id_865B("hitmorehealth");
      break;
    case "killshot":
      _id_865B("killshot");
      break;
    case "killshot_headshot":
      _id_865B("killshot_headshot");
      break;
    case "minor":
      if(isDefined(level._id_585D) && level._id_585D)
        _id_865B("minor");
      else
        _id_865B("standard");

      break;
    case "raid_buildable":
      _id_865B("raid_buildable");
      break;
    case "raid_buildable_kill":
      _id_865B("raid_buildable_kill");
      break;
    case "raid_fighter":
      _id_865B("raid_fighter");
      break;
    case "raid_fighter_killshot":
      _id_865B("raid_fighter_killshot");
      break;
    case "throwingknife":
      _id_865B("throwingknife");
      break;
    case "none":
      break;
    default:
      _id_865B("standard");
      break;
  }
}

_id_865B(var_0) {
  self setclientomnvar("damage_feedback", var_0);
  thread _id_7D5B();
}

_id_7D5B() {
  self notify("reset_feedback_omnvar");
  self endon("reset_feedback_omnvar");
  wait 1;
  waittillframeend;

  if(isDefined(self))
    self setclientomnvar("damage_feedback", "none");
}

setdamagepickupclientomnvar(var_0) {
  self setclientomnvar("damage_pickup", var_0);
  thread resetdamagepickup();
}

resetdamagepickup() {
  self notify("reset_pickup_omnvar");
  self endon("reset_pickup_omnvar");
  wait 1;
  waittillframeend;

  if(isDefined(self))
    self setclientomnvar("damage_pickup", "none");
}