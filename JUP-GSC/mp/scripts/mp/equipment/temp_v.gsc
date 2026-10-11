/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\equipment\temp_v.gsc
***********************************************/

#using script_268c558ddb2267aa;
#using scripts\common\utility;
#using scripts\cp_mp\talking_gun;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#using scripts\mp\bounty_system;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\hud_message;
#using scripts\mp\perks\perkpackage;
#using scripts\mp\supers;
#namespace temp_v;

function init() {
  level.var_b35fc6d4a1b9424f = spawnStruct();
  level.var_b35fc6d4a1b9424f.powers = [];
  level.var_b35fc6d4a1b9424f.perks = ["specialty_super_strength", "specialty_durability", "specialty_super_speed"];
  level.var_2ddd5fa2cfa55afe = 0;
  namespace_314b181252bf1520::function_41c4a42ae28c7e16();
  level._effect["superPower_teleportOut"] = loadfx("vfx/iw9/gameplay/theboys/vfx_gameplay_theboys_teleport_out.vfx");
  game["dialog"]["supe_spotted"] = "game_ovld_spes";
  game["dialog"]["supe_lost"] = "game_ovld_spec";
  game["dialog"]["supe_killed"] = "game_ovld_sprk";
  snd_transient_load("mp_gamemode_temp_v");
}

function function_d3f8e1c800b2e8c0() {
  thread scripts\mp\hud_message::showsplash("super_temp_v" + "_pickup", undefined, self, undefined, undefined, undefined, 1);
}

function function_4364c764fcf6194d() {
  thread function_a44c81f35835ab6f();
  scripts\cp_mp\talking_gun::function_55b08d6d71b41402(self, "self_apply");
  return true;
}

function function_a44c81f35835ab6f() {
  while(isDefined(self getheldoffhand()) && self getheldoffhand().basename == "tempv_mp") {
    waitframe();
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    self setclientomnvar("ui_super_warning", 1);
  }

  if(isDefined(level.var_2ddd5fa2cfa55afe)) {
    level.var_2ddd5fa2cfa55afe--;

    if(level.var_2ddd5fa2cfa55afe < 0) {
      level.var_2ddd5fa2cfa55afe = 0;
    }
  }

  self setscriptablepartstate("superpowers_aura", "on", 0);
  self setscriptablepartstate("superpowers_veins", "on", 0);
  self.var_b9976aacfe15a7ba = 1;
  thread function_acf86641a7105328();
  thread function_f2c35147cd83e1c7();
  function_79cd1b77a631e77c(self);
  thread function_a823070a9e81d9d8();
  thread function_4c30d408ae45aa33();
  thread function_cef1c8463d56bb49();
}

function tempv_end() {
  return true;
}

function function_c0b7105aae16a9b3(mapname) {
  powerlist = ["super_teleport_deploy", "super_electric_discharge", "super_high_jump", "super_laser_charge"];

  if(level.mapname == "mp_bio_lab" || level.mapname == "mp_biobunker") {
    powerlist = ["super_electric_discharge", "super_laser_charge"];
  }

  return powerlist;
}

function function_a823070a9e81d9d8() {
  powerlist = function_c0b7105aae16a9b3(level.mapname);
  randint = randomint(powerlist.size);
  powerref = powerlist[randint];
  forcepower = getDvar(@ "hash_18cc28f3820edbd6", "");

  if(forcepower != "") {
    if(forcepower == "teleport") {
      powerref = "super_teleport_deploy";
    } else if(forcepower == "electric") {
      powerref = "super_electric_discharge";
    } else if(forcepower == "jump") {
      powerref = "super_high_jump";
    } else if(forcepower == "laser") {
      powerref = "super_laser_charge";
    }
  }

  equipname = "equip_";
  postfix = getsubstr(powerref, 6);

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    scripts\mp\supers::function_8c7b1312cf5986b(0);
    equipname += postfix;
    scripts\mp\gametypes\br_pickups::_givebrsuper(equipname, powerref, 1);
  } else {
    scripts\mp\perks\perkpackage::perkpackage_giveoverridefieldupgrades(powerref);
    scripts\mp\supers::givesuperpoints(scripts\mp\supers::getsuperpointsneeded(), undefined, 0);
  }

  superid = level.superglobals.staticsuperdata[powerref].id;
  self setclientomnvar("ui_field_upgrade_use", superid);
  scripts\mp\supers::showsuperremindersplash();
}

function function_95b57b12158252c3() {
  scripts\mp\supers::givesuper("super_melee_jugg", 0, 1);
}

function function_7bddc961a86c19b2() {
  scripts\mp\perks\perkpackage::perkpackage_giveoverridefieldupgrades("super_teleport_deploy");
}

