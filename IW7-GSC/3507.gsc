/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3507.gsc
***************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_fastsprintrecovery_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_fastreload_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_lightweight_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_marathon_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_stalker_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_reducedsway_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_quickswap_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_pitcher_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_bulletaccuracy_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_quickdraw_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_sprintreload_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_silentkill_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_blindeye_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_gpsjammer_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_quieter_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_incog_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_paint_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_scavenger_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_detectexplosive_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_selectivehearing_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_comexp_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_falldamage_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_regenfaster_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_sharp_focus_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_stun_resistance_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_blastshield_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_gunsmith_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_extraammo_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_extra_equipment_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_extra_deadly_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_extra_attachment_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_explosivedamage_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_gambler_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_hardline_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_twoprimaries_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_boom_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_deadeye_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialty_chain_reaction_ks", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("teleport", ::tryuseperkstreak);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("all_perks_bonus", ::func_128D6);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("speed_boost", ::func_12904);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("refill_grenades", ::func_128FA);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("refill_ammo", ::func_128F9);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("regen_faster", ::func_128FB);
}

func_12904(var_00, var_01) {
  func_58E3("specialty_juiced", "speed_boost");
  return 1;
}

func_128FA(var_00, var_01) {
  func_58E3("specialty_refill_grenades", "refill_grenades");
  return 1;
}

func_128F9(var_00, var_01) {
  func_58E3("specialty_refill_ammo", "refill_ammo");
  return 1;
}

func_128FB(var_00, var_01) {
  func_58E3("specialty_regenfaster", "regen_faster");
  return 1;
}

func_128D6(var_00, var_01) {
  return 1;
}

tryuseperkstreak(var_00, var_01) {
  var_02 = scripts\mp\utility\game::strip_suffix(var_01, "_ks");
  func_5A5D(var_02);
  return 1;
}

func_5A5D(var_00) {
  scripts\mp\utility\game::giveperk(var_00);
  thread func_139E8(var_00);
  thread func_3E15(var_00);

  if(var_00 == "specialty_hardline") {
    scripts\mp\killstreaks\killstreaks::func_F866();
  }

  scripts\mp\matchdata::logkillstreakevent(var_00 + "_ks", self.origin);
}

func_58E3(var_00, var_01) {
  scripts\mp\utility\game::giveperk(var_00);

  if(isDefined(var_01)) {
    scripts\mp\matchdata::logkillstreakevent(var_01, self.origin);
  }
}

func_139E8(var_00) {
  self endon("disconnect");
  self waittill("death");
  scripts\mp\utility\game::removeperk(var_00);
}

func_3E15(var_00) {
  var_01 = scripts\mp\class::canplayerplacesentry(var_00);

  if(var_01 != "specialty_null") {
    scripts\mp\utility\game::giveperk(var_01);
    thread func_139E8(var_01);
  }
}

func_9EE0(var_00) {
  for(var_01 = 1; var_01 < 4; var_1++) {
    if(isDefined(self.pers["killstreaks"][var_01].streakname) && self.pers["killstreaks"][var_01].streakname == var_00) {
      if(self.pers["killstreaks"][var_01].func_269A) {
        return 1;
      }
    }
  }

  return 0;
}