/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\player\player_loadout.gsc
***********************************************/

#include scripts\abilities\ability_player;
#include scripts\abilities\ability_util;
#include scripts\abilities\gadgets\gadget_health_regen;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\dev_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\gestures;
#include scripts\core_common\healthoverlay;
#include scripts\core_common\loadout_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\perks;
#include scripts\core_common\player\player_loadout;
#include scripts\core_common\player\player_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\tweakables_shared;
#include scripts\core_common\util_shared;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\killstreaks\killstreaks_util;
#include scripts\mp_common\armor;
#include scripts\mp_common\challenges;
#include scripts\mp_common\gametypes\dev;
#include scripts\mp_common\gametypes\globallogic_score;
#include scripts\mp_common\gametypes\globallogic_utils;
#include scripts\mp_common\teams\teams;
#include scripts\weapons\weapon_utils;

#namespace loadout;

autoexec function_313e9d31() {
  callback::on_start_gametype(&function_dd840c5f);
  level.specialisthealingenabled = getgametypesetting(#"specialisthealingenabled_allies_1");
  level.specialistabilityenabled = getgametypesetting(#"specialistabilityenabled_allies_1");
  level.specialistequipmentenabled = getgametypesetting(#"specialistequipmentenabled_allies_1");
  level.var_50e97365 = getgametypesetting(#"hash_7684a70eb68f1ebb");
  level.specialistabilityreadyonrespawn = getgametypesetting(#"specialistabilityreadyonrespawn_allies_1");
  level.specialistequipmentreadyonrespawn = getgametypesetting(#"specialistequipmentreadyonrespawn_allies_1");
  level.playerloadoutrestrictions = [];
  level.playerloadoutrestrictions[0] = getscriptbundle(#"plr_mp_default");

  if(isDefined(getgametypesetting(#"scorestreaksbarebones")) && getgametypesetting(#"scorestreaksbarebones")) {
    level.scorestreaksbarebones = [];
    level.scorestreaksbarebones[0] = 126;
    level.scorestreaksbarebones[1] = 130;
    level.scorestreaksbarebones[2] = 134;
  }

  wildcardtable = getscriptbundle(#"wildcardtable");

  foreach(wildcard in wildcardtable.wildcardtable) {
    var_43645456 = wildcard.playerloadoutrestrictions;
    playerloadoutrestrictions = getscriptbundle(var_43645456);
    level.playerloadoutrestrictions[playerloadoutrestrictions.var_9bb0ceab] = playerloadoutrestrictions;
  }
}

function_dd840c5f() {
  profilestart();
  mp_init();
  profilestop();
}

function_9f888e75(weapons_table) {
  level.weapon_sig_minigun = getweapon(#"sig_minigun");
  level.weapon_hero_annihilator = getweapon(#"hero_annihilator");
  level.weaponbasemeleeheld = getweapon(#"bare_hands");
  level.weaponknifeloadout = getweapon(#"knife_loadout");
  level.weaponmeleeclub = getweapon(#"melee_club_t8");
  level.weaponmeleecoinbag = getweapon(#"melee_coinbag_t8");
  level.weaponmeleecutlass = getweapon(#"melee_cutlass_t8");
  level.weaponmeleedemohammer = getweapon(#"melee_demohammer_t8");
  level.weaponmeleesecretsanta = getweapon(#"melee_secretsanta_t8");
  level.weaponmeleeslaybell = getweapon(#"melee_slaybell_t8");
  level.weaponmeleezombiearm = getweapon(#"melee_zombiearm_t8");
  level.weaponmeleestopsign = getweapon(#"melee_stopsign_t8");
  level.weaponmeleeactionfigure = getweapon(#"melee_actionfigure_t8");
  level.weaponmeleeamuletfist = getweapon(#"melee_amuletfist_t8");

  if(!isDefined(level.meleeweapons)) {
    level.meleeweapons = [];
  } else if(!isarray(level.meleeweapons)) {
    level.meleeweapons = array(level.meleeweapons);
  }

  level.meleeweapons[level.meleeweapons.size] = level.weaponknifeloadout;

  if(!isDefined(level.meleeweapons)) {
    level.meleeweapons = [];
  } else if(!isarray(level.meleeweapons)) {
    level.meleeweapons = array(level.meleeweapons);
  }

  level.meleeweapons[level.meleeweapons.size] = level.weaponmeleeclub;

  if(!isDefined(level.meleeweapons)) {
    level.meleeweapons = [];
  } else if(!isarray(level.meleeweapons)) {
    level.meleeweapons = array(level.meleeweapons);
  }

  level.meleeweapons[level.meleeweapons.size] = level.weaponmeleecoinbag;

  if(!isDefined(level.meleeweapons)) {
    level.meleeweapons = [];
  } else if(!isarray(level.meleeweapons)) {
    level.meleeweapons = array(level.meleeweapons);
  }

  level.meleeweapons[level.meleeweapons.size] = level.weaponmeleecutlass;

  if(!isDefined(level.meleeweapons)) {
    level.meleeweapons = [];
  } else if(!isarray(level.meleeweapons)) {
    level.meleeweapons = array(level.meleeweapons);
  }

  level.meleeweapons[level.meleeweapons.size] = level.weaponmeleedemohammer;

  if(!isDefined(level.meleeweapons)) {
    level.meleeweapons = [];
  } else if(!isarray(level.meleeweapons)) {
    level.meleeweapons = array(level.meleeweapons);
  }

  level.meleeweapons[level.meleeweapons.size] = level.weaponmeleesecretsanta;

  if(!isDefined(level.meleeweapons)) {
    level.meleeweapons = [];
  } else if(!isarray(level.meleeweapons)) {
    level.meleeweapons = array(level.meleeweapons);
  }

  level.meleeweapons[level.meleeweapons.size] = level.weaponmeleeslaybell;

  if(!isDefined(level.meleeweapons)) {
    level.meleeweapons = [];
  } else if(!isarray(level.meleeweapons)) {
    level.meleeweapons = array(level.meleeweapons);
  }

  level.meleeweapons[level.meleeweapons.size] = level.weaponmeleezombiearm;

  if(!isDefined(level.meleeweapons)) {
    level.meleeweapons = [];
  } else if(!isarray(level.meleeweapons)) {
    level.meleeweapons = array(level.meleeweapons);
  }

  level.meleeweapons[level.meleeweapons.size] = level.weaponmeleestopsign;

  if(!isDefined(level.meleeweapons)) {
    level.meleeweapons = [];
  } else if(!isarray(level.meleeweapons)) {
    level.meleeweapons = array(level.meleeweapons);
  }

  level.meleeweapons[level.meleeweapons.size] = level.weaponmeleeactionfigure;

  if(!isDefined(level.meleeweapons)) {
    level.meleeweapons = [];
  } else if(!isarray(level.meleeweapons)) {
    level.meleeweapons = array(level.meleeweapons);
  }

  level.meleeweapons[level.meleeweapons.size] = level.weaponmeleeamuletfist;
  level.weaponshotgunenergy = getweapon(#"shotgun_energy");
  level.weaponpistolenergy = getweapon(#"pistol_energy");
  level.var_c1954e36 = getweapon(#"ac130_chaingun");
}

function_5be71695() {
  level.classmap[#"class_smg"] = "CLASS_SMG";
  level.classmap[#"class_cqb"] = "CLASS_CQB";
  level.classmap[#"class_assault"] = "CLASS_ASSAULT";
  level.classmap[#"class_lmg"] = "CLASS_LMG";
  level.classmap[#"class_sniper"] = "CLASS_SNIPER";
  level.classmap[#"class_specialized"] = "CLASS_SPECIALIZED";
  level.classmap[#"custom0"] = "CLASS_CUSTOM1";
  level.classmap[#"custom1"] = "CLASS_CUSTOM2";
  level.classmap[#"custom2"] = "CLASS_CUSTOM3";
  level.classmap[#"custom3"] = "CLASS_CUSTOM4";
  level.classmap[#"custom4"] = "CLASS_CUSTOM5";
  level.classmap[#"custom5"] = "CLASS_CUSTOM6";
  level.classmap[#"custom6"] = "CLASS_CUSTOM7";
  level.classmap[#"custom7"] = "CLASS_CUSTOM8";
  level.classmap[#"custom8"] = "CLASS_CUSTOM9";
  level.classmap[#"custom9"] = "CLASS_CUSTOM10";
  level.classmap[#"custom10"] = "CLASS_CUSTOM11";
  level.classmap[#"custom11"] = "CLASS_CUSTOM12";
  level.classmap[#"custom12"] = level.classmap[#"class_smg"];
  level.classmap[#"custom13"] = level.classmap[#"class_cqb"];
  level.classmap[#"custom14"] = level.classmap[#"class_assault"];
  level.classmap[#"custom15"] = level.classmap[#"class_lmg"];
  level.classmap[#"custom16"] = level.classmap[#"class_sniper"];
  level.classmap[#"custom17"] = level.classmap[#"class_specialized"];
}

function_5f206535() {
  if(!function_87bcb1b()) {
    return;
  }

  function_5be71695();
  level.defaultclass = "CLASS_CUSTOM1";
  create_class_exclusion_list();
  load_default_loadout("CLASS_SMG", 12);
  load_default_loadout("CLASS_CQB", 13);
  load_default_loadout("CLASS_ASSAULT", 14);
  load_default_loadout("CLASS_LMG", 15);
  load_default_loadout("CLASS_SNIPER", 16);
  load_default_loadout("CLASS_SPECIALIZED", 17);
}

mp_init() {
  level.maxkillstreaks = 4;
  level.maxspecialties = 6;
  level.maxallocation = getgametypesetting(#"maxallocation");
  level.loadoutkillstreaksenabled = getgametypesetting(#"loadoutkillstreaksenabled");
  level.prestigenumber = 5;
  function_6bc4927f();
  level thread function_8624b793();
  function_9f888e75();
  function_5f206535();
  callback::on_connecting(&on_player_connecting);

  if(isDefined(level.specialisthealingenabled) && !level.specialisthealingenabled) {
    ability_player::register_gadget_activation_callbacks(23, undefined, &offhealthregen);
  }
}

private create_class_exclusion_list() {
  currentdvar = 0;
  level.itemexclusions = [];

  while(getdvarint("item_exclusion_" + currentdvar, 0)) {
    level.itemexclusions[currentdvar] = getdvarint("item_exclusion_" + currentdvar, 0);
    currentdvar++;
  }

  level.attachmentexclusions = [];

  for(currentdvar = 0; getdvarstring("attachment_exclusion_" + currentdvar) != ""; currentdvar++) {
    level.attachmentexclusions[currentdvar] = getdvarstring("attachment_exclusion_" + currentdvar);
  }
}

private is_attachment_excluded(attachment) {
  numexclusions = level.attachmentexclusions.size;

  for(exclusionindex = 0; exclusionindex < numexclusions; exclusionindex++) {
    if(attachment == level.attachmentexclusions[exclusionindex]) {
      return true;
    }
  }

  return false;
}

private load_default_loadout(weaponclass, classnum) {
  level.classtoclassnum[weaponclass] = classnum;
  level.var_8e1db8ee[classnum] = weaponclass;
}

private weapon_class_register(weaponname, weapon_type) {
  if(issubstr("weapon_smg weapon_cqb weapon_assault weapon_tactical weapon_lmg weapon_sniper weapon_shotgun weapon_launcher weapon_knife weapon_special", weapon_type)) {
    level.primary_weapon_array[getweapon(weaponname)] = 1;
    return;
  }

  if(issubstr("weapon_pistol", weapon_type)) {
    level.side_arm_array[getweapon(weaponname)] = 1;
    return;
  }

  if(issubstr("weapon_grenade hero", weapon_type)) {
    level.grenade_array[getweapon(weaponname)] = 1;
    return;
  }

  if(weapon_type == "weapon_explosive") {
    level.inventory_array[getweapon(weaponname)] = 1;
    return;
  }

  if(weapon_type == "weapon_rifle") {
    level.inventory_array[getweapon(weaponname)] = 1;
    return;
  }

  assert(0, "<dev string:x38>" + weapon_type + "<dev string:x7b>" + weaponname);
}

private heavy_weapon_register_dialog(weapon) {
  readyvo = weapon.name + "_ready";
  game.dialog[readyvo] = readyvo;
}

private function_6bc4927f() {
  level.meleeweapons = [];
  level.primary_weapon_array = [];
  level.side_arm_array = [];
  level.grenade_array = [];
  level.inventory_array = [];
  level.perkicons = [];
  level.perkspecialties = [];
  level.killstreakicons = [];
  level.killstreakindices = [];

  for(i = 0; i < 1024; i++) {
    iteminfo = getunlockableiteminfofromindex(i, 0);

    if(isDefined(iteminfo)) {
      group_s = iteminfo.itemgroupname;
      reference_s = iteminfo.name;
      var_da0b29d2 = iteminfo.namehash;
      display_name_s = iteminfo.displayname;

      if(issubstr(group_s, "weapon_") || group_s == "hero") {
        if(group_s != "" && var_da0b29d2 != "") {
          weapon_class_register(var_da0b29d2, group_s);
        }

        continue;
      }

      if(group_s == "specialty") {
        level.perkspecialties[display_name_s] = reference_s;
        continue;
      }

      if(group_s == "killstreak") {
        level.tbl_killstreakdata[i] = var_da0b29d2;
        level.killstreakindices[var_da0b29d2] = i;
      }
    }
  }
}

private function_8624b793() {

  wait 0.5;

  for(i = 0; i < 1024; i++) {
    iteminfo = getunlockableiteminfofromindex(i, 0);

    if(!isDefined(iteminfo)) {
      continue;
    }

    reference_s = iteminfo.name;

    if(reference_s == "<dev string:x8b>") {
      continue;
    }

    group_s = iteminfo.itemgroupname;
    display_name_s = iteminfo.displayname;

    if(group_s == "<dev string:x8e>") {
      dev::add_perk_devgui(display_name_s, reference_s);
      continue;
    }

    if(group_s == "<dev string:x9a>") {
      if(strstartswith(iteminfo.name, "<dev string:xa3>")) {
        dev::function_8263c0d5(reference_s, "<dev string:xad>");
        continue;
      }

      postfix = "<dev string:xb3>" + sessionmodeabbreviation();
      dev::function_373068ca(reference_s, postfix);
    }
  }

}

function_97d216fa(response) {
  assert(isDefined(level.classmap[response]));
  return level.classmap[response];
}

private get_killstreak_index(weaponclass, killstreaknum) {
  killstreaknum++;
  killstreakstring = "killstreak" + killstreaknum;

  if(getdvarint(#"custom_killstreak_mode", 0) == 2) {
    return getdvarint("custom_" + killstreakstring, 0);
  }

  if(isDefined(level.scorestreaksbarebones) && isDefined(level.scorestreaksbarebones[killstreaknum - 1])) {
    return level.scorestreaksbarebones[killstreaknum - 1];
  }

  return self getloadoutitem(weaponclass, killstreakstring);
}

clear_killstreaks() {
  player = self;

  if(isDefined(player.killstreak)) {
    foreach(killstreak in player.killstreak) {
      killstreaktype = killstreaks::get_by_menu_name(killstreak);

      if(isDefined(killstreaktype)) {
        killstreakweapon = killstreaks::get_killstreak_weapon(killstreaktype);
        player takeweapon(killstreakweapon);
      }
    }

    i = 0;

    while(i < 4) {
      player function_b181bcbd(i);
      i += 1;
    }
  }

  player.killstreak = [];
}

give_killstreaks() {
  self clear_killstreaks();

  if(!level.loadoutkillstreaksenabled) {
    return;
  }

  classnum = self.class_num_for_global_weapons;
  sortedkillstreaks = [];
  currentkillstreak = 0;

  for(killstreaknum = 0; killstreaknum < level.maxkillstreaks; killstreaknum++) {
    killstreakindex = get_killstreak_index(classnum, killstreaknum);

    if(isDefined(killstreakindex) && killstreakindex > 0) {
      assert(isDefined(level.tbl_killstreakdata[killstreakindex]), "<dev string:xb7>" + killstreakindex + "<dev string:xc7>");

      if(isDefined(level.tbl_killstreakdata[killstreakindex])) {
        self.killstreak[currentkillstreak] = level.tbl_killstreakdata[killstreakindex];

        if(isDefined(level.usingmomentum) && level.usingmomentum) {
          killstreaktype = killstreaks::get_by_menu_name(self.killstreak[currentkillstreak]);

          if(isDefined(killstreaktype)) {
            weapon = killstreaks::get_killstreak_weapon(killstreaktype);
            self giveweapon(weapon);

            if(isDefined(level.usingscorestreaks) && level.usingscorestreaks) {
              if(weapon.iscarriedkillstreak) {
                if(!isDefined(self.pers[#"held_killstreak_ammo_count"][weapon])) {
                  self.pers[#"held_killstreak_ammo_count"][weapon] = 0;
                }

                if(!isDefined(self.pers[#"held_killstreak_clip_count"][weapon])) {
                  self.pers[#"held_killstreak_clip_count"][weapon] = 0;
                }

                if(self.pers[#"held_killstreak_ammo_count"][weapon] > 0) {
                  self setweaponammoclip(weapon, self.pers[#"held_killstreak_clip_count"][weapon]);
                  self setweaponammostock(weapon, self.pers[#"held_killstreak_ammo_count"][weapon] - self.pers[#"held_killstreak_clip_count"][weapon]);
                } else {
                  self function_3ba6ee5d(weapon, 0);
                }
              } else {
                quantity = 0;

                if(isDefined(self.pers[#"killstreak_quantity"]) && isDefined(self.pers[#"killstreak_quantity"][weapon])) {
                  quantity = self.pers[#"killstreak_quantity"][weapon];
                }

                self setweaponammoclip(weapon, quantity);
              }
            }

            sortdata = spawnStruct();
            sortdata.cost = self function_dceb5542(level.killstreaks[killstreaktype].itemindex);
            sortdata.weapon = weapon;
            sortindex = 0;

            for(sortindex = 0; sortindex < sortedkillstreaks.size; sortindex++) {
              if(sortedkillstreaks[sortindex].cost > sortdata.cost) {
                break;
              }
            }

            for(i = sortedkillstreaks.size; i > sortindex; i--) {
              sortedkillstreaks[i] = sortedkillstreaks[i - 1];
            }

            sortedkillstreaks[sortindex] = sortdata;
          }
        }

        currentkillstreak++;
      }
    }
  }

  var_2e1bd530 = [];
  var_2e1bd530[0] = 3;
  var_2e1bd530[1] = 1;
  var_2e1bd530[2] = 0;

  if(isDefined(level.usingmomentum) && level.usingmomentum) {
    for(sortindex = 0; sortindex < sortedkillstreaks.size && sortindex < var_2e1bd530.size; sortindex++) {
      if(sortedkillstreaks[sortindex].weapon != level.weaponnone) {
        self setkillstreakweapon(var_2e1bd530[sortindex], sortedkillstreaks[sortindex].weapon);
      }
    }
  }
}

private reset_specialty_slots(class_num) {
  self.specialty = [];
}

function_da96d067() {
  self.staticweaponsstarttime = gettime();
}

private function_50797a7f(equipment_name) {
  if(equipment_name == level.weapontacticalinsertion.name && level.disabletacinsert) {
    return false;
  }

  return true;
}

init_player(takeallweapons) {
  if(takeallweapons) {
    self takeallweapons();
  }

  self.specialty = [];
  self clear_killstreaks();
  self notify(#"give_map");
}

private give_gesture() {
  self gestures::clear_gesture();
}

private function_c84c77d8(loadoutslot) {
  switch (loadoutslot) {
    case 41:
      self.playerloadoutrestrictions.var_a2ef45f8--;

      if(self.playerloadoutrestrictions.var_a2ef45f8 < 0) {
        return false;
      }

      break;
    case 42:
      self.playerloadoutrestrictions.var_cd3db98c--;

      if(self.playerloadoutrestrictions.var_cd3db98c < 0) {
        return false;
      }

      break;
    case 43:
      self.playerloadoutrestrictions.var_25a22f4--;

      if(self.playerloadoutrestrictions.var_25a22f4 < 0) {
        return false;
      }

      break;
  }

  return true;
}

private give_talents() {
  pixbeginevent(#"give_talents");
  self.var_c8836f02 = self function_fd62a2aa(self.class_num);

  foreach(var_ebdddedf in self.var_c8836f02) {
    if(var_ebdddedf.namehash == #"hash_6be738527a4213aa" && level.hardcoremode) {
      var_ebdddedf.namehash = #"hash_5c9c79c25b74b7bb";
    }

    var_b3ed76f5 = function_c84c77d8(var_ebdddedf.loadoutslot);

    if(var_b3ed76f5 && !self hastalent(var_ebdddedf.namehash)) {
      self addtalent(var_ebdddedf.namehash);
    }
  }

  pixendevent();
}

give_perks() {
  pixbeginevent(#"give_perks");
  self.specialty = self getloadoutperks(self.class_num);
  self setplayerstateloadoutweapons(self.class_num);
  self setplayerstateloadoutbonuscards(self.class_num);

  if(level.leaguematch) {
    for(i = 0; i < self.specialty.size; i++) {
      if(isitemrestricted(self.specialty[i])) {
        arrayremoveindex(self.specialty, i);
        i--;
      }
    }
  }

  self register_perks();

  if(self hasperk(#"specialty_immunenvthermal")) {
    self clientfield::set("cold_blooded", 1);
  }

  pixendevent();
}

function_f436358b(weaponclass) {
  self.class_num = get_class_num(weaponclass);

  if(issubstr(weaponclass, "CLASS_CUSTOM")) {
    pixbeginevent(#"custom class");
    self.class_num_for_global_weapons = self.class_num;
    self reset_specialty_slots(self.class_num);
    playerrenderoptions = self calcplayeroptions(self.class_num);
    self setplayerrenderoptions(playerrenderoptions);
    pixendevent();
  } else {
    pixbeginevent(#"default class");
    assert(isDefined(self.pers[#"class"]), "<dev string:xde>");
    self.class_num_for_global_weapons = 0;
    self setplayerrenderoptions(0);
    pixendevent();
  }

  self recordloadoutindex(self.class_num);
}

get_class_num(weaponclass) {
  assert(isDefined(weaponclass));
  prefixstring = "CLASS_CUSTOM";
  var_8bba14bc = self getcustomclasscount();
  var_8bba14bc = max(var_8bba14bc, 0);

  if(isstring(weaponclass) && issubstr(weaponclass, prefixstring)) {
    var_3858e4e = getsubstr(weaponclass, prefixstring.size);
    class_num = int(var_3858e4e) - 1;

    if(class_num == -1) {
      class_num = var_8bba14bc;
    }

    assert(isDefined(class_num));

    if(class_num < 0 || class_num > var_8bba14bc) {
      class_num = 0;
    }

    assert(class_num >= 0 && class_num <= var_8bba14bc);
  } else {
    class_num = level.classtoclassnum[weaponclass];
  }

  if(!isDefined(class_num)) {
    class_num = self stats::get_stat(#"selectedcustomclass");

    if(!isDefined(class_num)) {
      class_num = 0;
    }
  }

  assert(isDefined(class_num));
  return class_num;
}

private function_d81e599e() {
  self.spawnweapon = level.weaponbasemeleeheld;
  self giveweapon(level.weaponbasemeleeheld);
  self.pers[#"spawnweapon"] = self.spawn_weapon;
  switchimmediate = isDefined(self.alreadysetspawnweapononce);
  self setspawnweapon(self.spawnweapon, switchimmediate);
  self.alreadysetspawnweapononce = 1;
}

private function_6bc6995e(weapon_options) {
  return weapon_options;
}

private get_weapon_options(type_index) {
  return self calcweaponoptions(self.class_num, type_index);
}

private function_f4042786(type_index) {
  weapon_options = self get_weapon_options(type_index);
  return function_6bc6995e(weapon_options);
}

private function_2ada6938(slot) {
  weapon = self getloadoutweapon(self.class_num, slot);

  if(weapon.iscarriedkillstreak) {
    weapon = level.weaponnull;
  }

  current_weapon_name = weapon.name;

  if(slot == "primary" || slot == "secondary") {
    var_4d371861 = self getweaponoptic(weapon);
  }

  var_a15bcb9f = getdvarint(#"hash_3c3e56404c9ca59c", 0) > 0;
  return weapon;
}

private give_weapon(weapon, slot, var_a6a8156, var_bc218695) {
  if(weapon != level.weaponnull) {
    if(isDefined(var_a6a8156)) {
      weapon_options = self[[var_a6a8156]](var_bc218695);
    } else {
      weapon_options = 0;
    }

    self giveweapon(weapon, weapon_options);
    self function_442539(slot, weapon);

    if(self hasperk(#"specialty_extraammo")) {
      self givemaxammo(weapon);
    }

    changedspecialist = 0;
    changedspecialist = self.pers[#"changed_specialist"];

    if(weapon.isgadget) {
      self ability_util::gadget_reset(weapon, self.pers[#"changed_class"], !util::isoneround(), util::isfirstround(), changedspecialist);
    }

    self function_3fb8b14(weapon, self function_9b237966(self.class_num, "primary" == slot));
    self function_a85d2581(weapon, self function_73182cb6(self.class_num, "primary" == slot));
  } else {
    self function_442539(slot, level.weaponnone);
  }

  return weapon;
}

private function_d35292b6(var_c41b864, new_weapon, var_9691c281, var_8feec653) {
  spawn_weapon = var_c41b864;

  if(new_weapon != level.weaponnull) {
    if(spawn_weapon == level.weaponnull) {
      spawn_weapon = new_weapon;
    }
  }

  return spawn_weapon;
}

private function_286ee0b6(previous_weapon, spawn_weapon) {
  if(!self hasmaxprimaryweapons()) {
    if(!isusingt7melee()) {
      self giveweapon(level.weaponbasemeleeheld);
      return self function_d35292b6(spawn_weapon, level.weaponbasemeleeheld, previous_weapon, level.weaponbasemeleeheld);
    }
  }

  return spawn_weapon;
}

private function_ee9b8d55() {
  primary_weapon = function_18a77b37("primary");
  secondary_weapon = function_18a77b37("secondary");
  self bbclasschoice(self.class_num, primary_weapon, secondary_weapon);
}

private function_d9035e42(weapon) {
  itemindex = getbaseweaponitemindex(weapon);
  iteminfo = getunlockableiteminfofromindex(itemindex, 1);

  if(iteminfo.loadoutslotname === "primary") {
    self.playerloadoutrestrictions.numprimaryweapons--;

    if(self.playerloadoutrestrictions.numprimaryweapons < 0) {
      return false;
    }
  } else if(iteminfo.loadoutslotname === "secondary") {
    self.playerloadoutrestrictions.var_ab1984e9--;

    if(self.playerloadoutrestrictions.var_ab1984e9 < 0) {
      return false;
    }
  }

  return true;
}

private function_e229fb1(weapon) {
  foreach(attachment in weapon.attachments) {
    if(attachment === "uber") {
      return true;
    }
  }

  return false;
}

private function_ad874c55(weapon) {
  foreach(attachment in weapon.attachments) {
    if(attachment === "clantag" || attachment === "killcounter" || attachment === "custom2") {
      return true;
    }
  }

  return false;
}

private function_3aa744b9(slot, weapon) {
  num_attachments = weapon.attachments.size;

  if(function_ad874c55(weapon)) {
    num_attachments--;
  }

  has_uber = function_e229fb1(weapon);

  if(has_uber) {
    num_attachments--;
  }

  if(slot === "primary") {
    self.playerloadoutrestrictions.var_355c3581 -= num_attachments;

    if(self.playerloadoutrestrictions.var_355c3581 < 0) {
      return false;
    }

    if(has_uber || weapon.isdualwield) {
      self.playerloadoutrestrictions.var_882b6b71--;

      if(self.playerloadoutrestrictions.var_882b6b71 < 0) {
        return false;
      }
    }
  } else if(slot === "secondary") {
    self.playerloadoutrestrictions.var_934131b6 -= num_attachments;

    if(self.playerloadoutrestrictions.var_934131b6 < 0) {
      return false;
    }

    if(has_uber || weapon.isdualwield) {
      self.playerloadoutrestrictions.var_c3fc8c73--;

      if(self.playerloadoutrestrictions.var_c3fc8c73 < 0) {
        return false;
      }
    }
  }

  return true;
}

private function_d126318c(slot, weapon) {
  var_b5bd8bd9 = 0;
  remove_uber = 0;

  if(slot === "primary") {
    var_b5bd8bd9 = self.playerloadoutrestrictions.var_355c3581;
    remove_uber = self.playerloadoutrestrictions.var_882b6b71 < 0;
  } else if(slot === "secondary") {
    var_b5bd8bd9 = self.playerloadoutrestrictions.var_934131b6;
    remove_uber = self.playerloadoutrestrictions.var_c3fc8c73 < 0;
  }

  attachments = arraycopy(weapon.attachments);
  max_index = attachments.size + var_b5bd8bd9;

  if(remove_uber) {
    arrayremovevalue(attachments, "uber");
  }

  for(i = attachments.size - 1; i >= max_index; i--) {
    arrayremoveindex(attachments, i);
  }

  rootweaponname = weapon.rootweapon.name;

  if(weapon.isdualwield) {
    if(#"smg_handling_t8_dw" == rootweaponname) {
      rootweaponname = #"smg_handling_t8";
    }
  }

  return getweapon(rootweaponname, attachments);
}

private function_68c2f1dc(slot, previous_weapon, var_c41b864, var_fe5710f, var_60b97679) {
  loadout = self get_loadout_slot(slot);
  var_8feec653 = loadout.weapon;
  weapon = self function_2ada6938(slot);

  if(weapon != level.weaponnull) {
    if(!self function_d9035e42(weapon)) {
      weapon = level.weaponnull;
    } else if(!self function_3aa744b9(slot, weapon)) {
      weapon = self function_d126318c(slot, weapon);
    }
  }

  self give_weapon(weapon, slot, var_60b97679, var_fe5710f);
  return self function_d35292b6(var_c41b864, weapon, previous_weapon, var_8feec653);
}

private function_cba7f33e(slot, previous_weapon, var_c41b864, var_4571c11d) {
  var_8feec653 = self function_18a77b37(slot);
  weapon = self function_2ada6938(slot);
  self[[var_4571c11d]](slot, previous_weapon);
  return self function_d35292b6(var_c41b864, weapon, previous_weapon, var_8feec653);
}

private give_hero_gadget(previous_weapon, var_c41b864, var_4571c11d) {
  var_8feec653 = self function_18a77b37("herogadget");
  self[[var_4571c11d]]("herogadget", previous_weapon);
  return var_c41b864;
}

private function_f20f595a(previous_weapon, var_c41b864, var_4571c11d) {
  var_8feec653 = self function_18a77b37("ultimate");

  if(isDefined(self.playerrole) && isDefined(self.playerrole.ultimateweapon)) {
    weapon = getweapon(self.playerrole.ultimateweapon);
    self[[var_4571c11d]]("ultimate", previous_weapon);
  }

  return var_c41b864;
}

function_d98a8122(spawn_weapon) {
  if(!isDefined(self.spawnweapon) && isDefined(self.pers[#"spawnweapon"])) {
    self.spawnweapon = self.pers[#"spawnweapon"];
  }

  if(isDefined(self.spawnweapon) && doesweaponreplacespawnweapon(self.spawnweapon, spawn_weapon) && !self.pers[#"changed_class"]) {
    spawn_weapon = self.spawnweapon;
  }

  self thread initweaponattachments(spawn_weapon);
  self.pers[#"changed_class"] = 0;
  self.spawnweapon = spawn_weapon;
  self.pers[#"spawn_weapon"] = self.spawnweapon;

  if(spawn_weapon != level.weaponnone) {
    switchimmediate = isDefined(self.alreadysetspawnweapononce);
    self setspawnweapon(spawn_weapon, switchimmediate);
    self.alreadysetspawnweapononce = 1;
  }
}

private give_weapons(previous_weapon) {
  pixbeginevent(#"give_weapons");
  self.primaryloadoutgunsmithvariantindex = self getloadoutgunsmithvariantindex(self.class_num, 0);
  self.secondaryloadoutgunsmithvariantindex = self getloadoutgunsmithvariantindex(self.class_num, 1);
  spawn_weapon = self function_68c2f1dc("primary", previous_weapon, level.weaponnull, 0, &function_f4042786);
  spawn_weapon = self function_68c2f1dc("secondary", previous_weapon, spawn_weapon, 1, &get_weapon_options);
  spawn_weapon = self function_286ee0b6(previous_weapon, spawn_weapon);
  spawn_weapon = self function_cba7f33e("primarygrenade", previous_weapon, spawn_weapon, &function_8e961216);
  spawn_weapon = self function_cba7f33e("specialgrenade", previous_weapon, spawn_weapon, &function_c3448ab0);

  if(!(isDefined(level.specialistabilityenabled) && !level.specialistabilityenabled)) {
    spawn_weapon = self give_hero_gadget(previous_weapon, spawn_weapon, &give_special_offhand);
  }

  spawn_weapon = self function_f20f595a(previous_weapon, spawn_weapon, &give_ultimate);
  self function_d98a8122(spawn_weapon);
  self function_da96d067();
  self function_ee9b8d55();
  pixendevent();
}

function_cdb86a18() {
  function_5536bd9e();
}

function_5536bd9e() {
  has_specialty_armor = self hasperk(#"specialty_armor");
  healthtoassign = self.spawnhealth;

  if(isDefined(level.maxspawnhealthboostprct)) {
    self.bonusspawnhealth = int(level.maxspawnhealthboostprct * self.spawnhealth);
    healthtoassign += self.bonusspawnhealth;
  }

  if(isDefined(self.var_71a70093)) {
    healthtoassign = self.var_71a70093;
  }

  self player::function_9080887a(healthtoassign);
  self.maxhealth = healthtoassign + (isDefined(level.var_90bb9821) ? level.var_90bb9821 : 0);
  new_health = self.var_66cb03ad < 0 ? healthtoassign : self.var_66cb03ad;
  give_armor = has_specialty_armor && (!isDefined(self.var_a06951b7) || self.var_a06951b7 < gettime());
  armor = give_armor ? self.spawnarmor : 0;
  self.health = new_health;
  self armor::set_armor(armor, armor, 0, self function_e95ae03(#"hash_56055daf9601d89e"), self function_e95ae03(#"hash_e7550a3c852687e"), self function_e95ae03(#"hash_5a20313f9a8825a9"), self function_e95ae03(#"hash_7c24b2a7dce26e8f"), 1, 1, 1);
  self.var_ed2f8b3a = self.spawnhealth;

  if(give_armor || isDefined(self.var_a06951b7) && self.var_a06951b7 < gettime()) {
    self.var_a06951b7 = undefined;
    clientfield::set_player_uimodel("hudItems.armorIsOnCooldown", 0);
  }

  self healthoverlay::restart_player_health_regen();
}

private function_8e961216(slot, previous_weapon) {
  pixbeginevent(#"hash_7187aa59ab81d21a");
  changedclass = self.pers[#"changed_class"];
  roundbased = !util::isoneround();
  firstround = util::isfirstround();
  changedspecialist = self.pers[#"changed_specialist"];
  primaryoffhand = level.weaponnone;
  var_46119dfa = 0;
  primaryoffhandcount = 0;
  primaryoffhandname = self function_b958b70d(self.class_num, "primarygrenade");

  if(primaryoffhandname == "default_specialist_equipment" && isDefined(self.playerrole) && isDefined(self.playerrole.primaryequipment)) {
    if(isDefined(level.var_50e97365) && level.var_50e97365) {
      primaryoffhandname = self.playerrole.primaryequipment;
    } else {
      primaryoffhandname = #"weapon_null";
    }
  }

  if(primaryoffhandname != #"" && primaryoffhandname != #"weapon_null") {
    primaryoffhand = getweapon(primaryoffhandname);
    var_46119dfa = self getloadoutitem(self.class_num, "primarygrenadecount");
    primaryoffhandcount = var_46119dfa ? 2 : 1;

    if(isDefined(self.pers[#"primarygrenadecount"]) && self.pers[#"primarygrenadecount"] < primaryoffhandcount && isDefined(self.pers[#"held_gadgets_power"]) && isDefined(self.pers[#"held_gadgets_power"][primaryoffhand])) {
      self.pers[#"held_gadgets_power"][primaryoffhand] *= self.pers[#"primarygrenadecount"] / primaryoffhandcount;
    }

    self.pers[#"primarygrenadecount"] = primaryoffhandcount;
  }

  if(isitemrestricted(primaryoffhand.name) || !function_50797a7f(primaryoffhand.name)) {
    primaryoffhand = level.weaponnone;
    primaryoffhandcount = 0;
  }

  if(primaryoffhand == level.weaponnone || isDefined(level.specialistequipmentenabled) && !level.specialistequipmentenabled) {
    primaryoffhand = level.var_34d27b26;
    primaryoffhandcount = 0;
  }

  if(primaryoffhand != level.weaponnull) {
    self giveweapon(primaryoffhand);
    self setweaponammoclip(primaryoffhand, primaryoffhandcount);
    self switchtooffhand(primaryoffhand);
    loadout = self get_loadout_slot(slot);
    loadout.weapon = primaryoffhand;
    loadout.count = primaryoffhandcount;
    self ability_util::gadget_reset(primaryoffhand, changedclass, roundbased, firstround, changedspecialist);

    if(isDefined(level.specialistequipmentreadyonrespawn) && level.specialistequipmentreadyonrespawn) {
      self ability_util::gadget_power_full(primaryoffhand);
    }
  }

  pixendevent();
}

function_c3448ab0(slot, previous_weapon, force_give_gadget_health_regen = 1) {
  pixbeginevent(#"hash_d790bf4ec8958ba");
  changedclass = self.pers[#"changed_class"];
  roundbased = !util::isoneround();
  firstround = util::isfirstround();
  changedspecialist = self.pers[#"changed_specialist"];
  secondaryoffhand = level.weaponnone;
  secondaryoffhandcount = 0;

  if(getdvarint(#"equipmentasgadgets", 0) == 1) {
    if(isDefined(self.playerrole) && isDefined(self.playerrole.secondaryequipment)) {
      secondaryoffhand = self.playerrole.secondaryequipment;
      secondaryoffhandcount = secondaryoffhand.startammo;
    }
  } else {
    secondaryoffhandname = self function_b958b70d(self.class_num, "specialgrenade");

    if(secondaryoffhandname != #"" && secondaryoffhandname != #"weapon_null") {
      secondaryoffhand = getweapon(secondaryoffhandname);
      secondaryoffhandcount = self getloadoutitem(self.class_num, "specialgrenadecount");
    }
  }

  if(isitemrestricted(secondaryoffhand.name) || !function_50797a7f(secondaryoffhand.name)) {
    secondaryoffhand = level.weaponnone;
    secondaryoffhandcount = 0;
  }

  if(secondaryoffhand == level.weaponnone) {
    secondaryoffhand = level.var_6388e216;
    secondaryoffhandcount = 0;
  }

  if(globallogic_utils::function_308e3379()) {
    secondaryoffhand = getweapon(#"hash_28323cd36d8b5f93");
    secondaryoffhandcount = 0;
  } else if(force_give_gadget_health_regen === 1 && level.new_health_model) {
    tactical_gear = self function_d78e0e04(self.class_num);

    if(#"gear_medicalinjectiongun" == tactical_gear) {
      secondaryoffhand = getweapon(#"gadget_medicalinjectiongun");
    } else if(level.specialisthealingenabled) {
      secondaryoffhand = getweapon(#"gadget_health_regen");
    }

    secondaryoffhandcount = 0;
  }

  if(secondaryoffhand != level.weaponnull) {
    self giveweapon(secondaryoffhand);
    self setweaponammoclip(secondaryoffhand, secondaryoffhandcount);
    self switchtooffhand(secondaryoffhand);
    loadout = self get_loadout_slot(slot);
    loadout.weapon = secondaryoffhand;
    loadout.count = secondaryoffhandcount;

    if(force_give_gadget_health_regen === 1) {
      self ability_util::gadget_power_full(secondaryoffhand);
    } else {
      self ability_util::gadget_reset(secondaryoffhand, changedclass, roundbased, firstround, changedspecialist);
    }
  }

  pixendevent();
}

private give_special_offhand(slot, previous_weapon) {
  pixbeginevent(#"give_special_offhand");
  changedclass = self.pers[#"changed_class"];
  roundbased = !util::isoneround();
  firstround = util::isfirstround();
  changedspecialist = self.pers[#"changed_specialist"];
  classnum = self.class_num_for_global_weapons;
  specialoffhand = level.weaponnone;
  specialoffhandcount = 0;

  if(isDefined(self.playerrole) && isDefined(self.playerrole.var_c21d61e9)) {
    specialoffhand = getweapon(self.playerrole.var_c21d61e9);
    specialoffhandcount = specialoffhand.startammo;
  }

  if(getdvarstring(#"scr_herogadgetname_debug") != "<dev string:x8b>") {
    herogadgetname = getdvarstring(#"scr_herogadgetname_debug");
    specialoffhand = level.weaponnone;

    if(herogadgetname != "<dev string:x10e>") {
      specialoffhand = getweapon(herogadgetname);
    }
  }

    if(isDefined(self.pers[#"rouletteweapon"])) {
      assert(specialoffhand.name == "<dev string:x11c>");
      specialoffhand = self.pers[#"rouletteweapon"];
    }

  if(isitemrestricted(specialoffhand.name) || !function_50797a7f(specialoffhand.name)) {
    specialoffhand = level.weaponnone;
    specialoffhandcount = 0;
  }

  if(specialoffhand == level.weaponnone) {
    specialoffhand = level.var_43a51921;
    specialoffhandcount = 0;
  }

  if(specialoffhand != level.weaponnull) {
    self giveweapon(specialoffhand);
    self setweaponammoclip(specialoffhand, specialoffhandcount);
    loadout = self get_loadout_slot("specialgrenade");
    loadout.weapon = specialoffhand;
    loadout.count = specialoffhandcount;
    self ability_util::gadget_reset(specialoffhand, changedclass, roundbased, firstround, changedspecialist);

    if(isDefined(level.specialistabilityreadyonrespawn) && level.specialistabilityreadyonrespawn) {
      self ability_util::gadget_power_full(specialoffhand);
    }

    if(isDefined(self.var_ad1472a2) && self.var_ad1472a2 && specialoffhand.name == #"eq_gravityslam") {
      gadgetslot = self gadgetgetslot(specialoffhand);
      self gadgetpowerchange(gadgetslot, 100 - specialoffhand.var_d911d477);
      self.var_ad1472a2 = 0;
    }

    self function_442539(slot, specialoffhand);
  }

  pixendevent();
}

private give_ultimate(slot, previous_weapon) {
  pixbeginevent(#"give_ultimate");
  changedclass = self.pers[#"changed_class"];
  roundbased = !util::isoneround();
  firstround = util::isfirstround();
  changedspecialist = self.pers[#"changed_specialist"];
  classnum = self.class_num_for_global_weapons;
  ultimate = level.weaponnone;
  var_36aac800 = 0;

  if(isDefined(self.playerrole) && isDefined(self.playerrole.ultimateweapon)) {
    ultimate = getweapon(self.playerrole.ultimateweapon);
    var_36aac800 = ultimate.startammo;
  }

  if(getdvarstring(#"hash_488ee9aa10c06400") != "<dev string:x8b>") {
    var_92d4ff6c = getdvarstring(#"hash_488ee9aa10c06400");
    ultimate = level.weaponnone;

    if(var_92d4ff6c != "<dev string:x10e>") {
      ultimate = getweapon(var_92d4ff6c);
    }
  }

    if(isitemrestricted(ultimate.name) || !function_50797a7f(ultimate.name)) {
      ultimate = level.weaponnone;
      var_36aac800 = 0;
    }

  if(ultimate == level.weaponnone) {
    ultimate = level.var_387e902c;
    var_36aac800 = 0;
  }

  if(ultimate != level.weaponnull) {
    self giveweapon(ultimate);
    self setweaponammoclip(ultimate, var_36aac800);
    loadout = self get_loadout_slot("ultimate");
    loadout.weapon = ultimate;
    loadout.count = var_36aac800;
    self ability_util::gadget_reset(ultimate, changedclass, roundbased, firstround, changedspecialist);
    self function_442539(slot, ultimate);
  }

  pixendevent();
}

function_3d16577a(team, weaponclass) {
  level.var_8314ef9f = 1;
  self give_loadout(team, weaponclass);
  level.var_8314ef9f = undefined;
}

  function give_loadout(team, weaponclass) {
    self endon(#"death");
    pixbeginevent(#"give_loadout");
    pixbeginevent(#"hash_d8a2ffe71c27024");
    self clientfield::set("cold_blooded", 0);

    if(function_87bcb1b()) {
      assert(isDefined(self.curclass));
      self function_d7c205b9(self.curclass, #"give_loadout");
      var_c8f2f688 = 1;

      if(level.var_8314ef9f === 1) {
        var_c8f2f688 = 0;
      }

        current_weapon = self getcurrentweapon();

      if(isDefined(self.var_560765bb) && self.var_560765bb >= gettime() && current_weapon != level.weaponnone) {
        return;
      }

      if(current_weapon == level.weaponnone && isDefined(self.class_num)) {
        current_weapon = self getloadoutweapon(self.class_num, "primary");
      }

      self setactionslot(3, "flourish_callouts");
      self setactionslot(4, "sprays_boasts");

      if(isDefined(level.givecustomloadout)) {
        spawn_weapon = self[[level.givecustomloadout]]();

        if(isDefined(spawn_weapon)) {
          self thread initweaponattachments(spawn_weapon);
        }

        self.spawnweapon = spawn_weapon;
      } else {
        hero_gadget = self function_18a77b37("herogadget");
        self.var_e74926dc = isDefined(hero_gadget) ? self getweaponammoclip(hero_gadget) : undefined;
        primary_grenade = self function_18a77b37("primarygrenade");
        self.var_d92d6743 = undefined;

        if(isDefined(primary_grenade)) {
          slot = self gadgetgetslot(primary_grenade);
          self.var_d92d6743 = self gadgetpowerget(slot);
        }

        self init_player(1);
        function_f436358b(weaponclass);
        allocationspent = self getloadoutallocation(self.class_num);
        overallocation = allocationspent > level.maxallocation;
        self function_8aa3ff4e();

        if(var_c8f2f688) {
          self cleartalents();
          give_talents();
        }

        give_perks();
        give_weapons(current_weapon);
        function_5536bd9e();
        give_gesture();
        give_killstreaks();
        self.attackeraccuracy = self function_968b6c6a();
      }
    } else if(isDefined(level.givecustomloadout)) {
      spawn_weapon = self[[level.givecustomloadout]]();

      if(isDefined(spawn_weapon)) {
        self thread initweaponattachments(spawn_weapon);
      }

      self.spawnweapon = spawn_weapon;
    }

    self.var_e74926dc = undefined;
    self.var_d92d6743 = undefined;
    self detachall();

    if(isDefined(self.movementspeedmodifier)) {
      self setmovespeedscale(self.movementspeedmodifier * self getmovespeedscale());
    } else {
      self setmovespeedscale(1);
    }

    self cac_selector();
    specialistindex = self getspecialistindex();
    self.ability_medal_count = isDefined(self.pers["ability_medal_count" + specialistindex]) ? self.pers["ability_medal_count" + specialistindex] : 0;
    self.equipment_medal_count = isDefined(self.pers["equipment_medal_count" + specialistindex]) ? self.pers["equipment_medal_count" + specialistindex] : 0;
    self.firstspawn = 0;
    primary_weapon = function_18a77b37("primary");
    self function_43048d33(self.spawnweapon, primary_weapon);
    self notify(#"loadout_given");
    callback::callback(#"on_loadout");
    self thread function_b61852e1();
    pixendevent();
  }

private function_b61852e1() {
  self endon(#"disconnect");
  self notify("25e412c683e8d36");
  self endon("25e412c683e8d36");
  waitframe(1);
  self luinotifyevent(#"hash_21e30e91084f7e66", 0);
  wait 0.1;
  self luinotifyevent(#"hash_21e30e91084f7e66", 0);
  wait 0.5;
  self luinotifyevent(#"hash_21e30e91084f7e66", 0);
}

private function_43048d33(spawn_weapon, primaryweapon) {
  if(!isDefined(self.firstspawn)) {
    if(isDefined(spawn_weapon)) {
      self initialweaponraise(spawn_weapon);
    } else if(isDefined(primaryweapon)) {
      self initialweaponraise(primaryweapon);
    }
  } else {
    self seteverhadweaponall(1);
  }

  if(isDefined(spawn_weapon)) {
    self function_c9a111a(spawn_weapon);
  } else if(isDefined(primaryweapon)) {
    self function_c9a111a(primaryweapon);
  }

  self.firstspawn = 0;
  self.switchedteamsresetgadgets = 0;
  self.var_560765bb = gettime();

  if(isDefined(self.pers[#"changed_specialist"]) && self.pers[#"changed_specialist"]) {
    self notify(#"changed_specialist");
    self callback::callback(#"changed_specialist");
    self.var_228b6835 = 1;
  } else {
    self.var_228b6835 = 0;
  }

  self.pers[#"changed_specialist"] = 0;
  self flagsys::set(#"loadout_given");
}

private on_player_connecting() {
  if(!isDefined(self)) {
    return;
  }

  self.pers[#"loadoutindex"] = 0;

  if(function_87bcb1b()) {
    if(!isDefined(self.pers[#"class"])) {
      self.pers[#"class"] = "";
    }

    self.curclass = self.pers[#"class"];
    self.lastclass = "";
    self function_c67222df();
    self function_d7c205b9(self.curclass);
  }
}

function_53b62db1(newclass) {
  self.curclass = newclass;
}

function_d7c205b9(newclass, calledfrom = #"unspecified") {
  loadoutindex = isDefined(newclass) ? get_class_num(newclass) : undefined;
  self.pers[#"loadoutindex"] = loadoutindex;
  var_45843e9a = calledfrom == #"give_loadout";
  var_7f8c24df = 0;

  if(!var_45843e9a) {
    var_7f8c24df = isDefined(game) && isDefined(game.state) && game.state == "playing" && isalive(self);

    if(var_7f8c24df && self.sessionstate == "playing") {
      var_25b0cd7 = self.usingsupplystation === 1;

      if(isDefined(level.ingraceperiod) && level.ingraceperiod && !(isDefined(self.hasdonecombat) && self.hasdonecombat) || var_25b0cd7) {
        var_7f8c24df = 0;
      }
    }
  }

  if(var_7f8c24df) {
    return;
  }

  self setloadoutindex(loadoutindex);
  self setplayerstateloadoutweapons(loadoutindex);
}

init_dvars() {
  level.cac_armorpiercing_data = getdvarint(#"perk_armorpiercing", 40) / 100;
  level.cac_bulletdamage_data = getdvarint(#"perk_bulletdamage", 35);
  level.cac_fireproof_data = getdvarint(#"perk_fireproof", 20);
  level.cac_armorvest_data = getdvarint(#"perk_armorvest", 80);
  level.cac_flakjacket_data = getdvarint(#"perk_flakjacket", 35);
  level.cac_flakjacket_hardcore_data = getdvarint(#"perk_flakjacket_hardcore", 9);
}

private cac_selector() {
  self.detectexplosives = 0;

  if(isDefined(self.specialty)) {
    perks = self.specialty;

    for(i = 0; i < perks.size; i++) {
      perk = perks[i];

      if(perk == "specialty_detectexplosive") {
        self.detectexplosives = 1;
      }
    }
  }
}

register_perks() {
  perks = self.specialty;
  perks::perk_reset_all();

  if(isDefined(perks) && isDefined(level.perksenabled) && level.perksenabled) {
    for(i = 0; i < perks.size; i++) {
      perk = perks[i];

      if(perk == #"specialty_null" || perk == #"weapon_null") {
        continue;
      }

      self perks::perk_setperk(perk);
    }
  }

  dev::giveextraperks();

}

cac_modified_damage(victim, attacker, damage, mod, weapon, inflictor, hitloc) {
  assert(isDefined(victim));
  assert(isDefined(attacker));
  assert(isplayer(victim));
  attacker_is_player = isplayer(attacker);

  if(damage <= 0) {
    return damage;
  }

  debug = 0;

  if(getdvarint(#"scr_perkdebug", 0)) {
    debug = 1;

    if(!isDefined(attacker.name)) {
      attacker.name = "<dev string:x12e>";
    }
  }

    final_damage = damage;

  if(victim != attacker) {
    var_81ca51d = 1;

    if(attacker_is_player && attacker hasperk(#"specialty_bulletdamage") && isprimarydamage(mod)) {
      if(victim hasperk(#"specialty_armorvest") && !function_4c80bca1(hitloc)) {

        if(debug) {
          println("<dev string:x138>" + victim.name + "<dev string:x142>" + attacker.name + "<dev string:x158>");
        }

      } else {
        final_damage = damage * (100 + level.cac_bulletdamage_data) / 100;

        if(debug) {
          println("<dev string:x138>" + attacker.name + "<dev string:x175>" + victim.name);
        }

      }
    } else if(victim hasperk(#"specialty_armorvest") && isprimarydamage(mod) && !function_4c80bca1(hitloc)) {
      final_damage = damage * level.cac_armorvest_data * 0.01;

      if(debug) {
        println("<dev string:x138>" + attacker.name + "<dev string:x19d>" + victim.name);
      }

    } else if(victim hasperk(#"specialty_fireproof") && weapon_utils::isfiredamage(weapon, mod)) {
      final_damage = damage * level.cac_fireproof_data * 0.01;

      if(debug) {
        println("<dev string:x138>" + attacker.name + "<dev string:x1c4>" + victim.name);
      }

    } else if(!var_81ca51d && victim hasperk(#"specialty_flakjacket") && weapon_utils::isexplosivedamage(mod) && !weapon.ignoresflakjacket && !victim grenade_stuck(inflictor)) {
      cac_data = level.hardcoremode ? level.cac_flakjacket_hardcore_data : level.cac_flakjacket_data;
      final_damage = int(damage * cac_data / 100);

      if(debug) {
        println("<dev string:x138>" + victim.name + "<dev string:x1e4>" + attacker.name + "<dev string:x200>");
      }

    }
  }

  victim.cac_debug_damage_type = tolower(mod);
  victim.cac_debug_original_damage = damage;
  victim.cac_debug_final_damage = final_damage;
  victim.cac_debug_location = tolower(hitloc);
  victim.cac_debug_weapon = weapon.displayname;
  victim.cac_debug_range = int(distance(attacker.origin, victim.origin));

  if(debug) {
    println("<dev string:x214>" + final_damage / damage + "<dev string:x22d>" + damage + "<dev string:x23f>" + final_damage);
  }

    final_damage = int(final_damage);

  if(final_damage < 1) {
    final_damage = 1;
  }

  return final_damage;
}

private function_4c80bca1(hitloc) {
  return hitloc == "helmet" || hitloc == "head" || hitloc == "neck";
}

private grenade_stuck(inflictor) {
  return isDefined(inflictor) && isDefined(inflictor.stucktoplayer) && inflictor.stucktoplayer == self;
}

private offhealthregen(slot, weapon) {
  self gadgetdeactivate(self.gadget_health_regen_slot, self.gadget_health_regen_weapon);
  thread function_c57586b8();
}

private function_c57586b8() {
  self endon(#"disconnect");
  wait 0.5;
  self gadget_health_regen::power_off();

  if(isDefined(self.gadget_health_regen_slot)) {
    self function_19ed70ca(self.gadget_health_regen_slot, 1);
  }
}

private function_8aa3ff4e() {
  wildcards = self function_6f2c0492(self.class_num);
  self.playerloadoutrestrictions = spawnStruct();
  self.playerloadoutrestrictions.numprimaryweapons = isDefined(level.playerloadoutrestrictions[0].numprimaryweapons) ? level.playerloadoutrestrictions[0].numprimaryweapons : 0;
  self.playerloadoutrestrictions.var_355c3581 = isDefined(level.playerloadoutrestrictions[0].var_355c3581) ? level.playerloadoutrestrictions[0].var_355c3581 : 0;
  self.playerloadoutrestrictions.var_882b6b71 = isDefined(level.playerloadoutrestrictions[0].var_882b6b71) ? level.playerloadoutrestrictions[0].var_882b6b71 : 0;
  self.playerloadoutrestrictions.var_ab1984e9 = isDefined(level.playerloadoutrestrictions[0].var_ab1984e9) ? level.playerloadoutrestrictions[0].var_ab1984e9 : 0;
  self.playerloadoutrestrictions.var_934131b6 = isDefined(level.playerloadoutrestrictions[0].var_934131b6) ? level.playerloadoutrestrictions[0].var_934131b6 : 0;
  self.playerloadoutrestrictions.var_c3fc8c73 = isDefined(level.playerloadoutrestrictions[0].var_c3fc8c73) ? level.playerloadoutrestrictions[0].var_c3fc8c73 : 0;
  self.playerloadoutrestrictions.var_a2ef45f8 = isDefined(level.playerloadoutrestrictions[0].var_a2ef45f8) ? level.playerloadoutrestrictions[0].var_a2ef45f8 : 0;
  self.playerloadoutrestrictions.var_cd3db98c = isDefined(level.playerloadoutrestrictions[0].var_cd3db98c) ? level.playerloadoutrestrictions[0].var_cd3db98c : 0;
  self.playerloadoutrestrictions.var_25a22f4 = isDefined(level.playerloadoutrestrictions[0].var_25a22f4) ? level.playerloadoutrestrictions[0].var_25a22f4 : 0;

  if(isDefined(wildcards) && wildcards.size > 0) {
    foreach(var_9bb0ceab in wildcards) {
      var_47dbd1c3 = level.playerloadoutrestrictions[var_9bb0ceab];

      if(isDefined(var_47dbd1c3)) {
        self.playerloadoutrestrictions.numprimaryweapons += isDefined(var_47dbd1c3.numprimaryweapons) ? var_47dbd1c3.numprimaryweapons : 0;
        self.playerloadoutrestrictions.var_355c3581 += isDefined(var_47dbd1c3.var_355c3581) ? var_47dbd1c3.var_355c3581 : 0;
        self.playerloadoutrestrictions.var_882b6b71 += isDefined(var_47dbd1c3.var_882b6b71) ? var_47dbd1c3.var_882b6b71 : 0;
        self.playerloadoutrestrictions.var_ab1984e9 += isDefined(var_47dbd1c3.var_ab1984e9) ? var_47dbd1c3.var_ab1984e9 : 0;
        self.playerloadoutrestrictions.var_934131b6 += isDefined(var_47dbd1c3.var_934131b6) ? var_47dbd1c3.var_934131b6 : 0;
        self.playerloadoutrestrictions.var_c3fc8c73 += isDefined(var_47dbd1c3.var_c3fc8c73) ? var_47dbd1c3.var_c3fc8c73 : 0;
        self.playerloadoutrestrictions.var_a2ef45f8 += isDefined(var_47dbd1c3.var_a2ef45f8) ? var_47dbd1c3.var_a2ef45f8 : 0;
        self.playerloadoutrestrictions.var_cd3db98c += isDefined(var_47dbd1c3.var_cd3db98c) ? var_47dbd1c3.var_cd3db98c : 0;
        self.playerloadoutrestrictions.var_25a22f4 += isDefined(var_47dbd1c3.var_25a22f4) ? var_47dbd1c3.var_25a22f4 : 0;
      }
    }
  }
}