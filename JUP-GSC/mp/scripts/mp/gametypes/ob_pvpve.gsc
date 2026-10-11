/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\ob_pvpve.gsc
************************************************/

#using script_2f11ea014b8bb8eb;
#using script_3691c0b107a6701c;
#using script_443d99fe707f1d9f;
#using script_638d701d263ee1ed;
#using script_749ff6f56673a813;
#using script_8a9252a4a14729;
#using scripts\common\callbacks;
#using scripts\common\powerups;
#using scripts\common\values;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\loot\common_inventory;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\pack_a_punch;
#using scripts\cp_mp\radiation;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\class;
#using scripts\mp\deathicons;
#using scripts\mp\equipment;
#using scripts\mp\flags;
#using scripts\mp\gametypes\ob;
#using scripts\mp\hud_message;
#using scripts\mp\laststand;
#using scripts\mp\menus;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\perks\perkpackage;
#using scripts\mp\teamrevive;
#using scripts\mp\utility\game;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#using scripts\ob\points;
#namespace ob_pvpve;

function main() {
  function_7a48f3c1e25d94ea();
  level.var_9ce53104c2f3221b = &function_881e64f6b6191304;
  level.var_b25a2c14d4e17e75 = % "hash_7b846d7b9eeba59e";
  scripts\mp\gametypes\ob::main();
  level.var_a77c94576da6cab0 = "powerup_list_jup_ob_pvpve";
  level.var_2f26ac0d970dddb0 = 0;
  level.var_5025186a3fc7fa4 = 1;
  level.var_dc23eb4e69e18ed6 = "ob_jup_items_enemy_droplist_zombie_pvpve";
  initspawn();
  waittillframeend();
  thread initpostmain();

  level thread initdebug();
}

