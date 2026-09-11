/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58275.gsc
***********************************************/

function init() {
  var0 = spawnStruct();
  var0.ref_138fd = "field_resupply";
  var0.assault_update_hint_logic = &assault_update_hint_logic;
  var0.isdisconnecting = &isdisconnecting;
  _keypadscriptableused_bunkeralt::ref_12af4(var0);
}

function assault_update_hint_logic() {
  ref_135b7();
  self.player playlocalsound("ui_iw8_vip_premium_collected_fullscreen_lsrs");
  thread ref_12ccc();
  _keypadscriptableused_bunkeralt::ref_12425(self.player, "br_rumble_powerup_field_resupply_activated");
}

function ref_12ccc() {
  self.health = self.maxhealth;
  self.br_armorhealth = self.br_maxarmorhealth;
  self setclientomnvar("ui_br_armor_damage", 1);
  scripts\mp\equipment\armor_plate::debug_state(self.br_armorhealth);
  scripts\mp\gametypes\br_pickups::play_hud_reminder_vo();
  scripts\mp\supers::givesuperpoints(scripts\mp\supers::getsuperpointsneeded());
  thread ref_12ccb();
}

function ref_12ccb() {
  self endon("death_or_disconnect");
  thread scripts\mp\equipment::givescavengerammo();
  thread scripts\mp\equipment::givescavengerammo();
  scripts\mp\weapons::scavengergiveammo(self);
  waitframe();
  scripts\mp\weapons::scavengergiveammo(self);
  waitframe();
  scripts\mp\weapons::scavengergiveammo(self);
}

function isdisconnecting() {}

function ref_135b7() {}

function isplatepouch() {
  scripts\mp\gametypes\br_dev::ref_12b21(&isplacementplayerobstructed);
  thread isplayerbrsquadleader();
}

function isplayerbrsquadleader() {
  level endon("game_ended");

  while(!isDefined(level.player)) {
    waitframe();
  }
}

function isplacementplayerobstructed(var0, var1) {
  var2 = "";

  switch (var0) {
    case "rmbl_give_field_resupply_powerup":
      level.player _keypadscriptableused_bunkeralt::ref_1393a("field_resupply");
      break;
    case "rmbl_spawn_field_resupply_powerup":
      var3 = level.player.origin + anglesToForward(level.player.angles) * 300 + (0, 0, 25);
      easepower("brloot_rumble_powerup_field_resupply", var3);
      break;
    case "rmbl_give_teammate_field_resupply_powerup":
      var4 = scripts\mp\utility\teams::getteamdata(level.player.team, "players");
      var4 = scripts\engine\utility::array_remove(var4, level.player);
      var4[randomintrange(0, var4.size)] _keypadscriptableused_bunkeralt::ref_1393a("field_resupply");
      break;
  }
}