/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_damagefeedback.gsc
***************************************************/

init() {}

updateDamageFeedback(typeHit, victim) {
  if(!isPlayer(self) || !isDefined(typeHit)) {
    return;
  }

  switch (typeHit) {
    case "scavenger":
      self PlayLocalSound("scavenger_pack_pickup");
      if(!level.hardcoreMode) {
        self SetClientOmnvar("damage_feedback", typeHit);
      }
      break;

    case "hitblastshield":
    case "hitlightarmor":
    case "hitjuggernaut":
      self PlayLocalSound("mp_hit_armor");
      self SetClientOmnvar("damage_feedback", typeHit);
      break;
    case "mp_solar":
      if(!isDefined(self.shouldloopdamagefeedback)) {
        if(isDefined(level.mapKillStreakDamageFeedbackSound)) {
          self thread[[level.mapKillStreakDamageFeedbackSound]]();
        }
      } else {
        self.damagefeedbacktimer = 10;
      }
      break;
    case "laser":
      if(isDefined(level.sentryGun)) {
        if(!isDefined(self.shouldloopdamagefeedback)) {
          if(isDefined(level.mapKillStreakDamageFeedbackSound)) {
            self thread[[level.mapKillStreakDamageFeedbackSound]](level.sentryGun);
          }
        }
      }
      break;
    case "headshot":
      self PlayLocalSound("mp_hit_headshot");
      self SetClientOmnvar("damage_feedback", "headshot");
      break;
    case "hitmorehealth":
      self PlayLocalSound("mp_hit_armor");
      self SetClientOmnvar("damage_feedback", "hitmorehealth");
      break;
    case "killshot":
      self PlayLocalSound("mp_hit_kill");
      self SetClientOmnvar("damage_feedback", "killshot");
      break;
    case "killshot_headshot":
      self PlayLocalSound("mp_hit_kill_headshot");
      self SetClientOmnvar("damage_feedback", "killshot_headshot");
      break;
    case "none":
      break;
    default:
      self PlayLocalSound("mp_hit_default");
      self SetClientOmnvar("damage_feedback", "standard");
      break;
  }
}