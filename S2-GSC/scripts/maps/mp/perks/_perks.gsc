/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\perks\_perks.gsc
********************************************/

init() {
  setdvarifuninitialized("6015", 0);
  setdvarifuninitialized("spv_commandoTacInsert_disabled", 0);
  setdvarifuninitialized("spv_cavalryImpactExplosivesBlocked_enabled", 0);
  setdvarifuninitialized("specialistBasicTraining1_score", 200);
  setdvarifuninitialized("specialistBasicTraining2_score", 400);
  setdvarifuninitialized("specialistBasicTraining3_score", 600);
  setdvarifuninitialized("specialistBasicTraining4_score", 800);
  level.perkfuncs = [];
  level.specialty_finalstand_icon = "specialty_s1_temp";
  level.specialty_c4_death_icon = "specialty_s1_temp";
  level.specialty_compassping_revenge_icon = "specialty_s1_temp";
  level.specialty_juiced_icon = "specialty_s1_temp";

  if(!isDefined(level.iszombiegame) || !level.iszombiegame) {
    level.spawnglowmodel["enemy"] = "npc_usa_emergency_flare";
    level.spawnglowmodel["friendly"] = "npc_usa_emergency_flare";
    level.spawnglow["enemy"] = loadfx("vfx/props/tac_insert_enemy");
    level.spawnglow["friendly"] = loadfx("vfx/props/tac_insert_friendly");
    level.spawnfire = loadfx("vfx/explosion/mp_tac_explosion");
  }

  level._effect["ricochet"] = loadfx("vfx/test/test_fx");
  level.disableoffhandweapons = [];
  level.perksetfuncs = [];
  level.perkunsetfuncs = [];
  level.disableoffhandweapons["specialty_blastshield"] = 1;
  level.disableoffhandweapons["specialty_blastshield2"] = 1;
  level.disableoffhandweapons["specialty_akimbo"] = 1;
  level.disableoffhandweapons["specialty_falldamage"] = 1;
  level.disableoffhandweapons["specialty_shield"] = 1;
  level.disableoffhandweapons["specialty_feigndeath"] = 1;
  level.disableoffhandweapons["specialty_shellshock"] = 1;
  level.disableoffhandweapons["specialty_delaymine"] = 1;
  level.disableoffhandweapons["specialty_localjammer"] = 1;
  level.disableoffhandweapons["specialty_thermal"] = 1;
  level.disableoffhandweapons["specialty_blackbox"] = 1;
  level.disableoffhandweapons["specialty_steelnerves"] = 1;
  level.disableoffhandweapons["specialty_flashgrenade"] = 1;
  level.disableoffhandweapons["specialty_smokegrenade"] = 1;
  level.disableoffhandweapons["specialty_concussiongrenade"] = 1;
  level.disableoffhandweapons["specialty_saboteur"] = 1;
  level.disableoffhandweapons["specialty_endgame"] = 1;
  level.disableoffhandweapons["specialty_rearview"] = 1;
  level.disableoffhandweapons["specialty_onemanarmy"] = 1;
  level.disableoffhandweapons["specialty_primarydeath"] = 1;
  level.disableoffhandweapons["specialty_secondarybling"] = 1;
  level.disableoffhandweapons["specialty_explosivedamage"] = 1;
  level.disableoffhandweapons["specialty_laststandoffhand"] = 1;
  level.disableoffhandweapons["specialty_dangerclose"] = 1;
  level.disableoffhandweapons["specialty_hardjack"] = 1;
  level.disableoffhandweapons["specialty_extraspecialduration"] = 1;
  level.disableoffhandweapons["specialty_rollover"] = 1;
  level.disableoffhandweapons["specialty_armorpiercing"] = 1;
  level.disableoffhandweapons["specialty_omaquickchange"] = 1;
  level.disableoffhandweapons["_specialty_rearview"] = 1;
  level.disableoffhandweapons["_specialty_onemanarmy"] = 1;
  level.disableoffhandweapons["specialty_steadyaimpro"] = 1;
  level.disableoffhandweapons["specialty_stun_resistance"] = 1;
  level.disableoffhandweapons["specialty_double_load"] = 1;
  level.disableoffhandweapons["specialty_regenspeed"] = 1;
  level.disableoffhandweapons["specialty_twoprimaries"] = 1;
  level.disableoffhandweapons["specialty_overkill"] = 1;
  level.disableoffhandweapons["specialty_anytwo"] = 1;
  level.disableoffhandweapons["specialty_fasterlockon"] = 1;
  level.disableoffhandweapons["specialty_paint"] = 1;
  level.disableoffhandweapons["specialty_paint_pro"] = 1;
  level.disableoffhandweapons["specialty_silentkill"] = 1;
  level.disableoffhandweapons["specialty_crouchmovement"] = 1;
  level.disableoffhandweapons["specialty_personaluav"] = 1;
  level.disableoffhandweapons["specialty_unwrapper"] = 1;
  level.disableoffhandweapons["specialty_extraammo"] = 1;
  level.disableoffhandweapons["specialty_fireshield"] = 1;
  level.disableoffhandweapons["specialty_minimapwhileads"] = 1;
  level.disableoffhandweapons["specialty_radarpingonspawn"] = 1;
  level.disableoffhandweapons["specialty_perception"] = 1;
  level.disableoffhandweapons["specialty_shortfuse"] = 1;
  level.disableoffhandweapons["specialty_throwequipmentfarther"] = 1;
  level.disableoffhandweapons["specialty_cookinggrenadedeath"] = 1;
  level.disableoffhandweapons["specialty_increasedmeleedamage"] = 1;
  level.disableoffhandweapons["specialty_fightorflight"] = 1;
  level.disableoffhandweapons["specialty_reducedexplosivefallprotection"] = 1;
  level.disableoffhandweapons["specialty_gpsjammer"] = 1;
  level.disableoffhandweapons["specialty_deadeye"] = 1;
  level.disableoffhandweapons["specialty_boostafterkill"] = 1;
  level.disableoffhandweapons["specialty_sprintfasterovertime"] = 1;
  level.disableoffhandweapons["specialty_regenbullets"] = 1;
  level.disableoffhandweapons["specialty_regenequipment"] = 1;
  level.disableoffhandweapons["specialty_improvedtacticals"] = 1;
  level.disableoffhandweapons["specialty_explosivewareffectiveness"] = 1;
  level.disableoffhandweapons["specialty_intelkillsandassists"] = 1;
  level.disableoffhandweapons["specialty_trainingUnlocker1"] = 1;
  level.disableoffhandweapons["specialty_trainingUnlocker2"] = 1;
  level.disableoffhandweapons["specialty_trainingUnlocker3"] = 1;
  level.disableoffhandweapons["specialty_sessionProgressionA"] = 1;
  level.disableoffhandweapons["specialty_sessionProgressionB"] = 1;
  level.disableoffhandweapons["specialty_sessionProgressionC"] = 1;
  level.disableoffhandweapons["specialty_medic"] = 1;
  level.disableoffhandweapons["specialty_medkit"] = 1;
  level.disableoffhandweapons["specialty_teammatehealthregen"] = 1;
  level.disableoffhandweapons["specialty_extrascorewhilehealing"] = 1;
  level.disableoffhandweapons["specialty_extraobjectivescore"] = 1;
  level.disableoffhandweapons["specialty_tacticalinsertion"] = 1;
  level.disableoffhandweapons["specialty_multikillboost"] = 1;
  level.disableoffhandweapons["specialty_class_airborne_enlisted"] = 1;
  level.disableoffhandweapons["specialty_class_airborne_expert"] = 1;
  level.disableoffhandweapons["specialty_class_airborne_master"] = 1;
  level.disableoffhandweapons["specialty_class_airborne_grandmaster"] = 1;
  level.disableoffhandweapons["specialty_class_infantry_enlisted"] = 1;
  level.disableoffhandweapons["specialty_class_infantry_expert"] = 1;
  level.disableoffhandweapons["specialty_class_infantry_master"] = 1;
  level.disableoffhandweapons["specialty_class_infantry_grandmaster"] = 1;
  level.disableoffhandweapons["specialty_class_armored_enlisted"] = 1;
  level.disableoffhandweapons["specialty_class_armored_expert"] = 1;
  level.disableoffhandweapons["specialty_class_armored_master"] = 1;
  level.disableoffhandweapons["specialty_class_armored_grandmaster"] = 1;
  level.disableoffhandweapons["specialty_class_mountain_enlisted"] = 1;
  level.disableoffhandweapons["specialty_class_mountain_expert"] = 1;
  level.disableoffhandweapons["specialty_class_mountain_master"] = 1;
  level.disableoffhandweapons["specialty_class_mountain_grandmaster"] = 1;
  level.disableoffhandweapons["specialty_class_expeditionary_enlisted"] = 1;
  level.disableoffhandweapons["specialty_class_expeditionary_expert"] = 1;
  level.disableoffhandweapons["specialty_class_expeditionary_master"] = 1;
  level.disableoffhandweapons["specialty_class_expeditionary_grandmaster"] = 1;
  level.disableoffhandweapons["specialty_class_resistance_enlisted"] = 1;
  level.disableoffhandweapons["specialty_class_resistance_expert"] = 1;
  level.disableoffhandweapons["specialty_class_resistance_master"] = 1;
  level.disableoffhandweapons["specialty_class_resistance_grandmaster"] = 1;
  level.disableoffhandweapons["specialty_class_grenadier_enlisted"] = 1;
  level.disableoffhandweapons["specialty_class_grenadier_expert"] = 1;
  level.disableoffhandweapons["specialty_class_grenadier_master"] = 1;
  level.disableoffhandweapons["specialty_class_grenadier_grandmaster"] = 1;
  level.disableoffhandweapons["specialty_class_commando_enlisted"] = 1;
  level.disableoffhandweapons["specialty_class_commando_expert"] = 1;
  level.disableoffhandweapons["specialty_class_commando_master"] = 1;
  level.disableoffhandweapons["specialty_class_commando_grandmaster"] = 1;
  level.disableoffhandweapons["specialty_class_scout_enlisted"] = 1;
  level.disableoffhandweapons["specialty_class_scout_expert"] = 1;
  level.disableoffhandweapons["specialty_class_scout_master"] = 1;
  level.disableoffhandweapons["specialty_class_scout_grandmaster"] = 1;
  level.disableoffhandweapons["specialty_class_artillery_enlisted"] = 1;
  level.disableoffhandweapons["specialty_class_artillery_expert"] = 1;
  level.disableoffhandweapons["specialty_class_artillery_master"] = 1;
  level.disableoffhandweapons["specialty_class_artillery_grandmaster"] = 1;
  level.disableoffhandweapons["specialty_class_hustle"] = 1;
  level.disableoffhandweapons["specialty_class_gunslinger"] = 1;
  level.disableoffhandweapons["specialty_class_energetic"] = 1;
  level.disableoffhandweapons["specialty_class_inconspicuous"] = 1;
  level.disableoffhandweapons["specialty_class_scoped"] = 1;
  level.disableoffhandweapons["specialty_class_duelist"] = 1;
  level.disableoffhandweapons["specialty_class_rifleman"] = 1;
  level.disableoffhandweapons["specialty_class_primed"] = 1;
  level.disableoffhandweapons["specialty_class_forage"] = 1;
  level.disableoffhandweapons["specialty_class_ordnance"] = 1;
  level.disableoffhandweapons["specialty_class_requisitions"] = 1;
  level.disableoffhandweapons["specialty_class_serrated"] = 1;
  level.disableoffhandweapons["specialty_class_concussed"] = 1;
  level.disableoffhandweapons["specialty_class_hunker"] = 1;
  level.disableoffhandweapons["specialty_class_launched"] = 1;
  level.disableoffhandweapons["specialty_class_bang"] = 1;
  level.disableoffhandweapons["specialty_class_undercover"] = 1;
  level.disableoffhandweapons["specialty_class_lookout"] = 1;
  level.disableoffhandweapons["specialty_class_instincts"] = 1;
  level.disableoffhandweapons["specialty_class_flanker"] = 1;
  level.disableoffhandweapons["specialty_class_espionage"] = 1;
  level.disableoffhandweapons["specialty_class_frigid"] = 1;
  level.disableoffhandweapons["specialty_class_blizzard"] = 1;
  level.disableoffhandweapons["specialty_class_snowblind"] = 1;
  level.disableoffhandweapons["specialty_class_whiteout"] = 1;
  level.disableoffhandweapons["specialty_class_humbug"] = 1;
  level.disableoffhandweapons["specialty_class_thaw"] = 1;
  level.disableoffhandweapons["specialty_class_shifty"] = 1;
  level.disableoffhandweapons["specialty_class_saboteur"] = 1;
  level.disableoffhandweapons["specialty_class_blitzkrieg"] = 1;
  level.disableoffhandweapons["specialty_class_clandestine"] = 1;
  level.disableoffhandweapons["specialty_class_wanderlust"] = 1;
  level.disableoffhandweapons["specialty_class_escalation"] = 1;
  level.disableoffhandweapons["specialty_class_specialist"] = 1;
  level.disableoffhandweapons["specialty_class_remedy"] = 1;
  level.disableoffhandweapons["specialty_class_frenzy"] = 1;
  level.disableoffhandweapons["specialty_class_stopping_power"] = 1;
  level.disableoffhandweapons["specialty_class_juggernaut"] = 1;
  level.disableoffhandweapons["specialty_class_danger_close"] = 1;
  level.disableoffhandweapons["specialty_class_one_man_army"] = 1;
  level.disableoffhandweapons["specialty_class_commando_pro"] = 1;
  level.disableoffhandweapons["specialty_class_last_stand"] = 1;
  level.disableoffhandweapons["specialty_class_martyrdom"] = 1;
  level.disableoffhandweapons["specialty_streakshield"] = 1;
  level.disableoffhandweapons["specialty_streakdamager"] = 1;
  level.disableoffhandweapons["specialty_marksman"] = 1;
  level.disableoffhandweapons["specialty_sharp_focus"] = 1;
  level.disableoffhandweapons["specialty_moredamage"] = 1;
  level.disableoffhandweapons["specialty_copycat"] = 1;
  level.disableoffhandweapons["specialty_finalstand"] = 1;
  level.disableoffhandweapons["specialty_juiced"] = 1;
  level.disableoffhandweapons["specialty_light_armor"] = 1;
  level.disableoffhandweapons["specialty_carepackage"] = 1;
  level.disableoffhandweapons["specialty_stopping_power"] = 1;
  level.disableoffhandweapons["specialty_uav"] = 1;
  level.disableoffhandweapons["bouncingbetty_mp"] = 1;
  level.disableoffhandweapons["c4_mp"] = 1;
  level.disableoffhandweapons["claymore_mp"] = 1;
  level.disableoffhandweapons["frag_grenade_mp"] = 1;
  level.disableoffhandweapons["frag_grenade_german_mp"] = 1;
  level.disableoffhandweapons["semtex_mp"] = 1;
  level.disableoffhandweapons["throwingknife_mp"] = 1;
  level.disableoffhandweapons["explosive_gel_mp"] = 1;
  level.disableoffhandweapons["contact_grenade_mp"] = 1;
  level.disableoffhandweapons["concussion_grenade_mp"] = 1;
  level.disableoffhandweapons["flash_grenade_mp"] = 1;
  level.disableoffhandweapons["stun_grenade_mp"] = 1;
  level.disableoffhandweapons["smoke_grenade_mp"] = 1;
  level.disableoffhandweapons["smoke_grenade_axis_mp"] = 1;
  level.disableoffhandweapons["smoke_grenade_expeditionary_mp"] = 1;
  level.disableoffhandweapons["smoke_grenade_axis_expeditionary_mp"] = 1;
  level.disableoffhandweapons["portable_radar_mp"] = 1;
  level.disableoffhandweapons["trophy_mp"] = 1;
  level.disableoffhandweapons["s2_tactical_insertion_device_mp"] = 1;
  level.disableoffhandweapons["s2_tactical_insertion_cavalry_mp"] = 1;
  level.disableoffhandweapons["tabun_grenade_mp"] = 1;
  level.disableoffhandweapons["decoy_device_mp"] = 1;
  level.disableoffhandweapons["signal_flare_mp"] = 1;
  level.disableoffhandweapons["signal_flare_expeditionary_mp"] = 1;
  level.disableoffhandweapons["extra_health_mp"] = 1;
  level.disableoffhandweapons["specialty_null"] = 1;
  level.perksetfuncs["specialty_blastshield"] = _id_052C::eqon;
  level.perkunsetfuncs["specialty_blastshield"] = _id_052C::unsetblastshield;
  level.perksetfuncs["specialty_falldamage"] = _id_052C::setfreefall;
  level.perkunsetfuncs["specialty_falldamage"] = _id_052C::unsetfreefall;
  level.perksetfuncs["specialty_localjammer"] = _id_052C::setlocaljammer;
  level.perkunsetfuncs["specialty_localjammer"] = _id_052C::unsetlocaljammer;
  level.perksetfuncs["specialty_thermal"] = _id_052C::setthermal;
  level.perkunsetfuncs["specialty_thermal"] = _id_052C::unsetthermal;
  level.perksetfuncs["specialty_blackbox"] = _id_052C::disableaudiozoom;
  level.perkunsetfuncs["specialty_blackbox"] = _id_052C::unsetblackbox;
  level.perksetfuncs["specialty_steelnerves"] = _id_052C::setsteelnerves;
  level.perkunsetfuncs["specialty_steelnerves"] = _id_052C::unsetsteelnerves;
  level.perksetfuncs["specialty_delaymine"] = _id_052C::setdelaymine;
  level.perkunsetfuncs["specialty_delaymine"] = _id_052C::unsetdelaymine;
  level.perksetfuncs["specialty_improvedobjectives"] = _id_052C::setimprovedobjectives;
  level.perkunsetfuncs["specialty_improvedobjectives"] = _id_052C::unsetimprovedobjectives;
  level.perksetfuncs["specialty_endgame"] = _id_052C::setendgame;
  level.perkunsetfuncs["specialty_endgame"] = _id_052C::unsetendgame;
  level.perksetfuncs["specialty_rearview"] = _id_052C::setrearview;
  level.perkunsetfuncs["specialty_rearview"] = _id_052C::unsetrearview;
  level.perksetfuncs["specialty_onemanarmy"] = _id_052C::setonemanarmy;
  level.perkunsetfuncs["specialty_onemanarmy"] = _id_052C::unsetonemanarmy;
  level.perksetfuncs["specialty_steadyaimpro"] = _id_052C::setsteadyaimpro;
  level.perkunsetfuncs["specialty_steadyaimpro"] = _id_052C::unsetsteadyaimpro;
  level.perksetfuncs["specialty_stun_resistance"] = _id_052C::setstunresistance;
  level.perkunsetfuncs["specialty_stun_resistance"] = _id_052C::unsetstunresistance;
  level.perksetfuncs["specialty_marksman"] = _id_052C::setmarksman;
  level.perkunsetfuncs["specialty_marksman"] = _id_052C::unsetmarksman;
  level.perksetfuncs["specialty_double_load"] = _id_052C::setdoubleload;
  level.perkunsetfuncs["specialty_double_load"] = _id_052C::unsetdoubleload;
  level.perksetfuncs["specialty_sharp_focus"] = _id_052C::setsharpfocus;
  level.perkunsetfuncs["specialty_sharp_focus"] = _id_052C::unsetsharpfocus;
  level.perksetfuncs["specialty_regenspeed"] = _id_052C::setregenspeed;
  level.perkunsetfuncs["specialty_regenspeed"] = _id_052C::unsetregenspeed;
  level.perksetfuncs["specialty_empimmune"] = _id_052C::setempimmune;
  level.perkunsetfuncs["specialty_empimmune"] = _id_052C::unsetempimmune;
  level.perksetfuncs["specialty_overkill_pro"] = _id_052C::setoverkillpro;
  level.perkunsetfuncs["specialty_overkill_pro"] = _id_052C::unsetoverkillpro;
  level.perksetfuncs["specialty_personaluav"] = _id_052C::setpersonaluav;
  level.perkunsetfuncs["specialty_personaluav"] = _id_052C::unsetpersonaluav;
  level.perksetfuncs["specialty_crouchmovement"] = _id_052C::setcrouchmovement;
  level.perkunsetfuncs["specialty_crouchmovement"] = _id_052C::unsetcrouchmovement;
  level.perksetfuncs["specialty_light_armor"] = _id_052C::setlightarmor;
  level.perkunsetfuncs["specialty_light_armor"] = _id_052C::unsetlightarmor;
  level.perksetfuncs["specialty_fightorflight"] = _id_052C::_id_867F;
  level.perkunsetfuncs["specialty_fightorflight"] = _id_052C::_id_A060;
  level.perksetfuncs["specialty_extraammo"] = _id_052C::_id_867A;
  level.perkunsetfuncs["specialty_extraammo"] = _id_052C::_id_A05E;
  level.perksetfuncs["specialty_radarpingonspawn"] = _id_052C::_id_870D;
  level.perkunsetfuncs["specialty_radarpingonspawn"] = _id_052C::_id_A077;
  level.perksetfuncs["specialty_perception"] = _id_052C::_id_86F1;
  level.perkunsetfuncs["specialty_perception"] = _id_052C::_id_A075;
  level.perksetfuncs["specialty_throwequipmentfarther"] = _id_052C::_id_8743;
  level.perkunsetfuncs["specialty_throwequipmentfarther"] = _id_052C::_id_A084;
  level.perksetfuncs["specialty_shortfuse"] = _id_052C::_id_8722;
  level.perkunsetfuncs["specialty_shortfuse"] = _id_052C::_id_A07C;
  level.perksetfuncs["specialty_cookinggrenadedeath"] = _id_052C::_id_8656;
  level.perkunsetfuncs["specialty_cookinggrenadedeath"] = _id_052C::_id_A055;
  level.perksetfuncs["specialty_explosiveearlywarning"] = _id_052C::_id_8678;
  level.perkunsetfuncs["specialty_explosiveearlywarning"] = _id_052C::_id_A05D;
  level.perksetfuncs["specialty_class_snowblind"] = _id_052C::setsnowblind;
  level.perkunsetfuncs["specialty_class_snowblind"] = _id_052C::unsetsnowblind;
  level.perksetfuncs["specialty_class_thaw"] = _id_052C::setthaw;
  level.perkunsetfuncs["specialty_class_thaw"] = _id_052C::unsetthaw;
  level.perksetfuncs["specialty_class_humbug"] = _id_052C::sethumbug;
  level.perkunsetfuncs["specialty_class_humbug"] = _id_052C::unsethumbug;
  level.perksetfuncs["specialty_gpsjammer"] = _id_052C::setgpsjammer;
  level.perkunsetfuncs["specialty_gpsjammer"] = _id_052C::unsetgpsjammer;
  level.perksetfuncs["specialty_class_shifty"] = _id_052C::setshifty;
  level.perkunsetfuncs["specialty_class_shifty"] = _id_052C::unsetshifty;
  level.perksetfuncs["specialty_deadeye"] = _id_052C::setdeadeye;
  level.perkunsetfuncs["specialty_deadeye"] = _id_052C::unsetdeadeye;
  level.perksetfuncs["specialty_class_resistance_enlisted"] = _id_052C::setresistancedivisionscramblerindicator;
  level.perkunsetfuncs["specialty_class_resistance_enlisted"] = _id_052C::unsetresistancedivisionscramblerindicator;
  level.perksetfuncs["specialty_class_resistance_expert"] = _id_052C::setresistancedivisionscramblerindicator;
  level.perkunsetfuncs["specialty_class_resistance_expert"] = _id_052C::unsetresistancedivisionscramblerindicator;
  level.perksetfuncs["specialty_class_resistance_master"] = _id_052C::setresistancedivisionscramblerindicator;
  level.perkunsetfuncs["specialty_class_resistance_master"] = _id_052C::unsetresistancedivisionscramblerindicator;
  level.perksetfuncs["specialty_class_resistance_grandmaster"] = _id_052C::setresistancedivisionscramblerindicator;
  level.perkunsetfuncs["specialty_class_resistance_grandmaster"] = _id_052C::unsetresistancedivisionscramblerindicator;
  level.perksetfuncs["specialty_sprintfasterovertime"] = _id_052C::setsprintfasterovertime;
  level.perkunsetfuncs["specialty_sprintfasterovertime"] = _id_052C::unsetsprintfasterovertime;
  level.perksetfuncs["specialty_regenbullets"] = _id_052C::setregeneratebulletsovertime;
  level.perkunsetfuncs["specialty_regenbullets"] = _id_052C::unsetregeneratebulletsovertime;
  level.perksetfuncs["specialty_regenequipment"] = _id_052C::setregenerateequipmentovertime;
  level.perkunsetfuncs["specialty_regenequipment"] = _id_052C::unsetregenerateequipmentovertime;
  level.perksetfuncs["specialty_explosiveammoresupply"] = _id_052C::setlaunched;
  level.perkunsetfuncs["specialty_explosiveammoresupply"] = _id_052C::unsetlaunched;
  level.perksetfuncs["specialty_boostafterkill"] = _id_052C::setescalationboostafterkill;
  level.perkunsetfuncs["specialty_boostafterkill"] = _id_052C::unsetescalationboostafterkill;
  level.perksetfuncs["specialty_randomgun"] = _id_052C::setrandomgun;
  level.perkunsetfuncs["specialty_randomgun"] = _id_052C::unsetrandomgun;
  level.perksetfuncs["specialty_perkstreaks"] = _id_052C::setperkstreaks;
  level.perkunsetfuncs["specialty_perkstreaks"] = _id_052C::unsetperkstreaks;
  level.perksetfuncs["specialty_medic"] = maps\mp\perks\_medic::setmedic;
  level.perkunsetfuncs["specialty_medic"] = maps\mp\perks\_medic::unsetmedic;
  level.perksetfuncs["specialty_boostafterreload"] = _id_052C::setclassifiedboostafterreload;
  level.perkunsetfuncs["specialty_boostafterreload"] = _id_052C::unsetclassifiedboostafterreload;
  level.perksetfuncs["specialty_sessionProgressionA"] = _id_052C::setserumbasictraining;
  level.perkunsetfuncs["specialty_sessionProgressionA"] = _id_052C::unsetserumbasictraining;
  level.perksetfuncs["specialty_finalstand"] = _id_052C::setfinalstand;
  level.perkunsetfuncs["specialty_finalstand"] = _id_052C::unsetfinalstand;
  level.perksetfuncs["specialty_juiced"] = _id_052C::setjuiced;
  level.perkunsetfuncs["specialty_juiced"] = _id_052C::unsetjuiced;
  level.perksetfuncs["specialty_carepackage"] = _id_052C::setcarepackage;
  level.perkunsetfuncs["specialty_carepackage"] = _id_052C::unsetcarepackage;
  level.perksetfuncs["specialty_stopping_power"] = _id_052C::setstoppingpower;
  level.perkunsetfuncs["specialty_stopping_power"] = _id_052C::unsetstoppingpower;
  level.perksetfuncs["specialty_uav"] = _id_052C::setuav;
  level.perkunsetfuncs["specialty_uav"] = _id_052C::unsetuav;
  _id_052C::buildwunderlustweaponlist();

  if(isDefined(level._id_3FDE)) {
    [[level._id_3FDE]]();
  }

  _id_532A();
  level thread maps\mp\perks\_medic::initmedic();
  level thread onplayerconnect();
}