function initpostmain() {
  level.ob_pvpve = 1;
  level.var_a95cf198feabb6a = level.callbackplayerdamage;
  level.callbackplayerdamage = &callback_playerdamage;
  level.var_b0830df5265878d5 = getdvarint(@ "hash_dd3a7048817057e3", 1);
  val::group_register("laststand_ob_pvpve_values", ["ascender_use", "crate_use", "gesture", "killstreaks", "melee", "offhand_primary_weapons", "offhand_secondary_weapons", "supers", "usability", "vehicle_use", "weapon", "fire", "weapon_pickup", "reload", "weapon_switch", "show_operator_pet"]);
  level.customlaststandactionset = "laststand_ob_pvpve_values";
  level.var_a9fc119c2a887dd8 = "jup_ob_pvpve_dialogue_overlord";
  callback::remove("bleedout_tick", #"all");
  callback::add("bleedout_tick", &function_59bb85cf2b5af12f);
  callback::add("player_spawned", &on_player_spawned);
  callback::add("player_disconnect", &on_player_disconnect);
  callback::add("register_activities", &function_3b0edbbabf280e78);
  callback::add("player_request_leave_team", &function_36a8585bd9146630);
  callback::add("player_laststand", &function_4f2d84b47d6319a2);
  level._effect["vfx_player_eye_glow"] = loadfx("vfx/jup/ob/gameplay/zm_ai/vfx_zai_player_eye_glow.vfx");
  level._effect["vfx_player_chest_smk"] = loadfx("vfx/jup/ob/gameplay/zm_ai/vfx_zai_player_chest_smk.vfx");
  level.var_7d6f4cde2f1448f = getdvarint(@ "hash_101ca4d31e01e1b4", 1);
  level.allowfauxdeath = 0;
  level.liveragdollrevive = 1;
  level.var_1838f58e6385de74 = 1;
  level.var_856931603ae695a6 = getdvarint(@ "hash_fa0142387e9a27ba", 50);
  level.var_3938090780aa0be = &function_3938090780aa0be;
  initsuper();
  initrespawn();

  if(getdvarint(@ "hash_fc33c3ed0db21df1", 1) == 1) {
    level thread function_8bc4148d7acee203();
  }

  function_ea1e7eeb0d48ba61();
  level.var_6beff7b631ab7e18 = &function_6beff7b631ab7e18;
  function_7e852bbad70e2a5e();

  if(isDefined(level.streakglobals) && isDefined(level.streakglobals.streakbundles)) {
    level.streakglobals.streakbundles["precision_airstrike"].var_e408b79ae78f84bc = 1;
  }

  level callback::add("ob_register_objectives", &function_4fbb19878e3ae3e8);
  level thread function_5d7af95f131c52aa();
  level thread function_511e530940a6e570();
  level thread function_68556cab1f415279();
  level.var_38fb6b3d12228747 = getdvarint(@ "hash_a97e48774418e619", 1);
  level thread function_f664e717ec410248();
}

function initspawn() {
  level.var_529deb371b5eeb12 = getdvarint(@ "hash_f42c93cfb94e6b70", 0);
  spawnlocationsuffix = getDvar(@ "hash_2bd79e8b28a32bcb", "ne");
  level.var_126fea15d159e0ca = "ob/ob_pvpve/ob_pvpve_spawnpoints_" + spawnlocationsuffix + ".csv";

  if(istrue(level.var_529deb371b5eeb12)) {
    level.var_49839a7ef42e68d8 = function_feab0a1523a87a88();
  }
}

function initsuper() {
  level.var_b71c0a184363d6a2 = getdvarint(@ "hash_252cdcbb5bc3ae70", 1) == 1;

  if(level.var_b71c0a184363d6a2) {
    level.var_c24e4f076c66bfb4 = 0;
    level.var_921200c3b5274d3e = 0;
    level.var_cb9af30290da6a03 = 1;
    level utility::flag_wait("common_items_init");
    callback::remove("on_super_use_finished", #"all");
  } else {
    level.var_c24e4f076c66bfb4 = 1;
    level.var_921200c3b5274d3e = 1;
    level.var_cb9af30290da6a03 = 0;
  }

  level.var_8b5c3bda53460402 = &validateclass;
}

function initrespawn() {
  level.var_b482b579a7b7f6f = getdvarint(@ "hash_cc3db596630b78c7", 0) == 1;
  level.var_8868d59e008df32d = &function_8868d59e008df32d;
  level.modeonspawnplayer = &prespawnplayer;
  level callback::add("on_ob_laststand_player_killed", &onplayerkilled);
  registersharedfunc(#"ob_pvpve", #"hash_c69889de57e82c49", &function_50c0ea10b250b9e);

  if(getdvarint(@ "hash_551606c97d23028c", 1) == 1) {
    scripts\mp\teamrevive::function_5343ecb486b66bf1("ob_pvpve", &onspawnrevivetrigger);
  }

  level thread function_b08c8369dffc535f();
}

function function_ea1e7eeb0d48ba61() {
  level.var_127cc78420f659f8 = &function_127cc78420f659f8;
}

function function_127cc78420f659f8() {
  return false;
}

function function_7e852bbad70e2a5e() {
  level.var_172cc7874c623df2 = &function_172cc7874c623df2;
  level.var_6007f92acc049c02 = &function_6007f92acc049c02;
}

function function_172cc7874c623df2(owner) {
  if(!scripts\mp\laststand::function_2a3c9a91bf1d3911()) {
    return;
  }

  scripts\mp\laststand::interrogationsetup(owner);
}

function function_6007f92acc049c02(team) {
  self disableplayeruseforallplayers();
  scripts\mp\laststand::function_4c452a6c72371f17();
}

function function_7a48f3c1e25d94ea() {
  level.var_5a57e4de82e72545 = getdvarint(@ "hash_307fc239dc43be41", 0);
  callback::add("player_death", &on_player_death);
  level.var_176215213ecd54a8 = &function_176215213ecd54a8;
}

function function_600cc18a5b7b64b0(table) {
  level.var_15c03fdd665277c0 = [];
  var_7d958726e11b327 = tablelookupgetnumcols(table) - 1;

  for(i = 0; i < var_7d958726e11b327; i++) {
    level.var_15c03fdd665277c0[i] = function_aa8a954d66bf39b4(i, table);
  }
}

function private function_aa8a954d66bf39b4(classindex, table) {
  loadout["loadoutPrimary"] = tablelookup(table, 0, "loadoutPrimary", classindex + 1);
  loadout["loadoutSecondary"] = tablelookup(table, 0, "loadoutSecondary", classindex + 1);
  loadout["loadoutEquipmentPrimary"] = tablelookup(table, 0, "loadoutEquipmentPrimary", classindex + 1);
  loadout["loadoutPrimaryAttachment1"] = tablelookup(table, 0, "loadoutPrimaryAttachment1", classindex + 1);
  loadout["loadoutPrimaryAttachment2"] = tablelookup(table, 0, "loadoutPrimaryAttachment2", classindex + 1);
  loadout["loadoutPrimaryAttachment3"] = tablelookup(table, 0, "loadoutPrimaryAttachment3", classindex + 1);
  loadout["loadoutPrimaryAttachment4"] = tablelookup(table, 0, "loadoutPrimaryAttachment4", classindex + 1);
  loadout["loadoutPrimaryAttachment5"] = tablelookup(table, 0, "loadoutPrimaryAttachment5", classindex + 1);
  loadout["loadoutEquipmentSecondary"] = tablelookup(table, 0, "loadoutEquipmentSecondary", classindex + 1);
  loadout["loadoutSecondaryAttachment1"] = tablelookup(table, 0, "loadoutSecondaryAttachment1", classindex + 1);
  loadout["loadoutSecondaryAttachment2"] = tablelookup(table, 0, "loadoutSecondaryAttachment2", classindex + 1);
  loadout["loadoutSecondaryAttachment3"] = tablelookup(table, 0, "loadoutSecondaryAttachment3", classindex + 1);
  loadout["loadoutSecondaryAttachment4"] = tablelookup(table, 0, "loadoutSecondaryAttachment4", classindex + 1);
  loadout["loadoutSecondaryAttachment5"] = tablelookup(table, 0, "loadoutSecondaryAttachment5", classindex + 1);
  loadout["fieldUpgrade"] = tablelookup(table, 0, "fieldUpgrade", classindex + 1);
  return loadout;
}

function callback_playerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, var_b0fc59ff15058522, var_be4285b26ed99ab1) {
  if(istrue(level.ob_pvpve)) {
    n_pap_level = 0;

    if(issharedfuncdefined("zombie", "get_pap_level") && isPlayer(eattacker)) {
      n_pap_level = eattacker callsharedfunc("zombie", "get_pap_level", objweapon);

      if(n_pap_level >= 1) {
        var_87c56f9e23a55ac3 = getdvarfloat(hashcat(@ "hash_cfa00926baa9b9a6", n_pap_level), 0.5);
        idamage *= var_87c56f9e23a55ac3;
      }
    }

    if(isDefined(objweapon) && objweapon.basename == "cluster_spike_jup_ob") {
      var_67ce52be5eb16800 = level.var_78203e815cf5c13b;

      if(isDefined(var_67ce52be5eb16800) && var_67ce52be5eb16800 > 0) {
        if(isPlayer(self) && isDefined(self.team) && isDefined(eattacker.team) && !is_equal(self.team, eattacker.team)) {
          idamage = var_67ce52be5eb16800;
        }
      }
    }
  }

  [[level.var_a95cf198feabb6a]](einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, var_b0fc59ff15058522, var_be4285b26ed99ab1);
}

function private function_36a8585bd9146630(params) {
  foreach(entry in level.teamnamelist) {
    if(!getteamdata(entry, "teamCount")) {
      newteam = entry;
      thread scripts\mp\menus::addtoteam(newteam);
      return;
    }
  }

  assertmsg("<dev string:x1c>");
}

function private function_4f2d84b47d6319a2(params) {
  teammates = scripts\mp\utility\teams::getteamdata(self.team, "players");
  teammates = array_remove(teammates, self);
  scripts\cp_mp\overlord::playevent("teammate_down", teammates);
}

function function_59bb85cf2b5af12f(params) {
  if(isDefined(params.progress) && istrue(level.var_520545ce455767b6)) {
    if(!self getbeingrevived()) {
      if(level.var_b0830df5265878d5) {
        healthprogress = self.health / level.laststandrevivehealth;
        params.progress = max(0, min(params.progress, healthprogress));
      }

      self.health = int(level.laststandrevivehealth * params.progress);

      if(isDefined(self.laststandreviveent) && isDefined(self.laststandreviveent.objidnum)) {
        scripts\mp\objidpoolmanager::objective_set_progress(self.laststandreviveent.objidnum, params.progress);
      }
    }
  }
}

function function_8dd7e341052992() {
  self notify("enter_live_ragdoll_teamreive");
  self endon("game_ended");
  self endon("death_or_disconnect");
  self endon("enter_live_ragdoll_teamreive");
  scripts\mp\flags::function_1240434f4201ac9d("prematch_done");
  self waittill("enter_live_ragdoll");
  self setsolid(0);
  self.var_d82ef0f535aa42fb = self.origin;
}

function on_player_spawned(params) {
  thread function_d496bb74f129b113();

  if(istrue(level.liveragdollrevive)) {
    thread function_8dd7e341052992();
  }

  if(getdvarint(@ "hash_3aa023d6eebd03fa", 0) == 1) {
    level thread function_3bbb149b603a44f9(self);
  }

  teammates = scripts\mp\utility\teams::getteamdata(self.team, "players");
  teammates = array_remove(teammates, self);
  scripts\cp_mp\overlord::playevent("teammate_down", teammates);
}

function on_player_disconnect(params) {
  function_5a6cae9be5731fa6();
}

function private prespawnplayer(var_f0729562cde426a3) {
  self.var_26d22342913bacf6 = istrue(var_f0729562cde426a3);
}

function function_d496bb74f129b113() {
  self endon("death_or_disconnect");
  scripts\mp\flags::function_1240434f4201ac9d("prematch_done");

  while(true) {
    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }

      if(!isDefined(self.var_2b3fffe79b36b023)) {
        self.var_2b3fffe79b36b023 = [];
      }

      if(self.team != player.team) {
        player_id = player getentitynumber();
        shouldshowfx = distancesquared(self.origin, player.origin) < 4000000 && isalive(player);
        var_641529ab835cfe52 = scripts\cp_mp\utility\player_utility::function_f8789f15330de751(player);

        if(!istrue(self.var_2b3fffe79b36b023[player_id]) && shouldshowfx) {
          playfxontagforclients(getfx("vfx_player_eye_glow"), player, "tag_eye", self);
          playfxontagforclients(getfx("vfx_player_chest_smk"), player, "j_spine4", self);
          waitframe();
          self.var_2b3fffe79b36b023[player_id] = 1;
        } else if(istrue(self.var_2b3fffe79b36b023[player_id]) && !shouldshowfx) {
          stopfxontagforclients(getfx("vfx_player_eye_glow"), player, "tag_eye", self);
          stopfxontagforclients(getfx("vfx_player_chest_smk"), player, "j_spine4", self);
          waitframe();
          self.var_2b3fffe79b36b023[player_id] = 0;
        }

        if(!istrue(player.var_d9b717fb47bcf883) && var_641529ab835cfe52) {
          self.var_2b3fffe79b36b023[player_id] = 0;
          player.var_d9b717fb47bcf883 = 1;
          continue;
        }

        if(istrue(player.var_d9b717fb47bcf883) && !var_641529ab835cfe52) {
          self.var_2b3fffe79b36b023[player_id] = 0;
          player.var_d9b717fb47bcf883 = 0;
        }
      }
    }

    wait 1;
  }
}

