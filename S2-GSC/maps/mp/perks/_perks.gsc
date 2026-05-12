/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\perks\_perks.gsc
*********************************************/

func_00D5() {
  setdvarifuninitialized("6015", 0);
  setdvarifuninitialized("spv_commandoTacInsert_disabled", 0);
  setdvarifuninitialized("spv_cavalryImpactExplosivesBlocked_enabled", 0);
  setdvarifuninitialized("specialistBasicTraining1_score", 200);
  setdvarifuninitialized("specialistBasicTraining2_score", 400);
  setdvarifuninitialized("specialistBasicTraining3_score", 600);
  setdvarifuninitialized("specialistBasicTraining4_score", 800);
  level.var_6F5A = [];
  level.var_90D7 = "specialty_s1_temp";
  level.var_90D5 = "specialty_s1_temp";
  level.var_90D6 = "specialty_s1_temp";
  level.var_90D9 = "specialty_s1_temp";
  if(!isDefined(level.var_585D) || !level.var_585D) {
    level.var_906A["enemy"] = "npc_usa_emergency_flare";
    level.var_906A["friendly"] = "npc_usa_emergency_flare";
    level.var_9069["enemy"] = loadfx("vfx/props/tac_insert_enemy");
    level.var_9069["friendly"] = loadfx("vfx/props/tac_insert_friendly");
    level.var_9062 = loadfx("vfx/explosion/mp_tac_explosion");
  }

  level.var_0611["ricochet"] = loadfx("vfx/test/test_fx");
  level.var_8324 = [];
  level.var_6F68 = [];
  level.var_6F6C = [];
  level.var_8324["specialty_blastshield"] = 1;
  level.var_8324["specialty_blastshield2"] = 1;
  level.var_8324["specialty_akimbo"] = 1;
  level.var_8324["specialty_falldamage"] = 1;
  level.var_8324["specialty_shield"] = 1;
  level.var_8324["specialty_feigndeath"] = 1;
  level.var_8324["specialty_shellshock"] = 1;
  level.var_8324["specialty_delaymine"] = 1;
  level.var_8324["specialty_localjammer"] = 1;
  level.var_8324["specialty_thermal"] = 1;
  level.var_8324["specialty_blackbox"] = 1;
  level.var_8324["specialty_steelnerves"] = 1;
  level.var_8324["specialty_flashgrenade"] = 1;
  level.var_8324["specialty_smokegrenade"] = 1;
  level.var_8324["specialty_concussiongrenade"] = 1;
  level.var_8324["specialty_saboteur"] = 1;
  level.var_8324["specialty_endgame"] = 1;
  level.var_8324["specialty_rearview"] = 1;
  level.var_8324["specialty_onemanarmy"] = 1;
  level.var_8324["specialty_primarydeath"] = 1;
  level.var_8324["specialty_secondarybling"] = 1;
  level.var_8324["specialty_explosivedamage"] = 1;
  level.var_8324["specialty_laststandoffhand"] = 1;
  level.var_8324["specialty_dangerclose"] = 1;
  level.var_8324["specialty_hardjack"] = 1;
  level.var_8324["specialty_extraspecialduration"] = 1;
  level.var_8324["specialty_rollover"] = 1;
  level.var_8324["specialty_armorpiercing"] = 1;
  level.var_8324["specialty_omaquickchange"] = 1;
  level.var_8324["_specialty_rearview"] = 1;
  level.var_8324["_specialty_onemanarmy"] = 1;
  level.var_8324["specialty_steadyaimpro"] = 1;
  level.var_8324["specialty_stun_resistance"] = 1;
  level.var_8324["specialty_double_load"] = 1;
  level.var_8324["specialty_regenspeed"] = 1;
  level.var_8324["specialty_twoprimaries"] = 1;
  level.var_8324["specialty_overkill"] = 1;
  level.var_8324["specialty_anytwo"] = 1;
  level.var_8324["specialty_fasterlockon"] = 1;
  level.var_8324["specialty_paint"] = 1;
  level.var_8324["specialty_paint_pro"] = 1;
  level.var_8324["specialty_silentkill"] = 1;
  level.var_8324["specialty_crouchmovement"] = 1;
  level.var_8324["specialty_personaluav"] = 1;
  level.var_8324["specialty_unwrapper"] = 1;
  level.var_8324["specialty_extraammo"] = 1;
  level.var_8324["specialty_fireshield"] = 1;
  level.var_8324["specialty_minimapwhileads"] = 1;
  level.var_8324["specialty_radarpingonspawn"] = 1;
  level.var_8324["specialty_perception"] = 1;
  level.var_8324["specialty_shortfuse"] = 1;
  level.var_8324["specialty_throwequipmentfarther"] = 1;
  level.var_8324["specialty_cookinggrenadedeath"] = 1;
  level.var_8324["specialty_increasedmeleedamage"] = 1;
  level.var_8324["specialty_fightorflight"] = 1;
  level.var_8324["specialty_reducedexplosivefallprotection"] = 1;
  level.var_8324["specialty_gpsjammer"] = 1;
  level.var_8324["specialty_deadeye"] = 1;
  level.var_8324["specialty_boostafterkill"] = 1;
  level.var_8324["specialty_sprintfasterovertime"] = 1;
  level.var_8324["specialty_regenbullets"] = 1;
  level.var_8324["specialty_regenequipment"] = 1;
  level.var_8324["specialty_improvedtacticals"] = 1;
  level.var_8324["specialty_explosivewareffectiveness"] = 1;
  level.var_8324["specialty_intelkillsandassists"] = 1;
  level.var_8324["specialty_trainingUnlocker1"] = 1;
  level.var_8324["specialty_trainingUnlocker2"] = 1;
  level.var_8324["specialty_trainingUnlocker3"] = 1;
  level.var_8324["specialty_sessionProgressionA"] = 1;
  level.var_8324["specialty_sessionProgressionB"] = 1;
  level.var_8324["specialty_sessionProgressionC"] = 1;
  level.var_8324["specialty_medic"] = 1;
  level.var_8324["specialty_medkit"] = 1;
  level.var_8324["specialty_teammatehealthregen"] = 1;
  level.var_8324["specialty_extrascorewhilehealing"] = 1;
  level.var_8324["specialty_extraobjectivescore"] = 1;
  level.var_8324["specialty_tacticalinsertion"] = 1;
  level.var_8324["specialty_multikillboost"] = 1;
  level.var_8324["specialty_class_airborne_enlisted"] = 1;
  level.var_8324["specialty_class_airborne_expert"] = 1;
  level.var_8324["specialty_class_airborne_master"] = 1;
  level.var_8324["specialty_class_airborne_grandmaster"] = 1;
  level.var_8324["specialty_class_infantry_enlisted"] = 1;
  level.var_8324["specialty_class_infantry_expert"] = 1;
  level.var_8324["specialty_class_infantry_master"] = 1;
  level.var_8324["specialty_class_infantry_grandmaster"] = 1;
  level.var_8324["specialty_class_armored_enlisted"] = 1;
  level.var_8324["specialty_class_armored_expert"] = 1;
  level.var_8324["specialty_class_armored_master"] = 1;
  level.var_8324["specialty_class_armored_grandmaster"] = 1;
  level.var_8324["specialty_class_mountain_enlisted"] = 1;
  level.var_8324["specialty_class_mountain_expert"] = 1;
  level.var_8324["specialty_class_mountain_master"] = 1;
  level.var_8324["specialty_class_mountain_grandmaster"] = 1;
  level.var_8324["specialty_class_expeditionary_enlisted"] = 1;
  level.var_8324["specialty_class_expeditionary_expert"] = 1;
  level.var_8324["specialty_class_expeditionary_master"] = 1;
  level.var_8324["specialty_class_expeditionary_grandmaster"] = 1;
  level.var_8324["specialty_class_resistance_enlisted"] = 1;
  level.var_8324["specialty_class_resistance_expert"] = 1;
  level.var_8324["specialty_class_resistance_master"] = 1;
  level.var_8324["specialty_class_resistance_grandmaster"] = 1;
  level.var_8324["specialty_class_grenadier_enlisted"] = 1;
  level.var_8324["specialty_class_grenadier_expert"] = 1;
  level.var_8324["specialty_class_grenadier_master"] = 1;
  level.var_8324["specialty_class_grenadier_grandmaster"] = 1;
  level.var_8324["specialty_class_commando_enlisted"] = 1;
  level.var_8324["specialty_class_commando_expert"] = 1;
  level.var_8324["specialty_class_commando_master"] = 1;
  level.var_8324["specialty_class_commando_grandmaster"] = 1;
  level.var_8324["specialty_class_scout_enlisted"] = 1;
  level.var_8324["specialty_class_scout_expert"] = 1;
  level.var_8324["specialty_class_scout_master"] = 1;
  level.var_8324["specialty_class_scout_grandmaster"] = 1;
  level.var_8324["specialty_class_artillery_enlisted"] = 1;
  level.var_8324["specialty_class_artillery_expert"] = 1;
  level.var_8324["specialty_class_artillery_master"] = 1;
  level.var_8324["specialty_class_artillery_grandmaster"] = 1;
  level.var_8324["specialty_class_hustle"] = 1;
  level.var_8324["specialty_class_gunslinger"] = 1;
  level.var_8324["specialty_class_energetic"] = 1;
  level.var_8324["specialty_class_inconspicuous"] = 1;
  level.var_8324["specialty_class_scoped"] = 1;
  level.var_8324["specialty_class_duelist"] = 1;
  level.var_8324["specialty_class_rifleman"] = 1;
  level.var_8324["specialty_class_primed"] = 1;
  level.var_8324["specialty_class_forage"] = 1;
  level.var_8324["specialty_class_ordnance"] = 1;
  level.var_8324["specialty_class_requisitions"] = 1;
  level.var_8324["specialty_class_serrated"] = 1;
  level.var_8324["specialty_class_concussed"] = 1;
  level.var_8324["specialty_class_hunker"] = 1;
  level.var_8324["specialty_class_launched"] = 1;
  level.var_8324["specialty_class_bang"] = 1;
  level.var_8324["specialty_class_undercover"] = 1;
  level.var_8324["specialty_class_lookout"] = 1;
  level.var_8324["specialty_class_instincts"] = 1;
  level.var_8324["specialty_class_flanker"] = 1;
  level.var_8324["specialty_class_espionage"] = 1;
  level.var_8324["specialty_class_frigid"] = 1;
  level.var_8324["specialty_class_blizzard"] = 1;
  level.var_8324["specialty_class_snowblind"] = 1;
  level.var_8324["specialty_class_whiteout"] = 1;
  level.var_8324["specialty_class_humbug"] = 1;
  level.var_8324["specialty_class_thaw"] = 1;
  level.var_8324["specialty_class_shifty"] = 1;
  level.var_8324["specialty_class_saboteur"] = 1;
  level.var_8324["specialty_class_blitzkrieg"] = 1;
  level.var_8324["specialty_class_clandestine"] = 1;
  level.var_8324["specialty_class_wanderlust"] = 1;
  level.var_8324["specialty_class_escalation"] = 1;
  level.var_8324["specialty_class_specialist"] = 1;
  level.var_8324["specialty_class_remedy"] = 1;
  level.var_8324["specialty_class_frenzy"] = 1;
  level.var_8324["specialty_class_stopping_power"] = 1;
  level.var_8324["specialty_class_juggernaut"] = 1;
  level.var_8324["specialty_class_danger_close"] = 1;
  level.var_8324["specialty_class_one_man_army"] = 1;
  level.var_8324["specialty_class_commando_pro"] = 1;
  level.var_8324["specialty_class_last_stand"] = 1;
  level.var_8324["specialty_class_martyrdom"] = 1;
  level.var_8324["specialty_streakshield"] = 1;
  level.var_8324["specialty_streakdamager"] = 1;
  level.var_8324["specialty_marksman"] = 1;
  level.var_8324["specialty_sharp_focus"] = 1;
  level.var_8324["specialty_moredamage"] = 1;
  level.var_8324["specialty_copycat"] = 1;
  level.var_8324["specialty_finalstand"] = 1;
  level.var_8324["specialty_juiced"] = 1;
  level.var_8324["specialty_light_armor"] = 1;
  level.var_8324["specialty_carepackage"] = 1;
  level.var_8324["specialty_stopping_power"] = 1;
  level.var_8324["specialty_uav"] = 1;
  level.var_8324["bouncingbetty_mp"] = 1;
  level.var_8324["c4_mp"] = 1;
  level.var_8324["claymore_mp"] = 1;
  level.var_8324["frag_grenade_mp"] = 1;
  level.var_8324["frag_grenade_german_mp"] = 1;
  level.var_8324["semtex_mp"] = 1;
  level.var_8324["throwingknife_mp"] = 1;
  level.var_8324["explosive_gel_mp"] = 1;
  level.var_8324["contact_grenade_mp"] = 1;
  level.var_8324["concussion_grenade_mp"] = 1;
  level.var_8324["flash_grenade_mp"] = 1;
  level.var_8324["stun_grenade_mp"] = 1;
  level.var_8324["smoke_grenade_mp"] = 1;
  level.var_8324["smoke_grenade_axis_mp"] = 1;
  level.var_8324["smoke_grenade_expeditionary_mp"] = 1;
  level.var_8324["smoke_grenade_axis_expeditionary_mp"] = 1;
  level.var_8324["portable_radar_mp"] = 1;
  level.var_8324["trophy_mp"] = 1;
  level.var_8324["s2_tactical_insertion_device_mp"] = 1;
  level.var_8324["s2_tactical_insertion_cavalry_mp"] = 1;
  level.var_8324["tabun_grenade_mp"] = 1;
  level.var_8324["decoy_device_mp"] = 1;
  level.var_8324["signal_flare_mp"] = 1;
  level.var_8324["signal_flare_expeditionary_mp"] = 1;
  level.var_8324["extra_health_mp"] = 1;
  level.var_8324["specialty_null"] = 1;
  level.var_6F68["specialty_blastshield"] = ::maps\mp\perks\_perkfunctions::func_8639;
  level.var_6F6C["specialty_blastshield"] = ::maps\mp\perks\_perkfunctions::func_A053;
  level.var_6F68["specialty_falldamage"] = ::maps\mp\perks\_perkfunctions::func_8689;
  level.var_6F6C["specialty_falldamage"] = ::maps\mp\perks\_perkfunctions::func_A065;
  level.var_6F68["specialty_localjammer"] = ::maps\mp\perks\_perkfunctions::func_86C2;
  level.var_6F6C["specialty_localjammer"] = ::maps\mp\perks\_perkfunctions::func_A06F;
  level.var_6F68["specialty_thermal"] = ::maps\mp\perks\_perkfunctions::func_8741;
  level.var_6F6C["specialty_thermal"] = ::maps\mp\perks\_perkfunctions::func_A083;
  level.var_6F68["specialty_blackbox"] = ::maps\mp\perks\_perkfunctions::func_8638;
  level.var_6F6C["specialty_blackbox"] = ::maps\mp\perks\_perkfunctions::func_A052;
  level.var_6F68["specialty_steelnerves"] = ::maps\mp\perks\_perkfunctions::func_8734;
  level.var_6F6C["specialty_steelnerves"] = ::maps\mp\perks\_perkfunctions::func_A080;
  level.var_6F68["specialty_delaymine"] = ::maps\mp\perks\_perkfunctions::func_8663;
  level.var_6F6C["specialty_delaymine"] = ::maps\mp\perks\_perkfunctions::func_A057;
  level.var_6F68["specialty_improvedobjectives"] = ::maps\mp\perks\_perkfunctions::setimprovedobjectives;
  level.var_6F6C["specialty_improvedobjectives"] = ::maps\mp\perks\_perkfunctions::unsetimprovedobjectives;
  level.var_6F68["specialty_endgame"] = ::maps\mp\perks\_perkfunctions::func_8675;
  level.var_6F6C["specialty_endgame"] = ::maps\mp\perks\_perkfunctions::func_A05C;
  level.var_6F68["specialty_rearview"] = ::maps\mp\perks\_perkfunctions::func_870E;
  level.var_6F6C["specialty_rearview"] = ::maps\mp\perks\_perkfunctions::func_A078;
  level.var_6F68["specialty_onemanarmy"] = ::maps\mp\perks\_perkfunctions::func_86E0;
  level.var_6F6C["specialty_onemanarmy"] = ::maps\mp\perks\_perkfunctions::func_A071;
  level.var_6F68["specialty_steadyaimpro"] = ::maps\mp\perks\_perkfunctions::func_8733;
  level.var_6F6C["specialty_steadyaimpro"] = ::maps\mp\perks\_perkfunctions::func_A07F;
  level.var_6F68["specialty_stun_resistance"] = ::maps\mp\perks\_perkfunctions::func_8736;
  level.var_6F6C["specialty_stun_resistance"] = ::maps\mp\perks\_perkfunctions::func_A082;
  level.var_6F68["specialty_marksman"] = ::maps\mp\perks\_perkfunctions::func_86C6;
  level.var_6F6C["specialty_marksman"] = ::maps\mp\perks\_perkfunctions::func_A070;
  level.var_6F68["specialty_double_load"] = ::maps\mp\perks\_perkfunctions::func_866D;
  level.var_6F6C["specialty_double_load"] = ::maps\mp\perks\_perkfunctions::func_A059;
  level.var_6F68["specialty_sharp_focus"] = ::maps\mp\perks\_perkfunctions::func_8721;
  level.var_6F6C["specialty_sharp_focus"] = ::maps\mp\perks\_perkfunctions::func_A07B;
  level.var_6F68["specialty_regenspeed"] = ::maps\mp\perks\_perkfunctions::func_8711;
  level.var_6F6C["specialty_regenspeed"] = ::maps\mp\perks\_perkfunctions::func_A079;
  level.var_6F68["specialty_empimmune"] = ::maps\mp\perks\_perkfunctions::func_8673;
  level.var_6F6C["specialty_empimmune"] = ::maps\mp\perks\_perkfunctions::func_A05B;
  level.var_6F68["specialty_overkill_pro"] = ::maps\mp\perks\_perkfunctions::func_86E8;
  level.var_6F6C["specialty_overkill_pro"] = ::maps\mp\perks\_perkfunctions::func_A073;
  level.var_6F68["specialty_personaluav"] = ::maps\mp\perks\_perkfunctions::func_86F4;
  level.var_6F6C["specialty_personaluav"] = ::maps\mp\perks\_perkfunctions::func_A076;
  level.var_6F68["specialty_crouchmovement"] = ::maps\mp\perks\_perkfunctions::func_8658;
  level.var_6F6C["specialty_crouchmovement"] = ::maps\mp\perks\_perkfunctions::func_A056;
  level.var_6F68["specialty_light_armor"] = ::maps\mp\perks\_perkfunctions::func_86BB;
  level.var_6F6C["specialty_light_armor"] = ::maps\mp\perks\_perkfunctions::func_A06E;
  level.var_6F68["specialty_fightorflight"] = ::maps\mp\perks\_perkfunctions::func_867F;
  level.var_6F6C["specialty_fightorflight"] = ::maps\mp\perks\_perkfunctions::func_A060;
  level.var_6F68["specialty_extraammo"] = ::maps\mp\perks\_perkfunctions::func_867A;
  level.var_6F6C["specialty_extraammo"] = ::maps\mp\perks\_perkfunctions::func_A05E;
  level.var_6F68["specialty_radarpingonspawn"] = ::maps\mp\perks\_perkfunctions::func_870D;
  level.var_6F6C["specialty_radarpingonspawn"] = ::maps\mp\perks\_perkfunctions::func_A077;
  level.var_6F68["specialty_perception"] = ::maps\mp\perks\_perkfunctions::func_86F1;
  level.var_6F6C["specialty_perception"] = ::maps\mp\perks\_perkfunctions::func_A075;
  level.var_6F68["specialty_throwequipmentfarther"] = ::maps\mp\perks\_perkfunctions::func_8743;
  level.var_6F6C["specialty_throwequipmentfarther"] = ::maps\mp\perks\_perkfunctions::func_A084;
  level.var_6F68["specialty_shortfuse"] = ::maps\mp\perks\_perkfunctions::func_8722;
  level.var_6F6C["specialty_shortfuse"] = ::maps\mp\perks\_perkfunctions::func_A07C;
  level.var_6F68["specialty_cookinggrenadedeath"] = ::maps\mp\perks\_perkfunctions::func_8656;
  level.var_6F6C["specialty_cookinggrenadedeath"] = ::maps\mp\perks\_perkfunctions::func_A055;
  level.var_6F68["specialty_explosiveearlywarning"] = ::maps\mp\perks\_perkfunctions::func_8678;
  level.var_6F6C["specialty_explosiveearlywarning"] = ::maps\mp\perks\_perkfunctions::func_A05D;
  level.var_6F68["specialty_class_snowblind"] = ::maps\mp\perks\_perkfunctions::setsnowblind;
  level.var_6F6C["specialty_class_snowblind"] = ::maps\mp\perks\_perkfunctions::unsetsnowblind;
  level.var_6F68["specialty_class_thaw"] = ::maps\mp\perks\_perkfunctions::setthaw;
  level.var_6F6C["specialty_class_thaw"] = ::maps\mp\perks\_perkfunctions::unsetthaw;
  level.var_6F68["specialty_class_humbug"] = ::maps\mp\perks\_perkfunctions::sethumbug;
  level.var_6F6C["specialty_class_humbug"] = ::maps\mp\perks\_perkfunctions::unsethumbug;
  level.var_6F68["specialty_gpsjammer"] = ::maps\mp\perks\_perkfunctions::setgpsjammer;
  level.var_6F6C["specialty_gpsjammer"] = ::maps\mp\perks\_perkfunctions::unsetgpsjammer;
  level.var_6F68["specialty_class_shifty"] = ::maps\mp\perks\_perkfunctions::setshifty;
  level.var_6F6C["specialty_class_shifty"] = ::maps\mp\perks\_perkfunctions::unsetshifty;
  level.var_6F68["specialty_deadeye"] = ::maps\mp\perks\_perkfunctions::setdeadeye;
  level.var_6F6C["specialty_deadeye"] = ::maps\mp\perks\_perkfunctions::unsetdeadeye;
  level.var_6F68["specialty_class_resistance_enlisted"] = ::maps\mp\perks\_perkfunctions::setresistancedivisionscramblerindicator;
  level.var_6F6C["specialty_class_resistance_enlisted"] = ::maps\mp\perks\_perkfunctions::unsetresistancedivisionscramblerindicator;
  level.var_6F68["specialty_class_resistance_expert"] = ::maps\mp\perks\_perkfunctions::setresistancedivisionscramblerindicator;
  level.var_6F6C["specialty_class_resistance_expert"] = ::maps\mp\perks\_perkfunctions::unsetresistancedivisionscramblerindicator;
  level.var_6F68["specialty_class_resistance_master"] = ::maps\mp\perks\_perkfunctions::setresistancedivisionscramblerindicator;
  level.var_6F6C["specialty_class_resistance_master"] = ::maps\mp\perks\_perkfunctions::unsetresistancedivisionscramblerindicator;
  level.var_6F68["specialty_class_resistance_grandmaster"] = ::maps\mp\perks\_perkfunctions::setresistancedivisionscramblerindicator;
  level.var_6F6C["specialty_class_resistance_grandmaster"] = ::maps\mp\perks\_perkfunctions::unsetresistancedivisionscramblerindicator;
  level.var_6F68["specialty_sprintfasterovertime"] = ::maps\mp\perks\_perkfunctions::setsprintfasterovertime;
  level.var_6F6C["specialty_sprintfasterovertime"] = ::maps\mp\perks\_perkfunctions::unsetsprintfasterovertime;
  level.var_6F68["specialty_regenbullets"] = ::maps\mp\perks\_perkfunctions::setregeneratebulletsovertime;
  level.var_6F6C["specialty_regenbullets"] = ::maps\mp\perks\_perkfunctions::unsetregeneratebulletsovertime;
  level.var_6F68["specialty_regenequipment"] = ::maps\mp\perks\_perkfunctions::setregenerateequipmentovertime;
  level.var_6F6C["specialty_regenequipment"] = ::maps\mp\perks\_perkfunctions::unsetregenerateequipmentovertime;
  level.var_6F68["specialty_explosiveammoresupply"] = ::maps\mp\perks\_perkfunctions::setlaunched;
  level.var_6F6C["specialty_explosiveammoresupply"] = ::maps\mp\perks\_perkfunctions::unsetlaunched;
  level.var_6F68["specialty_boostafterkill"] = ::maps\mp\perks\_perkfunctions::setescalationboostafterkill;
  level.var_6F6C["specialty_boostafterkill"] = ::maps\mp\perks\_perkfunctions::unsetescalationboostafterkill;
  level.var_6F68["specialty_randomgun"] = ::maps\mp\perks\_perkfunctions::setrandomgun;
  level.var_6F6C["specialty_randomgun"] = ::maps\mp\perks\_perkfunctions::unsetrandomgun;
  level.var_6F68["specialty_perkstreaks"] = ::maps\mp\perks\_perkfunctions::setperkstreaks;
  level.var_6F6C["specialty_perkstreaks"] = ::maps\mp\perks\_perkfunctions::unsetperkstreaks;
  level.var_6F68["specialty_medic"] = ::maps\mp\perks\_medic::setmedic;
  level.var_6F6C["specialty_medic"] = ::maps\mp\perks\_medic::unsetmedic;
  level.var_6F68["specialty_boostafterreload"] = ::maps\mp\perks\_perkfunctions::setclassifiedboostafterreload;
  level.var_6F6C["specialty_boostafterreload"] = ::maps\mp\perks\_perkfunctions::unsetclassifiedboostafterreload;
  level.var_6F68["specialty_sessionProgressionA"] = ::maps\mp\perks\_perkfunctions::setserumbasictraining;
  level.var_6F6C["specialty_sessionProgressionA"] = ::maps\mp\perks\_perkfunctions::unsetserumbasictraining;
  level.var_6F68["specialty_finalstand"] = ::maps\mp\perks\_perkfunctions::func_8680;
  level.var_6F6C["specialty_finalstand"] = ::maps\mp\perks\_perkfunctions::func_A061;
  level.var_6F68["specialty_juiced"] = ::maps\mp\perks\_perkfunctions::func_86B4;
  level.var_6F6C["specialty_juiced"] = ::maps\mp\perks\_perkfunctions::func_A06B;
  level.var_6F68["specialty_carepackage"] = ::maps\mp\perks\_perkfunctions::func_8642;
  level.var_6F6C["specialty_carepackage"] = ::maps\mp\perks\_perkfunctions::func_A054;
  level.var_6F68["specialty_stopping_power"] = ::maps\mp\perks\_perkfunctions::func_8735;
  level.var_6F6C["specialty_stopping_power"] = ::maps\mp\perks\_perkfunctions::func_A081;
  level.var_6F68["specialty_uav"] = ::maps\mp\perks\_perkfunctions::func_8752;
  level.var_6F6C["specialty_uav"] = ::maps\mp\perks\_perkfunctions::func_A085;
  maps\mp\perks\_perkfunctions::buildwunderlustweaponlist();
  if(isDefined(level.var_3FDE)) {
    [[level.var_3FDE]]();
  }

  func_532A();
  level thread maps\mp\perks\_medic::initmedic();
  level thread func_6B6C();
}

