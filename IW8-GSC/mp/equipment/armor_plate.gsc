/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\equipment\armor_plate.gsc
***********************************************/

debug_test_kill_kidnapper() {
  var_0 = scripts\mp\equipment::getequipmentslotammo("_encstr_91B50734CA58631D1A");

  if(var_0 <= 0) {
    return;
  }
  if(self isparachuting()) {
    self notify("_encstr_869A146EBB0984CB5B5F5F1B130893F780A1E5B6F128");
    return;
  }

  if(isDefined(self.cam))
    self.cam--;

  var_1 = scripts\engine\utility::ter_op(scripts\mp\utility\perk::_hasperk("_encstr_B68A1CDC072BC696C2C63AE5F54CC9FA37A339B7B93BCA937DC2C9ADDE27"), self.br_maxarmorhealth / 2, self.br_maxarmorhealth / 3);

  if(getdvarint("_encstr_858219CD1B9CEB37B5854E3AA0C95BDB9CAF5AB96E56E4E84BF6E6", 0) == 1) {
    var_2 = self.br_armorhealth;
    var_2 = int(var_2 + var_1);
  } else {
    var_3 = self.br_armorhealth + 5;
    var_2 = clamp(var_3, 0, self.br_maxarmorhealth);
    var_2 = int(var_2 / var_1) * var_1 + var_1;
  }

  self.br_armorhealth = clamp(var_2, 0, self.br_maxarmorhealth);
  debug_state(self.br_armorhealth);
  scripts\mp\equipment::decrementequipmentslotammo("_encstr_91B50734CA58631D1A", 1);
  scripts\cp\vehicles\vehicle_compass_cp::_id_120A8("_encstr_8D3F0C8FA2EAE77B6FEB4010C36D");
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_encstr_82D91946DDF83E5657A7C383859F33489CDF082F10E88BAAE24D36("_encstr_8BAA0D6F98B6638032CB176411995F");

  if(scripts\mp\utility\perk::_hasperk("_encstr_A946261781314E6450C08D0376EB4D9773282796FBBBEFB750BF71BA04C7930905620EA151E9F58A"))
    scripts\mp\perks\perkfunctions::_id_12AD0();

  self notify("_encstr_97A115667350571380C9939FF9B5099990BB9F2A2BB8E4");
}

debug_swivelroom_start() {
  var_0 = self.br_armorhealth + 5;
  var_1 = clamp(var_0, 0, self.br_maxarmorhealth);
  var_2 = max(1, getdvarint("_encstr_8C0F1902B14887F2F67747736B10BBCFC0D93E4DAE384DFA4D3D1B", 50));
  var_1 = int(var_1 / var_2) * var_2;
  var_3 = clamp(var_1, 0, self.br_maxarmorhealth);

  if(var_3 >= self.br_armorhealth) {
    return;
  }
  self.br_armorhealth = var_3;
  debug_state(self.br_armorhealth);
}

debug_state(var_0) {
  var_1 = var_0 * (150 / self.br_maxarmorhealth);
  self setclientomnvar("_encstr_A9F113AEA5EB4C4EFAC2E4B5BD4EEBC2DABDBA3747", int(var_1));
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat("_encstr_AB7D11491E889F8289381AC25821725F430BDF", int(var_1));
}

demo_update_hint_logic(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(var_1 == 0) {
    return;
  }
  if(istrue(self.tracking_max_health)) {
    return;
  }
  if(self isswitchingweapon()) {
    return;
  }
  if(!delay_end_soldiers_spawns()) {
    return;
  }
  var_2 = getcompleteweaponname("_encstr_B60816BAAB286D9BE1BF79AE2BC31FB38B8B856008975D73");
  var_3 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_B40101", self);
  var_3.camera_character_preview_select = var_2;
  deletetmtylheadicon(1);
  thread denyascendmessagelaststand();
  var_4 = scripts\cp_mp\killstreaks\killstreakdeploy::switchtodeployweapon(var_2, var_3, ::delay_end_common_combat, undefined, undefined, undefined, undefined, 0);
}

