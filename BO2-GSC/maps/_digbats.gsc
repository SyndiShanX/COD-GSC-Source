/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_digbats.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include animscripts\utility;
#include animscripts\combat_utility;
#include animscripts\debug;
#include animscripts\anims;
#include animscripts\anims_table;
#include animscripts\anims_table_digbats;
#include maps\_dialog;
#include animscripts\shared;

melee_digbat_init() {
  precachemodel("t6_wpn_machete_prop");
  precachemodel("t6_wpn_bat_barbedwire");
}

make_barbwire_digbat() {
  self animscripts\shared::placeweaponon(self.weapon, "none");
  self.digbat_melee_weapon = spawn("script_model", self gettagorigin("tag_weapon_right"));
  self.digbat_melee_weapon.angles = self gettagangles("tag_weapon_right");
  self.digbat_melee_weapon setmodel("t6_wpn_bat_barbedwire");
  self.digbat_melee_weapon linkto(self, "tag_weapon_right");

  recordent(self.digbat_melee_weapon);

  self.painoverridefunc = ::melee_digbat_pain_override;
  self set_melee_digbat_run_cycles();
  self setup_melee_digbat_anim_array();
  digbat_common_setup();
}

make_machete_digbat() {
  self.a.shortcantseeenemywait = 1;
  self animscripts\shared::placeweaponon(self.weapon, "none");
  self.digbat_melee_weapon = spawn("script_model", self gettagorigin("tag_weapon_right"));
  self.digbat_melee_weapon.angles = self gettagangles("tag_weapon_right");
  self.digbat_melee_weapon setmodel("t6_wpn_machete_prop");
  self.digbat_melee_weapon linkto(self, "tag_weapon_right");

  recordent(self.digbat_melee_weapon);

  self.painoverridefunc = ::melee_digbat_pain_override;
  self set_melee_digbat_run_cycles();
  self setup_melee_digbat_anim_array();
  digbat_common_setup();
}

#using_animtree("generic_human");

melee_digbat_pain_override() {
  self endon("death");
  painanim = undefined;
  self.blockingpain = 1;

  if(isDefined(self.damagemod) && self.damagemod == "MOD_MELEE")
    return false;

  if(self.a.movement == "run" && self.a.script != "combat") {
    if(isDefined(self.damagelocation)) {
      if(issubstr(self.damagelocation, "right"))
        painanim = % ai_digbat_melee_run_f_stumble_r;
      else if(issubstr(self.damagelocation, "left"))
        painanim = % ai_digbat_melee_run_f_stumble_l;
    }

    if(!isDefined(painanim)) {
      if(cointoss())
        painanim = % ai_digbat_melee_run_f_stumble_r;
      else
        painanim = % ai_digbat_melee_run_f_stumble_l;
    }

    self setflaggedanimknoballrestart("painanim", painanim, % body, 1, 0.1, 1.0);
    animlength = getanimlength(painanim);
    self animscripts\shared::donotetracksfortime(animlength - 0.2, "painanim");
  } else {
    if(cointoss())
      painanim = % ai_digbat_melee_idle_pain_01;
    else
      painanim = % ai_digbat_melee_idle_pain_02;

    self setflaggedanimknoballrestart("painanim", painanim, % body, 1, 0.1, 1.0);
    self animscripts\shared::donotetracks("painanim");
  }

  self.blockingpain = 0;
}

digbat_common_setup() {
  self disable_react();
  self allowedstances("stand");
  self disable_tactical_walk();
  self.disableexits = 1;
  self.disablearrivals = 1;
  self.a.disablelongdeath = 1;
  self.grenadeawareness = 0;
  self.badplaceawareness = 0;
  self.ignoresuppression = 1;
  self.suppressionthreshold = 1;
  self.grenadeammo = 0;
  self.dontshootwhilemoving = 1;
  self.a.allow_shooting = 0;
  self.a.allowevasivemovement = 0;
  self.a.neversprintforvariation = 1;
  self.noheatanims = 1;
  self.combatmode = "ambush";
  self.pathenemyfightdist = 64;
  self.a.disablereacquire = 1;
  self.a.disablewoundedset = 1;
  self thread digbat_hunt_immediately_behavior();
  self thread digbat_get_closer_if_melee_blocked();
  self thread digbat_drop_baton_on_death();
}

digbat_hunt_immediately_behavior() {
  self endon("death");

  while(true) {
    if(isDefined(self.enemy)) {
      self setgoalentity(self.enemy);
      self.goalradius = 64;
    } else {
      self setgoalpos(self.origin);
      self.goalradius = 32;
    }

    wait 0.5;
  }
}

set_melee_digbat_run_cycles() {
  self animscripts\anims::clearanimcache();
  self.a.combatrunanim = % ai_digbat_melee_run_f;
  self.run_noncombatanim = self.a.combatrunanim;
  self.walk_combatanim = self.a.combatrunanim;
  self.walk_noncombatanim = self.a.combatrunanim;
  self.alwaysrunforward = 1;
}

digbat_get_closer_if_melee_blocked() {
  self endon("death");

  while(true) {
    self waittill("melee_path_blocked");

    if(isDefined(self.enemy)) {
      self setgoalentity(self.enemy);
      self.goalradius = 32;
    } else {
      self setgoalpos(self.origin);
      self.goalradius = 32;
    }
  }
}

digbat_drop_baton_on_death() {
  self waittill("death");
  digbat_melee_weapon = self.digbat_melee_weapon;
  digbat_melee_weapon unlink();
  digbat_melee_weapon physicslaunch();
  wait 15;

  if(isDefined(digbat_melee_weapon))
    digbat_melee_weapon delete();
}

setup_digbat() {
  if(!isalive(self)) {
    return;
  }
  if(!issubstr(tolower(self.classname), "digbat")) {
    self.combatmode = "only_cover";
    return;
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "machete_digbat") {
    make_machete_digbat();

    if(level.script == "panama_2")
      self thread play_charge_vo();

    return;
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "bat_digbat") {
    make_barbwire_digbat();

    if(level.script == "panama_2")
      self thread play_charge_vo();

    return;
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "melee_digbat") {
    make_barbwire_digbat();

    if(level.script == "panama_2")
      self thread play_charge_vo();

    return;
  }

  self.combatmode = "exposed_nodes_only";
  self.moveplaybackrate = 1.2;
  self.grenadeawareness = 0;
  self.a.allow_sidearm = 0;
  self.ignoresuppression = 1;
  self.maxhealth = 200;
  self.health = 200;
  self allowedstances("stand");
  self setengagementmindist(300, 200);
  self setengagementmaxdist(512, 768);
}

play_charge_vo() {
  self endon("death");
  digbat_charge_vo = [];
  digbat_charge_vo[digbat_charge_vo.size] = "db2_kill_them_0";
  digbat_charge_vo[digbat_charge_vo.size] = "db3_die_here_american_0";

  while(true) {
    if(distance2dsquared(self.origin, level.player.origin) < 40000) {
      break;
    }

    wait 0.1;
  }

  self say_dialog(digbat_charge_vo[randomint(digbat_charge_vo.size)]);
}