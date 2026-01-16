/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_loadout.gsc
*****************************************************/

init_loadout() {
  if(!isDefined(level.campaign))
    level.campaign = "american";

  give_loadout();
  maps\_loadout_code::loadout_complete();
}

give_loadout() {
  if(isDefined(level.dodgeloadout)) {
    return;
  }
  var_0 = maps\_loadout_code::get_loadout();
  level.player maps\_loadout_code::setdefaultactionslot();
  level.has_loadout = 0;
  maps\_loadout_code::campaign("british");
  maps\_loadout_code::persist("innocent", "london", "flash");
  maps\_loadout_code::loadout("london", "mp5_silencer_eotech", "fraggrenade", "flash_grenade", undefined, "viewhands_sas", "flash");
  maps\_loadout_code::loadout("innocent", "mp5_silencer_eotech", "usp_silencer", "flash_grenade", "fraggrenade", "viewhands_sas", "flash");
  maps\_loadout_code::campaign("delta");
  maps\_loadout_code::loadout("prologue", "noweapon_youngblood", undefined, undefined, undefined, "viewhands_gs_hostage", undefined);
  maps\_loadout_code::loadout("deer_hunt", "honeybadger+acog_sp", "m9a1", "fraggrenade", undefined, "viewhands_us_rangers", undefined);
  maps\_loadout_code::loadout("nml", "honeybadger+acog_sp", "p226", undefined, undefined, "viewhands_us_rangers", undefined);
  maps\_loadout_code::loadout("enemyhq", "sc2010+reflex_sp", undefined, "flash_grenade", "fraggrenade", "viewhands_us_rangers", undefined);
  maps\_loadout_code::loadout("homecoming", "cz805bren+acog_sp", "m9a1", "flash_grenade", "fraggrenade", "viewhands_us_rangers", "flash");
  maps\_loadout_code::loadout("flood", "r5rgp+reflex_sp", "p226", "flash_grenade", "fraggrenade", "viewhands_gs_flood", "flash");
  maps\_loadout_code::loadout("cornered", "imbel+acog_sp+silencer_sp", "kriss+eotechsmg_sp+silencer_sp", "flash_grenade", "fraggrenade", "viewhands_gs_stealth", "flash");
  maps\_loadout_code::loadout("oilrocks", "sc2010+acog_sp", "m9a1", "flash_grenade", "fraggrenade", "viewhands_devgru_elite", "flash");
  maps\_loadout_code::loadout("jungle_ghosts", "m4_silencer_reflex", "fraggrenade", undefined, undefined, "viewhands_gs_jungle_b", undefined);
  maps\_loadout_code::loadout("clockwork", "gm6+scopegm6_sp+silencer03_sp", "cz805bren+reflex_sp+silencer_sp", "flash_grenade", "fraggrenade", "viewhands_player_fed_army_arctic", "flash");
  maps\_loadout_code::loadout("black_ice", "r5rgp+reflex_sp", "p226", "flash_grenade", "fraggrenade", "viewhands_us_udt", "flash");
  maps\_loadout_code::loadout("ship_graveyard", "aps_underwater+swim", undefined, undefined, undefined, "viewhands_us_udt", undefined);
  maps\_loadout_code::loadout("factory", "honeybadger+grip_sp+reflex_sp", "p226_tactical+silencerpistol_sp+tactical_sp", "flash_grenade", "fraggrenade", "viewhands_devgru_elite", "flash");
  maps\_loadout_code::loadout("las_vegas", "r5rgp+acog_sp", "fraggrenade", undefined, undefined, "viewhands_gs_hostage", "flash");
  maps\_loadout_code::loadout("carrier", "g28+acog_sp", "msbs+eotech_sp", "flash_grenade", "fraggrenade", "viewhands_gs_stealth", "flash");
  maps\_loadout_code::loadout("satfarm", "lsat", "kriss+eotechsmg_sp", "flash_grenade", "fraggrenade", "viewhands_gs_stealth", "flash");
  maps\_loadout_code::loadout("loki", "arx160_space+acog_sp+glarx160_sp", undefined, undefined, undefined, "viewhands_us_space", undefined);
  maps\_loadout_code::loadout("skyway", "fads+acog_sp", "k7+reflexsmg_sp", "flash_grenade", "semtex_grenade", "viewhands_gs_stealth", "flash");
  maps\_loadout_code::loadout("youngblood", "noweapon_youngblood", undefined, undefined, undefined, "viewhands_gs_hostage", undefined);
  maps\_loadout_code::loadout("odin", "microtar_space_interior+acogsmg_sp", undefined, undefined, undefined, "viewhands_us_space", undefined);
  maps\_loadout_code::loadout("hamburg", "m4m203_acog_payback", "smaw_nolock", "flash_grenade", "fraggrenade", "viewhands_delta", "flash");
  maps\_loadout_code::loadout("prague", "rsass_hybrid_silenced", "usp_silencer", "flash_grenade", "fraggrenade", "viewhands_yuri_europe", "flash");
  maps\_loadout_code::loadout("payback", "m4m203_acog_payback", "deserteagle", "flash_grenade", "fraggrenade", "viewhands_yuri", "flash");
  maps\_loadout_code::default_loadout_if_notset();
}