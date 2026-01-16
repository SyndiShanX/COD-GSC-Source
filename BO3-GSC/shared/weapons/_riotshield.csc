/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\weapons\_riotshield.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using_animtree("mp_riotshield");
#namespace riotshield;

function init_shared() {
  clientfield::register("scriptmover", "riotshield_state", 1, 2, "int", & shield_state_change, 0, 0);
  level._effect["riotshield_light"] = "_t6/weapon/riotshield/fx_riotshield_depoly_lights";
  level._effect["riotshield_dust"] = "_t6/weapon/riotshield/fx_riotshield_depoly_dust";
}

function shield_state_change(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  switch (newval) {
    case 1: {
      instant = oldval == 2;
      self thread riotshield_deploy_anim(localclientnum, instant);
      break;
    }
    case 2: {
      self thread riotshield_destroy_anim(localclientnum);
      break;
    }
  }
}

function riotshield_deploy_anim(localclientnum, instant) {
  self endon("entityshutdown");
  self thread watch_riotshield_damage();
  self util::waittill_dobj(localclientnum);
  self useanimtree($mp_riotshield);
  if(instant) {
    self setanimtime( % mp_riotshield::o_riot_stand_deploy, 1);
  } else {
    self setanim( % mp_riotshield::o_riot_stand_deploy, 1, 0, 1);
    playfxontag(localclientnum, level._effect["riotshield_dust"], self, "tag_origin");
  }
  if(!instant) {
    wait(0.8);
  }
  self.shieldlightfx = playfxontag(localclientnum, level._effect["riotshield_light"], self, "tag_fx");
}

function watch_riotshield_damage() {
  self endon("entityshutdown");
  while (true) {
    self waittill("damage", damage_loc, damage_type);
    self useanimtree($mp_riotshield);
    if(damage_type == "MOD_MELEE" || damage_type == "MOD_MELEE_WEAPON_BUTT" || damage_type == "MOD_MELEE_ASSASSINATE") {
      self setanim( % mp_riotshield::o_riot_stand_melee_front, 1, 0, 1);
    } else {
      self setanim( % mp_riotshield::o_riot_stand_shot, 1, 0, 1);
    }
  }
}

function riotshield_destroy_anim(localclientnum) {
  self endon("entityshutdown");
  if(isdefined(self.shieldlightfx)) {
    stopfx(localclientnum, self.shieldlightfx);
  }
  wait(0.05);
  self playsound(localclientnum, "wpn_shield_destroy");
  self useanimtree($mp_riotshield);
  self setanim( % mp_riotshield::o_riot_stand_destroyed, 1, 0, 1);
  wait(1);
  self setforcenotsimple();
}