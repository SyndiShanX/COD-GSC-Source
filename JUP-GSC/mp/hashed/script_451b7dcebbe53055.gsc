/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_451b7dcebbe53055.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\utility;
#using scripts\mp\class;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\spawn_event_aggregator;
#namespace namespace_3d584eb182204aa6;

function function_fdcb8b9791123648() {
  level.denyclasschoice = 1;
  level thread onstartgametypefinished();
  level scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);
  level.bypassclasschoicefunc = &scripts\mp\class::alwaysgamemodeclass;
}

function onstartgametypefinished() {
  utility::flag_wait("onStartGameTypeFinished");
  setspecialloadouts();
  level.blockweapondrops = 1;
  level thread onplayerconnect();
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", player);
    player scripts\mp\class::function_a16868d4dcd81a4b();
    player.pers["gamemodeLoadout"] = level.var_76c17959f073bcae["allies"];
    player loadweaponsforplayer(["jup_cp01_sm_pcharlie9_mp", "jup_cp24_pi_glima21_mp"], 1);
  }
}

function onplayerspawned() {
  var_5153824e5dd5c7af = ["specialty_stalker_boots", "specialty_lightweight", "specialty_fastreload", "specialty_longslide", "specialty_sliding_ads", "specialty_fastcrouchmovement"];
  function_14d01be4caf93d0a(var_5153824e5dd5c7af);
  val::set("paintballMode", "execution_attack", 0);
  val::set("paintballMode", "execution_victim", 0);
}