_id_A277(var_0, var_1) {
  if(getdvarint("scr_game_perks") == 0) {
    return 0;
  }

  if(_func_30D(var_1)) {
    var_1 = maps\mp\_utility::_id_452B(var_1);
  }

  if(isDefined(level._id_3FE0)) {
    var_2 = [[level._id_3FE0]](var_0, var_1);
    return var_2;
  }

  switch (var_1) {
    case "specialty_class_frenzy":
    case "specialty_class_specialist":
    case "specialty_class_artillery_grandmaster":
    case "specialty_class_scout_grandmaster":
    case "specialty_class_commando_grandmaster":
    case "specialty_class_grenadier_grandmaster":
    case "specialty_class_resistance_grandmaster":
    case "specialty_class_artillery_master":
    case "specialty_class_artillery_expert":
    case "specialty_class_artillery_enlisted":
    case "specialty_class_scout_master":
    case "specialty_class_scout_expert":
    case "specialty_class_scout_enlisted":
    case "specialty_class_commando_master":
    case "specialty_class_commando_expert":
    case "specialty_class_commando_enlisted":
    case "specialty_class_grenadier_master":
    case "specialty_class_grenadier_expert":
    case "specialty_class_grenadier_enlisted":
    case "specialty_class_resistance_master":
    case "specialty_class_resistance_expert":
    case "specialty_class_resistance_enlisted":
    case "specialty_class_expeditionary_expert":
    case "specialty_class_expeditionary_enlisted":
    case "specialty_class_mountain_grandmaster":
    case "specialty_class_mountain_expert":
    case "specialty_class_mountain_enlisted":
    case "specialty_class_armored_grandmaster":
    case "specialty_class_armored_expert":
    case "specialty_class_armored_enlisted":
    case "specialty_class_infantry_grandmaster":
    case "specialty_class_infantry_expert":
    case "specialty_class_infantry_enlisted":
    case "specialty_class_airborne_grandmaster":
    case "specialty_class_airborne_expert":
    case "specialty_class_airborne_enlisted":
    case "specialty_class_saboteur":
    case "specialty_class_mountain_master":
    case "specialty_class_armored_master":
    case "specialty_class_infantry_master":
    case "specialty_class_airborne_master":
    case "specialty_class_blitzkrieg":
    case "specialty_class_ordnance":
    case "specialty_class_wanderlust":
    case "specialty_class_remedy":
    case "specialty_class_escalation":
    case "specialty_class_clandestine":
    case "specialty_class_shifty":
    case "specialty_class_lookout":
    case "specialty_class_serrated":
    case "specialty_class_inconspicuous":
    case "specialty_class_energetic":
    case "specialty_class_flanker":
    case "specialty_class_instincts":
    case "specialty_class_bang":
    case "specialty_class_concussed":
    case "specialty_class_launched":
    case "specialty_class_requisitions":
    case "specialty_class_primed":
    case "specialty_class_rifleman":
    case "specialty_class_gunslinger":
    case "specialty_class_hustle":
    case "specialty_class_forage":
    case "specialty_class_duelist":
    case "specialty_class_hunker":
    case "specialty_class_undercover":
    case "specialty_class_scoped":
    case "specialty_class_espionage":
    case "specialty_class_expeditionary_grandmaster":
    case "specialty_class_expeditionary_master":
      return maps\mp\_utility::_id_452A(var_1);
    case "specialty_class_thaw":
    case "specialty_class_humbug":
    case "specialty_class_whiteout":
    case "specialty_class_blizzard":
    case "specialty_class_frigid":
    case "specialty_class_martyrdom":
    case "specialty_class_last_stand":
    case "specialty_class_commando_pro":
    case "specialty_class_one_man_army":
    case "specialty_class_danger_close":
    case "specialty_class_juggernaut":
    case "specialty_class_stopping_power":
    case "specialty_class_snowblind":
      if(maps\mp\_utility::areexperimentalbasictrainingsenabled()) {
        return maps\mp\_utility::_id_452A(var_1);
      } else {
        return 0;
      }
    case "specialty_class_toughness":
    case "specialty_bulletaccuracy":
    case "specialty_sprintreload":
    case "specialty_class_dangerclose":
    case "specialty_falldamage":
    case "specialty_exo_blastsuppressor":
      return var_1;
    default:
      return 0;
  }
}

