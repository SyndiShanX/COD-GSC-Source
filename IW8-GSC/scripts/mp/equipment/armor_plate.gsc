/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\armor_plate.gsc
************************************************/

function debug_test_kill_kidnapper() {
  var0 = scripts\mp\equipment::getequipmentslotammo("health");

  if(var0 <= 0) {
    return;
  }

  if(self isparachuting()) {
    self notify("br_try_armor_cancel");
    return;
  }

  if(isDefined(self.cam)) {
    self.cam--;
  }

  var1 = scripts\engine\utility::ter_op(scripts\mp\utility\perk::_hasperk("specialty_br_stronger_armor"), self.br_maxarmorhealth / 2, self.br_maxarmorhealth / 3);
  jumpiffalse(getdvarint("scr_smartArmor_insertion", 0) == 1) LOC_00000077;
  var2 = self.br_armorhealth;
  var2 = int(var2 + var1);
  goto LOC_0000009d;
}

function debug_swivelroom_start() {
  var0 = self.br_armorhealth + 5;
  var1 = clamp(var0, 0, self.br_maxarmorhealth);
  var2 = max(1, getdvarint("scr_br_armor_heal_amount", 50));
  var1 = int(var1 / var2) * var2;
  var3 = clamp(var1, 0, self.br_maxarmorhealth);

  if(var3 >= self.br_armorhealth) {
    return;
  }

  self.br_armorhealth = var3;
  debug_state(self.br_armorhealth);
}

function debug_state(var0) {
  var1 = var0 * 150 / self.br_maxarmorhealth;
  self setclientomnvar("ui_br_armor_amount", int(var1));
  scripts\mp\gametypes\br_public::updatebrscoreboardstat("armorHealthRatio", int(var1));
}

function demo_update_hint_logic(var0, var1) {
  self endon("disconnect");

  if(var1 == 0) {
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

  var2 = getcompleteweaponname("armor_plate_deploy_mp");
  var3 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("", self);
  var3.camera_character_preview_select = var2;
  deletetmtylheadicon(1);
  thread denyascendmessagelaststand();
  var4 = scripts\cp_mp\killstreaks\killstreakdeploy::switchtodeployweapon(var2, var3, &delay_end_common_combat, undefined, undefined, undefined, undefined, 0);
}

function denyascendmessagelaststand() {
  self endon("br_armor_repair_end");
  self endon("disconnect");
  debug_run_helicopter_boss();
  thread depletiondelay();
  self.ref_138d4 = 0;
  scripts\engine\utility::ref_143a9("death", "mantle_start", "last_stand_start", "special_weapon_fired", "br_try_armor_cancel", "br_armor_plate_done");
  self.ref_138d4 = 1;
  thread debug_trans_1_start();
}

function depletiondelay() {
  self endon("disconnect");
  self endon("br_armor_repair_end");

  while(isDefined(self.currentweapon) && isDefined(self.currentweapon.basename) && self.currentweapon.basename != "armor_plate_deploy_mp") {
    if(self isonladder()) {
      self notify("br_try_armor_cancel");
    }

    waitframe();
  }

  while(isDefined(self.currentweapon) && isDefined(self.currentweapon.basename) && self.currentweapon.basename == "armor_plate_deploy_mp") {
    if(self isonladder()) {
      self notify("br_try_armor_cancel");
    }

    waitframe();
  }

  self notify("br_try_armor_cancel");
}

function deletetmtylheadicon(var0) {
  scripts\common\utility::allow_melee(!var0);
  scripts\common\utility::allow_killstreaks(!var0);
  scripts\common\utility::allow_crate_use(!var0);
  scripts\mp\equipment::allow_equipment(!var0);
  scripts\common\utility::allow_offhand_weapons(!var0);
  scripts\common\utility::brjugg_onplayerkilled(!var0);
  self.tracking_max_health = var0;
}

function delay_end_common_combat(var0) {
  self endon("disconnect");
  self endon("br_armor_repair_end");

  if(!delay_end_soldiers_spawns() || istrue(self.ref_138d4)) {
    return;
  }

  var1 = gettime();
  var2 = var1 + 1860;
  var3 = 2000;
  var4 = 1860;
  var5 = 0;

  while(var1 < var2) {
    if(!isDefined(var0.camera_character_preview_select) || var0.camera_character_preview_select != self getcurrentweapon()) {
      return;
    }

    waitframe();
    var1 = gettime();
  }

  debug_test_kill_kidnapper();
  var6 = (var3 - var4) / 1000;
  wait var6;

  while(deletepropsifatmax()) {
    var7 = self.equipment["health"];
    var8 = scripts\mp\equipment::getequipmentslotammo("health");

    if(isDefined(var7) && isDefined(var8) && var8 > 0 && self.br_armorhealth < self.br_maxarmorhealth) {
      var9 = gettime() + 1250;

      while(gettime() < var9) {
        if(!isDefined(var0.camera_character_preview_select) || var0.camera_character_preview_select != self getcurrentweapon()) {
          return;
        }

        waitframe();
      }

      debug_test_kill_kidnapper();
      var10 = 0.25;
      wait var10;
      continue;
    }

    break;
  }

  self notify("br_armor_plate_done");
}

function delay_end_soldiers_spawns() {
  if(isDefined(self.vehicle)) {
    var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(self.vehicle, self);

    if(var0 == "driver") {
      return false;
    }
  }

  var1 = self isskydiving() || self isonladder();
  var2 = istrue(self.ref_12d1e) || istrue(self.isjuggernaut);
  var2 |= scripts\mp\supers::issuperinuse() && self.super.staticdata.ref != "super_deadsilence" && self.super.staticdata.ref != "super_serum_gadget";

  if(var1 || var2) {
    return false;
  }

  if(self.br_armorhealth == self.br_maxarmorhealth) {
    scripts\mp\hud_message::showerrormessage(level.br_pickups.delete_furthest_respawn_enemy);
    return false;
  }

  return true;
}

function deletepropsifatmax() {
  var0 = scripts\engine\utility::is_player_gamepad_enabled() && self allowspectateallteams();
  var1 = isDefined(self.cam) && self.cam > 0;
  return var0 || var1;
}

function debug_run_helicopter_boss() {
  self notifyonplayercommand("br_try_armor_cancel", "+weapnext");
  self notifyonplayercommand("br_try_armor_cancel", "+weapprev");
  self notifyonplayercommand("br_try_armor_cancel", "+attack");
  self notifyonplayercommand("br_try_armor_cancel", "+smoke");
  self notifyonplayercommand("br_try_armor_cancel", "+frag");
  self notifyonplayercommand("br_try_armor_cancel", "+melee_zoom");
}

function delete_wire_blocker_on_trigger() {
  self notifyonplayercommandremove("br_try_armor_cancel", "+weapnext");
  self notifyonplayercommandremove("br_try_armor_cancel", "+weapprev");
  self notifyonplayercommandremove("br_try_armor_cancel", "+attack");
  self notifyonplayercommandremove("br_try_armor_cancel", "+smoke");
  self notifyonplayercommandremove("br_try_armor_cancel", "+frag");
  self notifyonplayercommandremove("br_try_armor_cancel", "+melee_zoom");
}

function debug_trans_1_start() {
  self endon("disconnect");
  self notify("br_armor_repair_end");
  delete_wire_blocker_on_trigger();

  while(isDefined(self.currentweapon) && isDefined(self.currentweapon.basename) && self.currentweapon.basename == "armor_plate_deploy_mp") {
    waitframe();
  }

  waitframe();

  if(istrue(self.cam)) {
    self.cam = 0;
  }

  deletetmtylheadicon(0);
}