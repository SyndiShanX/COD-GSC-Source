/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_mpla_unita.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include animscripts\utility;
#include animscripts\combat_utility;
#include animscripts\anims_table;
#include animscripts\anims_table_mpla;
#include animscripts\shared;
#include animscripts\anims;

melee_mpla_init() {
  precachemodel("t6_wpn_machete_prop");
  level._effect["flesh_hit_machete"] = loadfx("impacts/fx_flesh_hit_machete");
}

setup_mpla() {
  if(!issubstr(tolower(self.classname), "mpla") && !issubstr(tolower(self.classname), "unita")) {
    return;
  }
  if(usingrocketlauncher())
    self.animtype = "default";

  machete_scripted = isDefined(self.script_noteworthy) && self.script_noteworthy == "machete_scripted" || isDefined(self.script_string) && self.script_string == "machete_scripted";
  machete_hunter = isDefined(self.script_noteworthy) && self.script_noteworthy == "machete_hunter";
  melee_machete = isDefined(self.script_noteworthy) && self.script_noteworthy == "machete" || isDefined(self.script_string) && self.script_string == "machete";

  if(machete_scripted || machete_hunter || melee_machete) {
    make_machete_mpla(melee_machete);
    return;
  }

  make_default_mpla();
}

make_default_mpla() {
  self disable_react();
  self.grenadeawareness = 0;
  self.badplaceawareness = 0;
  self.ignoresuppression = 1;
  self.suppressionthreshold = 1;
  self.grenadeammo = 0;
  self.a.allowevasivemovement = 0;
  self.a.neversprintforvariation = 1;
  self.noheatanims = 1;
  self.pathenemyfightdist = 64;
  self.a.allow_sidearm = 0;
  self.a.disablewoundedset = 1;
  self.a.doexposedblindfire = 0;
  self.meleechargedistsq = 250000;
  self.canexecutemeleesequenceoverride = ::mpla_melee_aivsai_canexecute;
  self.meleesequenceoverride = ::mpla_melee_aivsai;
}

make_machete_mpla(melee_machete) {
  if(!is_true(melee_machete))
    self animscripts\shared::placeweaponon(self.weapon, "none");

  self.mpla_melee_weapon = spawn("script_model", self gettagorigin("tag_weapon_right"));
  self.mpla_melee_weapon.angles = self gettagangles("tag_weapon_right");
  self.mpla_melee_weapon setmodel("t6_wpn_machete_prop");
  self.mpla_melee_weapon linkto(self, "tag_weapon_right");
  self.mpla_melee_weapon hide();
  self.meleechargedistsq = 129600;
  self.canexecutemeleesequenceoverride = ::mpla_melee_aivsai_canexecute;
  self.meleesequenceoverride = ::mpla_melee_aivsai;
  self.meleenotetrackhandler = ::mpla_melee_notetrackhandler;
  self.meleeendfunc = ::mpla_melee_endfunc;
  self.special_knife_attack_fx_name = "flesh_hit_machete";
  self.special_knife_attack_fx_tag = "tag_blood_fx";
  self.melee_weapon_ent = self.mpla_melee_weapon;

  if(!is_true(melee_machete))
    machete_mpla_get_ready_for_melee();
}

machete_mpla_get_ready_for_melee(melee_machete) {
  self.mpla_melee_weapon show();

  recordent(self.mpla_melee_weapon);

  self.painoverridefunc = ::melee_mpla_pain_override;
  self.hasknifelikeweapon = 1;
  self set_mpla_run_cycles();
  self setup_melee_mpla_anim_array();
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
  self.a.disablewoundedset = 1;
  self.pathenemyfightdist = 128;
  self.a.doexposedblindfire = 0;
  self.a.disablereacquire = 1;
  self.a.meleedontrestoreweapon = 1;
  self.a.disable120runngun = 1;
  self.a.shortcantseeenemywait = 1;

  if(!is_true(melee_machete) && self.team != "allies")
    self thread mpla_hunt_immediately_behavior();

  self thread mpla_drop_baton_on_death();
}

#using_animtree("generic_human");

