/***************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\perks\_perks.gsc
***************************************/

init() {
  level thread scripts\mp\perks\_weaponpassives::weaponpassivesinit();
  level.var_CA51 = [];
  level.var_108D3["enemy"] = "tactical_insertion_marker_wm_dropmodel";
  level.var_108D3["friendly"] = "tactical_insertion_marker_wm_dropmodel";
  level.var_108D2["enemy"] = loadfx("vfx\core\mp\core\vfx_flare_glow_en.vfx");
  level.var_108D2["friendly"] = loadfx("vfx\core\mp\core\vfx_flare_glow_fr.vfx");
  level.var_10888 = loadfx("vfx\props\barrelexp.vfx");
  level._effect["ricochet"] = loadfx("vfx\core\impacts\large_metalhit_1");
  level._effect["tracker_cloak_tag"] = loadfx("vfx\iw7\_requests\mp\vfx_tesla_shock_sparks_tracker.vfx");
  level.menuperks = [];
  level.scriptperks = [];
  level.perksetfuncs = [];
  level.perkunsetfuncs = [];
  level.extraperkmap = [];
  level.menurigperks = [];
  level.scriptperks["specialty_afterburner"] = 1;
  level.scriptperks["specialty_blastshield"] = 1;
  level.scriptperks["specialty_autospot"] = 1;
  level.scriptperks["specialty_boom"] = 1;
  level.scriptperks["specialty_delaymine"] = 1;
  level.scriptperks["specialty_dexterity"] = 1;
  level.scriptperks["specialty_empimmune"] = 1;
  level.scriptperks["specialty_engineer"] = 1;
  level.scriptperks["specialty_explosivedamage"] = 1;
  level.scriptperks["specialty_extraammo"] = 1;
  level.scriptperks["specialty_falldamage"] = 1;
  level.scriptperks["specialty_ghost"] = 1;
  level.scriptperks["specialty_hard_shell"] = 1;
  level.scriptperks["specialty_hardline"] = 1;
  level.scriptperks["specialty_powercell"] = 1;
  level.scriptperks["specialty_hunter"] = 1;
  level.scriptperks["specialty_incog"] = 1;
  level.scriptperks["specialty_localjammer"] = 1;
  level.scriptperks["specialty_overclock"] = 1;
  level.scriptperks["specialty_outlinekillstreaks"] = 1;
  level.scriptperks["specialty_pitcher"] = 1;
  level.scriptperks["specialty_regenfaster"] = 1;
  level.scriptperks["specialty_stun_resistance"] = 1;
  level.scriptperks["specialty_tracker"] = 1;
  level.scriptperks["specialty_twoprimaries"] = 1;
  level.scriptperks["specialty_bullet_outline"] = 1;
  level.scriptperks["specialty_activereload"] = 1;
  level.scriptperks["specialty_sixth_sense"] = 1;
  level.scriptperks["specialty_enhanced_sixth_sense"] = 1;
  level.scriptperks["specialty_meleekill"] = 1;
  level.scriptperks["specialty_gung_ho"] = 1;
  level.scriptperks["specialty_man_at_arms"] = 1;
  level.scriptperks["specialty_blast_suppressor"] = 1;
  level.scriptperks["specialty_momentum"] = 1;
  level.scriptperks["specialty_improvedmelee"] = 1;
  level.scriptperks["specialty_thief"] = 1;
  level.scriptperks["specialty_silentkill"] = 1;
  level.scriptperks["specialty_armorpiercingks"] = 1;
  level.scriptperks["specialty_fastcrouch"] = 1;
  level.scriptperks["specialty_battleslide"] = 1;
  level.scriptperks["specialty_battleslide_offense"] = 1;
  level.scriptperks["specialty_battleslide_shield"] = 1;
  level.scriptperks["specialty_disruptor_punch"] = 1;
  level.scriptperks["specialty_ground_pound"] = 1;
  level.scriptperks["specialty_ground_pound_shield"] = 1;
  level.scriptperks["specialty_ground_pound_shock"] = 1;
  level.scriptperks["specialty_thruster"] = 1;
  level.scriptperks["specialty_dodge"] = 1;
  level.scriptperks["specialty_extra_dodge"] = 1;
  level.scriptperks["specialty_extend_dodge"] = 1;
  level.scriptperks["specialty_phase_slide"] = 1;
  level.scriptperks["specialty_tele_slide"] = 1;
  level.scriptperks["specialty_phaseslash"] = 1;
  level.scriptperks["specialty_phaseslash_rephase"] = 1;
  level.scriptperks["specialty_phase_fall"] = 1;
  level.scriptperks["specialty_aura_regen"] = 1;
  level.scriptperks["specialty_aura_quickswap"] = 1;
  level.scriptperks["specialty_aura_speed"] = 1;
  level.scriptperks["specialty_mark_targets"] = 1;
  level.scriptperks["specialty_batterypack"] = 1;
  level.scriptperks["specialty_camo_elite"] = 1;
  level.scriptperks["specialty_scorestreakpack"] = 1;
  level.scriptperks["specialty_superpack"] = 1;
  level.scriptperks["specialty_dodge_defense"] = 1;
  level.scriptperks["specialty_spawncloak"] = 1;
  level.scriptperks["specialty_commando"] = 1;
  level.scriptperks["specialty_personal_trophy"] = 1;
  level.scriptperks["specialty_equipment_ping"] = 1;
  level.scriptperks["specialty_rugged_eqp"] = 1;
  level.scriptperks["specialty_cloak"] = 1;
  level.scriptperks["specialty_wall_lock"] = 1;
  level.scriptperks["specialty_rush"] = 1;
  level.scriptperks["specialty_hover"] = 1;
  level.scriptperks["specialty_scavenger_eqp"] = 1;
  level.scriptperks["specialty_spawnview"] = 1;
  level.scriptperks["specialty_headgear"] = 1;
  level.scriptperks["specialty_ftlslide"] = 1;
  level.scriptperks["specialty_improved_prone"] = 1;
  level.scriptperks["specialty_support_killstreaks"] = 1;
  level.scriptperks["specialty_overrideweaponspeed"] = 1;
  level.scriptperks["specialty_ballcarrier"] = 1;
  level.scriptperks["specialty_cloak_aerial"] = 1;
  level.scriptperks["specialty_spawn_radar"] = 1;
  level.scriptperks["specialty_ads_awareness"] = 1;
  level.scriptperks["specialty_rearguard"] = 1;
  level.scriptperks["specialty_sharp_focus"] = 1;
  level.scriptperks["specialty_bling"] = 1;
  level.scriptperks["specialty_moredamage"] = 1;
  level.scriptperks["specialty_comexp"] = 1;
  level.scriptperks["specialty_paint"] = 1;
  level.scriptperks["specialty_paint_pro"] = 1;
  level.scriptperks["specialty_adrenaline"] = 1;
  level.scriptperks["specialty_adrenaline_lite"] = 1;
  level.scriptperks["specialty_block_health_regen"] = 1;
  level.scriptperks["specialty_rshieldradar"] = 1;
  level.scriptperks["specialty_rshieldscrambler"] = 1;
  level.scriptperks["specialty_combathigh"] = 1;
  level.scriptperks["specialty_finalstand"] = 1;
  level.scriptperks["specialty_c4death"] = 1;
  level.scriptperks["specialty_juiced"] = 1;
  level.scriptperks["specialty_revenge"] = 1;
  level.scriptperks["specialty_light_armor"] = 1;
  level.scriptperks["specialty_carepackage"] = 1;
  level.scriptperks["specialty_stopping_power"] = 1;
  level.scriptperks["specialty_uav"] = 1;
  level.scriptperks["specialty_viewkickoverride"] = 1;
  level.scriptperks["specialty_affinityspeedboost"] = 1;
  level.scriptperks["specialty_affinityextralauncher"] = 1;
  level.scriptperks["bouncingbetty_mp"] = 1;
  level.scriptperks["c4_mp"] = 1;
  level.scriptperks["claymore_mp"] = 1;
  level.scriptperks["frag_grenade_mp"] = 1;
  level.scriptperks["semtex_mp"] = 1;
  level.scriptperks["cluster_grenade_mp"] = 1;
  level.scriptperks["throwingknife_mp"] = 1;
  level.scriptperks["throwingknifec4_mp"] = 1;
  level.scriptperks["throwingknifeteleport_mp"] = 1;
  level.scriptperks["throwingknifejugg_mp"] = 1;
  level.scriptperks["throwingknifesmokewall_mp"] = 1;
  level.scriptperks["proximity_explosive_mp"] = 1;
  level.scriptperks["mortar_shelljugg_mp"] = 1;
  level.scriptperks["case_bomb_mp"] = 1;
  level.scriptperks["blackhole_grenade_mp"] = 1;
  level.scriptperks["throwingreaper_mp"] = 1;
  level.scriptperks["transponder_mp"] = 1;
  level.scriptperks["sonic_sensor_mp"] = 1;
  level.scriptperks["sticky_mine_mp"] = 1;
  level.scriptperks["throwingknifedisruptor_mp"] = 1;
  level.scriptperks["pulse_grenade_mp"] = 1;
  level.scriptperks["portal_grenade_mp"] = 1;
  level.scriptperks["virus_grenade_mp"] = 1;
  level.scriptperks["concussion_grenade_mp"] = 1;
  level.scriptperks["sensor_grenade_mp"] = 1;
  level.scriptperks["gravity_grenade_mp"] = 1;
  level.scriptperks["flash_grenade_mp"] = 1;
  level.scriptperks["smoke_grenade_mp"] = 1;
  level.scriptperks["smoke_grenadejugg_mp"] = 1;
  level.scriptperks["emp_grenade_mp"] = 1;
  level.scriptperks["specialty_tacticalinsertion"] = 1;
  level.scriptperks["trophy_mp"] = 1;
  level.scriptperks["motion_sensor_mp"] = 1;
  level.scriptperks["proto_ricochet_device_mp"] = 1;
  level.scriptperks["bulletstorm_device_mp"] = 1;
  level.scriptperks["mobile_radar_mp"] = 1;
  level.scriptperks["gas_grenade_mp"] = 1;
  level.scriptperks["blackout_grenade_mp"] = 1;
  level.scriptperks["proxy_bomb_mp"] = 1;
  level.scriptperks["adrenaline_mist_mp"] = 1;
  level.scriptperks["domeshield_mp"] = 1;
  level.scriptperks["copycat_grenade_mp"] = 1;
  level.scriptperks["speed_strip_mp"] = 1;
  level.scriptperks["shard_ball_mp"] = 1;
  level.scriptperks["splash_grenade_mp"] = 1;
  level.scriptperks["forcepush_mp"] = 1;
  level.scriptperks["portal_generator_mp"] = 1;
  level.scriptperks["ammo_box_mp"] = 1;
  level.scriptperks["blackhat_mp"] = 1;
  level.scriptperks["flare_mp"] = 1;
  var_0 = scripts\mp\passives::_meth_8239();
  foreach(var_2 in var_0) {
    level.scriptperks[var_2] = 1;
    var_3 = scripts\mp\passives::getpassivemessage(var_2);
    if(isDefined(var_3)) {
      level.extraperkmap[var_2] = [var_3];
    }
  }

  level.scriptperks["specialty_null"] = 1;
  level.perksetfuncs["specialty_afterburner"] = ::scripts\mp\perks\_perkfunctions::setafterburner;
  level.perkunsetfuncs["specialty_afterburner"] = ::scripts\mp\perks\_perkfunctions::unsetafterburner;
  level.perksetfuncs["specialty_blastshield"] = ::scripts\mp\perks\_perkfunctions::setblastshield;
  level.perkunsetfuncs["specialty_blastshield"] = ::scripts\mp\perks\_perkfunctions::unsetblastshield;
  level.perksetfuncs["specialty_falldamage"] = ::scripts\mp\perks\_perkfunctions::setfreefall;
  level.perkunsetfuncs["specialty_falldamage"] = ::scripts\mp\perks\_perkfunctions::unsetfreefall;
  level.perksetfuncs["specialty_localjammer"] = ::scripts\mp\perks\_perkfunctions::setlocaljammer;
  level.perkunsetfuncs["specialty_localjammer"] = ::scripts\mp\perks\_perkfunctions::unsetlocaljammer;
  level.perksetfuncs["specialty_thermal"] = ::scripts\mp\perks\_perkfunctions::setthermal;
  level.perkunsetfuncs["specialty_thermal"] = ::scripts\mp\perks\_perkfunctions::unsetthermal;
  level.perksetfuncs["specialty_lightweight"] = ::scripts\mp\perks\_perkfunctions::setlightweight;
  level.perkunsetfuncs["specialty_lightweight"] = ::scripts\mp\perks\_perkfunctions::unsetlightweight;
  level.perksetfuncs["specialty_steelnerves"] = ::scripts\mp\perks\_perkfunctions::setsteelnerves;
  level.perkunsetfuncs["specialty_steelnerves"] = ::scripts\mp\perks\_perkfunctions::unsetsteelnerves;
  level.perksetfuncs["specialty_delaymine"] = ::scripts\mp\perks\_perkfunctions::setdelaymine;
  level.perkunsetfuncs["specialty_delaymine"] = ::scripts\mp\perks\_perkfunctions::unsetdelaymine;
  level.perksetfuncs["specialty_saboteur"] = ::scripts\mp\perks\_perkfunctions::setsaboteur;
  level.perkunsetfuncs["specialty_saboteur"] = ::scripts\mp\perks\_perkfunctions::unsetsaboteur;
  level.perksetfuncs["specialty_endgame"] = ::scripts\mp\perks\_perkfunctions::setendgame;
  level.perkunsetfuncs["specialty_endgame"] = ::scripts\mp\perks\_perkfunctions::unsetendgame;
  level.perksetfuncs["specialty_onemanarmy"] = ::scripts\mp\perks\_perkfunctions::setonemanarmy;
  level.perkunsetfuncs["specialty_onemanarmy"] = ::scripts\mp\perks\_perkfunctions::unsetonemanarmy;
  level.perksetfuncs["specialty_tacticalinsertion"] = ::scripts\mp\perks\_perkfunctions::settacticalinsertion;
  level.perkunsetfuncs["specialty_tacticalinsertion"] = ::scripts\mp\perks\_perkfunctions::unsettacticalinsertion;
  level.perksetfuncs["specialty_weaponlaser"] = ::scripts\mp\perks\_perkfunctions::setweaponlaser;
  level.perkunsetfuncs["specialty_weaponlaser"] = ::scripts\mp\perks\_perkfunctions::unsetweaponlaser;
  level.perksetfuncs["specialty_steadyaimpro"] = ::scripts\mp\perks\_perkfunctions::setsteadyaimpro;
  level.perkunsetfuncs["specialty_steadyaimpro"] = ::scripts\mp\perks\_perkfunctions::unsetsteadyaimpro;
  level.perksetfuncs["specialty_stun_resistance"] = ::scripts\mp\perks\_perkfunctions::setstunresistance;
  level.perkunsetfuncs["specialty_stun_resistance"] = ::scripts\mp\perks\_perkfunctions::unsetstunresistance;
  level.perksetfuncs["specialty_marksman"] = ::scripts\mp\perks\_perkfunctions::setmarksman;
  level.perkunsetfuncs["specialty_marksman"] = ::scripts\mp\perks\_perkfunctions::unsetmarksman;
  level.perksetfuncs["specialty_rshieldradar"] = ::scripts\mp\perks\_perkfunctions::setrshieldradar;
  level.perkunsetfuncs["specialty_rshieldradar"] = ::scripts\mp\perks\_perkfunctions::func_12D1D;
  level.perksetfuncs["specialty_rshieldscrambler"] = ::scripts\mp\perks\_perkfunctions::setrshieldscrambler;
  level.perkunsetfuncs["specialty_rshieldscrambler"] = ::scripts\mp\perks\_perkfunctions::unsetrshieldscrambler;
  level.perksetfuncs["specialty_double_load"] = ::scripts\mp\perks\_perkfunctions::setdoubleload;
  level.perkunsetfuncs["specialty_double_load"] = ::scripts\mp\perks\_perkfunctions::unsetdoubleload;
  level.perksetfuncs["specialty_sharp_focus"] = ::scripts\mp\perks\_perkfunctions::setsharpfocus;
  level.perkunsetfuncs["specialty_sharp_focus"] = ::scripts\mp\perks\_perkfunctions::unsetsharpfocus;
  level.perksetfuncs["specialty_hard_shell"] = ::scripts\mp\perks\_perkfunctions::sethardshell;
  level.perkunsetfuncs["specialty_hard_shell"] = ::scripts\mp\perks\_perkfunctions::unsethardshell;
  level.perksetfuncs["specialty_regenfaster"] = ::scripts\mp\perks\_perkfunctions::setregenfaster;
  level.perkunsetfuncs["specialty_regenfaster"] = ::scripts\mp\perks\_perkfunctions::unsetregenfaster;
  level.perksetfuncs["specialty_autospot"] = ::scripts\mp\perks\_perkfunctions::setautospot;
  level.perkunsetfuncs["specialty_autospot"] = ::scripts\mp\perks\_perkfunctions::unsetautospot;
  level.perksetfuncs["specialty_empimmune"] = ::scripts\mp\perks\_perkfunctions::setempimmune;
  level.perkunsetfuncs["specialty_empimmune"] = ::scripts\mp\perks\_perkfunctions::unsetempimmune;
  level.perksetfuncs["specialty_overkill_pro"] = ::scripts\mp\perks\_perkfunctions::setoverridearchetype;
  level.perkunsetfuncs["specialty_overkill_pro"] = ::scripts\mp\perks\_perkfunctions::unsetoverridearchetype;
  level.perksetfuncs["specialty_refill_grenades"] = ::scripts\mp\perks\_perkfunctions::setrefillgrenades;
  level.perkunsetfuncs["specialty_refill_grenades"] = ::scripts\mp\perks\_perkfunctions::unsetrefillgrenades;
  level.perksetfuncs["specialty_refill_ammo"] = ::scripts\mp\perks\_perkfunctions::setrefillammo;
  level.perkunsetfuncs["specialty_refill_ammo"] = ::scripts\mp\perks\_perkfunctions::unsetrefillammo;
  level.perksetfuncs["specialty_combat_speed"] = ::scripts\mp\perks\_perkfunctions::setcombatspeed;
  level.perkunsetfuncs["specialty_combat_speed"] = ::scripts\mp\perks\_perkfunctions::unsetcombatspeed;
  level.perksetfuncs["specialty_gambler"] = ::scripts\mp\perks\_perkfunctions::func_F71F;
  level.perkunsetfuncs["specialty_gambler"] = ::scripts\mp\perks\_perkfunctions::func_12CC5;
  level.perksetfuncs["specialty_comexp"] = ::scripts\mp\perks\_perkfunctions::setcomexp;
  level.perkunsetfuncs["specialty_comexp"] = ::scripts\mp\perks\_perkfunctions::unsetcomexp;
  level.perksetfuncs["specialty_gunsmith"] = ::scripts\mp\perks\_perkfunctions::func_F737;
  level.perkunsetfuncs["specialty_gunsmith"] = ::scripts\mp\perks\_perkfunctions::func_12CCB;
  level.perksetfuncs["specialty_tagger"] = ::scripts\mp\perks\_perkfunctions::settagger;
  level.perkunsetfuncs["specialty_tagger"] = ::scripts\mp\perks\_perkfunctions::unsettagger;
  level.perksetfuncs["specialty_pitcher"] = ::scripts\mp\perks\_perkfunctions::setpitcher;
  level.perkunsetfuncs["specialty_pitcher"] = ::scripts\mp\perks\_perkfunctions::func_12D0C;
  level.perksetfuncs["specialty_boom"] = ::scripts\mp\perks\_perkfunctions::setboom;
  level.perkunsetfuncs["specialty_boom"] = ::scripts\mp\perks\_perkfunctions::unsetboom;
  level.perksetfuncs["specialty_triggerhappy"] = ::scripts\mp\perks\_perkfunctions::settriggerhappy;
  level.perkunsetfuncs["specialty_triggerhappy"] = ::scripts\mp\perks\_perkfunctions::unsettriggerhappy;
  level.perksetfuncs["specialty_incog"] = ::scripts\mp\perks\_perkfunctions::setincog;
  level.perkunsetfuncs["specialty_incog"] = ::scripts\mp\perks\_perkfunctions::unsetincog;
  level.perksetfuncs["specialty_blindeye"] = ::scripts\mp\perks\_perkfunctions::setblindeye;
  level.perkunsetfuncs["specialty_blindeye"] = ::scripts\mp\perks\_perkfunctions::unsetblindeye;
  level.perksetfuncs["specialty_quickswap"] = ::scripts\mp\perks\_perkfunctions::setquickswap;
  level.perkunsetfuncs["specialty_quickswap"] = ::scripts\mp\perks\_perkfunctions::unsetquickswap;
  level.perksetfuncs["specialty_extraammo"] = ::scripts\mp\perks\_perkfunctions::setextraammo;
  level.perkunsetfuncs["specialty_extraammo"] = ::scripts\mp\perks\_perkfunctions::unsetextraammo;
  level.perksetfuncs["specialty_extra_equipment"] = ::scripts\mp\perks\_perkfunctions::setextraequipment;
  level.perkunsetfuncs["specialty_extra_equipment"] = ::scripts\mp\perks\_perkfunctions::unsetextraequipment;
  level.perksetfuncs["specialty_extra_deadly"] = ::scripts\mp\perks\_perkfunctions::setextradeadly;
  level.perkunsetfuncs["specialty_extra_deadly"] = ::scripts\mp\perks\_perkfunctions::unsetextradeadly;
  level.perksetfuncs["specialty_fastcrouch"] = ::scripts\mp\perks\_perkfunctions::setfastcrouch;
  level.perkunsetfuncs["specialty_fastcrouch"] = ::scripts\mp\perks\_perkfunctions::unsetfastcrouch;
  level.perksetfuncs["specialty_battleslide"] = ::scripts\mp\perks\_perkfunctions::setbattleslide;
  level.perkunsetfuncs["specialty_battleslide"] = ::scripts\mp\perks\_perkfunctions::unsetbattleslide;
  level.perksetfuncs["specialty_battleslide_shield"] = ::scripts\mp\perks\_perkfunctions::setbattleslideshield;
  level.perkunsetfuncs["specialty_battleslide_shield"] = ::scripts\mp\perks\_perkfunctions::unsetbattleslideshield;
  level.perksetfuncs["specialty_bullet_outline"] = ::scripts\mp\perks\_perkfunctions::setbulletoutline;
  level.perkunsetfuncs["specialty_bullet_outline"] = ::scripts\mp\perks\_perkfunctions::unsetbulletoutline;
  level.perksetfuncs["specialty_twoprimaries"] = ::scripts\mp\perks\_perkfunctions::setoverkill;
  level.perkunsetfuncs["specialty_twoprimaries"] = ::scripts\mp\perks\_perkfunctions::unsetoverkill;
  level.perksetfuncs["specialty_activereload"] = ::scripts\mp\perks\_perkfunctions::setactivereload;
  level.perkunsetfuncs["specialty_activereload"] = ::scripts\mp\perks\_perkfunctions::unsetactivereload;
  level.perksetfuncs["specialty_lifepack"] = ::scripts\mp\perks\_perkfunctions::setlifepack;
  level.perkunsetfuncs["specialty_lifepack"] = ::scripts\mp\perks\_perkfunctions::unsetlifepack;
  level.perksetfuncs["specialty_toughenup"] = ::scripts\mp\perks\_perkfunctions::settoughenup;
  level.perkunsetfuncs["specialty_toughenup"] = ::scripts\mp\perks\_perkfunctions::unsettoughenup;
  level.perksetfuncs["specialty_scoutping"] = ::scripts\mp\perks\_perkfunctions::setscoutping;
  level.perkunsetfuncs["specialty_scoutping"] = ::scripts\mp\perks\_perkfunctions::unsetscoutping;
  level.perksetfuncs["specialty_corpse_steal"] = ::scripts\mp\perks\_perkfunctions::setphasespeed;
  level.perkunsetfuncs["specialty_corpse_steal"] = ::scripts\mp\perks\_perkfunctions::unsetcritchance;
  level.perksetfuncs["specialty_phase_speed"] = ::scripts\mp\perks\_perkfunctions::setphasespeed;
  level.perkunsetfuncs["specialty_phase_speed"] = ::scripts\mp\perks\_perkfunctions::unsetphasespeed;
  level.perksetfuncs["specialty_dodge"] = ::scripts\mp\perks\_perkfunctions::setdodge;
  level.perkunsetfuncs["specialty_dodge"] = ::scripts\mp\perks\_perkfunctions::unsetdodge;
  level.perksetfuncs["specialty_extra_dodge"] = ::scripts\mp\perks\_perkfunctions::setextradodge;
  level.perkunsetfuncs["specialty_extra_dodge"] = ::scripts\mp\perks\_perkfunctions::unsetextradodge;
  level.perksetfuncs["specialty_ground_pound"] = ::scripts\mp\perks\_perkfunctions::setgroundpound;
  level.perkunsetfuncs["specialty_ground_pound"] = ::scripts\mp\perks\_perkfunctions::unsetgroundpound;
  level.perksetfuncs["specialty_ground_pound_shock"] = ::scripts\mp\perks\_perkfunctions::setgroundpoundshock;
  level.perkunsetfuncs["specialty_ground_pound_shock"] = ::scripts\mp\perks\_perkfunctions::unsetgroundpoundshock;
  level.perksetfuncs["specialty_ground_pound_shield"] = ::scripts\mp\perks\_perkfunctions::setgroundpoundshield;
  level.perkunsetfuncs["specialty_ground_pound_shield"] = ::scripts\mp\perks\_perkfunctions::unsetgroundpoundshield;
  level.perksetfuncs["specialty_thruster"] = ::scripts\mp\perks\_perkfunctions::setthruster;
  level.perkunsetfuncs["specialty_thruster"] = ::scripts\mp\perks\_perkfunctions::unsetthruster;
  level.perksetfuncs["specialty_phase_slide"] = ::scripts\mp\perks\_perkfunctions::setphaseslide;
  level.perkunsetfuncs["specialty_phase_slide"] = ::scripts\mp\perks\_perkfunctions::unsetphaseslide;
  level.perksetfuncs["specialty_tele_slide"] = ::scripts\mp\perks\_perkfunctions::setteleslide;
  level.perkunsetfuncs["specialty_tele_slide"] = ::scripts\mp\perks\_perkfunctions::unsetteleslide;
  level.perksetfuncs["specialty_phaseslash_rephase"] = ::scripts\mp\perks\_perkfunctions::setphaseslashrephase;
  level.perkunsetfuncs["specialty_phaseslash_rephase"] = ::scripts\mp\perks\_perkfunctions::unsetphaseslashrephase;
  level.perksetfuncs["specialty_phase_fall"] = ::scripts\mp\perks\_perkfunctions::func_F7E0;
  level.perkunsetfuncs["specialty_phase_fall"] = ::scripts\mp\perks\_perkfunctions::func_12D05;
  level.perksetfuncs["specialty_sixth_sense"] = ::scripts\mp\perks\_perkfunctions::setsixthsense;
  level.perkunsetfuncs["specialty_sixth_sense"] = ::scripts\mp\perks\_perkfunctions::unsetsixthsense;
  level.perksetfuncs["specialty_enchanced_sixth_sense"] = ::scripts\mp\perks\_perkfunctions::func_F6E9;
  level.perkunsetfuncs["specialty_enhanced_sixth_sense"] = ::scripts\mp\perks\_perkfunctions::func_12CAD;
  level.perksetfuncs["specialty_adrenaline"] = ::scripts\mp\perks\_perkfunctions::func_F62F;
  level.perkunsetfuncs["specialty_adrenaline"] = ::scripts\mp\perks\_perkfunctions::func_12C68;
  level.perksetfuncs["specialty_adrenaline_lite"] = ::scripts\mp\perks\_perkfunctions::func_F630;
  level.perkunsetfuncs["specialty_adrenaline_lite"] = ::scripts\mp\perks\_perkfunctions::func_12C69;
  level.perksetfuncs["specialty_extend_dodge"] = ::scripts\mp\perks\_perkfunctions::func_F6F1;
  level.perkunsetfuncs["specialty_extend_dodge"] = ::scripts\mp\perks\_perkfunctions::func_12CB1;
  level.perksetfuncs["specialty_aura_regen"] = ::scripts\mp\perks\_perkfunctions::func_F64E;
  level.perkunsetfuncs["specialty_aura_regen"] = ::scripts\mp\perks\_perkfunctions::func_12C74;
  level.perksetfuncs["specialty_aura_quickswap"] = ::scripts\mp\perks\_perkfunctions::func_F64D;
  level.perkunsetfuncs["specialty_aura_quickswap"] = ::scripts\mp\perks\_perkfunctions::func_12C73;
  level.perksetfuncs["specialty_aura_speed"] = ::scripts\mp\perks\_perkfunctions::func_F64F;
  level.perkunsetfuncs["specialty_aura_speed"] = ::scripts\mp\perks\_perkfunctions::func_12C75;
  level.perksetfuncs["specialty_mark_targets"] = ::scripts\mp\perks\_perkfunctions::func_F790;
  level.perkunsetfuncs["specialty_mark_targets"] = ::scripts\mp\perks\_perkfunctions::func_12CED;
  level.perksetfuncs["specialty_batterypack"] = ::scripts\mp\perks\_perkfunctions::func_F65A;
  level.perkunsetfuncs["specialty_batterypack"] = ::scripts\mp\perks\_perkfunctions::func_12C7A;
  level.perksetfuncs["specialty_camo_clone"] = ::scripts\mp\perks\_perkfunctions::func_F67A;
  level.perkunsetfuncs["specialty_camo_clone"] = ::scripts\mp\perks\_perkfunctions::func_12C8B;
  level.perksetfuncs["specialty_camo_elite"] = ::scripts\mp\perks\_perkfunctions::setcamoelite;
  level.perkunsetfuncs["specialty_camo_elite"] = ::scripts\mp\perks\_perkfunctions::unsetcamoelite;
  level.perksetfuncs["specialty_block_health_regen"] = ::scripts\mp\perks\_perkfunctions::setblockhealthregen;
  level.perkunsetfuncs["specialty_block_health_regen"] = ::scripts\mp\perks\_perkfunctions::unsetblockhealthregen;
  level.perksetfuncs["specialty_scorestreakpack"] = ::scripts\mp\perks\_perkfunctions::setscorestreakpack;
  level.perkunsetfuncs["specialty_scorestreakpack"] = ::scripts\mp\perks\_perkfunctions::unsetscorestreakpack;
  level.perksetfuncs["specialty_superpack"] = ::scripts\mp\perks\_perkfunctions::setsuperpack;
  level.perkunsetfuncs["specialty_superpack"] = ::scripts\mp\perks\_perkfunctions::unsetsuperpack;
  level.perksetfuncs["specialty_dodge_defense"] = ::scripts\mp\perks\_perkfunctions::setdodgedefense;
  level.perkunsetfuncs["specialty_dodge_defense"] = ::scripts\mp\perks\_perkfunctions::unsetdodgedefense;
  level.perksetfuncs["specialty_battleslide_offense"] = ::scripts\mp\perks\_perkfunctions::setbattleslideoffense;
  level.perkunsetfuncs["specialty_battleslide_offense"] = ::scripts\mp\perks\_perkfunctions::unsetbattleslideoffense;
  level.perksetfuncs["specialty_spawncloak"] = ::scripts\mp\perks\_perkfunctions::setspawncloak;
  level.perkunsetfuncs["specialty_spawncloak"] = ::scripts\mp\perks\_perkfunctions::unsetspawncloak;
  level.perksetfuncs["specialty_meleekill"] = ::scripts\mp\perks\_perkfunctions::setmeleekill;
  level.perkunsetfuncs["specialty_meleekill"] = ::scripts\mp\perks\_perkfunctions::unsetmeleekill;
  level.perksetfuncs["specialty_powercell"] = ::scripts\mp\perks\_perkfunctions::setpowercell;
  level.perkunsetfuncs["specialty_powercell"] = ::scripts\mp\perks\_perkfunctions::unsetpowercell;
  level.perksetfuncs["specialty_hardline"] = ::scripts\mp\perks\_perkfunctions::sethardline;
  level.perkunsetfuncs["specialty_hardline"] = ::scripts\mp\perks\_perkfunctions::unsethardline;
  level.perksetfuncs["specialty_hunter"] = ::scripts\mp\perks\_perkfunctions::func_F74A;
  level.perkunsetfuncs["specialty_hunter"] = ::scripts\mp\perks\_perkfunctions::func_12CD3;
  level.perksetfuncs["specialty_overclock"] = ::scripts\mp\perks\_perkfunctions::func_F7CD;
  level.perkunsetfuncs["specialty_overclock"] = ::scripts\mp\perks\_perkfunctions::unsetoverclock;
  level.perksetfuncs["specialty_tracker"] = ::scripts\mp\perks\_perkfunctions::func_F894;
  level.perkunsetfuncs["specialty_tracker"] = ::scripts\mp\perks\_perkfunctions::func_12D4E;
  level.perksetfuncs["specialty_personal_trophy"] = ::scripts\mp\perks\_perkfunctions::func_F7DE;
  level.perkunsetfuncs["specialty_personal_trophy"] = ::scripts\mp\perks\_perkfunctions::func_12D04;
  level.perksetfuncs["specialty_disruptor_punch"] = ::scripts\mp\perks\_perkfunctions::func_F6CA;
  level.perkunsetfuncs["specialty_disruptor_punch"] = ::scripts\mp\perks\_perkfunctions::func_12CA3;
  level.perksetfuncs["specialty_equipment_ping"] = ::scripts\mp\perks\_perkfunctions::setequipmentping;
  level.perkunsetfuncs["specialty_equipment_ping"] = ::scripts\mp\perks\_perkfunctions::unsetequipmentping;
  level.perksetfuncs["specialty_rugged_eqp"] = ::scripts\mp\perks\_perkfunctions::setruggedeqp;
  level.perkunsetfuncs["specialty_rugged_eqp"] = ::scripts\mp\perks\_perkfunctions::unsetruggedeqp;
  level.perksetfuncs["specialty_man_at_arms"] = ::scripts\mp\perks\_perkfunctions::setmanatarms;
  level.perkunsetfuncs["specialty_man_at_arms"] = ::scripts\mp\perks\_perkfunctions::unsetmanatarms;
  level.perksetfuncs["specialty_outlinekillstreaks"] = ::scripts\mp\perks\_perkfunctions::func_F7CB;
  level.perkunsetfuncs["specialty_outlinekillstreaks"] = ::scripts\mp\perks\_perkfunctions::func_12CFC;
  level.perksetfuncs["specialty_engineer"] = ::scripts\mp\perks\_perkfunctions::setengineer;
  level.perkunsetfuncs["specialty_engineer"] = ::scripts\mp\perks\_perkfunctions::unsetengineer;
  level.perksetfuncs["specialty_cloak"] = ::scripts\mp\perks\_perkfunctions::setcloak;
  level.perkunsetfuncs["specialty_cloak"] = ::scripts\mp\perks\_perkfunctions::unsetcloak;
  level.perksetfuncs["specialty_wall_lock"] = ::scripts\mp\perks\_perkfunctions::setwalllock;
  level.perkunsetfuncs["specialty_wall_lock"] = ::scripts\mp\perks\_perkfunctions::unsetwalllock;
  level.perksetfuncs["specialty_momentum"] = ::scripts\mp\perks\_perkfunctions::setmomentum;
  level.perkunsetfuncs["specialty_momentum"] = ::scripts\mp\perks\_perkfunctions::unsetmomentum;
  level.perksetfuncs["specialty_hover"] = ::scripts\mp\perks\_perkfunctions::sethover;
  level.perkunsetfuncs["specialty_hover"] = ::scripts\mp\perks\_perkfunctions::unsethover;
  level.perksetfuncs["specialty_rush"] = ::scripts\mp\perks\_perkfunctions::setrush;
  level.perkunsetfuncs["specialty_rush"] = ::scripts\mp\perks\_perkfunctions::unsetrush;
  level.perksetfuncs["specialty_scavenger_eqp"] = ::scripts\mp\perks\_perkfunctions::setscavengereqp;
  level.perkunsetfuncs["specialty_scavenger_eqp"] = ::scripts\mp\perks\_perkfunctions::unsetscavengereqp;
  level.perksetfuncs["specialty_spawnview"] = ::scripts\mp\perks\_perkfunctions::setspawnview;
  level.perkunsetfuncs["specialty_spawnview"] = ::scripts\mp\perks\_perkfunctions::unsetspawnview;
  level.perksetfuncs["specialty_headgear"] = ::scripts\mp\perks\_perkfunctions::setheadgear;
  level.perkunsetfuncs["specialty_headgear"] = ::scripts\mp\perks\_perkfunctions::unsetheadgear;
  level.perksetfuncs["specialty_ftlslide"] = ::scripts\mp\perks\_perkfunctions::setftlslide;
  level.perkunsetfuncs["specialty_ftlslide"] = ::scripts\mp\perks\_perkfunctions::unsetftlslide;
  level.perksetfuncs["specialty_improved_prone"] = ::scripts\mp\perks\_perkfunctions::func_F753;
  level.perkunsetfuncs["specialty_improved_prone"] = ::scripts\mp\perks\_perkfunctions::func_12CD6;
  level.perksetfuncs["specialty_ghost"] = ::scripts\mp\perks\_perkfunctions::setghost;
  level.perkunsetfuncs["specialty_ghost"] = ::scripts\mp\perks\_perkfunctions::unsetghost;
  level.perksetfuncs["specialty_support_killstreaks"] = ::scripts\mp\perks\_perkfunctions::setsupportkillstreaks;
  level.perkunsetfuncs["specialty_support_killstreaks"] = ::scripts\mp\perks\_perkfunctions::unsetsupportkillstreaks;
  level.perksetfuncs["specialty_overrideweaponspeed"] = ::scripts\mp\perks\_perkfunctions::func_F7D2;
  level.perkunsetfuncs["specialty_overrideweaponspeed"] = ::scripts\mp\perks\_perkfunctions::unsetoverrideweaponspeed;
  level.perksetfuncs["specialty_ballcarrier"] = ::scripts\mp\perks\_perkfunctions::func_F657;
  level.perkunsetfuncs["specialty_ballcarrier"] = ::scripts\mp\perks\_perkfunctions::func_12C77;
  level.perksetfuncs["specialty_cloak_aerial"] = ::scripts\mp\perks\_perkfunctions::setcloakaerial;
  level.perkunsetfuncs["specialty_cloak_aerial"] = ::scripts\mp\perks\_perkfunctions::unsetcloakaerial;
  level.perksetfuncs["specialty_spawn_radar"] = ::scripts\mp\perks\_perkfunctions::setspawnradar;
  level.perkunsetfuncs["specialty_spawn_radar"] = ::scripts\mp\perks\_perkfunctions::unsetspawnradar;
  level.perksetfuncs["specialty_improvedmelee"] = ::scripts\mp\perks\_perkfunctions::setimprovedmelee;
  level.perkunsetfuncs["specialty_improvedmelee"] = ::scripts\mp\perks\_perkfunctions::unsetimprovedmelee;
  level.perksetfuncs["specialty_thief"] = ::scripts\mp\perks\_perkfunctions::setthief;
  level.perkunsetfuncs["specialty_thief"] = ::scripts\mp\perks\_perkfunctions::unsetthief;
  level.perksetfuncs["specialty_ads_awareness"] = ::scripts\mp\perks\_perkfunctions::setadsawareness;
  level.perkunsetfuncs["specialty_ads_awareness"] = ::scripts\mp\perks\_perkfunctions::unsetadsawareness;
  level.perksetfuncs["specialty_rearguard"] = ::scripts\mp\perks\_perkfunctions::setrearguard;
  level.perkunsetfuncs["specialty_rearguard"] = ::scripts\mp\perks\_perkfunctions::unsetrearguard;
  level.perksetfuncs["specialty_combathigh"] = ::scripts\mp\perks\_perkfunctions::setcombathigh;
  level.perkunsetfuncs["specialty_combathigh"] = ::scripts\mp\perks\_perkfunctions::unsetcombathigh;
  level.perksetfuncs["specialty_light_armor"] = ::scripts\mp\perks\_perkfunctions::setlightarmor;
  level.perkunsetfuncs["specialty_light_armor"] = ::scripts\mp\perks\_perkfunctions::unsetlightarmor;
  level.perksetfuncs["specialty_revenge"] = ::scripts\mp\perks\_perkfunctions::setrevenge;
  level.perkunsetfuncs["specialty_revenge"] = ::scripts\mp\perks\_perkfunctions::unsetrevenge;
  level.perksetfuncs["specialty_c4death"] = ::scripts\mp\perks\_perkfunctions::func_F678;
  level.perkunsetfuncs["specialty_c4death"] = ::scripts\mp\perks\_perkfunctions::func_12C8A;
  level.perksetfuncs["specialty_finalstand"] = ::scripts\mp\perks\_perkfunctions::func_F704;
  level.perkunsetfuncs["specialty_finalstand"] = ::scripts\mp\perks\_perkfunctions::func_12CBD;
  level.perksetfuncs["specialty_juiced"] = ::scripts\mp\perks\_perkfunctions::setjuiced;
  level.perkunsetfuncs["specialty_juiced"] = ::scripts\mp\perks\_perkfunctions::unsetjuiced;
  level.perksetfuncs["specialty_carepackage"] = ::scripts\mp\perks\_perkfunctions::setcarepackage;
  level.perkunsetfuncs["specialty_carepackage"] = ::scripts\mp\perks\_perkfunctions::unsetcarepackage;
  level.perksetfuncs["specialty_stopping_power"] = ::scripts\mp\perks\_perkfunctions::func_F864;
  level.perkunsetfuncs["specialty_stopping_power"] = ::scripts\mp\perks\_perkfunctions::func_12D3A;
  level.perksetfuncs["specialty_uav"] = ::scripts\mp\perks\_perkfunctions::setuav;
  level.perkunsetfuncs["specialty_uav"] = ::scripts\mp\perks\_perkfunctions::unsetuav;
  level.perksetfuncs["specialty_viewkickoverride"] = ::scripts\mp\perks\_perkfunctions::setviewkickoverride;
  level.perkunsetfuncs["specialty_viewkickoverride"] = ::scripts\mp\perks\_perkfunctions::unsetviewkickoverride;
  level.perksetfuncs["specialty_affinityspeedboost"] = ::scripts\mp\perks\_perkfunctions::setaffinityspeedboost;
  level.perkunsetfuncs["specialty_affinityspeedboost"] = ::scripts\mp\perks\_perkfunctions::unsetaffinityspeedboost;
  level.perksetfuncs["specialty_affinityextralauncher"] = ::scripts\mp\perks\_perkfunctions::setaffinityextralauncher;
  level.perkunsetfuncs["specialty_affinityextralauncher"] = ::scripts\mp\perks\_perkfunctions::unsetaffinityextralauncher;
  level.perksetfuncs["passive_minimap_decoys"] = ::scripts\mp\perks\_weaponpassives::func_F79A;
  level.perkunsetfuncs["passive_minimap_decoys"] = ::scripts\mp\perks\_weaponpassives::func_12CF0;
  level.perksetfuncs["passive_headshot_ammo"] = ::scripts\mp\perks\_weaponpassives::func_F73F;
  level.perkunsetfuncs["passive_headshot_ammo"] = ::scripts\mp\perks\_weaponpassives::func_12CCE;
  level.perksetfuncs["passive_scrambler"] = ::scripts\mp\perks\_weaponpassives::func_F82F;
  level.perkunsetfuncs["passive_scrambler"] = ::scripts\mp\perks\_weaponpassives::func_12D27;
  level.perksetfuncs["passive_last_shots_ammo"] = ::scripts\mp\perks\_weaponpassives::func_F77D;
  level.perkunsetfuncs["passive_last_shots_ammo"] = ::scripts\mp\perks\_weaponpassives::unsetkineticwave;
  level.perksetfuncs["passive_health_on_kill"] = ::scripts\mp\perks\_weaponpassives::func_F740;
  level.perkunsetfuncs["passive_health_on_kill"] = ::scripts\mp\perks\_weaponpassives::func_12CCF;
  level.perksetfuncs["passive_double_kill_reload"] = ::scripts\mp\perks\_weaponpassives::func_F6D6;
  level.perkunsetfuncs["passive_double_kill_reload"] = ::scripts\mp\perks\_weaponpassives::func_12CA7;
  level.perksetfuncs["passive_explosive_kills"] = ::scripts\mp\perks\_weaponpassives::func_F6F0;
  level.perkunsetfuncs["passive_explosive_kills"] = ::scripts\mp\perks\_weaponpassives::func_12CB0;
  level.perksetfuncs["passive_miss_refund"] = ::scripts\mp\perks\_weaponpassives::func_F79B;
  level.perkunsetfuncs["passive_miss_refund"] = ::scripts\mp\perks\_weaponpassives::func_12CF1;
  level.perksetfuncs["passive_move_speed"] = ::scripts\mp\perks\_weaponpassives::func_F7AA;
  level.perkunsetfuncs["passive_move_speed"] = ::scripts\mp\perks\_weaponpassives::func_12CF5;
  level.perksetfuncs["passive_fast_rechamber_move_speed"] = ::scripts\mp\perks\_weaponpassives::setrechambermovespeedpassive;
  level.perkunsetfuncs["passive_fast_rechamber_move_speed"] = ::scripts\mp\perks\_weaponpassives::unsetrechambermovespeedpassive;
  level.perksetfuncs["passive_extra_xp"] = ::scripts\mp\perks\_weaponpassives::func_F6FD;
  level.perkunsetfuncs["passive_extra_xp"] = ::scripts\mp\perks\_weaponpassives::func_12CBA;
  level.perksetfuncs["passive_nuke"] = ::scripts\mp\perks\_weaponpassives::func_F7BD;
  level.perkunsetfuncs["passive_nuke"] = ::scripts\mp\perks\_weaponpassives::func_12CF8;
  level.perksetfuncs["passive_berserk"] = ::scripts\mp\perks\_weaponpassives::setquadfeederpassive;
  level.perkunsetfuncs["passive_berserk "] = ::scripts\mp\perks\_weaponpassives::unsetquadfeederpassive;
  level.perksetfuncs["passive_streak_ammo"] = ::scripts\mp\perks\_weaponpassives::func_F865;
  level.perkunsetfuncs["passive_streak_ammo"] = ::scripts\mp\perks\_weaponpassives::func_12D3B;
  level.perksetfuncs["passive_score_bonus_kills"] = ::scripts\mp\perks\_weaponpassives::func_F82A;
  level.perkunsetfuncs["passive_score_bonus_kills"] = ::scripts\mp\perks\_weaponpassives::func_12D23;
  level.perksetfuncs["passive_score_bonus_objectives"] = ::scripts\mp\perks\_weaponpassives::func_F82B;
  level.perkunsetfuncs["passive_score_bonus_objectives"] = ::scripts\mp\perks\_weaponpassives::func_12D24;
  level.perksetfuncs["passive_hivemind"] = ::scripts\mp\perks\_weaponpassives::func_F746;
  level.perkunsetfuncs["passive_hivemind"] = ::scripts\mp\perks\_weaponpassives::func_12CD1;
  level.perksetfuncs["passive_scoutping"] = ::scripts\mp\perks\_perkfunctions::setscoutping;
  level.perkunsetfuncs["passive_scoutping"] = ::scripts\mp\perks\_perkfunctions::unsetscoutping;
  level.perksetfuncs["passive_hunter_killer"] = ::scripts\mp\perks\_weaponpassives::func_F74B;
  level.perkunsetfuncs["passive_hunter_killer"] = ::scripts\mp\perks\_weaponpassives::func_12CD4;
  level.perkunsetfuncs["passive_double_kill_super"] = ::scripts\mp\perks\_weaponpassives::unsetdoublekillsuperpassive;
  level.perksetfuncs["passive_wallrun_quieter"] = ::scripts\mp\perks\_weaponpassives::setwallrunquieterpassive;
  level.perkunsetfuncs["passive_wallrun_quieter"] = ::scripts\mp\perks\_weaponpassives::unsetwallrunquieterpassive;
  level.perksetfuncs["passive_slide_blastshield"] = ::scripts\mp\perks\_weaponpassives::setslideblastshield;
  level.perkunsetfuncs["passive_slide_blastshield"] = ::scripts\mp\perks\_weaponpassives::unsetslideblastshield;
  level.perksetfuncs["passive_prone_blindeye"] = ::scripts\mp\perks\_weaponpassives::setproneblindeye;
  level.perkunsetfuncs["passive_prone_blindeye"] = ::scripts\mp\perks\_weaponpassives::unsetproneblindeye;
  level.perksetfuncs["passive_stationary_engineer"] = ::scripts\mp\perks\_weaponpassives::setstationaryengineer;
  level.perkunsetfuncs["passive_stationary_engineer"] = ::scripts\mp\perks\_weaponpassives::unsetstationaryengineer;
  level.perksetfuncs["passive_doppleganger"] = ::scripts\mp\perks\_weaponpassives::setdoppleganger;
  level.perkunsetfuncs["passive_doppleganger"] = ::scripts\mp\perks\_weaponpassives::unsetdoppleganger;
  level.perksetfuncs["passive_collat_streak"] = ::scripts\mp\perks\_weaponpassives::setcollatstreak;
  level.perkunsetfuncs["passive_collat_streak"] = ::scripts\mp\perks\_weaponpassives::unsetcollatstreak;
  level.extraperkmap["specialty_coldblooded"] = ["specialty_spygame", "specialty_heartbreaker", "specialty_radarringresist"];
  level.extraperkmap["specialty_blindeye"] = ["specialty_noplayertarget"];
  level.extraperkmap["specialty_quickswap"] = ["specialty_fastoffhand"];
  level.extraperkmap["specialty_improvedgunkick"] = ["specialty_reducedsway"];
  level.extraperkmap["specialty_dexterity"] = ["specialty_fastreload", "specialty_quickswap"];
  level.extraperkmap["specialty_engineer"] = ["specialty_detectexplosive", "specialty_delaymine", "specialty_outlinekillstreaks", "specialty_drawenemyturrets"];
  level.extraperkmap["specialty_empimmune"] = ["specialty_tracker_jammer", "specialty_noscopeoutline"];
  level.extraperkmap["specialty_afterburner"] = ["specialty_thruster"];
  level.extraperkmap["specialty_man_at_arms"] = ["specialty_extraammo", "specialty_overrideweaponspeed"];
  level.extraperkmap["specialty_phaseslash"] = ["specialty_phaseslash_rephase"];
  level.extraperkmap["specialty_ghost"] = ["specialty_gpsjammer"];
  level.extraperkmap["specialty_equipment_ping"] = ["specialty_paint"];
  level.extraperkmap["specialty_blast_suppressor"] = ["specialty_silentdoublejump", "specialty_silentdoublejump_audio"];
  level.extraperkmap["specialty_quieter"] = ["specialty_silentdoublejump_audio"];
  level.extraperkmap["specialty_improvedmelee"] = ["specialty_extendedmelee", "specialty_fastermelee", "specialty_thief"];
  level.extraperkmap["specialty_marksman"] = ["specialty_viewkickoverride"];
  level.extraperkmap["specialty_tracker"] = ["specialty_selectivehearing", "specialty_tracker_pro"];
  level.extraperkmap["specialty_sprintfire"] = ["specialty_fastsprintrecovery"];
  func_98B0();
  menurigperkparsetable();
  menuperkparsetable();
  func_98B2();
  level thread onplayerconnect();
}

