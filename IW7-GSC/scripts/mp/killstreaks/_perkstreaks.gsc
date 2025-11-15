/***************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_perkstreaks.gsc
***************************************************/

init() {
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_fastsprintrecovery_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_fastreload_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_lightweight_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_marathon_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_stalker_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_reducedsway_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_quickswap_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_pitcher_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_bulletaccuracy_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_quickdraw_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_sprintreload_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_silentkill_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_blindeye_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_gpsjammer_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_quieter_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_incog_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_paint_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_scavenger_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_detectexplosive_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_selectivehearing_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_comexp_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_falldamage_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_regenfaster_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_sharp_focus_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_stun_resistance_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_blastshield_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_gunsmith_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_extraammo_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_extra_equipment_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_extra_deadly_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_extra_attachment_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_explosivedamage_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_gambler_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_hardline_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_twoprimaries_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_boom_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_deadeye_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("specialty_chain_reaction_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("teleport", ::tryuseperkstreak);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("all_perks_bonus", ::func_128D6);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("speed_boost", ::func_12904);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("refill_grenades", ::func_128FA);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("refill_ammo", ::func_128F9);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("regen_faster", ::func_128FB);
}

func_12904(param_00, param_01) {
  func_58E3("specialty_juiced", "speed_boost");
  return 1;
}

func_128FA(param_00, param_01) {
  func_58E3("specialty_refill_grenades", "refill_grenades");
  return 1;
}

func_128F9(param_00, param_01) {
  func_58E3("specialty_refill_ammo", "refill_ammo");
  return 1;
}

func_128FB(param_00, param_01) {
  func_58E3("specialty_regenfaster", "regen_faster");
  return 1;
}

func_128D6(param_00, param_01) {
  return 1;
}

tryuseperkstreak(param_00, param_01) {
  var_02 = scripts\mp\utility::strip_suffix(param_01, "_ks");
  func_5A5D(var_02);
  return 1;
}

func_5A5D(param_00) {
  scripts\mp\utility::giveperk(param_00);
  thread func_139E8(param_00);
  thread func_3E15(param_00);
  if(param_00 == "specialty_hardline") {
    scripts\mp\killstreaks\_killstreaks::func_F866();
  }

  scripts\mp\matchdata::logkillstreakevent(param_00 + "_ks", self.origin);
}

func_58E3(param_00, param_01) {
  scripts\mp\utility::giveperk(param_00);
  if(isDefined(param_01)) {
    scripts\mp\matchdata::logkillstreakevent(param_01, self.origin);
  }
}

func_139E8(param_00) {
  self endon("disconnect");
  self waittill("death");
  scripts\mp\utility::removeperk(param_00);
}

func_3E15(param_00) {
  var_01 = scripts\mp\class::canplayerplacesentry(param_00);
  if(var_01 != "specialty_null") {
    scripts\mp\utility::giveperk(var_01);
    thread func_139E8(var_01);
  }
}

func_9EE0(param_00) {
  for(var_01 = 1; var_01 < 4; var_01++) {
    if(isDefined(self.pers["killstreaks"][var_01].streakname) && self.pers["killstreaks"][var_01].streakname == param_00) {
      if(self.pers["killstreaks"][var_01].var_269A) {
        return 1;
      }
    }
  }

  return 0;
}