getemptyperks() {
  var_0 = [];

  for(var_1 = 0; var_1 < 9; var_1++) {
    var_0[var_1] = 0;
  }

  return var_0;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 _id_73C7();
    var_0 thread onplayerspawned();
  }
}

_id_73C7() {
  self.perks = [];
}

onplayerspawned() {
  self endon("disconnect");

  if(maps\mp\_utility::invirtuallobby()) {
    return;
  }
  for(;;) {
    self waittill("spawned_player");

    if(maps\mp\_utility::_hasperk("specialty_sixthsense")) {
      thread _id_052C::_id_63E3();
    }
  }
}

cac_modified_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = 0;

  if(maps\mp\_utility::isbulletdamage(var_3)) {
    if(!isDefined(var_1)) {
      return var_2;
    }

    if(isPlayer(var_1) && var_1 maps\mp\_utility::_hasperk("specialty_deadeye")) {
      var_1 _id_052C::setdeadeyeinternal();
    }

    if(isPlayer(var_1) && var_1 maps\mp\_utility::_hasperk("specialty_paint_pro") && !maps\mp\_utility::iskillstreakweapon(var_4) && (isPlayer(var_0) || _isagent(var_0))) {
      if(!var_0 _id_052C::ispainted()) {
        var_1 maps\mp\gametypes\_missions::processchallenge("ch_bulletpaint");
      }

      var_0 thread _id_052C::setpainted(var_1, 1);
    }

    if(isPlayer(var_0) && isDefined(var_0._id_4B9A) && var_0._id_4B9A && !maps\mp\_utility::isheadshot(var_4, var_7, var_3, var_1)) {
      var_9 = var_9 - (var_2 - 1);
      var_10 = var_2;

      if(isPlayer(var_1) && isDefined(var_1._id_4B50) && var_1._id_4B50) {
        var_10 = var_10 * level._id_0A07;
      }

      thread _id_0535::_id_0F31(var_10);
    } else if(isPlayer(var_1) && isDefined(var_1._id_4B50) && var_1._id_4B50 && var_0 maps\mp\_utility::_hasperk("specialty_armorvest"))
      var_9 = var_9 + var_2 * (level._id_0A07 - level._id_0F6A);
    else if(isPlayer(var_1) && isDefined(var_1._id_4B50) && var_1._id_4B50) {
      var_9 = var_9 + var_2 * level._id_0A07;
    } else if(isPlayer(var_1) && (var_1 maps\mp\_utility::_hasperk("specialty_bulletdamage") || var_1 maps\mp\_utility::_hasperk("specialty_moredamage")) && var_0 maps\mp\_utility::_hasperk("specialty_armorvest")) {
      var_9 = var_9 + 0;
    } else if(isPlayer(var_1) && (var_1 maps\mp\_utility::_hasperk("specialty_bulletdamage") || var_1 maps\mp\_utility::_hasperk("specialty_moredamage"))) {
      var_9 = var_9 + var_2 * level.bulletdamagemod;
    } else if(var_0 maps\mp\_utility::_hasperk("specialty_armorvest")) {
      var_9 = var_9 - var_2 * level._id_0F6A;
    }
  } else if(_isexplosivedamagemod(var_3) || var_3 == "MOD_GAS") {
    if(!isDefined(var_1)) {
      return var_2;
    }

    if(isPlayer(var_1) && var_1 != var_0 && var_1 maps\mp\_utility::_hasperk("specialty_paint") && (!maps\mp\_utility::iskillstreakweapon(var_4) || issubstr(var_4, "killstreak_molotov_cocktail"))) {
      var_0 thread _id_052C::setpainted(var_1, 0);
    }

    if(maps\mp\_utility::getweaponclass(var_4) == "weapon_projectile" && weaponclass(var_4) == "rocketlauncher" && isPlayer(var_1) && _weaponinheritsperks(var_4) && var_1 maps\mp\_utility::_hasperk("specialty_class_launched")) {
      var_2 = var_2 * level.launchedrocketlauncherdamagemod;
    }

    if(_id_0513::_id_57F6(var_4) && var_0 maps\mp\_utility::_hasperk("specialty_stun_resistance")) {
      var_2 = 1;
      var_9 = 0;
    } else if(isPlayer(var_0) && isDefined(var_0._id_4B64) && var_0._id_4B64) {
      var_9 = var_9 - (var_2 - 1);
      thread _id_0530::_id_0F31(var_2);
    } else if(isPlayer(var_1) && _weaponinheritsperks(var_4) && (var_1 maps\mp\_utility::_hasexperimentalbtperk("specialty_explosivedamage") && var_0 maps\mp\_utility::_hasperk("specialty_blastshield2") && var_0 maps\mp\_utility::_hasexperimentalbtperk("specialty_reducedexplosivefallprotection")))
      var_9 = var_9 + var_2 * level.clumsydamagemod;
    else if(isPlayer(var_1) && _weaponinheritsperks(var_4) && (var_1 maps\mp\_utility::_hasexperimentalbtperk("specialty_explosivedamage") && var_0 maps\mp\_utility::_hasperk("specialty_blastshield2"))) {
      var_9 = var_9 + 0;
    } else if(isPlayer(var_1) && _weaponinheritsperks(var_4) && (var_1 maps\mp\_utility::_hasexperimentalbtperk("specialty_explosivedamage") && var_0 maps\mp\_utility::_hasexperimentalbtperk("specialty_reducedexplosivefallprotection"))) {
      var_9 = var_9 + (var_2 * level.explosivedamagemod + var_2 * level.clumsydamagemod);
    } else if(isPlayer(var_1) && _weaponinheritsperks(var_4) && var_1 maps\mp\_utility::_hasexperimentalbtperk("specialty_explosivedamage")) {
      var_9 = var_9 + var_2 * level.explosivedamagemod;
    } else if(var_0 maps\mp\_utility::_hasexperimentalbtperk("specialty_reducedexplosivefallprotection")) {
      var_9 = var_9 + var_2 * level.clumsydamagemod;
    } else if(var_0 maps\mp\_utility::_hasperk("specialty_blastshield2") && isDefined(var_0._id_90D4) && (var_4 != "semtex_mp" || var_2 < 145) && !_id_0513::_id_57F6(var_4) && !_id_3154(var_4)) {
      var_2 = var_2 * var_0._id_90D4;
    }

    if(maps\mp\_utility::iskillstreakweapon(var_4) && isPlayer(var_1) && var_0 maps\mp\_utility::_hasperk("specialty_streakshield")) {
      var_2 = var_2 * var_0._id_944B;
    }

    if(_id_0513::ingrenadegraceperiod()) {
      var_2 = var_2 * level._id_597E;
    }
  } else if(var_3 == "MOD_FALLING") {
    if(var_0 maps\mp\_utility::_hasperk("specialty_falldamage") && isDefined(var_0._id_3A0F)) {
      var_9 = 0;
      var_2 = var_2 * var_0._id_3A0F;
    }

    if(var_0 maps\mp\_utility::_hasexperimentalbtperk("specialty_reducedexplosivefallprotection")) {
      var_9 = var_9 + var_2 * level.clumsydamagemod;
    }
  } else if(maps\mp\_utility::ismeleemod(var_3)) {
    if(var_1 maps\mp\_utility::_hasperk("specialty_increasedmeleedamage")) {
      var_2 = var_2 * level._id_60E3;
    }

    if(isDefined(var_0.haslightarmor) && var_0.haslightarmor) {
      if(issubstr(var_4, "riotshield") || var_4 == "exoshield_equipment_mp") {
        var_2 = int(var_0.maxhealth * 0.66);
      } else {
        var_2 = var_0.maxhealth + 1;
      }
    }
  } else if(maps\mp\_utility::_id_5697(var_3, var_4)) {
    if(isDefined(var_1) && isPlayer(var_1) && var_1 != var_0 && var_1 maps\mp\_utility::_hasperk("specialty_paint") && (!maps\mp\_utility::iskillstreakweapon(var_4) || issubstr(var_4, "killstreak_molotov_cocktail")) && !issubstr(var_4, "dragon_breath")) {
      var_0 thread _id_052C::setpainted(var_1, 0);
    }

    if(var_0 maps\mp\_utility::_hasperk("specialty_fireshield") && isDefined(var_0._id_90D8)) {
      var_2 = var_2 * var_0._id_90D8;
    }
  }

  var_11 = _getweaponbasename(var_4);

  if(isDefined(var_0.lightarmorhp) && isDefined(var_11)) {
    switch (var_11) {
      case "exoknife_jug_mp":
      case "exoknife_mp":
        var_2 = var_0.health;
        var_9 = 0;
        break;
      case "semtex_mp":
      case "semtexproj_mp":
        if(isDefined(var_8) && isDefined(var_8.stuckenemyentity) && var_8.stuckenemyentity == var_0) {
          var_2 = var_0.health;
          var_9 = 0;
        }

        break;
      default:
        if(var_3 != "MOD_FALLING" && !maps\mp\_utility::ismeleemod(var_3) && !maps\mp\_utility::isheadshot(var_11, var_7, var_3, var_1) && !maps\mp\_utility::isfmjdamage(var_11, var_3, var_1)) {
          var_0 _id_052C::setlightarmorhp(var_0.lightarmorhp - (var_2 + var_9));
          var_2 = 0;
          var_9 = 0;

          if(var_0.lightarmorhp <= 0) {
            var_2 = _abs(var_0.lightarmorhp);
            var_9 = 0;
            _id_052C::unsetlightarmor();
          }
        }

        break;
    }
  }

  if(var_2 < 1 && _func_367()) {
    return 0;
  }

  if(var_2 <= 1) {
    var_2 = 1;
    return var_2;
  } else
    return int(var_2 + var_9);
}