menurigperkparsetable() {
  if(!isDefined(level.menurigperks)) {
    level.menurigperks = [];
  }

  var_0 = 0;
  for(;;) {
    var_1 = tablelookupbyrow("mp\menuRigPerks.csv", var_0, 0);
    if(var_1 == "") {
      break;
    }

    var_2 = tablelookupbyrow("mp\menuRigPerks.csv", var_0, 1);
    var_3 = tablelookupbyrow("mp\menuRigPerks.csv", var_0, 2);
    var_4 = spawnStruct();
    var_4.id = var_1;
    var_4.ref = var_3;
    var_4.archetype = var_2;
    if(!isDefined(level.menurigperks[var_3])) {
      level.menurigperks[var_3] = var_4;
    }

    var_0++;
  }
}

menuperkparsetable() {
  if(!isDefined(level.menuperks)) {
    level.menuperks = [];
  }

  var_0 = 0;
  for(;;) {
    var_1 = tablelookupbyrow("mp\menuPerks.csv", var_0, 0);
    if(var_1 == "") {
      break;
    }

    var_2 = tablelookupbyrow("mp\menuPerks.csv", var_0, 1);
    var_3 = tablelookupbyrow("mp\menuPerks.csv", var_0, 2);
    var_4 = spawnStruct();
    var_4.name = var_3;
    var_4.ref = var_3;
    var_4.slot = var_2;
    if(!isDefined(level.menuperks[var_3])) {
      level.menuperks[var_3] = var_4;
    }

    var_0++;
  }
}