func_A277(param_00, param_01) {
  if(getdvarint("scr_game_perks") == 0) {
    return 0;
  }

  if(function_030D(param_01)) {
    param_01 = maps\mp\_utility::func_452B(param_01);
  }

  if(isDefined(level.var_3FE0)) {
    var_02 = [[level.var_3FE0]](param_00, param_01);
    return var_02;
  }

  switch (param_01) {
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
    case "specialty_class_launched":
    case "specialty_class_concussed":
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
      return maps\mp\_utility::func_452A(param_01);

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
        return maps\mp\_utility::func_452A(param_01);
      } else {
        return 0;
      }

      break;

    case "specialty_class_toughness":
    case "specialty_bulletaccuracy":
    case "specialty_sprintreload":
    case "specialty_class_dangerclose":
    case "specialty_falldamage":
    case "specialty_exo_blastsuppressor":
      return param_01;

    default:
      return 0;
  }
}

func_44B5() {
  var_00 = [];
  for(var_01 = 0; var_01 < 9; var_01++) {
    var_00[var_01] = 0;
  }

  return var_00;
}

func_6B6C() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 func_73C7();
    var_00 thread func_6B82();
  }
}

func_73C7() {
  self.var_6F65 = [];
}

func_6B82() {
  self endon("disconnect");
  if(maps\mp\_utility::func_551F()) {
    return;
  }

  for(;;) {
    self waittill("spawned_player");
    if(maps\mp\_utility::func_0649("specialty_sixthsense")) {
      thread maps\mp\perks\_perkfunctions::func_63E3();
    }
  }
}

