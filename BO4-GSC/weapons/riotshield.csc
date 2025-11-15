/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\riotshield.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\util_shared;

#namespace riotshield;

init_shared() {
  clientfield::register("scriptmover", "riotshield_state", 1, 2, "int", &shield_state_change, 0, 0);
  level._effect[#"riotshield_light"] = #"_t6/weapon/riotshield/fx_riotshield_depoly_lights";
  level._effect[#"riotshield_dust"] = #"_t6/weapon/riotshield/fx_riotshield_depoly_dust";
}

shield_state_change(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  switch (newval) {
    case 1:
      instant = oldval == 2;
      self thread riotshield_deploy_anim(localclientnum, instant);
      break;
    case 2:
      self thread riotshield_destroy_anim(localclientnum);
      break;
  }
}

riotshield_deploy_anim(localclientnum, instant) {
  self endon(#"death");
  self thread watch_riotshield_damage();
  self util::waittill_dobj(localclientnum);
  self useanimtree("generic");

  if(instant) {
    self setanimtime(#"o_riot_stand_deploy", 1);
  } else {
    self setanim(#"o_riot_stand_deploy", 1, 0, 1);
    util::playFXOnTag(localclientnum, level._effect[#"riotshield_dust"], self, "tag_origin");
  }

  if(!instant) {
    wait 0.8;
  }

  self.shieldlightfx = util::playFXOnTag(localclientnum, level._effect[#"riotshield_light"], self, "tag_fx");
}

watch_riotshield_damage() {
  self endon(#"death");

  while(true) {
    waitresult = self waittill(#"damage");
    damage_type = waitresult.mod;
    self useanimtree("generic");

    if(damage_type == "MOD_MELEE" || damage_type == "MOD_MELEE_WEAPON_BUTT" || damage_type == "MOD_MELEE_ASSASSINATE") {
      self setanim(#"o_riot_stand_melee_front", 1, 0, 1);
      continue;
    }

    self setanim(#"o_riot_stand_shot", 1, 0, 1);
  }
}

riotshield_destroy_anim(localclientnum) {
  self endon(#"death");

  if(isDefined(self.shieldlightfx)) {
    stopfx(localclientnum, self.shieldlightfx);
  }

  waitframe(1);
  self playSound(localclientnum, #"wpn_shield_destroy");
  self useanimtree("generic");
  self setanim(#"o_riot_stand_destroyed", 1, 0, 1);
  wait 1;
  self setforcenotsimple();
}