denyascendmessagelaststand() {
  self endon("_encstr_9B01144B76D1D96AED68F31FC56DF0E26C130F097049");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  debug_run_helicopter_boss();
  thread depletiondelay();
  self._id_138D4 = 0;
  scripts\engine\utility::_id_143A9("_encstr_AD75063D571AE108", "_encstr_8C4F0DB65873E8D8ACAF6E8EB0E4E8", "_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B", "_encstr_AA22154B3A4D309B228BFFA7C74A5F08EE59518022B5C0", "_encstr_869A146EBB0984CB5B5F5F1B130893F780A1E5B6F128", "_encstr_8216144C4EEBB0C9B6DB4EAFC1C6588E59FA91BDDCCA");
  self._id_138D4 = 1;
  thread debug_trans_1_start();
}

depletiondelay() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9B01144B76D1D96AED68F31FC56DF0E26C130F097049");

  while(isDefined(self.currentweapon) && isDefined(self.currentweapon.basename) && self.currentweapon.basename != "_encstr_B60816BAAB286D9BE1BF79AE2BC31FB38B8B856008975D73") {
    if(self isonladder())
      self notify("_encstr_869A146EBB0984CB5B5F5F1B130893F780A1E5B6F128");

    waitframe();
  }

  while(isDefined(self.currentweapon) && isDefined(self.currentweapon.basename) && self.currentweapon.basename == "_encstr_B60816BAAB286D9BE1BF79AE2BC31FB38B8B856008975D73") {
    if(self isonladder())
      self notify("_encstr_869A146EBB0984CB5B5F5F1B130893F780A1E5B6F128");

    waitframe();
  }

  self notify("_encstr_869A146EBB0984CB5B5F5F1B130893F780A1E5B6F128");
}

deletetmtylheadicon(var_0) {
  scripts\common\utility::allow_melee(!var_0);
  scripts\common\utility::allow_killstreaks(!var_0);
  scripts\common\utility::allow_crate_use(!var_0);
  scripts\mp\equipment::allow_equipment(!var_0);
  scripts\common\utility::allow_offhand_weapons(!var_0);
  scripts\common\utility::brjugg_onplayerkilled(!var_0);
  self.tracking_max_health = var_0;
}

delay_end_common_combat(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9B01144B76D1D96AED68F31FC56DF0E26C130F097049");

  if(!delay_end_soldiers_spawns() || istrue(self._id_138D4)) {
    return;
  }
  var_1 = gettime();
  var_2 = var_1 + 1860.0;
  var_3 = 2000.0;
  var_4 = 1860.0;

  for(var_5 = 0; var_1 < var_2; var_1 = gettime()) {
    if(!isDefined(var_0.camera_character_preview_select) || var_0.camera_character_preview_select != self getcurrentweapon()) {
      return;
    }
    waitframe();
  }

  debug_test_kill_kidnapper();
  var_6 = (var_3 - var_4) / 1000;
  wait(var_6);

  while(deletepropsifatmax()) {
    var_7 = self.equipment["_encstr_91B50734CA58631D1A"];
    var_8 = scripts\mp\equipment::getequipmentslotammo("_encstr_91B50734CA58631D1A");

    if(isDefined(var_7) && isDefined(var_8) && var_8 > 0 && self.br_armorhealth < self.br_maxarmorhealth) {
      var_9 = gettime() + 1250.0;

      while(gettime() < var_9) {
        if(!isDefined(var_0.camera_character_preview_select) || var_0.camera_character_preview_select != self getcurrentweapon()) {
          return;
        }
        waitframe();
      }

      debug_test_kill_kidnapper();
      var_10 = 0.25;
      wait(var_10);
      continue;
    }

    break;
  }

  self notify("_encstr_8216144C4EEBB0C9B6DB4EAFC1C6588E59FA91BDDCCA");
}