_id_532A() {
  level._id_597E = 0.08;
  level._id_597C = 0.08;
  level._id_0F68 = 1.5;
  level._id_7B94 = 0.25;
  level.fightorflightmovespeedscale = 1.12;
  level.thawmovemod = 0.8;
  level.crouchperkmovespeedscale = 1.2;
  level.bayonetchargemovespeedscale = 1.04;
  level.shieldchargemovespeedscale = 1.07;
  level.launchedrocketlauncherdamagemod = 1.3;
  level.bulletdamagemod = maps\mp\_utility::getintproperty("perk_bulletDamage", 40) / 100;
  level.explosivedamagemod = maps\mp\_utility::getintproperty("perk_explosiveDamage", 40) / 100;
  level.clumsydamagemod = maps\mp\_utility::getintproperty("perk_clumsyDamage", 120) / 100;
  level._id_60E3 = maps\mp\_utility::getintproperty("perk_meleeDamage", 200) / 100;
  level.riotshieldmod = maps\mp\_utility::getintproperty("perk_riotShield", 100) / 100;
  level._id_0F6A = maps\mp\_utility::getintproperty("perk_armorVest", 25) / 100;
  var_0 = getdvarfloat("1773");
  var_1 = getdvarfloat("2817");
  level._id_6EB1 = var_0 * var_0;
  level._id_08E2 = var_1 * var_1;
}