melee_mpla_pain_override() {
  self endon("death");
  painanim = undefined;
  self.blockingpain = 1;

  if(isDefined(self.damagemod) && self.damagemod == "MOD_MELEE")
    return false;

  if(self.a.movement == "run" && !isDefined(self.melee)) {
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

    self setflaggedanimknoballrestart("meleepainanim", painanim, % body, 1, 0.1, 1.0);
    animlength = getanimlength(painanim);
    self animscripts\shared::donotetracksfortime(animlength - 0.2, "meleepainanim");
  } else {
    if(cointoss())
      painanim = % ai_digbat_melee_idle_pain_01;
    else
      painanim = % ai_digbat_melee_idle_pain_02;

    self setflaggedanimknoballrestart("meleepainanim", painanim, % body, 1, 0.1, 1.0);
    animlength = getanimlength(painanim);
    self animscripts\shared::donotetracksfortime(animlength - 0.2, "meleepainanim");
  }

  self.blockingpain = 0;
}

mpla_get_closer_if_melee_blocked() {
  self endon("death");

  while(true) {
    self waittill("melee_path_blocked");

    if(isDefined(level.player)) {
      self setentitytarget(level.player);
      self setgoalentity(level.player);
      self.goalradius = 128;
    } else {
      self setgoalpos(self.origin);
      self.goalradius = 32;
    }
  }
}

mpla_hunt_immediately_behavior() {
  self endon("death");

  if(self.team != "axis") {
    return;
  }
  self thread mpla_get_closer_if_melee_blocked();

  while(true) {
    if(isDefined(level.player)) {
      self setentitytarget(level.player);
      self setgoalentity(level.player);
      self.goalradius = 128;
    }

    wait 0.5;
  }
}

set_mpla_run_cycles() {
  self animscripts\anims::clearanimcache();
  self.a.combatrunanim = % ai_digbat_melee_run_f;
  self.run_noncombatanim = self.a.combatrunanim;
  self.walk_combatanim = self.a.combatrunanim;
  self.walk_noncombatanim = self.a.combatrunanim;
  self.alwaysrunforward = 1;
}

mpla_drop_baton_on_death() {
  self waittill("death");
  mpla_melee_weapon = self.mpla_melee_weapon;
  mpla_melee_weapon unlink();
  mpla_melee_weapon physicslaunch();
  wait 15;

  if(isDefined(mpla_melee_weapon))
    mpla_melee_weapon delete();
}

is_machete_mpla() {
  return isalive(self) && isDefined(self.mpla_melee_weapon);
}

is_rifle_mpla() {
  return isalive(self) && !isDefined(self.mpla_melee_weapon);
}

mpla_melee_aivsai(anglediff) {
  anglethreshold = 100;

  if(self.melee.inprogress)
    anglethreshold = anglethreshold + 50;

  if(abs(anglediff) < anglethreshold)
    return false;

  target = self.melee.target;

  if(isDefined(target.magic_bullet_shield))
    return false;

  if(isDefined(target.meleealwayswin)) {
    assert(!isDefined(self.magic_bullet_shield));
    return false;
  }

  self.melee.winner = 1;

  if(self.melee.winner) {
    self.melee.death = undefined;
    target.melee.death = 1;
  } else {
    target.melee.death = undefined;
    self.melee.death = 1;
  }

  self.a.deathforceragdoll = 1;
  target.a.deathforceragdoll = 1;
  disttotarget = distance2dsquared(self.origin, target.origin);
  meleeseqs = [];

  if(is_machete_mpla() && target is_rifle_mpla()) {
    if(disttotarget >= 115600) {
      if(cointoss())
        meleeseqs[meleeseqs.size] = "frontal_dodge_277";
      else {
        meleeseqs[meleeseqs.size] = "frontal_dodge_210";
        meleeseqs[meleeseqs.size] = "frontal_dodge_140";
        meleeseqs[meleeseqs.size] = "frontal_dodge_70";
      }
    } else if(disttotarget >= 44100) {
      meleeseqs[meleeseqs.size] = "frontal_dodge_210";
      meleeseqs[meleeseqs.size] = "frontal_dodge_140";
      meleeseqs[meleeseqs.size] = "frontal_dodge_70";
    } else if(disttotarget >= 19600) {
      meleeseqs[meleeseqs.size] = "frontal_dodge_140";
      meleeseqs[meleeseqs.size] = "frontal_dodge_70";
    } else if(disttotarget >= 4900)
      meleeseqs[meleeseqs.size] = "frontal_dodge_70";
  } else if(is_rifle_mpla() && target is_machete_mpla()) {
    if(disttotarget >= 19600)
      meleeseqs[meleeseqs.size] = "rifle_machete_133";
  } else if(is_machete_mpla() && target is_machete_mpla()) {
    if(disttotarget >= 115600)
      meleeseqs[meleeseqs.size] = "machete_machete_314";
  }

  if(meleeseqs.size > 0) {
    meleeseq = meleeseqs[randomintrange(0, meleeseqs.size)];
    mpla_melee_aivsai_setmeleeseqanims(meleeseq, target);
    return true;
  }

  return false;
}