func_1E13(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  var_09 = 0;
  if(maps\mp\_utility::func_5694(param_03)) {
    if(!isDefined(param_01)) {
      return param_02;
    }

    if(isPlayer(param_01) && param_01 maps\mp\_utility::func_0649("specialty_deadeye")) {
      param_01 maps\mp\perks\_perkfunctions::setdeadeyeinternal();
    }

    if(isPlayer(param_01) && param_01 maps\mp\_utility::func_0649("specialty_paint_pro") && !maps\mp\_utility::func_5740(param_04) && isPlayer(param_00) || function_01EF(param_00)) {
      if(!param_00 maps\mp\perks\_perkfunctions::func_576D()) {
        param_01 maps\mp\gametypes\_missions::func_7750("ch_bulletpaint");
      }

      param_00 thread maps\mp\perks\_perkfunctions::func_86ED(param_01, 1);
    }

    if(isPlayer(param_00) && isDefined(param_00.var_4B9A) && param_00.var_4B9A && !maps\mp\_utility::func_570A(param_04, param_07, param_03, param_01)) {
      var_09 = var_09 - param_02 - 1;
      var_0A = param_02;
      if(isPlayer(param_01) && isDefined(param_01.var_4B50) && param_01.var_4B50) {
        var_0A = var_0A * level.var_0A07;
      }

      thread lib_0535::func_0F31(var_0A);
    } else if(isPlayer(param_01) && isDefined(param_01.var_4B50) && param_01.var_4B50 && param_00 maps\mp\_utility::func_0649("specialty_armorvest")) {
      var_09 = var_09 + param_02 * level.var_0A07 - level.var_0F6A;
    } else if(isPlayer(param_01) && isDefined(param_01.var_4B50) && param_01.var_4B50) {
      var_09 = var_09 + param_02 * level.var_0A07;
    } else if(isPlayer(param_01) && (param_01 maps\mp\_utility::func_0649("specialty_bulletdamage") || param_01 maps\mp\_utility::func_0649("specialty_moredamage")) && param_00 maps\mp\_utility::func_0649("specialty_armorvest")) {
      var_09 = var_09 + 0;
    } else if(isPlayer(param_01) && param_01 maps\mp\_utility::func_0649("specialty_bulletdamage") || param_01 maps\mp\_utility::func_0649("specialty_moredamage")) {
      var_09 = var_09 + param_02 * level.var_1D7C;
    } else if(param_00 maps\mp\_utility::func_0649("specialty_armorvest")) {
      var_09 = var_09 - param_02 * level.var_0F6A;
    }
  } else if(isexplosivedamagemod(param_03) || param_03 == "MOD_GAS") {
    if(!isDefined(param_01)) {
      return param_02;
    }

    if(isPlayer(param_01) && param_01 != param_00 && param_01 maps\mp\_utility::func_0649("specialty_paint") && !maps\mp\_utility::func_5740(param_04) || issubstr(param_04, "killstreak_molotov_cocktail")) {
      param_00 thread maps\mp\perks\_perkfunctions::func_86ED(param_01, 0);
    }

    if(maps\mp\_utility::func_472A(param_04) == "weapon_projectile" && function_01AA(param_04) == "rocketlauncher" && isPlayer(param_01) && function_01A7(param_04) && param_01 maps\mp\_utility::func_0649("specialty_class_launched")) {
      param_02 = param_02 * level.launchedrocketlauncherdamagemod;
    }

    if(maps\mp\gametypes\_weapons::func_57F6(param_04) && param_00 maps\mp\_utility::func_0649("specialty_stun_resistance")) {
      param_02 = 1;
      var_09 = 0;
    } else if(isPlayer(param_00) && isDefined(param_00.var_4B64) && param_00.var_4B64) {
      var_09 = var_09 - param_02 - 1;
      thread lib_0530::func_0F31(param_02);
    } else if(isPlayer(param_01) && function_01A7(param_04) && param_01 maps\mp\_utility::_hasexperimentalbtperk("specialty_explosivedamage") && param_00 maps\mp\_utility::func_0649("specialty_blastshield2") && param_00 maps\mp\_utility::_hasexperimentalbtperk("specialty_reducedexplosivefallprotection")) {
      var_09 = var_09 + param_02 * level.clumsydamagemod;
    } else if(isPlayer(param_01) && function_01A7(param_04) && param_01 maps\mp\_utility::_hasexperimentalbtperk("specialty_explosivedamage") && param_00 maps\mp\_utility::func_0649("specialty_blastshield2")) {
      var_09 = var_09 + 0;
    } else if(isPlayer(param_01) && function_01A7(param_04) && param_01 maps\mp\_utility::_hasexperimentalbtperk("specialty_explosivedamage") && param_00 maps\mp\_utility::_hasexperimentalbtperk("specialty_reducedexplosivefallprotection")) {
      var_09 = var_09 + param_02 * level.var_395D + param_02 * level.clumsydamagemod;
    } else if(isPlayer(param_01) && function_01A7(param_04) && param_01 maps\mp\_utility::_hasexperimentalbtperk("specialty_explosivedamage")) {
      var_09 = var_09 + param_02 * level.var_395D;
    } else if(param_00 maps\mp\_utility::_hasexperimentalbtperk("specialty_reducedexplosivefallprotection")) {
      var_09 = var_09 + param_02 * level.clumsydamagemod;
    } else if(param_00 maps\mp\_utility::func_0649("specialty_blastshield2") && isDefined(param_00.var_90D4) && (param_04 != "semtex_mp" || param_02 < 145) && !maps\mp\gametypes\_weapons::func_57F6(param_04) && !func_3154(param_04)) {
      param_02 = param_02 * param_00.var_90D4;
    }

    if(maps\mp\_utility::func_5740(param_04) && isPlayer(param_01) && param_00 maps\mp\_utility::func_0649("specialty_streakshield")) {
      param_02 = param_02 * param_00.var_944B;
    }

    if(maps\mp\gametypes\_weapons::func_513A()) {
      param_02 = param_02 * level.var_597E;
    }
  } else if(param_03 == "MOD_FALLING") {
    if(param_00 maps\mp\_utility::func_0649("specialty_falldamage") && isDefined(param_00.var_3A0F)) {
      var_09 = 0;
      param_02 = param_02 * param_00.var_3A0F;
    }

    if(param_00 maps\mp\_utility::_hasexperimentalbtperk("specialty_reducedexplosivefallprotection")) {
      var_09 = var_09 + param_02 * level.clumsydamagemod;
    }
  } else if(maps\mp\_utility::func_5755(param_03)) {
    if(param_01 maps\mp\_utility::func_0649("specialty_increasedmeleedamage")) {
      param_02 = param_02 * level.var_60E3;
    }

    if(isDefined(param_00.var_4B76) && param_00.var_4B76) {
      if(issubstr(param_04, "riotshield") || param_04 == "exoshield_equipment_mp") {
        param_02 = int(param_00.var_00FB * 0.66);
      } else {
        param_02 = param_00.var_00FB + 1;
      }
    }
  } else if(maps\mp\_utility::func_5697(param_03, param_04)) {
    if(isDefined(param_01) && isPlayer(param_01) && param_01 != param_00 && param_01 maps\mp\_utility::func_0649("specialty_paint") && (!maps\mp\_utility::func_5740(param_04) || issubstr(param_04, "killstreak_molotov_cocktail")) && !issubstr(param_04, "dragon_breath")) {
      param_00 thread maps\mp\perks\_perkfunctions::func_86ED(param_01, 0);
    }

    if(param_00 maps\mp\_utility::func_0649("specialty_fireshield") && isDefined(param_00.var_90D8)) {
      param_02 = param_02 * param_00.var_90D8;
    }
  }

  var_0B = getweapondisplayname(param_04);
  if(isDefined(param_00.var_5D2E) && isDefined(var_0B)) {
    switch (var_0B) {
      case "exoknife_jug_mp":
      case "exoknife_mp":
        param_02 = param_00.var_00BC;
        var_09 = 0;
        break;

      case "semtex_mp":
      case "semtexproj_mp":
        if(isDefined(param_08) && isDefined(param_08.var_9488) && param_08.var_9488 == param_00) {
          param_02 = param_00.var_00BC;
          var_09 = 0;
        }
        break;

      default:
        if(param_03 != "MOD_FALLING" && !maps\mp\_utility::func_5755(param_03) && !maps\mp\_utility::func_570A(var_0B, param_07, param_03, param_01) && !maps\mp\_utility::func_56F8(var_0B, param_03, param_01)) {
          param_00 maps\mp\perks\_perkfunctions::func_86BC(param_00.var_5D2E - param_02 + var_09);
          param_02 = 0;
          var_09 = 0;
          if(param_00.var_5D2E <= 0) {
            param_02 = abs(param_00.var_5D2E);
            var_09 = 0;
            maps\mp\perks\_perkfunctions::func_A06E();
          }
        }
        break;
    }
  }

  if(param_02 < 1 && function_0367()) {
    return 0;
  }

  if(param_02 <= 1) {
    param_02 = 1;
    return param_02;
  }

  return int(param_02 + var_09);
}