function private function_8868d59e008df32d() {
  if(level.var_529deb371b5eeb12) {
    spawnlocationsuffix = getDvar(@ "hash_2bd79e8b28a32bcb", "ne");

    switch (spawnlocationsuffix) {
      case #"hash_fa50bff6bd83010f":
        return (-16448, -36317, 10000);
      case #"hash_fa2ebff6bd68bd92":
        return (-29673, 31794, 10000);
      case #"hash_fa50b1f6bd82eb05":
        return (32949, -29578, 10000);
      case #"hash_fa2ecdf6bd68d39c":
        return (30485, 27248, 10000);
      default:
        return ((level.mapcorners[0].origin + level.mapcorners[1].origin) * 0.5);
    }

    return;
  }

  return (level.mapcorners[0].origin + level.mapcorners[1].origin) * 0.5;
}

function private validateclass(struct) {
  if(level.var_b71c0a184363d6a2) {
    struct.loadoutfieldupgrade1 = "none";
    struct.var_4c4f03fa00925daf = 0;
    struct.loadoutfieldupgrade2 = "none";
    struct.var_2907f1614fe4e5f2 = 0;
  }

  return struct;
}

function private onplayerkilled(deathdata) {
  thread function_e48bd997f13cb39f(deathdata);
  scripts\common\powerups::function_5bfe254c7e9aa4db();
}

function private function_e48bd997f13cb39f(deathdata) {
  if(istrue(level.var_b482b579a7b7f6f)) {
    deathdata.victim thread function_a6a654c500d6b6c2();
  }
}

function private function_ba180700e314d6d7() {
  if(istrue(level.var_cb9af30290da6a03)) {
    self.var_9632a7ee2ddfb1ed = undefined;
  }
}

function private function_ddeeb266618960a1() {
  var_85a40249b07be68e = istrue(self.isjuggernaut) && isDefined(self.juggcontext);

  if(istrue(var_85a40249b07be68e)) {
    return;
  }

  respawnitems = scripts\mp\class::respawnitems_saveplayeritemstostruct();
  scripts\mp\class::respawnitems_assignrespawnitems(respawnitems);
}

function private function_f4c8727cac33c176() {
  self.var_57c207fde9b78089 = 1;
}

function private on_player_death(params) {
  function_ba180700e314d6d7();
  function_21ea168d74224bc0();
  function_ddeeb266618960a1();
  function_f4c8727cac33c176();
  function_af0e816da6ba7671();
}

function private function_d70acfe4eac5ae8c(quantity) {
  minquantity = getdvarint(@ "hash_571365590d627eff", 1500);
  maxquantity = getdvarint(@ "hash_632947d88cf01a55", 15000);
  percent = getdvarfloat(@ "hash_452ca064645e8f67", 0.5);
  return int(clamp(percent * quantity, minquantity, maxquantity));
}

function private function_5e255bd319719656(quantity) {
  dropcount = function_d70acfe4eac5ae8c(quantity);
  var_a5de1e8b6d1422cb = int(max(0, quantity - dropcount));
  return quantity - var_a5de1e8b6d1422cb;
}

function private function_b0a44966496005dd(quantity) {
  return function_d70acfe4eac5ae8c(quantity);
}

function private function_becdb4f09c5e8ab0(var_c301ae3e58a075e1, var_67d48175b1421af0) {
  if(!isDefined(var_c301ae3e58a075e1)) {
    assertmsg("<dev string:x36>");
    return;
  }

  var_67d48175b1421af0 = default_to(var_67d48175b1421af0, 0);
  rownum = tablelookupgetnumrows("ob/ob_pvpve/ob_pvpve_item_drop_life_time.csv");
  lifetimes = undefined;

  for(rowindex = 0; rowindex < rownum; rowindex++) {
    itemtype = tablelookupbyrow("ob/ob_pvpve/ob_pvpve_item_drop_life_time.csv", rowindex, 0);

    if(itemtype != var_c301ae3e58a075e1) {
      continue;
    }

    colindex = ter_op(var_67d48175b1421af0, 1, 2);
    var_94862a28047fe105 = tablelookupbyrow("ob/ob_pvpve/ob_pvpve_item_drop_life_time.csv", rowindex, colindex);

    if(isDefined(var_94862a28047fe105)) {
      lifetimes = int(var_94862a28047fe105);
    }

    break;
  }

  if(!isDefined(lifetimes) || lifetimes <= 0) {
    return;
  }

  return lifetimes;
}

function private function_a03445b277a5d1c6(itemtype, dropstruct, itemindex, var_16e342d6918d81d1, var_26b448211c62d57a) {
  dropstruct.var_c62a12bfca2ae58e = function_becdb4f09c5e8ab0(itemtype, 1);
  function_2166e0fab7a3263(itemtype, dropstruct, itemindex, var_16e342d6918d81d1, var_26b448211c62d57a);
}

function private function_fb077d5402810e85(itemindex) {
  lootid = function_d870b2c45335bd88(itemindex);

  if(!isDefined(lootid) || lootid <= 0) {
    return;
  }

  bundlename = function_fc925a153c7fd55c(lootid);

  if(!isDefined(bundlename)) {
    return;
  }

  itembundle = getscriptbundle("itemspawnentry:" + bundlename);

  if(!isDefined(itembundle)) {
    return;
  }

  return itembundle;
}