func_98B2() {
  if(!isDefined(level.perksuseslot)) {
    level.perksuseslot = [];
  }

  level.var_CA5E = [];
  var_0 = 0;
  for(;;) {
    var_1 = tablelookupbyrow("mp\perkTable.csv", var_0, 0);
    if(var_1 == "") {
      break;
    }

    var_2 = tablelookupbyrow("mp\perkTable.csv", var_0, 1);
    var_3 = spawnStruct();
    var_3.ref = var_2;
    var_3.id = int(var_1);
    if(!isDefined(level.perksuseslot[var_2])) {
      level.perksuseslot[var_2] = var_3;
    }

    level.var_CA5E[var_3.id] = var_3.ref;
    var_0++;
  }
}

func_7DE8() {
  var_0 = [];
  foreach(var_2 in level.menuperks) {
    if(scripts\mp\utility::_hasperk(var_2.name)) {
      continue;
    }

    var_0[var_0.size] = var_2.name;
  }

  return var_0;
}

_meth_805C(var_0) {
  var_1 = level.menuperks[var_0];
  if(!isDefined(var_1)) {
    return undefined;
  }

  return int(var_1.slot);
}

func_13144(var_0) {
  if(!scripts\mp\utility::perksenabled()) {
    var_0 = "specialty_null";
  } else {
    switch (var_0) {
      case "specialty_deadeye":
      case "specialty_scavenger":
      case "specialty_bulletaccuracy":
      case "specialty_lightweight":
      case "specialty_selectivehearing":
      case "specialty_gpsjammer":
      case "specialty_detectexplosive":
      case "specialty_reducedsway":
      case "specialty_silentkill":
      case "specialty_chain_reaction":
      case "specialty_corpse_steal":
      case "specialty_extra_deadly":
      case "specialty_gambler":
      case "specialty_explosivedamage":
      case "specialty_paint":
      case "specialty_comexp":
      case "specialty_superpack":
      case "specialty_scorestreakpack":
      case "specialty_batterypack":
      case "specialty_extend_dodge":
      case "specialty_extra_dodge":
      case "specialty_gung_ho":
      case "specialty_activereload":
      case "specialty_twoprimaries":
      case "specialty_pitcher":
      case "specialty_falldamage":
      case "specialty_extraammo":
      case "specialty_battleslide":
      case "specialty_blindeye":
      case "specialty_sixth_sense":
      case "specialty_quieter":
      case "specialty_stun_resistance":
      case "specialty_blastshield":
      case "specialty_regenfaster":
      case "specialty_boom":
      case "specialty_sharp_focus":
      case "specialty_null":
      case "specialty_hardline":
      case "specialty_stalker":
      case "specialty_quickswap":
      case "specialty_marathon":
      case "specialty_fastsprintrecovery":
      case "specialty_quickdraw":
      case "specialty_fastreload":
        break;

      default:
        var_0 = "specialty_null";
        break;
    }
  }

  return var_0;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerspawned();
  }
}