function function_6460412bc7e7df87() {
  scripts\mp\perks\perkpackage::perkpackage_giveoverridefieldupgrades("super_electric_discharge");
}

function function_7705327af583d75c() {
  scripts\mp\perks\perkpackage::perkpackage_giveoverridefieldupgrades("super_high_jump");
}

function function_11e36f0effe3e0a7() {
  scripts\mp\perks\perkpackage::perkpackage_giveoverridefieldupgrades("super_laser_charge");
}

function function_269b97f3d86eb172(shouldfinish, dontclear, waitons, iskillstreak) {
  if(isDefined(waitons)) {
    if(isarray(waitons)) {
      waittill_any_in_array(waitons);
    } else {
      self waittill(waitons);
    }
  }

  if(!istrue(iskillstreak)) {
    if(istrue(shouldfinish)) {
      scripts\mp\supers::superusefinished();
    }

    var_102baa631c8e7151 = 0;
    superinfo = self.super;

    if(!isDefined(superinfo) || !scripts\mp\supers::function_907944a173ed27e1(superinfo.staticdata.ref)) {
      var_102baa631c8e7151 = 1;
    }

    if(!istrue(dontclear) && !var_102baa631c8e7151) {
      scripts\mp\supers::clearsuper();

      if(scripts\engine\utility::issharedfuncdefined("br", "superSlotCleanUp")) {
        [[scripts\engine\utility::getsharedfunc("br", "superSlotCleanUp")]](self);
      }
    }

    if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      self setclientomnvar("ui_super_warning", 0);
    }
  }

  self setscriptablepartstate("superpowers", "off", 0);
  self setscriptablepartstate("superpowers_aura", "off", 0);
  self setscriptablepartstate("heroDiveVfx", "off", 0);
  self.var_b9976aacfe15a7ba = 0;

  if(getdvarint(@ "hash_93804fe50a4ddeab", 0) && !istrue(iskillstreak)) {
    delaythread(0.25, &function_8f385d41d37c6572);
  }

  self notify("temp_v_finished");
}

function function_8f385d41d37c6572() {
  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    scripts\mp\gametypes\br_pickups::_givebrsuper("equip_temp_v", "super_temp_v", 1);
    return;
  }

  scripts\mp\perks\perkpackage::perkpackage_giveimmediate("super_temp_v");
}

function function_333146dd4b1c3317(equipmentref) {
  if(!isDefined(equipmentref)) {
    return 0;
  }

  switch (equipmentref) {
    case #"hash_5b20a7c66514f7c":
    case #"hash_20be479cff1234e3":
    case #"hash_6cb9c4c2ee706f5d":
    case #"hash_fc0d3d954c29e3ec":
      return 1;
    default:
      return 0;
  }
}

function function_988143193cd6a03a(instance) {
  if(!istrue(level.var_7ebad80a50484a39)) {
    return;
  }

  var_3f2d768db35932e1 = undefined;
  dropchance = getdvarint(@ "hash_f15bc465eb216c3e", 5);

  switch (instance.type) {
    case #"hash_19ba8d41970911ad":
      dropchance = getdvarint(@ "hash_202437d366ab08bf", 50);
      break;
    default:
      if(issubstr(instance.type, "br_loot_cache")) {
        dropchance = getdvarint(@ "hash_2f77de10bafc6229", 25);
      }

      if(istrue(getdvarint(@ "hash_1c4ecb2e31a1b8e8", 0))) {
        dropchance = 0;
      }

      break;
  }

  forcedrop = getdvarint(@ "hash_69e3493c0e7dc860", 0);
  var_3f2d768db35932e1 = undefined;
  var_65b1523ca1aa20d2 = getdvarint(@ "hash_a0594edd74c2cd34", 100);

  if(level.var_2ddd5fa2cfa55afe < var_65b1523ca1aa20d2) {
    droproll = randomintrange(1, 100);

    if(istrue(forcedrop) || dropchance > 0 && droproll <= dropchance) {
      level.var_2ddd5fa2cfa55afe++;
      var_3f2d768db35932e1 = "brloot_super_temp_v";
    }
  }

  return var_3f2d768db35932e1;
}

function private function_acf86641a7105328() {
  self endon("disconnect");
  self visionsetnakedforplayer("battlerage-low-health", 0.5);
  waittill_any_timeout_1(0.2, "death");
  self visionsetnakedforplayer("", 0.5);
}

function private function_f2c35147cd83e1c7() {
  self endon("disconnect");
  waittill_any_timeout_1(1, "death");
  self setscriptablepartstate("superpowers_veins", "off", 0);
}