mpla_melee_aivsai_canexecute() {
  target = self.melee.target;

  if(is_machete_mpla() && target is_rifle_mpla())
    return true;
  else if(is_rifle_mpla() && target is_machete_mpla())
    return true;
  else if(is_machete_mpla() && target is_machete_mpla())
    return true;

  return false;
}

mpla_melee_aivsai_setmeleeseqanims(meleeseq, target) {
  switch (meleeseq) {
    case "frontal_dodge_277":
      self.melee.animname = % ai_melee_rm_mwin_f_02_m;
      target.melee.animname = % ai_melee_rm_mwin_f_02_r;
      break;
    case "frontal_dodge_210":
      self.melee.animname = % ai_melee_rm_mwin_f_01_210_m;
      target.melee.animname = % ai_melee_rm_mwin_f_01_210_r;
      break;
    case "frontal_dodge_140":
      self.melee.animname = % ai_melee_rm_mwin_f_01_140_m;
      target.melee.animname = % ai_melee_rm_mwin_f_01_140_r;
      break;
    case "frontal_dodge_70":
      self.melee.animname = % ai_melee_rm_mwin_f_01_70_m;
      target.melee.animname = % ai_melee_rm_mwin_f_01_70_r;
      break;
    case "rifle_machete_133":
      self.melee.animname = % ai_melee_rm_rwin_f_01_r;
      target.melee.animname = % ai_melee_rm_rwin_f_01_m;
      break;
    case "machete_machete_314":
      self.melee.animname = % ai_melee_mm_awin_f_01_attack;
      target.melee.animname = % ai_melee_mm_awin_f_01_defend;
      break;
    default:

      assertmsg("Unsupported meleeSeq" + meleeseq);

  }
}

mpla_melee_notetrackhandler(note) {
  if(note == "drop rifle") {
    self.dropped_weapon_before_melee = 1;
    self animscripts\shared::dropaiweapon();
    self animscripts\shared::placeweaponon(self.weapon, "none");
  } else if(note == "attach machete right") {
    self.got_machete_attached = 1;
    self machete_mpla_get_ready_for_melee();
  }
}

mpla_melee_endfunc() {
  self.a.deathforceragdoll = 0;

  if(is_machete_mpla() && self.team != "allies") {
    if(is_true(self.dropped_weapon_before_melee)) {
      self animscripts\shared::dropaiweapon();
      self animscripts\shared::placeweaponon(self.weapon, "none");

      if(!is_true(self.got_machete_attached)) {
        self.got_machete_attached = 1;
        self machete_mpla_get_ready_for_melee();
      }

      self.hunting_player = 1;
      self thread mpla_hunt_immediately_behavior();
    }

    if(!is_true(self.dropped_weapon_before_melee)) {
      self.dropped_weapon_before_melee = 1;
      self animscripts\shared::dropaiweapon();
      self animscripts\shared::placeweaponon(self.weapon, "none");
      self.got_machete_attached = 1;
      self machete_mpla_get_ready_for_melee();
      self.hunting_player = 1;
      self thread mpla_hunt_immediately_behavior();
    }

    if(is_true(self.got_machete_attached)) {
      self.dropped_weapon_before_melee = 1;
      self animscripts\shared::dropaiweapon();
      self animscripts\shared::placeweaponon(self.weapon, "none");
      self.got_machete_attached = 1;
      self machete_mpla_get_ready_for_melee();

      if(!is_true(self.hunting_player))
        self thread mpla_hunt_immediately_behavior();
    }
  }
}