onplayerspawned() {
  self endon("disconnect");
  self.perks = [];
  self.perksblocked = [];
  self.trait = undefined;
  self.weaponlist = [];
  self.var_C47E = 0;
  for(;;) {
    self waittill("spawned_player");
    self.var_C47E = 0;
    thread scripts\mp\killstreaks\_portableaoegenerator::func_7737();
  }
}

func_98B0() {
  level.allowgroundpound = 0.08;
  level.var_A4A7 = 0.08;
  level.var_A4A6 = 0.08;
  level.armorpiercingmod = 1.5;
  level.armorpiercingmodks = 1.25;
  level.var_DE8A = scripts\mp\utility::getintproperty("perk_fastRegenWaitMS", 800) / 1000;
  level.var_DE89 = scripts\mp\utility::getintproperty("perk_fastRegenRate", 2);
  level.var_3245 = scripts\mp\utility::getintproperty("perk_bulletDamage", 40) / 100;
  level.var_69FE = scripts\mp\utility::getintproperty("perk_explosiveDamage", 40) / 100;
  level.var_2B68 = scripts\mp\utility::getintproperty("perk_blastShieldScale", 65) / 100;
  level.var_2B67 = scripts\mp\utility::getintproperty("perk_blastShieldClampHP", 80);
  level.var_1177E = scripts\mp\utility::getintproperty("weap_thermoDebuffMod", 185) / 100;
  level.var_E559 = scripts\mp\utility::getintproperty("perk_riotShield", 100) / 100;
  level.var_21A3 = scripts\mp\utility::getintproperty("perk_armorVest", 75) / 100;
  level.var_8C74 = scripts\mp\utility::getintproperty("perk_headgear", 55) / 100;
  level._meth_848A = scripts\mp\utility::getintproperty("perk_gpsjammer_graceperiods", 4);
  level.var_B7CB = scripts\mp\utility::getintproperty("perk_gpsjammer_min_speed", 100);
  level.var_B75C = scripts\mp\utility::getintproperty("perk_gpsjammer_min_distance", 10);
  level.timeperiod = scripts\mp\utility::getintproperty("perk_gpsjammer_time_period", 200) / 1000;
  level.minspeedsq = level.var_B7CB * level.var_B7CB;
  level.var_B75E = level.var_B75C * level.var_B75C;
  if(isDefined(level.hardcoremode) && level.hardcoremode) {
    level.var_2B68 = scripts\mp\utility::getintproperty("perk_blastShieldScale_HC", 20) / 100;
    level.var_2B67 = scripts\mp\utility::getintproperty("perk_blastShieldClampHP_HC", 20);
  }

  if(level.tactical) {
    level.var_2B68 = 0.65;
    level.var_2B67 = 50;
  }
}