function private function_79cd1b77a631e77c(player) {
  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return;
  }

  if(!getdvarint(@ "hash_ab08e8567915abb8", 1)) {
    return;
  }

  bountysettings = spawnStruct();
  bountysettings.var_d66266e27481ace9 = 0;
  bountysettings.var_40ca706da5962314 = 1;
  bountysettings.inworld = 0;
  bountysettings.var_e6f187bcb4b1648e = "TempV_Br";
  bountysettings.var_d77771d6bfb89518 = "hud_icon_power_temp_v";
  bountysettings.circleradius = getdvarint(@ "hash_e232615a13615b53", 1000);
  bountysettings.circleupdatetime = getdvarint(@ "hash_c3c506f46b023d34", 5);
  bountysettings.var_9fccd0c71039eff7 = &function_dd9f4b8ceed5962e;
  bountysettings.var_981fda4f385c05d5 = &function_df6ba84c45ef214e;
  bountysettings.var_7073a47db2f80848 = &function_6f1e076a4ba6dbce;
  bountysettings.bountytimeout = 0;
  bountysettings.priority = 1;
  scripts\mp\bounty_system::function_4647cbf23f54d6f6(player, bountysettings);
}

function function_dd9f4b8ceed5962e(bountysettings, playerentering) {
  if(!isDefined(playerentering.var_20c4102e2ddc6fc2)) {
    playerentering.var_20c4102e2ddc6fc2 = 0;
  }

  playerentering.var_20c4102e2ddc6fc2++;

  if(!function_60461f95db3442b4(playerentering, bountysettings)) {
    return;
  }

  playerentering.var_1d7ce7f4baf78710 = gettime();
  scripts\mp\gametypes\br_public::brleaderdialogplayer("supe_spotted", playerentering, 1, 0, undefined, undefined, "dx_br_bds4_");
}

function function_df6ba84c45ef214e(bountysettings, playerexiting) {
  playerexiting.var_20c4102e2ddc6fc2--;

  if(playerexiting.var_20c4102e2ddc6fc2 <= 0) {
    playerexiting.var_20c4102e2ddc6fc2 = 0;
  }

  if(!function_60461f95db3442b4(playerexiting, bountysettings, 1)) {
    return;
  }

  playerexiting.var_1d7ce7f4baf78710 = gettime();

  if(isDefined(bountysettings.player) && !bountysettings.player scripts\cp_mp\utility\player_utility::_isalive()) {
    scripts\mp\gametypes\br_public::brleaderdialogplayer("supe_killed", playerexiting, 1, 0, undefined, undefined, "dx_br_bds4_");
    return;
  }

  scripts\mp\gametypes\br_public::brleaderdialogplayer("supe_lost", playerexiting, 1, 0, undefined, undefined, "dx_br_bds4_");
}

function function_60461f95db3442b4(var_1f6573e24689cf5f, bountysettings, var_506b84b2eafa32c5) {
  if(!getdvarint(@ "hash_3f710c257c1c6fb2", 1)) {
    return false;
  }

  if(!isDefined(var_1f6573e24689cf5f)) {
    return false;
  }

  if(isDefined(var_1f6573e24689cf5f) && var_1f6573e24689cf5f.team == bountysettings.player.team) {
    return false;
  }

  if(isDefined(var_1f6573e24689cf5f.var_1d7ce7f4baf78710)) {
    timediff = (gettime() - var_1f6573e24689cf5f.var_1d7ce7f4baf78710) / 1000;

    if(timediff <= getdvarint(@ "hash_1b11c351d93c1126", 5)) {
      return false;
    }
  }

  if(istrue(var_506b84b2eafa32c5)) {
    if(isDefined(var_1f6573e24689cf5f.var_20c4102e2ddc6fc2) && var_1f6573e24689cf5f.var_20c4102e2ddc6fc2 > 0) {
      return false;
    }
  } else if(isDefined(var_1f6573e24689cf5f.var_20c4102e2ddc6fc2) && var_1f6573e24689cf5f.var_20c4102e2ddc6fc2 > 1) {
    return false;
  }

  return true;
}

function function_6f1e076a4ba6dbce(bountysettings) {
  level endon("game_ended");
  bountysettings endon("bounty_end");
  bountysettings.player waittill_any_5("death_or_disconnect", "enter_live_ragdoll", "successful_exfil", "map_to_map_warp", "temp_v_finished");
  scripts\mp\bounty_system::function_a10c4276271c4ad7(bountysettings, 1, 2);
}

function function_4c30d408ae45aa33() {
  self endon("temp_v_finished");
  self endon("disconnect");
  level endon("game_ended");
  waittill_any_2("death", "unset_super");
  thread function_269b97f3d86eb172(0, 1);
}

function function_cef1c8463d56bb49() {
  self endon("temp_v_finished");
  self endon("disconnect");
  level waittill("game_ended");
  thread function_269b97f3d86eb172(0, 1);
}