func_532A() {
  level.var_597E = 0.08;
  level.var_597C = 0.08;
  level.var_0F68 = 1.5;
  level.var_7B94 = 0.25;
  level.fightorflightmovespeedscale = 1.12;
  level.thawmovemod = 0.8;
  level.crouchperkmovespeedscale = 1.2;
  level.bayonetchargemovespeedscale = 1.04;
  level.shieldchargemovespeedscale = 1.07;
  level.launchedrocketlauncherdamagemod = 1.3;
  level.var_1D7C = maps\mp\_utility::func_4529("perk_bulletDamage", 40) / 100;
  level.var_395D = maps\mp\_utility::func_4529("perk_explosiveDamage", 40) / 100;
  level.clumsydamagemod = maps\mp\_utility::func_4529("perk_clumsyDamage", 120) / 100;
  level.var_60E3 = maps\mp\_utility::func_4529("perk_meleeDamage", 200) / 100;
  level.var_7EA1 = maps\mp\_utility::func_4529("perk_riotShield", 100) / 100;
  level.var_0F6A = maps\mp\_utility::func_4529("perk_armorVest", 25) / 100;
  var_00 = getdvarfloat("1773");
  var_01 = getdvarfloat("2817");
  level.var_6EB1 = var_00 * var_00;
  level.var_08E2 = var_01 * var_01;
}