giveperks(var_0, var_1) {
  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 1);
  foreach(var_3 in var_0) {
    if(var_1) {
      var_3 = func_13144(var_3);
    }

    scripts\mp\utility::giveperk(var_3);
  }
}

_setperk(var_0) {
  if(!isDefined(self.perks[var_0])) {
    self.perks[var_0] = 1;
  } else {
    self.perks[var_0]++;
  }

  if(self.perks[var_0] == 1 && !isDefined(self.perksblocked[var_0])) {
    func_13D2(var_0);
  }
}

func_13D2(var_0) {
  var_1 = level.perksetfuncs[var_0];
  if(isDefined(var_1)) {
    self thread[[var_1]]();
  }

  self setperk(var_0, !isDefined(level.scriptperks[var_0]));
}

_setextraperks(var_0) {
  foreach(var_6, var_2 in level.extraperkmap) {
    if(var_0 == var_6) {
      foreach(var_4 in var_2) {
        _setperk(var_4);
      }

      break;
    }
  }
}

func_142F(var_0) {
  foreach(var_6, var_2 in level.extraperkmap) {
    if(var_0 == var_6) {
      foreach(var_4 in var_2) {
        _unsetperk(var_4);
      }

      break;
    }
  }
}

_unsetperk(var_0) {
  if(!isDefined(self.perks[var_0])) {
    return;
  }

  self.perks[var_0]--;
  if(self.perks[var_0] == 0) {
    if(!isDefined(self.perksblocked[var_0])) {
      func_1431(var_0);
    }

    self.perks[var_0] = undefined;
  }
}