cac_selector() {}

giveblindeyeafterspawn() {
  self endon("death");
  self endon("disconnect");
  maps\mp\_utility::giveperk("specialty_blindeye");
  self.spawnperk = 1;

  while(!isDefined(self.avoidkillstreakonspawntimer)) {
    waitframe();
  }

  while(self.avoidkillstreakonspawntimer > 0) {
    self.avoidkillstreakonspawntimer = self.avoidkillstreakonspawntimer - 0.05;
    waitframe();
  }

  maps\mp\_utility::_id_0735("specialty_blindeye");
  self.spawnperk = 0;
}

_id_3154(var_0) {
  switch (var_0) {
    case "teslagunmtx_mp":
    case "turretweapon_plane_gunner_turret_grenadier_mp":
    case "turretweapon_plane_gunner_turret_mp":
    case "fighter_strike_gun_mp":
    case "carepackage_crate_mp":
      return 1;
    default:
      return 0;
  }
}

_id_0F36() {
  if(isDefined(level._id_3FDD)) {
    [[level._id_3FDD]]();
    return;
  }

  if(maps\mp\_utility::isdivisionsglobaloverhaulenabled()) {
    _id_04CC::setdivisiontrainingbasedonprogressionglobaloverhaulmtx4(self._id_0079);
  } else {
    _id_04CC::_id_8667(self._id_0079);
  }

  if(maps\mp\_utility::_hasperk("specialty_class_hustle")) {
    maps\mp\_utility::giveperk("specialty_sprintreload");
    maps\mp\_utility::giveperk("specialty_fastreload");
  }

  if(maps\mp\_utility::_hasperk("specialty_class_gunslinger")) {
    maps\mp\_utility::giveperk("specialty_sprintfire");
    maps\mp\_utility::giveperk("specialty_divefire");
  }

  if(maps\mp\_utility::_hasperk("specialty_class_energetic")) {
    maps\mp\_utility::giveperk("specialty_falldamage");

    if(maps\mp\_utility::isdivisionsglobaloverhaulenabled()) {
      if(!maps\mp\_utility::_hasperk("specialty_sprintfasterovertime")) {
        maps\mp\_utility::giveperk("specialty_lightweight");
      }
    } else
      maps\mp\_utility::giveperk("specialty_sprintfastrecovery");
  }

  if(maps\mp\_utility::_hasperk("specialty_class_inconspicuous")) {
    maps\mp\_utility::giveperk("specialty_quieter");
    maps\mp\_utility::giveperk("specialty_crouchmovement");
  }

  if(maps\mp\_utility::_hasperk("specialty_class_scoped")) {
    maps\mp\_utility::giveperk("specialty_stalker");
    maps\mp\_utility::giveperk("specialty_reducedsway");
  }

  if(maps\mp\_utility::_hasperk("specialty_class_duelist")) {}

  if(maps\mp\_utility::_hasperk("specialty_class_rifleman")) {
    maps\mp\_utility::giveperk("specialty_twoprimaries");
    maps\mp\_utility::giveperk("specialty_overkill");
    maps\mp\_utility::giveperk("specialty_quickswap");
  }

  if(maps\mp\_utility::_hasperk("specialty_class_primed")) {
    maps\mp\_utility::giveperk("specialty_sharp_focus");
  }

  if(maps\mp\_utility::_hasperk("specialty_class_forage")) {
    maps\mp\_utility::giveperk("specialty_scavenger");
    maps\mp\_utility::giveperk("specialty_bulletresupply");

    if(maps\mp\_utility::isdivisionsglobaloverhaulenabled()) {
      maps\mp\_utility::giveperk("specialty_extraammo");
      maps\mp\_utility::giveperk("specialty_regenbullets");
    } else
      maps\mp\_utility::giveperk("specialty_quickswap");
  }

  if(maps\mp\_utility::_hasperk("specialty_class_ordnance")) {
    if(!maps\mp\_utility::areexperimentalbasictrainingsenabled()) {
      maps\mp\_utility::giveperk("specialty_hardline");

      if(maps\mp\_utility::isdivisionsglobaloverhaulenabled()) {
        maps\mp\_utility::giveperk("specialty_scavenger");
        maps\mp\_utility::giveperk("specialty_scorestreakresupply");
      } else
        maps\mp\_utility::giveperk("specialty_unwrapper");
    }
  }

  if(maps\mp\_utility::_hasperk("specialty_class_serrated")) {
    maps\mp\_utility::giveperk("specialty_fastermelee");
  }

  if(maps\mp\_utility::_hasperk("specialty_class_requisitions")) {
    if(!maps\mp\_utility::areexperimentalbasictrainingsenabled()) {
      maps\mp\_utility::giveperk("specialty_supportstreaks");
    }
  }

  if(maps\mp\_utility::_hasperk("specialty_class_concussed")) {}

  if(maps\mp\_utility::_hasperk("specialty_class_hunker")) {
    maps\mp\_utility::giveperk("specialty_explosiveearlywarning");
    maps\mp\_utility::giveperk("specialty_throwback");

    if(!maps\mp\_utility::_hasperk("specialty_class_armored_enlisted") && !maps\mp\_utility::_hasperk("specialty_class_armored_expert") && !maps\mp\_utility::_hasperk("specialty_class_armored_master") && !maps\mp\_utility::_hasperk("specialty_class_armored_grandmaster")) {
      maps\mp\_utility::giveperk("specialty_blastshield2");
      self._id_90D4 = maps\mp\_utility::getintproperty("perk_blastShieldScale", 55) / 100;

      if(isDefined(level.hardcoremode) && level.hardcoremode) {
        self._id_90D4 = maps\mp\_utility::getintproperty("perk_blastShieldScale_HC", 14) / 100;
      }
    }
  }

  if(maps\mp\_utility::_hasperk("specialty_class_launched")) {
    maps\mp\_utility::giveperk("specialty_scavenger");
    maps\mp\_utility::giveperk("specialty_explosiveammoresupply");
  }

  if(maps\mp\_utility::_hasperk("specialty_class_bang")) {}

  if(maps\mp\_utility::_hasperk("specialty_class_lookout")) {
    maps\mp\_utility::giveperk("specialty_moreminimap");
    maps\mp\_utility::giveperk("specialty_eagleeyes");
  }

  if(maps\mp\_utility::_hasperk("specialty_class_undercover")) {
    maps\mp\_utility::giveperk("specialty_silentkill");
    maps\mp\_utility::giveperk("specialty_coldblooded");
    maps\mp\_utility::giveperk("specialty_spygame");
    maps\mp\_utility::giveperk("specialty_heartbreaker");
  }

  if(maps\mp\_utility::_hasperk("specialty_class_instincts")) {
    if(getdvarint("isMLGMatch", 0) == 0 && !xmodelalias/alias_ger_heads_scarf_for_muddy_cheap()) {
      maps\mp\_utility::giveperk("specialty_perception");
    }

    maps\mp\_utility::giveperk("specialty_detectexplosive");

    if(maps\mp\_utility::isdivisionsglobaloverhaulenabled()) {
      maps\mp\_utility::giveperk("specialty_stun_resistance");
      maps\mp\_utility::giveperk("specialty_resistshellshock");
      maps\mp\_utility::giveperk("specialty_immunesmoke");
      self.stunscaler = 0.1;
    }
  }

  if(maps\mp\_utility::_hasperk("specialty_class_espionage")) {
    self.specialty_paint_time = 6.0;
    maps\mp\_utility::giveperk("specialty_paint_pro");
    maps\mp\_utility::giveperk("specialty_minimapdangerinfo");
  }

  if(maps\mp\_utility::_hasperk("specialty_class_flanker")) {
    maps\mp\_utility::giveperk("specialty_radarimmune");
    maps\mp\_utility::giveperk("specialty_delaymine");
  }

  if(maps\mp\_utility::isproductionlevelactive(7)) {
    if(maps\mp\_utility::_hasperk("specialty_class_saboteur")) {
      maps\mp\_utility::giveperk("specialty_shortfuse");
    }
  }

  if(maps\mp\_utility::isdivisionsglobaloverhaulenabled()) {
    if(maps\mp\_utility::_hasperk("specialty_class_blitzkrieg")) {
      if(!maps\mp\_utility::_id_579B()) {
        maps\mp\_utility::giveperk("specialty_killstreaks");
        maps\mp\_utility::giveperk("specialty_improvedstreaks");
        maps\mp\_utility::giveperk("specialty_fourthstreak");
      }
    }

    if(maps\mp\_utility::_hasperk("specialty_class_clandestine")) {
      maps\mp\_utility::giveperk("specialty_scavenger");
      maps\mp\_utility::giveperk("specialty_intelresupply");
      maps\mp\_utility::giveperk("specialty_radarpingonspawn");
    }
  }

  if(getdvarint("6020", 1) == 1) {
    if(maps\mp\_utility::_hasperk("specialty_class_wanderlust")) {
      maps\mp\_utility::giveperk("specialty_randomgun");
    }

    if(maps\mp\_utility::_hasperk("specialty_class_escalation")) {
      maps\mp\_utility::giveperk("specialty_boostafterkill");
    }

    if(maps\mp\_utility::_hasperk("specialty_class_specialist")) {
      if(!maps\mp\_utility::_id_579B()) {
        maps\mp\_utility::giveperk("specialty_perkstreaks");
      }
    }
  }

  if(getdvarint("6019", 1) == 1) {
    if(maps\mp\_utility::_hasperk("specialty_class_frenzy")) {
      if(!maps\mp\_utility::areexperimentalbasictrainingsenabled()) {
        maps\mp\_utility::giveperk("specialty_sessionProgressionA");
      }
    }

    if(maps\mp\_utility::_hasperk("specialty_class_remedy")) {
      maps\mp\_utility::giveperk("specialty_fasterhealthregen");
    }
  }

  if(maps\mp\_utility::areexperimentalbasictrainingsenabled()) {
    if(maps\mp\_utility::_hasperk("specialty_class_frigid")) {
      maps\mp\_utility::giveperk("specialty_fightorflight");
      thread _id_052C::_id_6391();
    }

    if(maps\mp\_utility::_hasperk("specialty_class_blizzard")) {
      maps\mp\_utility::giveperk("specialty_rof");
      maps\mp\_utility::giveperk("specialty_bulletinaccuracy");
      maps\mp\_utility::giveperk("specialty_increasedrecoil");
    }

    if(maps\mp\_utility::_hasperk("specialty_class_snowblind")) {
      maps\mp\_utility::giveperk("specialty_bulletaccuracy");
      maps\mp\_utility::giveperk("specialty_steadyaimpro");
      self allowads(0);
    }

    if(maps\mp\_utility::_hasperk("specialty_class_whiteout")) {
      maps\mp\_utility::giveperk("specialty_explosivedamage");
      maps\mp\_utility::giveperk("specialty_reducedexplosivefallprotection");
    }

    if(maps\mp\_utility::_hasperk("specialty_class_humbug")) {
      thread _id_052C::monitorhumbug();
    }

    if(maps\mp\_utility::_hasperk("specialty_class_thaw")) {
      maps\mp\_utility::giveperk("specialty_marathon");
      thread _id_052C::monitorthaw();
    }

    maps\mp\_utility::giveperk("specialty_class_blitzkrieg");
    maps\mp\_utility::giveperk("specialty_killstreaks");
    maps\mp\_utility::giveperk("specialty_improvedstreaks");
    maps\mp\_utility::giveperk("specialty_fourthstreak");

    if(maps\mp\_utility::_hasperk("specialty_class_stopping_power")) {
      maps\mp\_utility::giveperk("specialty_moredamage");
    }

    if(maps\mp\_utility::_hasperk("specialty_class_juggernaut")) {
      maps\mp\_utility::giveperk("specialty_armorvest");
    }

    if(maps\mp\_utility::_hasperk("specialty_class_danger_close")) {
      maps\mp\_utility::giveperk("specialty_explosivedamage");
    }

    if(maps\mp\_utility::_hasperk("specialty_class_one_man_army")) {
      maps\mp\_utility::giveperk("specialty_rof");
      maps\mp\_utility::giveperk("specialty_bulletaccuracy");
      maps\mp\_utility::giveperk("specialty_steadyaimpro");
    }

    if(maps\mp\_utility::_hasperk("specialty_class_commando_pro")) {
      maps\mp\_utility::giveperk("specialty_extendedmelee");
      maps\mp\_utility::giveperk("specialty_fastermelee");
      maps\mp\_utility::giveperk("specialty_falldamage");
      maps\mp\_utility::giveperk("specialty_marathon");
    }

    if(maps\mp\_utility::_hasperk("specialty_class_last_stand")) {
      maps\mp\_utility::giveperk("specialty_stun_resistance");
      maps\mp\_utility::giveperk("specialty_resistshellshock");
      maps\mp\_utility::giveperk("specialty_immunesmoke");
      self.stunscaler = 0.1;
    }

    if(maps\mp\_utility::_hasperk("specialty_class_martyrdom")) {
      maps\mp\_utility::giveperk("specialty_grenadepulldeath");
      maps\mp\_utility::giveperk("specialty_shortfuse");
    }
  }
}