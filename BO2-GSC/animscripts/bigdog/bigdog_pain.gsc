/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\bigdog\bigdog_pain.gsc
**********************************************/

#include animscripts\anims;
#include maps\_utility;
#include animscripts\bigdog\bigdog_utility;
#include animscripts\shared;
#include animscripts\pain;

main() {
  self endon("killanimscript");
  animscripts\bigdog\bigdog_utility::initialize("pain");
  pain();
}

pain() {
  self orientmode("face current");
  self animmode("zonly_physics");
  painanim = undefined;

  if(bigdog_cant_move_anymore_pain()) {
    return;
  }
  if(bigdog_hunkered_pain()) {
    return;
  }
  if(bigdog_charged_or_sniper_weapon_pain()) {
    return;
  }
  if(bigdog_explosive_body_pain()) {
    return;
  }
  if(bigdog_leg_pain()) {
    return;
  }
  iprintln("bigdog - no pain animation available");
}

end_script() {
  if(isDefined(self.paincausedhunkeringup) && self.paincausedhunkeringup)
    self.hunkereddown = 0;

  self.blockingpain = 0;
}

bigdog_play_pain_anim(painanim, rate) {
  if(!isDefined(rate))
    rate = 1.0;

  self.blockingpain = 1;
  time = getanimlength(painanim) / rate;
  self setflaggedanimrestart("painAnim", painanim, 1, 0.1, rate);
  self animscripts\shared::donotetracksfortime(time, "painAnim");
  self.blockingpain = 0;
}

bigdog_explosive_body_pain(forceexplosivedamage) {
  if(self.canmove && (isDefined(forceexplosivedamage) && forceexplosivedamage || animscripts\pain::isexplosivedamagemod(self.damagemod))) {
    painanim = getstumblepainanim();
    assert(isDefined(painanim));

    if(isDefined(painanim)) {
      self.paincausedhunkeringup = 1;
      self playsound("veh_claw_hit_alert");
      bigdog_play_pain_anim(painanim, 0.5);
      self.hunkereddown = 0;
      self.paincausedhunkeringup = 0;
      return true;
    }
  }

  return false;
}

getstumblepainanim() {
  painanim = undefined;
  animsuffix = animscripts\bigdog\bigdog_utility::animsuffix();

  if(self.damageyaw > 135 || self.damageyaw <= -135)
    painanim = animarray("stun_recover_b" + animsuffix);
  else if(self.damageyaw > 45 && self.damageyaw < 135)
    painanim = animarray("stun_recover_r" + animsuffix);
  else if(self.damageyaw > -135 && self.damageyaw < -45)
    painanim = animarray("stun_recover_l" + animsuffix);
  else
    painanim = animarray("stun_recover_f" + animsuffix);

  return painanim;
}

bigdog_leg_pain() {
  if(isDefined(self.damageleg)) {
    painanim = getlegpainanim();
    assert(isDefined(painanim));

    if(isDefined(painanim)) {
      self playsound("veh_claw_hit_alert");
      bigdog_play_pain_anim(painanim);
      return true;
    }
  }

  return false;
}

getlegpainanim() {
  painanim = undefined;

  if(self.damageleg == "FL")
    painanim = animarray("leg_pain_fl");
  else if(self.damageleg == "FR")
    painanim = animarray("leg_pain_fr");
  else if(self.damageleg == "RL")
    painanim = animarray("leg_pain_rl");
  else
    painanim = animarray("leg_pain_rr");

  return painanim;
}

bigdog_hunkered_pain() {
  shotbyasniperorexplosive = wasdamagedbychargedsnipershot() || wasdamagedbysnipershot();
  shotbyasniperorexplosive = shotbyasniperorexplosive || animscripts\pain::isexplosivedamagemod(self.damagemod);

  if(self.hunkereddown && (!self.canmove || !shotbyasniperorexplosive)) {
    painanim = getflinchanim();
    assert(isDefined(painanim));

    if(isDefined(painanim)) {
      bigdog_play_pain_anim(painanim, 1.0);
      return true;
    }
  }

  return false;
}

getflinchanim() {
  painanim = undefined;
  animsuffix = "";

  if(self.damageyaw > 135 || self.damageyaw <= -135)
    painanim = animarray("hunker_down_flinch_b" + animsuffix, "pain");
  else if(self.damageyaw > 45 && self.damageyaw < 135)
    painanim = animarray("hunker_down_flinch_r" + animsuffix, "pain");
  else if(self.damageyaw > -135 && self.damageyaw < -45)
    painanim = animarray("hunker_down_flinch_l" + animsuffix, "pain");
  else
    painanim = animarray("hunker_down_flinch_f" + animsuffix, "pain");

  return painanim;
}

bigdog_cant_move_anymore_pain() {
  if(!self.canmove && !self.hunkereddown) {
    painanim = gethunkerdownpainanim();
    assert(isDefined(painanim));

    if(isDefined(painanim)) {
      bigdog_play_pain_anim(painanim);
      self.hunkereddown = 1;
      return true;
    }
  }

  return false;
}

gethunkerdownpainanim() {
  animsuffix = animscripts\bigdog\bigdog_utility::animsuffix();

  if(animarrayanyexist("stun_fall" + animsuffix, "pain"))
    painanim = animarraypickrandom("stun_fall" + animsuffix, "pain");
  else
    painanim = animarraypickrandom("stun_fall", "pain");

  return painanim;
}

bigdog_charged_or_sniper_weapon_pain() {
  if(self.canmove) {
    if(wasdamagedbyfullychargedsnipershot())
      return bigdog_explosive_body_pain(1);
    else if(wasdamagedbychargedsnipershot() || wasdamagedbysnipershot()) {
      if(isDefined(self.damageleg) && self.damageleg != "")
        return bigdog_leg_pain();
      else {
        painanim = getchargedorsniperweaponbodypainanim();
        assert(isDefined(painanim));

        if(isDefined(painanim)) {
          self playsound("veh_claw_hit_alert");
          bigdog_play_pain_anim(painanim);
          self.hunkereddown = 0;
          return 1;
        }
      }
    }
  }

  return 0;
}

getchargedorsniperweaponbodypainanim() {
  painanim = undefined;

  if(self.damageyaw > 135 || self.damageyaw <= -135)
    painanim = animarray("body_pain_f");
  else if(self.damageyaw > 45 && self.damageyaw < 135)
    painanim = animarray("body_pain_r");
  else if(self.damageyaw > -135 && self.damageyaw < -45)
    painanim = animarray("body_pain_l");
  else
    painanim = animarray("body_pain_b");

  return painanim;
}