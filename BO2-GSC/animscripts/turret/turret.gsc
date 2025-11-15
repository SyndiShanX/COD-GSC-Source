/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\turret\turret.gsc
*****************************************/

#include maps\_turret;
#include animscripts\utility;
#include animscripts\shared;

get_turret_anim(weapon_name, anim_name) {
  str_pose = self.desired_anim_pose;

  if(!isDefined(str_pose))
    str_pose = self.a.pose;

  if(issubstr(weapon_name, "bipod"))
    weapon_name = "bipod";

  return anim.anim_array[self.animtype][self.a.movement][str_pose][weapon_name][anim_name];
}

#using_animtree("generic_human");

main() {
  e_turret = self getturret();

  if(!isDefined(e_turret)) {
    return;
  }
  self.primaryturretanim = get_turret_anim(e_turret.weaponinfo, "aim");
  self.additiveturretidle = get_turret_anim(e_turret.weaponinfo, "idle");
  self.additiveturretfire = get_turret_anim(e_turret.weaponinfo, "fire");
  self endon("killanimscript");
  e_turret maps\_turret::_animscripts_init(self);
  animscripts\utility::initialize("turret");
  self.a.special = "turret";
  self animscripts\shared::placeweaponon(self.weapon, "none");

  if(isDefined(e_turret.aiowner)) {
    assert(e_turret.aiowner == self);
    self.a.postscriptfunc = ::post_script_func;
    self.a.usingturret = e_turret;
    e_turret notify("being_used");
    self thread stop_using_turret_when_node_lost();
  } else
    self.a.postscriptfunc = ::preplaced_post_script_func;

  self setturretanim(self.primaryturretanim);
  self setanimknobrestart(self.primaryturretanim, 1, 0.2, 1);
  self setanimknoblimitedrestart(self.additiveturretidle);
  self setanimknoblimitedrestart(self.additiveturretfire);
  self setanim( % additive_turret_idle, 1, 0.1);
  self setanim( % additive_turret_fire, 0, 0.1);

  while(true) {
    e_turret waittill("shooting");
    self setanim( % additive_turret_idle, 0, 0.1);
    self setanim( % additive_turret_fire, 1, 0.1);
    e_turret waittill("idle");
    self setanim( % additive_turret_idle, 1, 0.1);
    self setanim( % additive_turret_fire, 0, 0.1);
  }
}

stop_using_turret_when_node_lost() {
  self endon("killanimscript");

  while(true) {
    if(!isDefined(self.node) || distancesquared(self.origin, self.node.origin) > 4096)
      self stopuseturret();

    wait 0.25;
  }
}

post_script_func(animscript) {
  if(animscript == "pain") {
    if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < 4096) {
      self.a.usingturret hide();
      self animscripts\shared::placeweaponon(self.primaryweapon, "right");
      self.a.postscriptfunc = ::post_pain_func;
      return;
    } else
      self stopuseturret();
  }

  assert(self.a.usingturret.aiowner == self);

  if(animscript == "saw") {
    turret = self getturret();
    assert(isDefined(turret) && turret == self.a.usingturret);
    return;
  }

  self.a.usingturret delete();
  self.a.usingturret = undefined;
  self animscripts\shared::placeweaponon(self.primaryweapon, "right");
}

post_pain_func(animscript) {
  assert(isDefined(self.a.usingturret));
  assert(self.a.usingturret.aiowner == self);

  if(!isDefined(self.node) || distancesquared(self.origin, self.node.origin) > 4096) {
    self stopuseturret();
    self.a.usingturret delete();
    self.a.usingturret = undefined;

    if(isDefined(self.weapon) && self.weapon != "none")
      self animscripts\shared::placeweaponon(self.weapon, "right");
  } else if(animscript != "saw")
    self.a.usingturret delete();
}

preplaced_post_script_func(animscript) {
  self animscripts\shared::placeweaponon(self.primaryweapon, "right");
}