delay_end_soldiers_spawns() {
  if(isDefined(self.vehicle)) {
    var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(self.vehicle, self);

    if(var_0 == "_encstr_9AE307B956E345D0AB")
      return 0;
  }

  var_1 = self isskydiving() || self isonladder();
  var_2 = istrue(self._id_12D1E) || istrue(self.isjuggernaut);
  var_2 = var_2 | (scripts\mp\supers::issuperinuse() && (self.super.staticdata.ref != "_encstr_A66C12DE3B63AB1307C36048AB4308C15A655E6D" && self.super.staticdata.ref != "_encstr_9B2613831B8F2F22392FB5AA0B80219FBF915A6AC3"));

  if(var_1 || var_2)
    return 0;

  if(self.br_armorhealth == self.br_maxarmorhealth) {
    scripts\mp\hud_message::showerrormessage(level.br_pickups.delete_furthest_respawn_enemy);
    return 0;
  }

  return 1;
}

deletepropsifatmax() {
  var_0 = scripts\engine\utility::is_player_gamepad_enabled() && self allowspectateallteams();
  var_1 = isDefined(self.cam) && self.cam > 0;
  return var_0 || var_1;
}

debug_run_helicopter_boss() {
  self notifyonplayercommand("_encstr_869A146EBB0984CB5B5F5F1B130893F780A1E5B6F128", "_encstr_A6E60A229B175A3B48A543AB");
  self notifyonplayercommand("_encstr_869A146EBB0984CB5B5F5F1B130893F780A1E5B6F128", "_encstr_81E10A4B8F483EAB573B2AE3");
  self notifyonplayercommand("_encstr_869A146EBB0984CB5B5F5F1B130893F780A1E5B6F128", "_encstr_A9E60828803C73F11780");
  self notifyonplayercommand("_encstr_869A146EBB0984CB5B5F5F1B130893F780A1E5B6F128", "_encstr_8E5F0795E6AD7BAD2B");
  self notifyonplayercommand("_encstr_869A146EBB0984CB5B5F5F1B130893F780A1E5B6F128", "_encstr_9B0D065699E485D9");
  self notifyonplayercommand("_encstr_869A146EBB0984CB5B5F5F1B130893F780A1E5B6F128", "_encstr_9AC10C59D6CAB12BCAF5E97BEDD6");
}

delete_wire_blocker_on_trigger() {
  self notifyonplayercommandremove("_encstr_869A146EBB0984CB5B5F5F1B130893F780A1E5B6F128", "_encstr_A6E60A229B175A3B48A543AB");
  self notifyonplayercommandremove("_encstr_869A146EBB0984CB5B5F5F1B130893F780A1E5B6F128", "_encstr_81E10A4B8F483EAB573B2AE3");
  self notifyonplayercommandremove("_encstr_869A146EBB0984CB5B5F5F1B130893F780A1E5B6F128", "_encstr_A9E60828803C73F11780");
  self notifyonplayercommandremove("_encstr_869A146EBB0984CB5B5F5F1B130893F780A1E5B6F128", "_encstr_8E5F0795E6AD7BAD2B");
  self notifyonplayercommandremove("_encstr_869A146EBB0984CB5B5F5F1B130893F780A1E5B6F128", "_encstr_9B0D065699E485D9");
  self notifyonplayercommandremove("_encstr_869A146EBB0984CB5B5F5F1B130893F780A1E5B6F128", "_encstr_9AC10C59D6CAB12BCAF5E97BEDD6");
}

debug_trans_1_start() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_9B01144B76D1D96AED68F31FC56DF0E26C130F097049");
  delete_wire_blocker_on_trigger();

  while(isDefined(self.currentweapon) && isDefined(self.currentweapon.basename) && self.currentweapon.basename == "_encstr_B60816BAAB286D9BE1BF79AE2BC31FB38B8B856008975D73")
    waitframe();

  waitframe();

  if(istrue(self.cam))
    self.cam = 0;

  deletetmtylheadicon(0);
}