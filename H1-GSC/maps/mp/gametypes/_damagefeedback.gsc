/*************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\_damagefeedback.gsc
*************************************************/

init() {}

updatedamagefeedback(var_0, var_1) {
  if(!isplayer(self) || !isdefined(var_0)) {
    return;
  }
  switch (var_0) {
    case "scavenger":
      self playlocalsound("scavenger_pack_pickup");

      if(!level.hardcoremode)
        self setclientomnvar("damage_feedback", var_0);

      break;
    case "hitjuggernaut":
    case "hitlightarmor":
    case "hitblastshield":
      self playlocalsound("mp_hit_armor");
      self setclientomnvar("damage_feedback", var_0);
      break;
    case "mp_solar":
      if(!isdefined(self.shouldloopdamagefeedback)) {
        if(isdefined(level.mapkillstreakdamagefeedbacksound))
          self thread[[level.mapkillstreakdamagefeedbacksound]]();
      } else
        self.damagefeedbacktimer = 10;

      break;
    case "laser":
      if(isdefined(level.sentrygun)) {
        if(!isdefined(self.shouldloopdamagefeedback)) {
          if(isdefined(level.mapkillstreakdamagefeedbacksound))
            self thread[[level.mapkillstreakdamagefeedbacksound]](level.sentrygun);
        }
      }

      break;
    case "headshot":
      self playlocalsound("mp_hit_headshot");
      self setclientomnvar("damage_feedback", "headshot");
      break;
    case "hitmorehealth":
      self playlocalsound("mp_hit_armor");
      self setclientomnvar("damage_feedback", "hitmorehealth");
      break;
    case "killshot":
      self playlocalsound("mp_hit_kill");
      self setclientomnvar("damage_feedback", "killshot");
      break;
    case "killshot_headshot":
      self playlocalsound("mp_hit_kill_headshot");
      self setclientomnvar("damage_feedback", "killshot_headshot");
      break;
    case "none":
      break;
    default:
      self playlocalsound("mp_hit_default");
      self setclientomnvar("damage_feedback", "standard");
      break;
  }
}