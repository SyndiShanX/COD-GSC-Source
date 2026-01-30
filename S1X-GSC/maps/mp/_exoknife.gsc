/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_exoknife.gsc
***************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;

EXO_KNIFE_NAME = "exoknife_mp";
EXO_KNIFE_SPEED = 1200.0;
EXO_KNIFE_RETURN_DELAY = 0.5;

init() {
  SetDevDvarIfUninitialized("exo_knife_speed", EXO_KNIFE_SPEED);
  SetDevDvarIfUninitialized("exo_knife_return_delay", EXO_KNIFE_RETURN_DELAY);

  level._effect["exo_knife_blood"] = loadfx("vfx/weaponimpact/flesh_impact_head_fatal_exit");
}

exo_knife_think() {
  self thread exo_knife_throw_watch();
}

exo_knife_throw_watch() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  while(1) {
    self waittill("grenade_fire", knife, weapon_name);

    shortWeaponName = maps\mp\_utility::strip_suffix(weapon_name, "_lefthand");

    if(shortWeaponName != EXO_KNIFE_NAME && shortWeaponName != "exoknife_jug_mp") {
      continue;
    }

    knife.manuallyDetonateFunc = ::exo_knife_manually_detonate;

    knife.flying = true;
    knife.weaponName = weapon_name;
    if(!isDefined(knife.recall)) {
      knife.recall = false;
    }
    knife.owner = self;

    self thread exo_knife_enable_detonate(knife);

    knife thread exo_knife_touch_watch();
    knife thread exo_knife_stuck_watch();
    knife thread exo_knife_recall_watch();
    knife thread exo_knife_emp_watch();
  }
}

exo_knife_emp_watch() {
  self endon("death");

  for(;;) {
    level waittill("emp_update");

    if(isDefined(level.empEquipmentDisabled) && level.empEquipmentDisabled && self.owner isEMPedByKillstreak()) {
      self thread exo_knife_delete();
    }
  }
}

exo_knife_enable_detonate(knife) {
  self endon("disconnect");

  if(!isDefined(self.exoknife_count)) {
    self.exoknife_count = 0;
  }

  if(!self.exoknife_count) {
    self _enableDetonate(knife.weaponName, true);
  }

  self.exoknife_count++;

  knife waittill("death");

  self.exoknife_count--;

  if(!self.exoknife_count) {
    self _enableDetonate(knife.weaponName, false);
  }
}

exo_knife_passed_target() {
  self endon("death");
  self.owner endon("disconnect");

  self waittill("missile_passed_target");

  self exo_knife_restock();
}

exo_knife_touch_watch() {
  if(!isDefined(self.owner)) {
    return;
  }

  self endon("death");
  self.owner endon("disconnect");

  trigger = spawn("trigger_radius", self.origin, 0, 15, 5);
  trigger EnableLinkTo();
  trigger LinkTo(self);
  trigger.knife = self;
  self thread delete_on_death(trigger);

  while(1) {
    trigger waittill("trigger", player);

    if(player != self.owner) {
      continue;
    }

    if(player GetFractionMaxAmmo(self.weaponName) >= 1.0) {
      continue;
    }

    break;
  }

  self exo_knife_restock();
}

exo_knife_restock() {
  self.owner SetClientOmnvar("damage_feedback", "throwingknife");
  self.owner SetWeaponAmmoStock(self.weaponName, self.owner GetWeaponAmmoStock(self.weaponName) + 1);

  self exo_knife_delete();
}

exo_knife_stuck_watch() {
  self endon("death");

  while(1) {
    self waittill("missile_stuck", hitEnt);

    isStuckToShield = self maps\mp\_riotshield::entIsStuckToShield();

    self.flying = false;
    self.recall = false;

    if(isDefined(self.owner) && isDefined(hitEnt) && ((isDefined(level.isHorde) && level.isHorde && hitEnt.model == "animal_dobernan") || IsGameParticipant(hitEnt)) && !isStuckToShield) {
      if(isDefined(hitEnt.team) && isDefined(self.owner.team) && hitEnt.team != self.owner.team) {
        PlayImpactHeadFatalFX(self.origin, (self.origin - self.owner.origin));
      }

      hitEnt maps\mp\_snd_common_mp::snd_message("exo_knife_player_impact");

      return_delay = GetDvarFloat("exo_knife_return_delay", EXO_KNIFE_RETURN_DELAY);
      self.owner thread exo_knife_recall(return_delay);
    } else {
      self thread maps\mp\gametypes\_weapons::stickyHandleMovers(undefined, "exo_knife_recall");
    }
  }
}

exo_knife_recall_stuck_watch() {
  self endon("death");

  while(1) {
    self waittill("missile_stuck", hitEnt);

    if(isDefined(self.owner) && isDefined(hitEnt) && (hitEnt IsJuggernaut())) {
      if(!level.teambased || (isDefined(self.owner.team) && isDefined(hitEnt.team) && hitEnt.team != self.owner.team)) {
        self thread exo_knife_delete();
      }
    }
  }
}

exo_knife_recall(waitTime) {
  self endon("death");
  self endon("disconnect");
  self endon("exo_knife_recall");

  if(isDefined(waitTime) && waitTime > 0) {
    wait waitTime;
  }

  self notify("exo_knife_recall");
}

exo_knife_manually_detonate(knife) {
  if(isDefined(knife) && !knife.recall) {
    self exo_knife_recall();
  }
}

exo_knife_recall_watch() {
  self endon("death");

  if(!isDefined(self.owner)) {
    return;
  }
  self.owner endon("disconnect");
  self.owner endon("death");

  self.owner waittill("exo_knife_recall");

  start = self.origin;
  end = self.owner getEye();

  if(self.owner GetStance() != "prone") {
    end -= (0, 0, 20);
  }

  speed = GetDvarFloat("exo_knife_speed", EXO_KNIFE_SPEED);
  dist = Distance(start, end);
  time = dist / speed;

  player_vel = self.owner GetVelocity();
  end = end + player_vel * time;

  dir = end - start;
  dir = VectorNormalize(dir);

  return_knife_offset = 0;
  if(return_knife_offset != 0) {
    start += dir * return_knife_offset;
  }

  vel = dir * speed;

  return_knife = MagicGrenadeManual(self.weaponName, start, vel, 30, self.owner, true);
  return_knife.owner = self.owner;
  return_knife.recall = true;

  return_knife Missile_SetTargetEnt(self.owner);
  return_knife thread exo_knife_recall_stuck_watch();
  return_knife thread exo_knife_passed_target();

  self exo_knife_delete();
}

exo_knife_clean_up_attractor(attractor, owner, knife) {
  waittill_any_ents(owner, "disconnect", owner, "death", knife, "death", knife, "missile_stuck");
  Missile_DeleteAttractor(attractor);
}

exo_knife_delete() {
  self delete();
}