function private function_b56001789cfbe83c(dropstruct) {
  backpacksize = function_1b35b10884bd8d67();

  for(i = 0; i < backpacksize; i++) {
    itembundle = function_fb077d5402810e85(i);

    if(!isDefined(itembundle) || istrue(function_7192774bb894cced(itembundle))) {
      continue;
    }

    dropstruct.var_c62a12bfca2ae58e = function_becdb4f09c5e8ab0(itembundle.type, 1);
    function_4433fa5f0f02ffd8(dropstruct, i);
  }
}

function private function_21ea168d74224bc0() {
  if(istrue(level.var_5a57e4de82e72545)) {
    return;
  }

  dropstruct = function_59a2e61d79065dca();
  function_a03445b277a5d1c6("currency", dropstruct, undefined, &function_5e255bd319719656, &function_b0a44966496005dd);
  function_a03445b277a5d1c6("weapon", dropstruct, 1);
  function_a03445b277a5d1c6("weapon", dropstruct, 0);
  function_a03445b277a5d1c6("lethal", dropstruct);
  function_a03445b277a5d1c6("tactical", dropstruct);
  function_a03445b277a5d1c6("killstreak", dropstruct);

  if(istrue(level.var_cb9af30290da6a03)) {
    function_a03445b277a5d1c6("super", dropstruct);
  }

  function_a03445b277a5d1c6("armor", dropstruct);
  function_a03445b277a5d1c6("gasmask", dropstruct);
  function_a03445b277a5d1c6("revive", dropstruct);
  function_a03445b277a5d1c6("plate_carrier", dropstruct);
  function_b56001789cfbe83c(dropstruct);

  if(!level.var_7d6f4cde2f1448f) {
    function_a03445b277a5d1c6("backpack", dropstruct);
  }
}

function private function_176215213ecd54a8(itemtype, itemindex) {
  if(!isDefined(itemtype)) {
    return;
  }

  return function_becdb4f09c5e8ab0(itemtype, 0);
}

function private function_af0e816da6ba7671() {
  if(isDefined(self.region)) {
    var_cdce5f59f2ef9d3d = level.var_f756bf4293f67099[self.region];
  }

  self.var_d9020915455a4741 = var_cdce5f59f2ef9d3d;
}

function function_a6a654c500d6b6c2() {
  level endon("game_ended");

  if(istrue(level.gameended)) {
    return;
  }

  self notify("ob_pvpve_wait_and_spawn");
  teamcount = scripts\mp\utility\teams::getteamdata(self.team, "teamCount");

  if(istrue(self.squadwiped) || teamcount == 1) {
    var_bca00499254fa395 = getdvarint(@ "hash_15a9b52f8eb91211", 5);
  } else {
    var_bca00499254fa395 = getdvarint(@ "hash_f3bede6d41ff6edd", 10);
  }

  scripts\mp\utility\lower_message::setlowermessageomnvar("waiting_to_spawn", int(gettime() + var_bca00499254fa395 * 1000));
  wait var_bca00499254fa395;
  thread adddeathicon();

  if(!isDefined(self.revivecount)) {
    self.revivecount = 1;
  } else {
    self.revivecount++;
  }

  self.var_57c207fde9b78089 = 0;
  respawnplayer();
}

function private function_7192774bb894cced(itembundle) {
  if(!isDefined(itembundle)) {
    return true;
  }

  if(level.var_7d6f4cde2f1448f) {
    return (itembundle.subtype == "schematic");
  }

  return false;
}

function respawnplayer() {
  if(istrue(self.liveragdoll)) {
    self.liveragdoll = 0;
    self setsolid(1);
    self function_6b4c8718bc36d1ef(0);
    self function_e4ccd01fb7ec7a6f(0);
    self stopliveragdoll();
  }

  spawnpoint = setspawnpoint();
  var_7b717b4dbce0b62f = ter_op(isDefined(spawnpoint), spawnpoint, self.origin);
  namespace_b3fcba693d3adc37::function_ef6adc9492d03ef(var_7b717b4dbce0b62f);
}

function setspawnpoint() {
  randomangle = randomint(360);
  var_736bfbe730557cf = function_e21d77ea0f26bfd1();

  if(var_736bfbe730557cf.size > 0) {
    respawnorigin = random(var_736bfbe730557cf).origin;
  } else {
    respawnorigin = self.origin;
  }

  randomdistance = ter_op(var_736bfbe730557cf.size > 0, randomintrange(0, 7500), randomintrange(7500, 20000));
  var_773f52a7d94b7f69 = [];

  for(i = 1; i <= 32; i++) {
    pos = respawnorigin + anglesToForward((0, randomangle + 11.25 * i, 0)) * randomdistance;

    if(!scripts\mp\outofbounds::ispointinoutofbounds(pos) && function_bdf19384dd9c7829(pos)) {
      var_773f52a7d94b7f69[var_773f52a7d94b7f69.size] = pos;
    }
  }

  thread function_99cccfd31080bb65(respawnorigin, var_773f52a7d94b7f69);

  if(var_773f52a7d94b7f69.size > 0) {
    return array_random(var_773f52a7d94b7f69);
  }

  var_2e7ac0673f9ee23f = [(-31536, 30148, 1500), (30752, 27476, 1515), (-31312, 4964, 1000), (38704, -5896, 2964), (-26336, -25180, 1748), (7492, -32964, 2000), (26040, -28664, 3504)];
  spawnlocation = undefined;
  var_2afbf36321eb0ca = undefined;

  foreach(location in var_2e7ac0673f9ee23f) {
    dis = distance2dsquared(location, self.origin);

    if(!isDefined(var_2afbf36321eb0ca) || dis < var_2afbf36321eb0ca) {
      var_2afbf36321eb0ca = dis;
      spawnlocation = location;
    }
  }

  return spawnlocation;
}

function function_e21d77ea0f26bfd1() {
  players = scripts\mp\utility\teams::getteamdata(self.team, "players");
  teammates = [];

  foreach(player in players) {
    if(player scripts\cp_mp\utility\player_utility::_isalive() && !istrue(player.extracted) && !istrue(player.var_ded04cdd264a7e00)) {
      teammates[teammates.size] = player;
    }
  }

  return teammates;
}

function function_99cccfd31080bb65(respawnorigin, var_773f52a7d94b7f69) {
  level endon("<dev string:x73>");
  self endon("<dev string:x81>");

  while(true) {
    waitframe();
    sphere(respawnorigin, 7500, (1, 0, 0));
    sphere(respawnorigin, 20000, (0, 1, 0));

    foreach(pos in var_773f52a7d94b7f69) {
      sphere(pos, 100, (0, 0, 1));
    }
  }
}

