main() {
  // restore scr_game_hardpoints value when game ends
  if(getdvar("g_gametype") == "gun") {
    level.saved_hardpoints_dvar = getdvar("scr_game_hardpoints");
  }

  // replace gun game weapon pool
  replacefunc(maps\mp\gametypes\gun::setguns, ::setguns_stub);

  replacefunc(maps\mp\gametypes\gun::isdedicatedmeleeweapon, ::isdedicatedmeleeweapon_stub);
}

init() {
  if(getdvar("g_gametype") == "gun") {
    thread reset_hardpoints_dvar();
  }
}

reset_hardpoints_dvar() {
  level waittill("game_ended");
  setdvar("scr_game_hardpoints", level.saved_hardpoints_dvar);
}

setguns_stub() {
  last_kill_shovel_1 = "h2_shovel";
  last_kill_shovel_2 = "h2_karambit";

  level.gun_guns = [];

  ar_additional_attachments = ["none", "reflex", "silencerar", "acog"]; // TODO: add "gl"shotgun_additional_attachments = ["none", "reflex", "foregrip"];
  shotgun_additional_attachments_akimbo = ["none", "fmj", "akimbo"];

  snipers_additional_attachments = ["none", "acog", "fmj", "silencersniper"];
  lmg_additional_attachments = ["none", "reflex", "foregrip", "acog"];
  smg_additional_attachments = ["none", "silencersmg", "reflex", "acog"];
  pistol_additional_attachments = ["none", "fmj", "akimbo"];

  default_attachments = ["none"];

  switch (level.gun_weaponlist) {
    case 0:
    default:
      maps\mp\gametypes\gun::guninfo("h2_colt45", "none", pistol_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_ak74u", "none", smg_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_m16", "none", ar_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_m240", "foregrip", lmg_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_m40a3", "none", snipers_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_m9", "none", pistol_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_p90", "none", smg_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_masada", "none", ar_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_spas12", "none", shotgun_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_wa2000", "none", snipers_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_deserteagle", "none", pistol_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_kriss", "none", smg_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_scar", "none", ar_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_mg4", "none", lmg_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_cheytac", "none", snipers_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_fal", "reflex", ar_additional_attachments); // no grenade luancher (3/18/2024)
      maps\mp\gametypes\gun::guninfo("h2_mp5k", "none", smg_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_fn2000", "none", ar_additional_attachments); // no grenade luancher (3/18/2024)
      maps\mp\gametypes\gun::guninfo("h2_model1887", "none", shotgun_additional_attachments_akimbo);
      maps\mp\gametypes\gun::guninfo("h2_barrett", "none", snipers_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_tavor", "acog", ar_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_glock", "none", pistol_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_ump45", "silencersmg", smg_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_ak47", "none", ar_additional_attachments); // has own gl attachment
      maps\mp\gametypes\gun::guninfo("h2_rpd", "reflex", lmg_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_m21", "none", snipers_additional_attachments);
      break;
    case 1:
      maps\mp\gametypes\gun::guninfo("h2_colt45", "none", pistol_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_ak74u", "silencersmg", smg_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_m16", "none", ar_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_m9", "none", pistol_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_p90", "none", smg_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_tavor", "silencerar", ar_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_spas12", "foregrip", shotgun_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_deserteagle", "none", pistol_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_kriss", "none", smg_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_scar", "none", ar_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_fal", "none", ar_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_mp5k", "silencersmg", smg_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_fn2000", "none", ar_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_model1887", "akimbo", shotgun_additional_attachments_akimbo);
      maps\mp\gametypes\gun::guninfo("h2_masada", "none", ar_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_glock", "none", pistol_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_ump45", "none", smg_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_ak47", "none", ar_additional_attachments);
      break;
    case 2:
      maps\mp\gametypes\gun::guninfo("h2_m16", "reflex", ar_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_m240", "foregrip", lmg_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_m40a3", "acog", snipers_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_masada", "none", ar_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_wa2000", "none", snipers_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_scar", "acog", ar_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_mg4", "reflex", lmg_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_cheytac", "none", snipers_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_fal", "none", ar_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_fn2000", "reflex", ar_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_barrett", "none", snipers_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_tavor", "none", ar_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_ak47", "none", ar_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_rpd", "foregrip", lmg_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_m21", "none", snipers_additional_attachments);
      break;
    case 3:
      maps\mp\gametypes\gun::guninfo("h2_m4", "none", ar_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_famas", "none", ar_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_scar", "none", ar_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_tavor", "none", ar_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_fal", "none", ar_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_m16", "none", ar_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_masada", "none", ar_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_fn2000", "none", ar_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_ak47", "none", ar_additional_attachments);
      break;
    case 4:
      maps\mp\gametypes\gun::guninfo("h2_uzi", "none", smg_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_ak74u", "none", smg_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_p90", "none", smg_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_kriss", "none", smg_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_mp5k", "none", smg_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_ump45", "none", smg_additional_attachments);
      break;
    case 5:
      maps\mp\gametypes\gun::guninfo("h2_m40a3", "none", snipers_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_wa2000", "none", snipers_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_cheytac", "none", snipers_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_barrett", "none", snipers_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_m21", "none", snipers_additional_attachments);
      break;
    case 6:
      maps\mp\gametypes\gun::guninfo("h2_spas12", "none", shotgun_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_aa12", "none", shotgun_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_striker", "none", shotgun_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_ranger", "none", shotgun_additional_attachments_akimbo);
      maps\mp\gametypes\gun::guninfo("h2_model1887", "none", shotgun_additional_attachments_akimbo);
      maps\mp\gametypes\gun::guninfo("h2_winchester1200", "none", shotgun_additional_attachments); // should have foregrip
      maps\mp\gametypes\gun::guninfo("h2_m1014", "none", shotgun_additional_attachments); // should have foregrip
      break;
    case 7:
      maps\mp\gametypes\gun::guninfo("h2_m240", "none", lmg_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_mg4", "none", lmg_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_rpd", "none", lmg_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_aug", "none", lmg_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_sa80", "none", lmg_additional_attachments);
      break;
    case 8:
      maps\mp\gametypes\gun::guninfo("h2_pp2000", "none", pistol_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_glock", "none", pistol_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_beretta393", "none", pistol_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_tmp", "none", pistol_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_usp", "none", pistol_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_coltanaconda", "none", default_attachments); // pistol_additional_attachments
      maps\mp\gametypes\gun::guninfo("h2_m9", "none", pistol_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_colt45", "none", pistol_additional_attachments);
      maps\mp\gametypes\gun::guninfo("h2_deserteagle", "none", pistol_additional_attachments);
      break;
    case 9:
      maps\mp\gametypes\gun::guninfo("at4", "none", default_attachments);
      maps\mp\gametypes\gun::guninfo("h2_m79", "none", default_attachments);
      maps\mp\gametypes\gun::guninfo("h2_rpg", "none", default_attachments);

      // TODO: grenade launchers later
      /*
      maps\mp\gametypes\gun::guninfo("h2_m16", "gl", ar_additional_attachments2, 1);
      maps\mp\gametypes\gun::guninfo("h2_scar", "gl", ar_additional_attachments2, 1);
      maps\mp\gametypes\gun::guninfo("h2_fal", "gl", ar_additional_attachments2, 1);
      maps\mp\gametypes\gun::guninfo("h2_fn2000", "gl", ar_additional_attachments2, 1);
      maps\mp\gametypes\gun::guninfo("h2_tavor", "gl", ar_additional_attachments2, 1);
      maps\mp\gametypes\gun::guninfo("h2_ak47", "gl", ar_additional_attachments2, 1);
      */
      break;
  }

  switch (level.gun_weaponorder) {
    case 0:
    default:
      break;
    case 1:
      level.gun_guns = common_scripts\utility::array_randomize(level.gun_guns);
      break;
    case 2:
      level.gun_guns = common_scripts\utility::array_reverse(level.gun_guns);
      break;
  }

  switch (level.gun_weaponlistend) {
    case 0:
    case 1:
    case 2:
      maps\mp\gametypes\gun::guninfo(last_kill_shovel_1, "none", default_attachments);
      break;
    case 2:
    case 3:
    default:
      maps\mp\gametypes\gun::guninfo(last_kill_shovel_2, "none", default_attachments);
      break;
  }
}

isdedicatedmeleeweapon_stub(var_0) {
  if(var_0 == "h2_shovel_mp" || var_0 == "h2_karambit_mp" || var_0 == "h2_sickle_mp" || var_0 == "h2_hatchet_mp" || var_0 == "h2_icepick_mp")
    return 1;

  return 0;
}