func_1E15() {}

func_4778() {
  self endon("death");
  self endon("disconnect");
  maps\mp\_utility::func_47A2("specialty_blindeye");
  self.var_907E = 1;
  while(!isDefined(self.var_1444)) {
    wait 0.05;
  }

  while(self.var_1444 > 0) {
    self.var_1444 = self.var_1444 - 0.05;
    wait 0.05;
  }

  maps\mp\_utility::func_0735("specialty_blindeye");
  self.var_907E = 0;
}

func_3154(param_00) {
  switch (param_00) {
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

func_0F36() {
  if(isDefined(level.var_3FDD)) {
    [[level.var_3FDD]]();
    return;
  }

  if(maps\mp\_utility::isdivisionsglobaloverhaulenabled()) {
    maps\mp\gametypes\_division_specialty::setdivisiontrainingbasedonprogressionglobaloverhaulmtx4(self.var_0079);
  } else {
    maps\mp\gametypes\_division_specialty::func_8667(self.var_0079);
  }

  if(maps\mp\_utility::func_0649("specialty_class_hustle")) {
    maps\mp\_utility::func_47A2("specialty_sprintreload");
    maps\mp\_utility::func_47A2("specialty_fastreload");
  }

  if(maps\mp\_utility::func_0649("specialty_class_gunslinger")) {
    maps\mp\_utility::func_47A2("specialty_sprintfire");
    maps\mp\_utility::func_47A2("specialty_divefire");
  }

  if(maps\mp\_utility::func_0649("specialty_class_energetic")) {
    maps\mp\_utility::func_47A2("specialty_falldamage");
    if(maps\mp\_utility::isdivisionsglobaloverhaulenabled()) {
      if(!maps\mp\_utility::func_0649("specialty_sprintfasterovertime")) {
        maps\mp\_utility::func_47A2("specialty_lightweight");
      }
    } else {
      maps\mp\_utility::func_47A2("specialty_sprintfastrecovery");
    }
  }

  if(maps\mp\_utility::func_0649("specialty_class_inconspicuous")) {
    maps\mp\_utility::func_47A2("specialty_quieter");
    maps\mp\_utility::func_47A2("specialty_crouchmovement");
  }

  if(maps\mp\_utility::func_0649("specialty_class_scoped")) {
    maps\mp\_utility::func_47A2("specialty_stalker");
    maps\mp\_utility::func_47A2("specialty_reducedsway");
  }

  if(maps\mp\_utility::func_0649("specialty_class_duelist")) {}

  if(maps\mp\_utility::func_0649("specialty_class_rifleman")) {
    maps\mp\_utility::func_47A2("specialty_twoprimaries");
    maps\mp\_utility::func_47A2("specialty_overkill");
    maps\mp\_utility::func_47A2("specialty_quickswap");
  }

  if(maps\mp\_utility::func_0649("specialty_class_primed")) {
    maps\mp\_utility::func_47A2("specialty_sharp_focus");
  }

  if(maps\mp\_utility::func_0649("specialty_class_forage")) {
    maps\mp\_utility::func_47A2("specialty_scavenger");
    maps\mp\_utility::func_47A2("specialty_bulletresupply");
    if(maps\mp\_utility::isdivisionsglobaloverhaulenabled()) {
      maps\mp\_utility::func_47A2("specialty_extraammo");
      maps\mp\_utility::func_47A2("specialty_regenbullets");
    } else {
      maps\mp\_utility::func_47A2("specialty_quickswap");
    }
  }

  if(maps\mp\_utility::func_0649("specialty_class_ordnance")) {
    if(!maps\mp\_utility::areexperimentalbasictrainingsenabled()) {
      maps\mp\_utility::func_47A2("specialty_hardline");
      if(maps\mp\_utility::isdivisionsglobaloverhaulenabled()) {
        maps\mp\_utility::func_47A2("specialty_scavenger");
        maps\mp\_utility::func_47A2("specialty_scorestreakresupply");
      } else {
        maps\mp\_utility::func_47A2("specialty_unwrapper");
      }
    }
  }

  if(maps\mp\_utility::func_0649("specialty_class_serrated")) {
    maps\mp\_utility::func_47A2("specialty_fastermelee");
  }

  if(maps\mp\_utility::func_0649("specialty_class_requisitions")) {
    if(!maps\mp\_utility::areexperimentalbasictrainingsenabled()) {
      maps\mp\_utility::func_47A2("specialty_supportstreaks");
    }
  }

  if(maps\mp\_utility::func_0649("specialty_class_concussed")) {}

  if(maps\mp\_utility::func_0649("specialty_class_hunker")) {
    maps\mp\_utility::func_47A2("specialty_explosiveearlywarning");
    maps\mp\_utility::func_47A2("specialty_throwback");
    if(!maps\mp\_utility::func_0649("specialty_class_armored_enlisted") && !maps\mp\_utility::func_0649("specialty_class_armored_expert") && !maps\mp\_utility::func_0649("specialty_class_armored_master") && !maps\mp\_utility::func_0649("specialty_class_armored_grandmaster")) {
      maps\mp\_utility::func_47A2("specialty_blastshield2");
      self.var_90D4 = maps\mp\_utility::func_4529("perk_blastShieldScale", 55) / 100;
      if(isDefined(level.var_4B17) && level.var_4B17) {
        self.var_90D4 = maps\mp\_utility::func_4529("perk_blastShieldScale_HC", 14) / 100;
      }
    }
  }

  if(maps\mp\_utility::func_0649("specialty_class_launched")) {
    maps\mp\_utility::func_47A2("specialty_scavenger");
    maps\mp\_utility::func_47A2("specialty_explosiveammoresupply");
  }

  if(maps\mp\_utility::func_0649("specialty_class_bang")) {}

  if(maps\mp\_utility::func_0649("specialty_class_lookout")) {
    maps\mp\_utility::func_47A2("specialty_moreminimap");
    maps\mp\_utility::func_47A2("specialty_eagleeyes");
  }

  if(maps\mp\_utility::func_0649("specialty_class_undercover")) {
    maps\mp\_utility::func_47A2("specialty_silentkill");
    maps\mp\_utility::func_47A2("specialty_coldblooded");
    maps\mp\_utility::func_47A2("specialty_spygame");
    maps\mp\_utility::func_47A2("specialty_heartbreaker");
  }

  if(maps\mp\_utility::func_0649("specialty_class_instincts")) {
    if(getdvarint("isMLGMatch", 0) == 0 && !function_03AF()) {
      maps\mp\_utility::func_47A2("specialty_perception");
    }

    maps\mp\_utility::func_47A2("specialty_detectexplosive");
    if(maps\mp\_utility::isdivisionsglobaloverhaulenabled()) {
      maps\mp\_utility::func_47A2("specialty_stun_resistance");
      maps\mp\_utility::func_47A2("specialty_resistshellshock");
      maps\mp\_utility::func_47A2("specialty_immunesmoke");
      self.var_94BE = 0.1;
    }
  }

  if(maps\mp\_utility::func_0649("specialty_class_espionage")) {
    self.var_90DA = 6;
    maps\mp\_utility::func_47A2("specialty_paint_pro");
    maps\mp\_utility::func_47A2("specialty_minimapdangerinfo");
  }

  if(maps\mp\_utility::func_0649("specialty_class_flanker")) {
    maps\mp\_utility::func_47A2("specialty_radarimmune");
    maps\mp\_utility::func_47A2("specialty_delaymine");
  }

  if(maps\mp\_utility::isproductionlevelactive(7)) {
    if(maps\mp\_utility::func_0649("specialty_class_saboteur")) {
      maps\mp\_utility::func_47A2("specialty_shortfuse");
    }
  }

  if(maps\mp\_utility::isdivisionsglobaloverhaulenabled()) {
    if(maps\mp\_utility::func_0649("specialty_class_blitzkrieg")) {
      if(!maps\mp\_utility::func_579B()) {
        maps\mp\_utility::func_47A2("specialty_killstreaks");
        maps\mp\_utility::func_47A2("specialty_improvedstreaks");
        maps\mp\_utility::func_47A2("specialty_fourthstreak");
      }
    }

    if(maps\mp\_utility::func_0649("specialty_class_clandestine")) {
      maps\mp\_utility::func_47A2("specialty_scavenger");
      maps\mp\_utility::func_47A2("specialty_intelresupply");
      maps\mp\_utility::func_47A2("specialty_radarpingonspawn");
    }
  }

  if(getdvarint("6020", 1) == 1) {
    if(maps\mp\_utility::func_0649("specialty_class_wanderlust")) {
      maps\mp\_utility::func_47A2("specialty_randomgun");
    }

    if(maps\mp\_utility::func_0649("specialty_class_escalation")) {
      maps\mp\_utility::func_47A2("specialty_boostafterkill");
    }

    if(maps\mp\_utility::func_0649("specialty_class_specialist")) {
      if(!maps\mp\_utility::func_579B()) {
        maps\mp\_utility::func_47A2("specialty_perkstreaks");
      }
    }
  }

  if(getdvarint("6019", 1) == 1) {
    if(maps\mp\_utility::func_0649("specialty_class_frenzy")) {
      if(!maps\mp\_utility::areexperimentalbasictrainingsenabled()) {
        maps\mp\_utility::func_47A2("specialty_sessionProgressionA");
      }
    }

    if(maps\mp\_utility::func_0649("specialty_class_remedy")) {
      maps\mp\_utility::func_47A2("specialty_fasterhealthregen");
    }
  }

  if(maps\mp\_utility::areexperimentalbasictrainingsenabled()) {
    if(maps\mp\_utility::func_0649("specialty_class_frigid")) {
      maps\mp\_utility::func_47A2("specialty_fightorflight");
      thread maps\mp\perks\_perkfunctions::func_6391();
    }

    if(maps\mp\_utility::func_0649("specialty_class_blizzard")) {
      maps\mp\_utility::func_47A2("specialty_rof");
      maps\mp\_utility::func_47A2("specialty_bulletinaccuracy");
      maps\mp\_utility::func_47A2("specialty_increasedrecoil");
    }

    if(maps\mp\_utility::func_0649("specialty_class_snowblind")) {
      maps\mp\_utility::func_47A2("specialty_bulletaccuracy");
      maps\mp\_utility::func_47A2("specialty_steadyaimpro");
      self allowads(0);
    }

    if(maps\mp\_utility::func_0649("specialty_class_whiteout")) {
      maps\mp\_utility::func_47A2("specialty_explosivedamage");
      maps\mp\_utility::func_47A2("specialty_reducedexplosivefallprotection");
    }

    if(maps\mp\_utility::func_0649("specialty_class_humbug")) {
      thread maps\mp\perks\_perkfunctions::monitorhumbug();
    }

    if(maps\mp\_utility::func_0649("specialty_class_thaw")) {
      maps\mp\_utility::func_47A2("specialty_marathon");
      thread maps\mp\perks\_perkfunctions::monitorthaw();
    }

    maps\mp\_utility::func_47A2("specialty_class_blitzkrieg");
    maps\mp\_utility::func_47A2("specialty_killstreaks");
    maps\mp\_utility::func_47A2("specialty_improvedstreaks");
    maps\mp\_utility::func_47A2("specialty_fourthstreak");
    if(maps\mp\_utility::func_0649("specialty_class_stopping_power")) {
      maps\mp\_utility::func_47A2("specialty_moredamage");
    }

    if(maps\mp\_utility::func_0649("specialty_class_juggernaut")) {
      maps\mp\_utility::func_47A2("specialty_armorvest");
    }

    if(maps\mp\_utility::func_0649("specialty_class_danger_close")) {
      maps\mp\_utility::func_47A2("specialty_explosivedamage");
    }

    if(maps\mp\_utility::func_0649("specialty_class_one_man_army")) {
      maps\mp\_utility::func_47A2("specialty_rof");
      maps\mp\_utility::func_47A2("specialty_bulletaccuracy");
      maps\mp\_utility::func_47A2("specialty_steadyaimpro");
    }

    if(maps\mp\_utility::func_0649("specialty_class_commando_pro")) {
      maps\mp\_utility::func_47A2("specialty_extendedmelee");
      maps\mp\_utility::func_47A2("specialty_fastermelee");
      maps\mp\_utility::func_47A2("specialty_falldamage");
      maps\mp\_utility::func_47A2("specialty_marathon");
    }

    if(maps\mp\_utility::func_0649("specialty_class_last_stand")) {
      maps\mp\_utility::func_47A2("specialty_stun_resistance");
      maps\mp\_utility::func_47A2("specialty_resistshellshock");
      maps\mp\_utility::func_47A2("specialty_immunesmoke");
      self.var_94BE = 0.1;
    }

    if(maps\mp\_utility::func_0649("specialty_class_martyrdom")) {
      maps\mp\_utility::func_47A2("specialty_grenadepulldeath");
      maps\mp\_utility::func_47A2("specialty_shortfuse");
    }
  }
}