function function_bdf19384dd9c7829(pos) {
  if(level.aether_storm.radiation scripts\cp_mp\radiation::function_1b4f63fa623de69a(pos)) {
    return false;
  }

  if(ispointinwater(drop_to_ground(pos) + (0, 0, -50))) {
    return false;
  }

  posregion = namespace_4df2ab39b0e96ec7::get_region(pos);

  if(!isDefined(posregion)) {
    return true;
  }

  var_bf528e00efcf9f48 = level.var_f756bf4293f67099[posregion];

  if(isDefined(var_bf528e00efcf9f48) && isDefined(self.var_d9020915455a4741)) {
    switch (self.var_d9020915455a4741) {
      case #"hash_5343b465e56ec9a4":
        return true;
      case #"hash_af83e47edfa8900a":
        return (var_bf528e00efcf9f48 != "difficulty_hard");
      case #"hash_7bb2cd766703d463":
        return (var_bf528e00efcf9f48 == "difficulty_easy");
    }
  }

  return true;
}

function private function_50c0ea10b250b9e() {
  loadout_clearweapons();
  function_ffe562ebbdab55fc(0);
  function_ffe562ebbdab55fc(1);
  randomloadoutindex = randomint(level.var_15c03fdd665277c0.size);
  function_5fedebeea12bd089(randomloadoutindex);
  lethalequipmentname = level.var_15c03fdd665277c0[randomloadoutindex]["loadoutEquipmentPrimary"];
  tacticalequipmentname = level.var_15c03fdd665277c0[randomloadoutindex]["loadoutEquipmentSecondary"];
  fieldupgradename = level.var_15c03fdd665277c0[randomloadoutindex]["fieldUpgrade"];

  foreach(equipment in [lethalequipmentname, tacticalequipmentname]) {
    if(equipment == "") {
      continue;
    }

    slot = scripts\mp\equipment::getdefaultslot(equipment);
    scripts\mp\equipment::giveequipment(equipment, slot);
  }

  scripts\mp\perks\perkpackage::perkpackage_giveoverridefieldupgrades(fieldupgradename);

  if(istrue(level.var_305f2037d12f6c5)) {
    scripts\cp_mp\loot\common_inventory::function_b9d2aee928c46b5f(8554, 1, 0, undefined);
    waitframe();
    scripts\cp_mp\armor::repair_armor(self.maxarmorhealth);
  }

  function_27fd1477dccfa12b();
}

function function_5fedebeea12bd089(randomloadoutindex) {
  primaryweaponname = getDvar(@ "hash_e37ee92c81bbd455", level.var_15c03fdd665277c0[randomloadoutindex]["loadoutPrimary"]);

  if(is_equal(primaryweaponname, level.var_15c03fdd665277c0[randomloadoutindex]["loadoutPrimary"])) {
    var_22fbb0794aa3448c = [level.var_15c03fdd665277c0[randomloadoutindex]["loadoutPrimaryAttachment1"], level.var_15c03fdd665277c0[randomloadoutindex]["loadoutPrimaryAttachment2"], level.var_15c03fdd665277c0[randomloadoutindex]["loadoutPrimaryAttachment3"], level.var_15c03fdd665277c0[randomloadoutindex]["loadoutPrimaryAttachment4"], level.var_15c03fdd665277c0[randomloadoutindex]["loadoutPrimaryAttachment5"]];
  } else {
    var_22fbb0794aa3448c = [];
  }

  primaryweapon = scripts\cp_mp\weapon::buildweapon(primaryweaponname, var_22fbb0794aa3448c, "none", "none", -1);
  self giveweapon(primaryweapon);
  self.primaryweapon = getcompleteweaponname(primaryweapon);
  function_b5f358d46f69b20e(primaryweapon);
  self.primaryweaponobj = primaryweapon;
  secondaryweaponname = getDvar(@ "hash_e5cc68d2496976d", level.var_15c03fdd665277c0[randomloadoutindex]["loadoutSecondary"]);

  if(is_equal(primaryweaponname, level.var_15c03fdd665277c0[randomloadoutindex]["loadoutSecondary"])) {
    var_d5c5c1aaa36c30cc = [level.var_15c03fdd665277c0[randomloadoutindex]["loadoutSecondaryAttachment1"], level.var_15c03fdd665277c0[randomloadoutindex]["loadoutSecondaryAttachment2"], level.var_15c03fdd665277c0[randomloadoutindex]["loadoutSecondaryAttachment3"], level.var_15c03fdd665277c0[randomloadoutindex]["loadoutSecondaryAttachment4"], level.var_15c03fdd665277c0[randomloadoutindex]["loadoutSecondaryAttachment5"]];
  } else {
    var_d5c5c1aaa36c30cc = [];
  }

  secondaryweapon = scripts\cp_mp\weapon::buildweapon(secondaryweaponname, var_d5c5c1aaa36c30cc, "none", "none", -1);
  self giveweapon(secondaryweapon);
  self.secondaryweapon = getcompleteweaponname(secondaryweapon);
  function_b5f358d46f69b20e(secondaryweapon);
  self.secondaryweaponobj = secondaryweapon;
  self switchtoweaponimmediate(self.primaryweapon);
  self setspawnweapon(self.primaryweapon);

  if(isDefined(level.var_eac78ec82ef04262)) {
    namespace_b4f2af6fa775d9b::function_3a0412b800f3331d(primaryweapon, level.var_eac78ec82ef04262);
  }

  if(isDefined(level.var_f742f900fb0a4ee8)) {
    scripts\cp_mp\pack_a_punch::pap_weapon(primaryweapon, level.var_f742f900fb0a4ee8 - 1);
  }
}

function function_b08c8369dffc535f() {
  level endon("game_ended");
  scripts\mp\flags::function_1240434f4201ac9d("prematch_done");
  var_5420f6f6ceb66aa1 = getdvarint(@ "hash_55456e251cb36fc5", 300);
  stage2time = getdvarint(@ "hash_63754c5788cc8212", 600);
  stage3time = getdvarint(@ "hash_5eb3980352bf9bf3", 1200);

  if(var_5420f6f6ceb66aa1 >= stage2time || stage2time >= stage3time) {
    assertmsg("<dev string:x98>");
    level.spawnarmorplates = getdvarint(@ "hash_2f31f2ca2556fa5f", 2);
    function_600cc18a5b7b64b0("ob/ob_pvpve/classtable_ob_pvpve_stage_1.csv");
    return;
  }

  level.spawnarmorplates = getdvarint(@ "hash_2f31f2ca2556fa5f", 2);
  function_600cc18a5b7b64b0("ob/ob_pvpve/classtable_ob_pvpve_stage_1.csv");
  wait var_5420f6f6ceb66aa1;
  level.spawnarmorplates = getdvarint(@ "hash_2f31f3ca2556fc92", 2);
  function_600cc18a5b7b64b0("ob/ob_pvpve/classtable_ob_pvpve_stage_2.csv");
  level.var_eac78ec82ef04262 = 1;
  wait stage2time - var_5420f6f6ceb66aa1;
  level.spawnarmorplates = getdvarint(@ "hash_2f31f4ca2556fec5", 2);
  function_600cc18a5b7b64b0("ob/ob_pvpve/classtable_ob_pvpve_stage_3.csv");
  level.var_eac78ec82ef04262 = 2;
  wait stage3time - stage2time;
  level.spawnarmorplates = getdvarint(@ "hash_2f31edca2556ef60", 3);
  function_600cc18a5b7b64b0("ob/ob_pvpve/classtable_ob_pvpve_stage_4.csv");
  level.var_305f2037d12f6c5 = 1;
  level.var_eac78ec82ef04262 = 3;
  level.var_f742f900fb0a4ee8 = 1;
}

