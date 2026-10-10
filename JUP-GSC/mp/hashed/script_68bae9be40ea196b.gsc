/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_68bae9be40ea196b.gsc
*************************************************/

#using script_57bdd8aff28a4717;
#using script_7c2886c7a12179f;
#using script_7cfaa6fd841fb4dd;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\utility;
#using scripts\mp\utility\teams;
#namespace namespace_ce833ecc1b8e98dd;

function init() {
  scripts\engine\utility::registersharedfunc("rift_gate_relics_s3", "track_merc_captain_kill", &function_98c754673084315b);
}

function private function_98c754673084315b(var_810260c05dd6359) {
  var_810260c05dd6359 callback::add("on_ai_killed", &function_2105b9dc72887b71);
}

function private function_2105b9dc72887b71(sparams) {
  if(isDefined(sparams.eattacker) && isPlayer(sparams.eattacker)) {
    return;
  }

  var_fb7680c7bee58bb9 = namespace_64135de19550f047::function_a818575675b1f1c0(sparams);

  if(isDefined(var_fb7680c7bee58bb9) && isPlayer(var_fb7680c7bee58bb9)) {
    var_57e9b8021f36d0d7 = 0;
    a_players = var_fb7680c7bee58bb9 scripts\cp_mp\utility\squad_utility::getsquadmembers();

    foreach(player in a_players) {
      if(namespace_362cfff5d79f8b9b::function_95ec56461198f3f9(player) && namespace_fc89f9b99b72df11::function_d737da36e4f0f6c2(var_fb7680c7bee58bb9, "ob_jup_hydro_obelisk_reward_laptop_s3") == 0) {
        var_57e9b8021f36d0d7 = 1;
        break;
      }
    }

    if(istrue(var_57e9b8021f36d0d7)) {
      namespace_fc89f9b99b72df11::function_65e52fad2bce952c(var_fb7680c7bee58bb9, "ob_jup_hydro_obelisk_reward_laptop_s3", self.origin, 1);
      a_players = var_fb7680c7bee58bb9 scripts\cp_mp\utility\squad_utility::getsquadmembers();
      thread scripts\cp_mp\overlord::playevent("RFT_S3_5_RGUQ_Whispers_Laptop", a_players, 3);
    }
  }
}