function setspecialloadouts() {
  level.var_76c17959f073bcae["loadoutArchetype"] = "archetype_assault";
  level.var_76c17959f073bcae["allies"]["loadoutPrimary"] = "jup_cp01_sm_pcharlie9_mp";
  level.var_76c17959f073bcae["allies"]["loadoutPrimaryAttachment"] = "jup_paintball";
  level.var_76c17959f073bcae["allies"]["loadoutPrimaryAttachmentVariantID"] = 0;
  level.var_76c17959f073bcae["allies"]["loadoutPrimaryAttachment2"] = "jup_cp01_sm_pcharlie9_barsil_long";
  level.var_76c17959f073bcae["allies"]["loadoutPrimaryAttachmentVariantID2"] = 1;
  level.var_76c17959f073bcae["allies"]["loadoutPrimaryAttachment3"] = "jup_cp01_sm_pcharlie9_mag_40_4x30";
  level.var_76c17959f073bcae["allies"]["loadoutPrimaryAttachmentVariantID3"] = 5;
  level.var_76c17959f073bcae["allies"]["loadoutPrimaryAttachment4"] = "jup_reflex_proj_tall";
  level.var_76c17959f073bcae["allies"]["loadoutPrimaryAttachmentVariantID4"] = 42;
  level.var_76c17959f073bcae["allies"]["loadoutPrimaryAttachment5"] = "jup_cp01_sm_pcharlie9_pgrip_ass";
  level.var_76c17959f073bcae["allies"]["loadoutPrimaryAttachmentVariantID5"] = 9;
  level.var_76c17959f073bcae["allies"]["loadoutPrimaryAttachment6"] = "jup_grip_stop_03";
  level.var_76c17959f073bcae["allies"]["loadoutPrimaryAttachmentVariantID6"] = 50;
  level.var_76c17959f073bcae["allies"]["loadoutPrimaryVariantID"] = function_64ccc54bdbae5cf6(80083);
  level.var_76c17959f073bcae["allies"]["loadoutSecondary"] = "jup_cp24_pi_glima21_mp";
  level.var_76c17959f073bcae["allies"]["loadoutSecondaryAttachment"] = "jup_paintball";
  level.var_76c17959f073bcae["allies"]["loadoutSecondaryAttachment2"] = "jup_cp24_pi_glima21_bar_hvylong";
  level.var_76c17959f073bcae["allies"]["loadoutSecondaryAttachmentVariantID2"] = 2;
  level.var_76c17959f073bcae["allies"]["loadoutSecondaryAttachment3"] = "jup_cp24_pi_glima21_mag_18_45acp";
  level.var_76c17959f073bcae["allies"]["loadoutSecondaryAttachmentVariantID3"] = 3;
  level.var_76c17959f073bcae["allies"]["loadoutSecondaryAttachment4"] = "jup_silencer_pi_07";
  level.var_76c17959f073bcae["allies"]["loadoutSecondaryAttachmentVariantID4"] = 1;
  level.var_76c17959f073bcae["allies"]["loadoutSecondaryAttachment5"] = "jup_cp24_pi_glima21_pgrip_ass";
  level.var_76c17959f073bcae["allies"]["loadoutSecondaryAttachmentVariantID5"] = 1;
  level.var_76c17959f073bcae["allies"]["loadoutSecondaryAttachment6"] = "jup_cp24_pi_glima21_trigger_tac";
  level.var_76c17959f073bcae["allies"]["loadoutSecondaryAttachmentVariantID6"] = 1;
  level.var_76c17959f073bcae["allies"]["loadoutSecondaryVariantID"] = function_64ccc54bdbae5cf6(80074);
  level.var_76c17959f073bcae["allies"]["loadoutEquipmentPrimary"] = "none";
  level.var_76c17959f073bcae["allies"]["loadoutEquipmentSecondary"] = "none";
  level.var_76c17959f073bcae["allies"]["loadoutStreakType"] = "assault";
  level.var_76c17959f073bcae["allies"]["loadoutGesture"] = "playerData";
  level.var_76c17959f073bcae["axis"]["loadoutPrimary"] = "jup_cp01_sm_pcharlie9_mp";
  level.var_76c17959f073bcae["axis"]["loadoutPrimaryAttachment"] = "jup_paintball";
  level.var_76c17959f073bcae["axis"]["loadoutPrimaryAttachmentVariantID"] = 0;
  level.var_76c17959f073bcae["axis"]["loadoutPrimaryAttachment2"] = "jup_cp01_sm_pcharlie9_barsil_long";
  level.var_76c17959f073bcae["axis"]["loadoutPrimaryAttachmentVariantID2"] = 2;
  level.var_76c17959f073bcae["axis"]["loadoutPrimaryAttachment3"] = "jup_cp01_sm_pcharlie9_mag_40_4x30";
  level.var_76c17959f073bcae["axis"]["loadoutPrimaryAttachmentVariantID3"] = 6;
  level.var_76c17959f073bcae["axis"]["loadoutPrimaryAttachment4"] = "jup_reflex_proj_tall";
  level.var_76c17959f073bcae["axis"]["loadoutPrimaryAttachmentVariantID4"] = 43;
  level.var_76c17959f073bcae["axis"]["loadoutPrimaryAttachment5"] = "jup_cp01_sm_pcharlie9_pgrip_ass";
  level.var_76c17959f073bcae["axis"]["loadoutPrimaryAttachmentVariantID5"] = 10;
  level.var_76c17959f073bcae["axis"]["loadoutPrimaryAttachment6"] = "jup_grip_stop_03";
  level.var_76c17959f073bcae["axis"]["loadoutPrimaryAttachmentVariantID6"] = 51;
  level.var_76c17959f073bcae["axis"]["loadoutPrimaryVariantID"] = function_64ccc54bdbae5cf6(80084);
  level.var_76c17959f073bcae["axis"]["loadoutSecondary"] = "jup_cp24_pi_glima21_mp";
  level.var_76c17959f073bcae["axis"]["loadoutSecondaryAttachment"] = "jup_paintball";
  level.var_76c17959f073bcae["axis"]["loadoutSecondaryAttachment2"] = "jup_cp24_pi_glima21_bar_hvylong";
  level.var_76c17959f073bcae["axis"]["loadoutSecondaryAttachmentVariantID2"] = 3;
  level.var_76c17959f073bcae["axis"]["loadoutSecondaryAttachment3"] = "jup_cp24_pi_glima21_mag_18_45acp";
  level.var_76c17959f073bcae["axis"]["loadoutSecondaryAttachmentVariantID3"] = 4;
  level.var_76c17959f073bcae["axis"]["loadoutSecondaryAttachment4"] = "jup_silencer_pi_07";
  level.var_76c17959f073bcae["axis"]["loadoutSecondaryAttachmentVariantID4"] = 2;
  level.var_76c17959f073bcae["axis"]["loadoutSecondaryAttachment5"] = "jup_cp24_pi_glima21_pgrip_ass";
  level.var_76c17959f073bcae["axis"]["loadoutSecondaryAttachmentVariantID5"] = 2;
  level.var_76c17959f073bcae["axis"]["loadoutSecondaryAttachment6"] = "jup_cp24_pi_glima21_trigger_tac";
  level.var_76c17959f073bcae["axis"]["loadoutSecondaryAttachmentVariantID6"] = 2;
  level.var_76c17959f073bcae["axis"]["loadoutSecondaryVariantID"] = function_64ccc54bdbae5cf6(80076);
  level.var_76c17959f073bcae["axis"]["loadoutEquipmentPrimary"] = "none";
  level.var_76c17959f073bcae["axis"]["loadoutEquipmentSecondary"] = "none";
  level.var_76c17959f073bcae["axis"]["loadoutStreakType"] = "assault";
  level.var_76c17959f073bcae["axis"]["loadoutGesture"] = "playerData";
}

function function_14d01be4caf93d0a(var_608cc23373c0fd33) {
  scripts\mp\class::loadout_clearperks();

  foreach(perk in var_608cc23373c0fd33) {
    if(!scripts\mp\utility\perk::_hasperk(perk)) {
      scripts\mp\utility\perk::giveperk(perk);
    }
  }
}