function function_27fd1477dccfa12b() {
  scripts\ob\points::function_d57de844b62e642b();
  currentpoints = scripts\ob\points::function_b86115649d705017();
  respawnpoints = currentpoints;
  var_5538fad92909a70 = getdvarint(@ "hash_708ba614485ed422", 0);

  switch (var_5538fad92909a70) {
    case 0:
      respawnpoints = function_4f46db58d9b511a4(currentpoints);
      break;
    case 1:
      respawnpoints = getdvarint(@ "hash_9fb9a40d0d26cc06", 0);
      break;
    default:
      break;
  }

  if(!isDefined(respawnpoints)) {
    assertmsg("<dev string:xe2>");
  }

  scripts\ob\points::function_5fb17ad4d286b0d5(respawnpoints);
}

function private function_4f46db58d9b511a4(currentpoints) {
  var_1e8428a95fd29d28 = scripts\mp\utility\game::getminutespassed();
  rownum = tablelookupgetnumrows("ob/ob_pvpve/ob_pvpve_respawn_currency_limit.csv");
  var_6d792a41b59f62f8 = undefined;

  for(rowindex = 0; rowindex < rownum; rowindex++) {
    minutes = int(tablelookupbyrow("ob/ob_pvpve/ob_pvpve_respawn_currency_limit.csv", rowindex, 0));
    mincount = int(tablelookupbyrow("ob/ob_pvpve/ob_pvpve_respawn_currency_limit.csv", rowindex, 1));

    if(var_1e8428a95fd29d28 <= minutes) {
      var_6d792a41b59f62f8 = mincount;
      break;
    }
  }

  if(!isDefined(var_6d792a41b59f62f8)) {
    var_6d792a41b59f62f8 = int(tablelookupbyrow("ob/ob_pvpve/ob_pvpve_respawn_currency_limit.csv", rownum - 1, 1));
  }

  if(!isDefined(currentpoints)) {
    currentpoints = 0;
  }

  return int(max(currentpoints, var_6d792a41b59f62f8));
}

function private function_feab0a1523a87a88() {
  spawnpointcsv = level.var_126fea15d159e0ca;
  rownum = tablelookupgetnumrows(spawnpointcsv);
  spawnpointslist = [];

  for(rowindex = 0; rowindex < rownum; rowindex++) {
    originstring = tablelookupbyrow(spawnpointcsv, rowindex, 0);
    anglesstring = tablelookupbyrow(spawnpointcsv, rowindex, 1);
    scriptnoteworthy = tablelookupbyrow(spawnpointcsv, rowindex, 2);
    index = tablelookupbyrow(spawnpointcsv, rowindex, 3);

    if(!isDefined(originstring) || originstring == "" || !isDefined(anglesstring) || anglesstring == "" || !isDefined(scriptnoteworthy) || scriptnoteworthy == "" || !isDefined(index) || index == "") {
      assertmsg("<dev string:x11d>" + rowindex + "<dev string:x14a>" + spawnpointcsv);
      continue;
    }

    var_b4d42a7ce0d49aaa = strtok(originstring, " ");
    anglesarr = strtok(anglesstring, " ");
    spawnpoint = spawnStruct();
    spawnpoint.index = int(index);
    spawnpoint.script_noteworthy = scriptnoteworthy;
    spawnpoint.origin = (float(var_b4d42a7ce0d49aaa[0]), float(var_b4d42a7ce0d49aaa[1]), float(var_b4d42a7ce0d49aaa[2]));
    spawnpoint.angles = (float(anglesarr[0]), float(anglesarr[1]), float(anglesarr[2]));
    spawnpoint.target = "";
    spawnpointslist[spawnpointslist.size] = spawnpoint;
  }

  return spawnpointslist;
}

function function_3b0edbbabf280e78(params) {
  namespace_4b05af9596de25bf::function_7582e8d13ed3c196(params);
  namespace_325330503813833a::function_b1568160c3017867(params);
}

function function_3938090780aa0be(player) {
  if(isDefined(player.var_cd20b5c89ca5f5d0) && istrue(player.var_cd20b5c89ca5f5d0["contract_target"])) {
    player scripts\mp\hud_message::showerrormessage("MP_PING_INGAME/BLOCKED_BY_CONTRACT_TARGET");
  }
}

function adddeathicon() {
  self endon("disconnect");
  iconorigin = self.origin + (0, 0, 40);
  self notify("addDeathIcon");
  self endon("addDeathIcon");

  if(isDefined(self.lastdeathheadicon)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.lastdeathheadicon);
    self.lastdeathheadicon = undefined;
  }

  self notify("removed_death_icon");
  image = "hud_icon_player_dead_" + self.sessionuimemberindex + 1;
  showto = scripts\mp\utility\teams::getteamdata(self.team, "players");
  self.lastdeathheadicon = scripts\cp_mp\entityheadicons::setheadicon_singleimage(showto, image, undefined, 1, 0, 200, undefined, undefined, 1, iconorigin, 1, "icon_regular");
  thread scripts\mp\deathicons::destroyslowly(20);
}

function private function_5dc7e082b29eb26e() {
  deadplayer = self.victim;

  if(!isDefined(deadplayer)) {
    return;
  }

  level endon("game_end");
  deadplayer endon("disconnect");
  deadplayer endon("spawned");
  deadplayer endon("end_respawn");
  deadplayer endon("started_spawnPlayer");
  deadplayer waittill("ob_pvpve_wait_and_spawn");
  logstring("[recon_points] remove trigger for " + deadplayer.name);
  deadplayer scripts\mp\teamrevive::removetrigger(deadplayer.guid);
}

function private onspawnrevivetrigger() {
  thread function_5dc7e082b29eb26e();
}