func_1431(var_0) {
  if(isDefined(level.perkunsetfuncs[var_0])) {
    self thread[[level.perkunsetfuncs[var_0]]]();
  }

  self unsetperk(var_0, !isDefined(level.scriptperks[var_0]));
}

_clearperks() {
  foreach(var_2, var_1 in self.perks) {
    if(isDefined(level.perkunsetfuncs[var_2])) {
      self[[level.perkunsetfuncs[var_2]]]();
    }
  }

  self.perks = [];
  self.perksblocked = [];
  self getplayerlookattarget();
}

func_E130(var_0) {
  var_1 = [];
  foreach(var_3 in var_0) {
    if(func_13144(var_3) != "specialty_null") {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

giveperksafterspawn() {
  self endon("death");
  self endon("disconnect");
  self endon("giveLoadout_start");
  scripts\mp\utility::giveperk("specialty_blindeye");
  scripts\mp\utility::giveperk("specialty_gpsjammer");
  scripts\mp\utility::giveperk("specialty_noscopeoutline");
  while(self.avoidkillstreakonspawntimer > 0) {
    self.avoidkillstreakonspawntimer = self.avoidkillstreakonspawntimer - 0.05;
    wait(0.05);
  }

  if(scripts\mp\utility::func_9EF0(self) && isDefined(self.playerproxyagent) && isalive(self.playerproxyagent)) {
    return;
  }

  scripts\mp\utility::removeperk("specialty_blindeye");
  scripts\mp\utility::removeperk("specialty_gpsjammer");
  scripts\mp\utility::removeperk("specialty_noscopeoutline");
  self notify("removed_spawn_perks");
}

updateactiveperks(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = isDefined(var_0) && isplayer(var_0);
  var_9 = scripts\mp\utility::getweaponrootname(var_5);
  var_0A = isDefined(var_9) && var_9 == "iw7_axe";
  var_0B = isDefined(var_9) && var_9 == "iw7_tacburst" && var_1 _meth_8519(var_5);
  var_0C = var_0A && isDefined(var_0) && isDefined(var_0.classname) && var_0.classname == "grenade";
  var_0D = isDefined(var_1) && isplayer(var_1) && var_1 != var_2;
  if(var_0D && var_8 || var_0C || var_0B) {
    thread scripts\mp\perks\_weaponpassives::func_12F61(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
    if(var_1 scripts\mp\utility::_hasperk("specialty_triggerhappy")) {
      var_1 thread scripts\mp\perks\_perkfunctions::settriggerhappyinternal();
    }

    if(var_1 scripts\mp\utility::_hasperk("specialty_boom")) {
      var_2 thread scripts\mp\perks\_perkfunctions::setboominternal(var_1);
    }

    if(var_1 scripts\mp\utility::_hasperk("specialty_deadeye")) {
      var_1.var_4DF0++;
    }

    var_0E = var_1.pers["abilityRecharging"];
    if(isDefined(var_0E) && var_0E) {
      var_1 notify("abilityFastRecharge");
    }

    var_0F = var_1.pers["abilityOn"];
    if(isDefined(var_0F) && var_0F) {
      var_1 notify("abilityExtraTime");
    }
  }
}

func_F7C5(var_0, var_1) {
  var_2 = [];
  foreach(var_4 in var_1) {
    if(!isDefined(level.perksuseslot[var_4])) {
      continue;
    }

    var_5 = _meth_805C(var_4);
    if(!isDefined(var_5)) {
      continue;
    }

    if(!isDefined(var_2[var_5])) {
      var_2[var_5] = [];
    }

    var_2[var_5][var_2[var_5].size] = level.perksuseslot[var_4].id;
  }

  var_7 = [];
  for(var_5 = 1; var_5 < 4; var_5++) {
    if(isDefined(var_2[var_5])) {
      foreach(var_4 in var_2[var_5]) {
        var_7[var_7.size] = var_4;
      }
    }
  }

  for(var_0A = 0; var_0A < 6; var_0A++) {
    var_0B = var_7[var_0A];
    if(!isDefined(var_0B)) {
      var_0B = -1;
    }

    self setclientomnvar(var_0 + var_0A, var_0B);
  }
}

func_9EDF(var_0) {
  var_1 = self.pers["loadoutPerks"];
  foreach(var_3 in var_1) {
    if(var_3 == var_0) {
      return 1;
    }
  }

  return 0;
}

getequipmenttableinfo(var_0) {
  if(!isDefined(var_0) || !isDefined(level.perksuseslot[var_0])) {
    return 0;
  }

  return level.perksuseslot[var_0].id;
}