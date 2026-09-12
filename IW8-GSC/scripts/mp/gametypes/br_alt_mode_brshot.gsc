/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_alt_mode_brshot.gsc
*******************************************************/

function init() {
  if(!getdvarint("scr_br_alt_mode_brshot", 0)) {
    return;
  }

  if(level.debug_safehouse_regroup_start != 0) {
    level.debug_safehouse_regroup_start = 0;
  }

  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("drogBagLoadout");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("dropBagLoop");
  scripts\mp\gametypes\br_gametypes::ref_13F25("playerNakedDropLoadout");
  scripts\mp\gametypes\br_gametypes::ref_12B11("playerNakedDropLoadout", &ref_13380);
}

function ref_13380() {
  var_0 = self;
  level.deletescriptableinstanceaftertime = ref_1337F();
  var_0 scripts\mp\class::loadout_emptycacheofloadout("gamemode");
  var_0 scripts\mp\gametypes\br::searchcircleorigin(0, 1, 0);
  var_0 scripts\mp\gametypes\br_armor::searchcirclesize();
  scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
  scripts\mp\gametypes\br_weapons::br_ammo_give_type(self, "brloot_ammo_12g", 4, 0);

  if(!isDefined(self.player_enable_invulnerability)) {
    self.player_enable_invulnerability = 1;
    var_1 = getdvarint("scr_br_give_self_revive_on_spawn", 1);

    if(var_1) {
      scripts\mp\gametypes\br_pickups::bdroppingshield(1);
      return;
    }

    return;
  }

  var_1 = getdvarint("scr_br_give_self_revive_on_respawn", 0);

  if(var_1) {
    scripts\mp\gametypes\br_pickups::bdroppingshield(1);
    return;
  }
}

function ref_1337F() {
  var_0 = [];
  GscBinSkip0(0x2e, "loadoutArchetype", "archetype_assault");
}