function function_8bc4148d7acee203() {
  level endon("game_ended");
  scripts\mp\flags::function_1240434f4201ac9d("prematch_done");
  level.var_32d6d39f3da920ca = [];
  var_b5ab6c23fefc22d4 = getdvarint(@ "hash_c5128635aef807e6", 3000);
  var_91a2946f78dd1971 = getdvarint(@ "hash_83cf2282d3e494fc", 1600);
  intensitymultiplier = getdvarfloat(@ "hash_a5cdb74fe4b8ac17", 0.7);

  while(true) {
    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }

      if(!scripts\mp\utility\player::isreallyalive(player)) {
        player function_5a6cae9be5731fa6();
        continue;
      }

      enemyteamnum = player function_eb0aa531d61fa07f(var_b5ab6c23fefc22d4);

      if(enemyteamnum > 0) {
        zoneindex = function_b439f805f07ff50(player.origin);
        subzone = function_2ee25a0fa15c04ce(player.origin);

        if(isDefined(player.currentzoneindex) && isDefined(player.var_f5bfeb5a0a08d17e)) {
          if(isDefined(subzone) && player.currentzoneindex == zoneindex && player.var_f5bfeb5a0a08d17e == subzone.subzoneindex) {
            continue;
          } else {
            player function_5a6cae9be5731fa6();
          }
        }

        subzones = function_6aa08c3e29cd1452(player.origin, var_91a2946f78dd1971);
        var_4b823d93740fc9dd = int(round(subzones.size * (1 - pow(intensitymultiplier, enemyteamnum))));
        subzones = array_randomize(subzones);

        for(i = 0; i < var_4b823d93740fc9dd; i++) {
          subzoneindex = subzones[i].subzoneindex;
          player function_a8e1fec0a897a1be(zoneindex, subzoneindex);
        }

        continue;
      }

      player function_5a6cae9be5731fa6();
    }

    wait 1;
  }
}

function function_eb0aa531d61fa07f(dist) {
  playersinradius = getplayersinradius(self.origin, dist);
  enemyteams = [];
  enemyteamnum = 0;

  foreach(player in playersinradius) {
    if(player.team != self.team) {
      if(!istrue(enemyteams[player.team])) {
        enemyteams[player.team] = 1;
        enemyteamnum++;
      }
    }
  }

  return enemyteamnum;
}

function function_3bbb149b603a44f9(player) {
  player notify("monitor_enemy_prox_ob");
  player endon("disconnect");
  player endon("death");
  player endon("monitor_enemy_prox_ob");
  level endon("game_ended");
  proximitydistance = getdvarint(@ "scr_overlord_enemy_proximity_radius", 4096);
  proximitydistancesq = proximitydistance * proximitydistance;
  ignoretime = getdvarfloat(@ "hash_32244d6acf101808", 60);
  var_a6cdf55657dde0fe = undefined;

  while(true) {
    if(!isDefined(var_a6cdf55657dde0fe) || (gettime() - var_a6cdf55657dde0fe) / 1000 > ignoretime) {
      validplayers = [];

      foreach(p in level.players) {
        if(scripts\mp\utility\player::isreallyalive(p) && p.team != player.team) {
          validplayers[validplayers.size] = p;
        }
      }

      if(validplayers.size > 0) {
        var_1dfdd816709afb30 = 0;
        partition = create_partition(validplayers, proximitydistance);

        foreach(playerarray in partition function_df633f460888a47(player.origin)) {
          if(var_1dfdd816709afb30) {
            break;
          }

          foreach(testplayer in playerarray) {
            if(distancesquared(player.origin, testplayer.origin) <= proximitydistancesq) {
              var_1dfdd816709afb30 = 1;
              break;
            }
          }
        }

        if(var_1dfdd816709afb30) {
          player scripts\mp\hud_message::showsplash("ob_pvpve_warn_enemy_nearby", undefined, undefined, undefined, undefined, "splash_list_jup_ob_pvpve");
          var_a6cdf55657dde0fe = gettime();
        }
      }
    }

    wait 3;
  }
}

function private function_a8e1fec0a897a1be(zoneindex, subzoneindex) {
  if(!isDefined(level.var_32d6d39f3da920ca[zoneindex])) {
    level.var_32d6d39f3da920ca[zoneindex] = [];
  }

  if(!isDefined(level.var_32d6d39f3da920ca[zoneindex][subzoneindex])) {
    level.var_32d6d39f3da920ca[zoneindex][subzoneindex] = [];
  }

  function_1d5039979534caef(zoneindex, subzoneindex, 0);
  playerid = self getentitynumber();
  level.var_32d6d39f3da920ca[zoneindex][subzoneindex] = function_6d6af8144a5131f1(level.var_32d6d39f3da920ca[zoneindex][subzoneindex], playerid);
  self.currentzoneindex = zoneindex;
  self.var_f5bfeb5a0a08d17e = subzoneindex;
}

function private function_5a6cae9be5731fa6() {
  if(!isDefined(self.currentzoneindex) || !isDefined(self.var_f5bfeb5a0a08d17e)) {
    return;
  }

  playerid = self getentitynumber();

  foreach(zoneindex, var_2eff22ac5a0456f0 in level.var_32d6d39f3da920ca) {
    foreach(subzoneindex, var_707742a55c7a4d52 in var_2eff22ac5a0456f0) {
      shouldclear = 0;

      for(i = 0; i < var_707742a55c7a4d52.size; i++) {
        if(isDefined(var_707742a55c7a4d52[i]) && playerid == var_707742a55c7a4d52[i]) {
          level.var_32d6d39f3da920ca[zoneindex][subzoneindex] = array_remove_index(var_707742a55c7a4d52, i);
          shouldclear = 1;
        }
      }

      if(level.var_32d6d39f3da920ca[zoneindex][subzoneindex].size == 0 && shouldclear) {
        function_1d5039979534caef(zoneindex, subzoneindex, 1);
      }
    }
  }

  self.currentzoneindex = undefined;
  self.var_f5bfeb5a0a08d17e = undefined;
}

function function_6beff7b631ab7e18(kiosk, player) {
  str_difficulty = namespace_f721fc7d0d2d0f47::function_4d8bb2d866771a10(kiosk.origin);

  switch (str_difficulty) {
    case #"hash_7bb2cd766703d463":
      kiosk.overrideindex = loot::function_54b046aa3ba2678a("jup_ob_pvpve_green");
      break;
    case #"hash_af83e47edfa8900a":
      kiosk.overrideindex = loot::function_54b046aa3ba2678a("jup_ob_pvpve_yellow");
      break;
    case #"hash_5343b465e56ec9a4":
      kiosk.overrideindex = loot::function_54b046aa3ba2678a("jup_ob_pvpve_orange");
      break;
    case #"hash_651f76c0ad6741ec":
      kiosk.overrideindex = loot::function_54b046aa3ba2678a("jup_ob_pvpve_red");
      break;
  }
}

function function_881e64f6b6191304() {
  level.weaponmetadata["magicbox_settings"].scorestreakitemspawnlist = "ob_pvpve_jup_items_magicbox_weapon_scorestreak_list";
}

function function_4fbb19878e3ae3e8(params) {
  level.var_f28f5eb4b1a3e47e = getdvarint(@ "hash_67beb83b362307b3", 2);
  level.var_7a426e8458734f73 = getdvarint(@ "hash_b336531565ba8973", 3);
  regions = namespace_f721fc7d0d2d0f47::get_regions();

  foreach(region in regions) {
    var_2a14bf805d104726 = level.var_5b7c4eafd38d35c.activityinstances["contract"][region]["REV_OB_SABOTAGE"];

    if(isDefined(var_2a14bf805d104726)) {
      foreach(instance in var_2a14bf805d104726) {
        instance.var_24cab756258ffc20.var_adc16068f51004c9 = level.var_f28f5eb4b1a3e47e;
      }
    }

    var_eb0f4ac8e3226468 = level.var_5b7c4eafd38d35c.activityinstances["contract"][region]["REV_OB_DEFEND_MERCS"];

    if(isDefined(var_eb0f4ac8e3226468)) {
      foreach(instance in var_eb0f4ac8e3226468) {
        instance.var_24cab756258ffc20.var_adc16068f51004c9 = level.var_7a426e8458734f73;
      }
    }
  }
}

function function_5d7af95f131c52aa() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("aether_storm_expansion_started");
  function_fb5b37eb3eccc267();
}

function function_fb5b37eb3eccc267() {
  var_5fe035f355489855 = [];
  var_6e374d053c0edc74 = getdvarint(@ "hash_6d47d945c756ff8", 1);

  foreach(s_exfil in level.var_2562ea48235e90b5) {
    if(isDefined(s_exfil.script_parameters) && s_exfil.script_parameters == "disabled") {
      continue;
    }

    if(!istrue(s_exfil.b_disabled) || s_exfil == level.aether_storm.final_exfil) {
      continue;
    }

    var_431e0d4d4f3f7c54 = getdvarint(@ "hash_1aa07ed6ff79f1b", 25000);

    if(distance2d(s_exfil.origin, level.aether_storm.starting_origin) > var_431e0d4d4f3f7c54) {
      var_5fe035f355489855 = function_6d6af8144a5131f1(var_5fe035f355489855, s_exfil);
    }
  }

  assertex(var_5fe035f355489855.size >= var_6e374d053c0edc74, "<dev string:x157>");

  for(i = 0; i < var_6e374d053c0edc74; i++) {
    s_exfil = var_5fe035f355489855[i];

    if(isDefined(s_exfil)) {
      s_exfil.b_disabled = 0;
      s_exfil namespace_9f6a961447bab709::function_2e0dc001c9a5c661();
      level thread namespace_9f6a961447bab709::start_exfil_spawns_at_destination(s_exfil);
    }
  }
}

function function_511e530940a6e570() {
  level endon("game_ended");
  scripts\mp\flags::function_1240434f4201ac9d("prematch_done");
  setDvar(@ "hash_faf56f135b3692d6", 1);
  level.var_35aa4c6db25e81ae = &function_dfdda3d98b049b3c;
}

function function_68556cab1f415279() {
  scripts\mp\flags::levelflagwait("overlord_csv_init");
  str_bundle = level.var_a9fc119c2a887dd8;

  if(isDefined(str_bundle)) {
    s_bundle = getscriptbundle("dialogueoverlord:" + str_bundle);

    if(isDefined(s_bundle)) {
      foreach(var_87fc95d97eb08ba9 in s_bundle.var_423f1766afe848b9) {
        if(isDefined(var_87fc95d97eb08ba9.alias)) {
          timeout = lookupsoundlength(var_87fc95d97eb08ba9.alias, 1) / 1000 + 0.25;
          registerevent(var_87fc95d97eb08ba9.ref, var_87fc95d97eb08ba9.alias, var_87fc95d97eb08ba9.priority, var_87fc95d97eb08ba9.cooldown, timeout, var_87fc95d97eb08ba9.speakerasset, var_87fc95d97eb08ba9.delaybefore, var_87fc95d97eb08ba9.delayafter);
        }
      }

      foreach(s_conversation in s_bundle.conversations) {
        level.overlord.conversations[s_conversation.conversationname] = s_conversation;

        foreach(var_84e41716d3779c0e in s_conversation.soundevents) {
          if(isDefined(var_84e41716d3779c0e.alias)) {
            eventref = var_84e41716d3779c0e.alias;

            if(!isDefined(level.overlord.events[eventref])) {
              registerevent(eventref, var_84e41716d3779c0e.alias, var_84e41716d3779c0e.priority, var_84e41716d3779c0e.cooldown, function_c89ed1840c8d0f0f(lookupsoundlength(var_84e41716d3779c0e.alias, 1)) + 0.25, var_84e41716d3779c0e.speakerasset, var_84e41716d3779c0e.delaybefore, var_84e41716d3779c0e.delayafter);
            }
          }
        }
      }
    }
  }
}

function function_dfdda3d98b049b3c(s_exfil, var_6d94a1f3678a98a6) {
  s_exfil.var_1d39d0784b73d713 = 1;
  s_exfil.var_2744fe7a1690ec17 = 1;
  return "ai_flood_fill_encounter:zombie_exfil_encounter_pvpve";
}

function private initdebug() {
  level thread function_5be6f854fd9386d8();
}

function private function_5be6f854fd9386d8() {
  while(true) {
    if(!isDefined(level.players) || level.players.size <= 0) {
      waitframe();
      continue;
    }

    eventref = getDvar(@ "hash_7953df1fd78ea4ed", "<dev string:x176>");

    if(eventref != "<dev string:x176>") {
      setDvar(@ "hash_7953df1fd78ea4ed", "<dev string:x176>");
      scripts\cp_mp\overlord::playevent(eventref, [level.players[0]]);
    }

    waitframe();
  }
}

function function_f664e717ec410248() {
  level endon("game_ended");
  scripts\mp\flags::function_1240434f4201ac9d("prematch_done");
  level.var_e29a4ad5667a5bd9 = getdvarint(@ "hash_b6bddda65eb23d91", 1);
  level callback::add("on_zombie_ai_damaged", &function_f99a74573f5d4158);
  level.var_8135774bdf2cf9f4 = getdvarint(@ "hash_589cfba100f4b6bd", 0);
  level.var_78203e815cf5c13b = getdvarint(@ "hash_a47be8f0015aa7cd", 150);
}

function function_f99a74573f5d4158(params) {
  if(!istrue(self.var_873d30685528d962)) {
    return;
  }

  if(self.maxhealth <= getdvarint(@ "hash_bb677973b07d33f7", 7500)) {
    params.idamage = self.maxhealth / getdvarint(@ "hash_479e16b02db63c5e", 1000) * params.idamage;
    return;
  }

  if(self.maxhealth <= getdvarint(@ "hash_bb677a73b07d362a", 18000)) {
    params.idamage = self.maxhealth / getdvarint(@ "hash_479e15b02db63a2b", 2000) * params.idamage;
    return;
  }

  if(self.maxhealth <= getdvarint(@ "hash_bb677b73b07d385d", 30000)) {
    params.idamage = self.maxhealth / getdvarint(@ "hash_479e14b02db637f8", 3500) * params.idamage;
    return;
  }

  if(self.maxhealth <= getdvarint(@ "hash_bb677473b07d28f8", 45000)) {
    params.idamage = self.maxhealth / getdvarint(@ "hash_479e1bb02db6475d", 4500) * params.idamage;
  }
}