/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\assign_weapon.gsc
*****************************************/

#include maps\_utility;
#include maps\_utility_code;
#include common_scripts\utility;

assign_random_weapon() {
  str_final_weapon = self.weapon;

  if(isDefined(anim._assignable_weapons)) {
    str_classname = tolower(self.classname);
    a_string_tokens = strtok(str_classname, "_");

    if(isinarray(a_string_tokens, "base")) {
      str_factions = getarraykeys(anim._assignable_weapons);

      foreach(str_token in a_string_tokens) {
        if(isinarray(str_factions, str_token)) {
          str_faction = str_token;
          break;
        }
      }

      if(isDefined(str_faction)) {
        a_classes = getarraykeys(anim._assignable_weapons[str_faction]);

        foreach(str_token in a_string_tokens) {
          if(isinarray(a_classes, str_token)) {
            str_class = str_token;
            break;
          }
        }
      }

      if(isDefined(str_faction) && isDefined(str_class))
        str_final_weapon = get_random_weapon_with_attachments_by_class(str_faction, str_class);
    }
  }

  if(isDefined(str_final_weapon)) {
    println("Assigning generated weapon " + str_final_weapon + " to " + self getentitynumber());

    return str_final_weapon;
  } else {
    println("Assigning default weapon " + self.weapon + " to " + self getentitynumber());

    return self.weapon;
  }
}

assign_weapon_init() {
  anim._assignable_weapons = [];
  anim._total_attachments = [];
  anim._assignable_attachments = [];
  anim._attachments_compatible = [];
  anim._attachment_percentage = [];
  anim._attachment_forced_banned = [];
  assign_camo_init();
  attachment_compatibility_init();

  switch (level.script) {
    case "angola":
    case "angola_2":
      add_weapons_to_class_and_faction("unita", "assault", array("ak47", "fnfal"), undefined, "silencer");
      add_weapons_to_class_and_faction("unita", "smg", array("ak74u"), undefined, "silencer");
      add_weapons_to_class_and_faction("unita", "lmg", array("rpd"), undefined, "silencer");
      add_weapons_to_class_and_faction("unita", "sniper", array("dragunov"), undefined, "silencer");
      add_weapons_to_class_and_faction("unita", "launcher", array("rpg"));
      add_weapons_to_class_and_faction("cuban", "assault", array("ak47", "fnfal"), undefined, "silencer");
      add_weapons_to_class_and_faction("cuban", "smg", array("ak74u"), undefined, "silencer");
      add_weapons_to_class_and_faction("cuban", "lmg", array("rpd"), undefined, "silencer");
      add_weapons_to_class_and_faction("cuban", "sniper", array("dragunov"), undefined, "silencer");
      add_weapons_to_class_and_faction("cuban", "launcher", array("rpg"));
      add_weapons_to_class_and_faction("cubanboat", "assault", array("ak47", "fnfal"), undefined, "silencer");
      add_weapons_to_class_and_faction("cubanboat", "smg", array("ak74u"), undefined, "silencer");
      add_weapons_to_class_and_faction("cubanboat", "lmg", array("rpd"), undefined, "silencer");
      add_weapons_to_class_and_faction("cubanboat", "sniper", array("dragunov"), undefined, "silencer");
      add_weapons_to_class_and_faction("cubanboat", "launcher", array("rpg"));
      add_weapons_to_class_and_faction("mpla", "assault", array("ak47", "fnfal"), undefined, "silencer");
      add_weapons_to_class_and_faction("mpla", "smg", array("ak74u"), undefined, "silencer");
      add_weapons_to_class_and_faction("mpla", "lmg", array("rpd"), undefined, "silencer");
      add_weapons_to_class_and_faction("mpla", "sniper", array("dragunov"), undefined, "silencer");
      add_weapons_to_class_and_faction("mpla", "launcher", array("rpg"));
      add_weapons_to_class_and_faction("mplachild", "assault", array("ak47", "fnfal"), undefined, "silencer");
      add_weapons_to_class_and_faction("mplachild", "smg", array("ak74u"), undefined, "silencer");
      add_weapons_to_class_and_faction("mplachild", "lmg", array("rpd"), undefined, "silencer");
      add_weapons_to_class_and_faction("mplachild", "sniper", array("dragunov"), undefined, "silencer");
      add_weapons_to_class_and_faction("mplachild", "launcher", array("rpg"));
      add_assignable_camo(array("camo_none", "camo_nevada", "camo_sahara", "camo_russia", "camo_flecktarn", "camo_flora"));
      break;
    case "monsoon":
      add_weapons_to_class_and_faction("pmc", "assault", array("saritch", "an94"), undefined, "silencer");
      add_weapons_to_class_and_faction("pmc", "smg", array("evoskorpion", "qcw05"), undefined, "silencer");
      add_weapons_to_class_and_faction("pmc", "pistol", array("beretta93r"), undefined, "silencer");
      add_weapons_to_class_and_faction("pmc", "shotgun", array("saiga12"), undefined, "silencer");
      add_weapons_to_class_and_faction("pmc", "lmg", array("qbb95"), undefined, "silencer");
      add_assignable_camo(array("camo_none", "camo_devgru", "camo_atacs", "camo_erdl", "camo_choco", "camo_blue_tiger", "camo_bloodshot", "camo_ghostek", "camo_kryptek"));
      break;
    case "haiti":
      add_weapons_to_class_and_faction("seal", "assault", array("xm8"), undefined, "silencer");
      add_weapons_to_class_and_faction("seal", "smg", array("pdw57"), undefined, "silencer");
      add_weapons_to_class_and_faction("seal", "lmg", array("mk48"), undefined, "silencer");
      add_weapons_to_class_and_faction("seal", "launcher", array("usrpg"));
      add_weapons_to_class_and_faction("sco", "assault", array("type95"), undefined, "silencer");
      add_weapons_to_class_and_faction("sco", "lmg", array("qbb95"), undefined, "silencer");
      add_weapons_to_class_and_faction("sco", "launcher", array("usrpg"));
      add_weapons_to_class_and_faction("pmc", "assault", array("an94", "type95", "xm8"), undefined, "silencer");
      add_weapons_to_class_and_faction("pmc", "lmg", array("hamr", "qbb95", "mk48"), undefined, "silencer");
      add_weapons_to_class_and_faction("pmc", "smg", array("evoskorpion", "pdw57"), undefined, "silencer");
      add_weapons_to_class_and_faction("pmc", "sniper", array("dsr50"), undefined, "silencer");
      add_weapons_to_class_and_faction("pmc", "shotgun", array("srm1216", "saiga12"), undefined, "silencer");
      add_weapons_to_class_and_faction("pmc", "launcher", array("usrpg"));
      add_assignable_camo(array("camo_none", "camo_devgru", "camo_atacs", "camo_erdl", "camo_choco", "camo_blue_tiger", "camo_bloodshot", "camo_ghostek", "camo_kryptek"));
      break;
    case "karma":
      add_weapons_to_class_and_faction("security", "assault", array("sa58"), undefined, "silencer");
      add_weapons_to_class_and_faction("security", "smg", array("insas"), undefined, "silencer");
      add_weapons_to_class_and_faction("security", "sniper", array("as50"), undefined, "silencer");
      add_weapons_to_class_and_faction("security", "shotgun", array("ksg"), undefined, "silencer");
      add_weapons_to_class_and_faction("security", "pistol", array("fiveseven"), undefined, "silencer");
      add_weapons_to_class_and_faction("security", "launcher", array("usrpg"));
      add_weapons_to_class_and_faction("pmc", "assault", array("sa58", "tar21"), undefined, "silencer");
      add_weapons_to_class_and_faction("pmc", "smg", array("insas", "qcw05"), undefined, "silencer");
      add_weapons_to_class_and_faction("pmc", "lmg", array("hamr"), undefined, "silencer");
      add_weapons_to_class_and_faction("pmc", "sniper", array("as50", "svu"), undefined, "silencer");
      add_weapons_to_class_and_faction("pmc", "shotgun", array("ksg", "saiga12"), undefined, "silencer");
      add_weapons_to_class_and_faction("pmc", "pistol", array("fiveseven", "beretta93r"), undefined, "silencer");
      add_weapons_to_class_and_faction("pmc", "launcher", array("usrpg"));
      add_weapons_to_class_and_faction("spetsnaz", "assault", array("sa58", "tar21"), "silencer");
      add_weapons_to_class_and_faction("spetsnaz", "smg", array("insas", "qcw05"), "silencer");
      add_weapons_to_class_and_faction("spetsnaz", "lmg", array("qbb95"), "silencer");
      add_weapons_to_class_and_faction("spetsnaz", "sniper", array("svu"), "silencer");
      add_weapons_to_class_and_faction("spetsnaz", "shotgun", array("ksg", "saiga12"), "silencer");
      add_weapons_to_class_and_faction("spetsnaz", "pistol", array("fiveseven", "beretta93r"), "silencer");
      add_weapons_to_class_and_faction("spetsnaz", "launcher", array("usrpg"), "silencer");
      add_assignable_camo(array("camo_none"));
      break;
    case "karma_2":
      add_weapons_to_class_and_faction("security", "assault", array("sa58"), undefined, "silencer");
      add_weapons_to_class_and_faction("security", "smg", array("insas"), undefined, "silencer");
      add_weapons_to_class_and_faction("security", "sniper", array("as50"), undefined, "silencer");
      add_weapons_to_class_and_faction("security", "shotgun", array("ksg"), undefined, "silencer");
      add_weapons_to_class_and_faction("security", "pistol", array("fiveseven"), undefined, "silencer");
      add_weapons_to_class_and_faction("security", "launcher", array("usrpg"));
      add_weapons_to_class_and_faction("pmc", "assault", array("sa58", "tar21"), undefined, "silencer");
      add_weapons_to_class_and_faction("pmc", "smg", array("insas", "qcw05"), undefined, "silencer");
      add_weapons_to_class_and_faction("pmc", "lmg", array("hamr"), undefined, "silencer");
      add_weapons_to_class_and_faction("pmc", "sniper", array("as50", "svu"), undefined, "silencer");
      add_weapons_to_class_and_faction("pmc", "shotgun", array("ksg", "saiga12"), undefined, "silencer");
      add_weapons_to_class_and_faction("pmc", "pistol", array("fiveseven", "beretta93r"), undefined, "silencer");
      add_weapons_to_class_and_faction("pmc", "launcher", array("usrpg"));
      add_assignable_camo(array("camo_none"));
      break;
    case "la_1":
    case "la_1b":
      add_weapons_to_class_and_faction("ally", "assault", array("scar", "hk416", "xm8"), undefined, "silencer");
      add_weapons_to_class_and_faction("ally", "smg", array("mp7"), undefined, "silencer");
      add_weapons_to_class_and_faction("ally", "sniper", array("dsr50"), undefined, "silencer");
      add_weapons_to_class_and_faction("ally", "shotgun", array("ksg"), undefined, "silencer");
      add_weapons_to_class_and_faction("ally", "pistol", array("kard_semiauto"), undefined, "silencer");
      add_weapons_to_class_and_faction("ally", "launcher", array("usrpg"));
      add_weapons_to_class_and_faction("manticore", "assault", array("sig556", "type95", "sa58"), undefined, "silencer");
      add_weapons_to_class_and_faction("manticore", "smg", array("vector", "qcw05"), undefined, "silencer");
      add_weapons_to_class_and_faction("manticore", "sniper", array("ballista"), undefined, "silencer");
      add_weapons_to_class_and_faction("manticore", "shotgun", array("ksg"), undefined, "silencer");
      add_weapons_to_class_and_faction("manticore", "pistol", array("kard_semiauto"), undefined, "silencer");
      add_weapons_to_class_and_faction("manticore", "launcher", array("usrpg"));
      add_assignable_camo(array("camo_none", "camo_devgru", "camo_atacs", "camo_erdl", "camo_choco", "camo_blue_tiger", "camo_bloodshot", "camo_ghostek", "camo_kryptek"));
      break;
    case "nicaragua":
      add_weapons_to_class_and_faction("cartel", "assault", array("ak47", "fnfal", "galil"), undefined, "silencer");
      add_weapons_to_class_and_faction("cartel", "smg", array("uzi", "ak74u"), undefined, "silencer");
      add_weapons_to_class_and_faction("cartel", "lmg", array("rpd"), undefined, "silencer");
      add_weapons_to_class_and_faction("cartel", "shotgun", array("spas"), undefined, "silencer");
      add_weapons_to_class_and_faction("cartel", "sniper", array("dragunov"), undefined, "silencer");
      add_weapons_to_class_and_faction("cartel", "pistol", array("browninghp"), undefined, "silencer");
      add_weapons_to_class_and_faction("cartel", "launcher", array("rpg"));
      add_weapons_to_class_and_faction("pdf", "assault", array("ak47", "fnfal", "galil"), undefined, "silencer");
      add_weapons_to_class_and_faction("pdf", "smg", array("uzi", "ak74u", "mp5k"), undefined, "silencer");
      add_weapons_to_class_and_faction("pdf", "lmg", array("rpd", "m60"), undefined, "silencer");
      add_weapons_to_class_and_faction("pdf", "sniper", array("dragunov"), undefined, "silencer");
      add_weapons_to_class_and_faction("pdf", "pistol", array("browninghp"), undefined, "silencer");
      add_weapons_to_class_and_faction("pdf", "launcher", array("rpg"));
      add_assignable_camo(array("camo_none", "camo_nevada", "camo_sahara", "camo_russia", "camo_flecktarn", "camo_flora"));
      break;
    case "pakistan":
    case "pakistan_2":
    case "pakistan_3":
      add_weapons_to_class_and_faction("seal", "assault", array("scar", "hk416"), undefined, "silencer");
      add_weapons_to_class_and_faction("seal", "smg", array("vector"), undefined, "silencer");
      add_weapons_to_class_and_faction("seal", "pistol", array("fnp45", "beretta93r"), undefined, "silencer");
      add_weapons_to_class_and_faction("seal", "launcher", array("m32"));
      add_weapons_to_class_and_faction("isi", "assault", array("tar21", "sa58"), undefined, "silencer");
      add_weapons_to_class_and_faction("isi", "lmg", array("qbb95"), undefined, "silencer");
      add_weapons_to_class_and_faction("isi", "smg", array("insas"), undefined, "silencer");
      add_weapons_to_class_and_faction("isi", "shotgun", array("saiga12"), undefined, "silencer");
      add_weapons_to_class_and_faction("isi", "pistol", array("fnp45", "beretta93r"), undefined, "silencer");
      add_weapons_to_class_and_faction("isi", "launcher", array("usrpg"));
      add_weapons_to_class_and_faction("let", "assault", array("sa58", "tar21"), undefined, "silencer");
      add_weapons_to_class_and_faction("let", "lmg", array("qbb95"), undefined, "silencer");
      add_weapons_to_class_and_faction("let", "smg", array("insas"), undefined, "silencer");
      add_weapons_to_class_and_faction("let", "shotgun", array("saiga12"), undefined, "silencer");
      add_weapons_to_class_and_faction("let", "pistol", array("fnp45", "beretta93r"), undefined, "silencer");
      add_weapons_to_class_and_faction("let", "launcher", array("usrpg"));
      add_assignable_camo(array("camo_none", "camo_devgru", "camo_atacs", "camo_erdl", "camo_choco", "camo_blue_tiger", "camo_bloodshot", "camo_ghostek", "camo_kryptek"));
      break;
    case "panama":
    case "panama_2":
    case "panama_3":
      add_weapons_to_class_and_faction("ally", "assault", array("m16"), undefined, "silencer");
      add_weapons_to_class_and_faction("ally", "smg", array("mp5k"), undefined, "silencer");
      add_weapons_to_class_and_faction("ally", "lmg", array("m60"), undefined, "silencer");
      add_weapons_to_class_and_faction("ally", "sniper", array("psg1_vzoom"), undefined, "silencer");
      add_weapons_to_class_and_faction("ally", "shotgun", array("ksg"), undefined, "silencer");
      add_weapons_to_class_and_faction("ally", "pistol", array("m1911"), undefined, "silencer");
      add_weapons_to_class_and_faction("ally", "launcher", array("rpg"));
      add_weapons_to_class_and_faction("pdf", "assault", array("ak47", "fnfal"), undefined, "silencer");
      add_weapons_to_class_and_faction("pdf", "smg", array("uzi"), undefined, "silencer");
      add_weapons_to_class_and_faction("pdf", "lmg", array("rpd"), undefined, "silencer");
      add_weapons_to_class_and_faction("pdf", "sniper", array("dragunov"), undefined, "silencer");
      add_weapons_to_class_and_faction("pdf", "shotgun", array("spas"), undefined, "silencer");
      add_weapons_to_class_and_faction("pdf", "pistol", array("browninghp"), undefined, "silencer");
      add_weapons_to_class_and_faction("pdf", "launcher", array("rpg"));
      add_assignable_camo(array("camo_none", "camo_nevada", "camo_sahara", "camo_russia", "camo_flecktarn", "camo_flora"));
      break;
    case "yemen":
      add_weapons_to_class_and_faction("seal", "assault", array("xm8"), undefined, "silencer");
      add_weapons_to_class_and_faction("seal", "smg", array("mp7"), undefined, "silencer");
      add_weapons_to_class_and_faction("seal", "pistol", array("fiveseven", undefined, "silencer"));
      add_weapons_to_class_and_faction("seal", "launcher", array("usrpg"), undefined, "silencer");
      add_weapons_to_class_and_faction("yemeni", "assault", array("xm8"), undefined, "silencer");
      add_weapons_to_class_and_faction("yemeni", "smg", array("mp7"), undefined, "silencer");
      add_weapons_to_class_and_faction("yemeni", "lmg", array("hamr"), undefined, "silencer");
      add_weapons_to_class_and_faction("yemeni", "sniper", array("as50"), undefined, "silencer");
      add_weapons_to_class_and_faction("yemeni", "pistol", array("fiveseven"), undefined, "silencer");
      add_weapons_to_class_and_faction("yemeni", "launcher", array("usrpg"), undefined, "silencer");
      add_weapons_to_class_and_faction("terrorist", "assault", array("an94"), undefined, "silencer");
      add_weapons_to_class_and_faction("terrorist", "smg", array("evoskorpion"), undefined, "silencer");
      add_weapons_to_class_and_faction("terrorist", "pistol", array("fiveseven"), undefined, "silencer");
      add_weapons_to_class_and_faction("terrorist", "launcher", array("usrpg"), undefined, "silencer");
      add_assignable_camo(array("camo_none", "camo_devgru", "camo_atacs", "camo_erdl", "camo_choco", "camo_blue_tiger", "camo_bloodshot", "camo_ghostek", "camo_kryptek"));
      break;
    case "blackout":
      add_weapons_to_class_and_faction("seal", "assault", array("xm8"), undefined, "silencer");
      add_weapons_to_class_and_faction("seal", "pistol", array("fiveseven"), undefined, "silencer");
      add_weapons_to_class_and_faction("navy", "assault", array("xm8"), undefined, "silencer");
      add_weapons_to_class_and_faction("navy", "shotgun", array("srm1216"), undefined, "silencer");
      add_weapons_to_class_and_faction("navy", "smg", array("mp5"), undefined, "silencer");
      add_weapons_to_class_and_faction("navy", "sniper", array("as50"), undefined, "silencer");
      add_weapons_to_class_and_faction("navy", "pistol", array("fiveseven"), undefined, "silencer");
      add_weapons_to_class_and_faction("navy", "launcher", array("usrpg"));
      add_weapons_to_class_and_faction("manticore", "assault", array("xm8", "hk416"), undefined, "silencer");
      add_weapons_to_class_and_faction("manticore", "shotgun", array("srm1216"), undefined, "silencer");
      add_weapons_to_class_and_faction("manticore", "smg", array("vector"), undefined, "silencer");
      add_weapons_to_class_and_faction("manticore", "sniper", array("as50"), undefined, "silencer");
      add_weapons_to_class_and_faction("manticore", "pistol", array("fiveseven"), undefined, "silencer");
      add_weapons_to_class_and_faction("manticore", "launcher", array("usrpg"));
      add_assignable_camo(array("camo_none", "camo_devgru", "camo_atacs", "camo_erdl", "camo_choco", "camo_blue_tiger", "camo_bloodshot", "camo_ghostek", "camo_kryptek"));
      break;
    case "so_rts_mp_dockside":
      add_level_banned_attachments(array("ir", "mms"));
      add_weapons_to_class_and_faction("chinese", "assault", array("saritch"), undefined, "silencer");
      add_weapons_to_class_and_faction("chinese", "smg", array("vector", "pdw57", "qcw05"), undefined, "silencer");
      add_weapons_to_class_and_faction("chinese", "lmg", array("qbb95"), undefined, "silencer");
      add_weapons_to_class_and_faction("ally", "assault", array("xm8", "scar"), undefined, "silencer");
      add_weapons_to_class_and_faction("ally", "heavy", array("mk48"), undefined, "silencer");
      add_weapons_to_class_and_faction("ally", "sniper", array("dsr50"), undefined, "silencer");
      add_assignable_camo(array("camo_none", "camo_devgru", "camo_atacs", "camo_erdl", "camo_choco", "camo_blue_tiger", "camo_bloodshot", "camo_ghostek", "camo_kryptek"));
      break;
    case "so_rts_mp_socotra":
      add_level_banned_attachments(array("ir", "mms"));
      add_weapons_to_class_and_faction("cd", "assault", array("tar21"), undefined, "silencer");
      add_weapons_to_class_and_faction("cd", "smg", array("vector", "qcw05"), undefined, "silencer");
      add_weapons_to_class_and_faction("cd", "lmg", array("lsat"), undefined, "silencer");
      add_weapons_to_class_and_faction("cd", "shotgun", array("ksg"), undefined, "silencer");
      add_weapons_to_class_and_faction("ally", "assault", array("xm8", "scar"), undefined, "silencer");
      add_weapons_to_class_and_faction("ally", "heavy", array("mk48"), undefined, "silencer");
      add_weapons_to_class_and_faction("ally", "sniper", array("dsr50"), undefined, "silencer");
      add_assignable_camo(array("camo_none", "camo_devgru", "camo_atacs", "camo_erdl", "camo_choco", "camo_blue_tiger", "camo_bloodshot", "camo_ghostek", "camo_kryptek"));
      break;
    case "so_rts_mp_overflow":
      add_level_banned_attachments(array("ir", "mms"));
      add_weapons_to_class_and_faction("chinese", "assault", array("saritch"), undefined, "silencer");
      add_weapons_to_class_and_faction("chinese", "smg", array("vector", "pdw57", "qcw05"), undefined, "silencer");
      add_weapons_to_class_and_faction("chinese", "lmg", array("qbb95"), undefined, "silencer");
      add_weapons_to_class_and_faction("ally", "assault", array("xm8", "scar"), undefined, "silencer");
      add_weapons_to_class_and_faction("ally", "heavy", array("mk48"), undefined, "silencer");
      add_weapons_to_class_and_faction("ally", "sniper", array("dsr50"), undefined, "silencer");
      add_assignable_camo(array("camo_none", "camo_devgru", "camo_atacs", "camo_erdl", "camo_choco", "camo_blue_tiger", "camo_bloodshot", "camo_ghostek", "camo_kryptek"));
      break;
    case "so_rts_mp_drone":
      add_level_banned_attachments(array("ir", "mms"));
      add_weapons_to_class_and_faction("pmc", "assault", array("tar21"), undefined, "silencer");
      add_weapons_to_class_and_faction("pmc", "smg", array("vector", "pdw57", "qcw05"), undefined, "silencer");
      add_weapons_to_class_and_faction("pmc", "lmg", array("qbb95"), undefined, "silencer");
      add_weapons_to_class_and_faction("ally", "assault", array("xm8", "scar"), undefined, "silencer");
      add_weapons_to_class_and_faction("ally", "heavy", array("mk48"), undefined, "silencer");
      add_weapons_to_class_and_faction("ally", "sniper", array("dsr50"), undefined, "silencer");
      add_assignable_camo(array("camo_none", "camo_devgru", "camo_atacs", "camo_erdl", "camo_choco", "camo_blue_tiger", "camo_bloodshot", "camo_ghostek", "camo_kryptek"));
      break;
    case "so_cmp_afghanistan":
      add_level_banned_attachments(array("ir", "mms"));
      add_weapons_to_class_and_faction("enemy", "assault", array("ak47"), undefined, "silencer");
      add_weapons_to_class_and_faction("enemy", "smg", array("ak74u"), undefined, "silencer");
      add_weapons_to_class_and_faction("enemy", "lmg", array("rpd"), undefined, "silencer");
      add_weapons_to_class_and_faction("enemy", "sniper", array("dragunov"));
      add_weapons_to_class_and_faction("enemy", "pistol", array("makarov"));
      add_weapons_to_class_and_faction("enemy", "launcher", array("rpg"));
      add_weapons_to_class_and_faction("ally", "assault", array("ak47"), undefined, "silencer");
      add_weapons_to_class_and_faction("ally", "smg", array("ak74u"), undefined, "silencer");
      add_weapons_to_class_and_faction("ally", "lmg", array("rpd"), undefined, "silencer");
      add_weapons_to_class_and_faction("ally", "sniper", array("dragunov"));
      add_weapons_to_class_and_faction("ally", "pistol", array("makarov"));
      add_weapons_to_class_and_faction("ally", "launcher", array("rpg"));
      break;
    case "challenge_bloodbath":
      add_weapons_to_class_and_faction("manticore", "assault", array("tar21"));
      add_weapons_to_class_and_faction("manticore", "shotgun", array("tar21"));
      add_weapons_to_class_and_faction("manticore", "smg", array("tar21"));
      add_weapons_to_class_and_faction("manticore", "sniper", array("tar21"));
      add_weapons_to_class_and_faction("manticore", "pistol", array("tar21"));
      add_weapons_to_class_and_faction("manticore", "launcher", array("tar21"));
      break;
  }
}

add_weapons_to_class_and_faction(str_faction, str_class, a_weapon_list, attach_forced, attach_banned, zero_attachment_perc, one_attachment_perc, two_attachment_perc, three_attachment_perc) {
  if(!isDefined(zero_attachment_perc))
    zero_attachment_perc = 10;

  if(!isDefined(one_attachment_perc))
    one_attachment_perc = 40;

  if(!isDefined(two_attachment_perc))
    two_attachment_perc = 40;

  if(!isDefined(three_attachment_perc))
    three_attachment_perc = 10;

  foreach(str_weapon in a_weapon_list)
  add_weapon_to_class_and_faction(str_faction, str_class, str_weapon, attach_forced, attach_banned, zero_attachment_perc, one_attachment_perc, two_attachment_perc, three_attachment_perc);
}

add_weapon_to_class_and_faction(str_faction, str_class, str_weapon, attach_forced, attach_banned, zero_attachment_perc, one_attachment_perc, two_attachment_perc, three_attachment_perc) {
  add_faction_to_weapon_array(str_faction);
  add_weapon_class_to_weapon_array(str_class, str_faction, str_weapon);
  add_weapon_attachment_percentages_to_weapon_array(str_class, str_faction, zero_attachment_perc, one_attachment_perc, two_attachment_perc, three_attachment_perc);
  add_weapon_assignable_attachments_weapon_array(str_class, str_faction, str_weapon, attach_forced, attach_banned);
  add_forced_banned_attachement_to_class_and_faction(str_faction, str_class, attach_forced, attach_banned);
}

add_faction_to_weapon_array(str_faction) {
  if(!isDefined(anim._assignable_weapons[str_faction]))
    anim._assignable_weapons[str_faction] = [];
}

add_weapon_class_to_weapon_array(str_class, str_faction, str_weapon) {
  if(!isDefined(anim._assignable_weapons[str_faction][str_class]))
    anim._assignable_weapons[str_faction][str_class] = [];

  if(isassetloaded("weapon", str_weapon + "_sp", 0)) {
    anim._assignable_weapons[str_faction][str_class][str_weapon] = str_weapon;
    precacheitem(str_weapon + "_sp");
  }
}

add_weapon_attachment_percentages_to_weapon_array(str_class, str_faction, zero_attachment_perc, one_attachment_perc, two_attachment_perc, three_attachment_perc) {
  if(!isDefined(anim._attachment_percentage[str_faction]))
    anim._attachment_percentage[str_faction] = [];

  if(!isDefined(anim._attachment_percentage[str_faction][str_class])) {
    anim._attachment_percentage[str_faction][str_class] = [];
    anim._attachment_percentage[str_faction][str_class][0] = zero_attachment_perc;
    anim._attachment_percentage[str_faction][str_class][1] = zero_attachment_perc + one_attachment_perc;
    anim._attachment_percentage[str_faction][str_class][2] = zero_attachment_perc + one_attachment_perc + two_attachment_perc;
    anim._attachment_percentage[str_faction][str_class][3] = zero_attachment_perc + one_attachment_perc + two_attachment_perc + three_attachment_perc;
    assert(zero_attachment_perc + one_attachment_perc + two_attachment_perc + three_attachment_perc == 100);
  }
}

add_weapon_assignable_attachments_weapon_array(str_class, str_faction, str_weapon, attach_forced, attach_banned) {
  if(!isDefined(anim._assignable_attachments[str_weapon])) {
    itemrow = tablelookuprownum("sp/statstable.csv", 4, str_weapon);
    str_attachments = tablelookupcolumnforrow("sp/statstable.csv", itemrow, 8);
    anim._assignable_attachments[str_weapon] = [];
    anim._assignable_attachments[str_weapon] = strtok(str_attachments, " ");

    for(i = 0; i < anim._assignable_attachments[str_weapon].size; i++) {
      if(issubstr(anim._assignable_attachments[str_weapon][i], "_")) {
        tokens = strtok(anim._assignable_attachments[str_weapon][i], "_");
        anim._assignable_attachments[str_weapon][i] = tokens[0];
      }
    }

    if(isDefined(anim._level_attach_banned)) {
      foreach(attach_banned in anim._level_attach_banned) {
        if(isDefined(attach_forced))
          assert(attach_forced != attach_banned, "forced and attachement for " + str_weapon + " cant be the same as the banned attachment for the level");
      }

      anim._assignable_attachments[str_weapon] = array_exclude(anim._assignable_attachments[str_weapon], anim._level_attach_banned);
    }
  }
}

add_forced_banned_attachement_to_class_and_faction(str_faction, str_class, attach_forced, attach_banned) {
  if(!isDefined(anim._attachment_forced_banned[str_faction])) {
    anim._attachment_forced_banned[str_faction] = [];
    anim._attachment_forced_banned[str_faction][str_class] = [];
    anim._attachment_forced_banned[str_faction][str_class]["forced"] = undefined;
    anim._attachment_forced_banned[str_faction][str_class]["banned"] = undefined;
  }

  anim._attachment_forced_banned[str_faction][str_class]["forced"] = attach_forced;
  anim._attachment_forced_banned[str_faction][str_class]["banned"] = attach_banned;

  if(isDefined(attach_forced))
    assert(isinarray(anim._total_attachments, attach_forced), "Invalid forced attachement, " + attach_forced);

  if(isDefined(attach_banned))
    assert(isinarray(anim._total_attachments, attach_banned), "Invalid banned attachement, " + attach_banned);

  if(isDefined(attach_forced) && isDefined(attach_banned))
    assert(attach_forced != attach_banned, "forced and banned attachments can not be the same attachments");
}

add_level_banned_attachments(attach_banned) {
  if(isDefined(attach_banned))
    anim._level_attach_banned = attach_banned;
}

attachment_compatibility_init() {
  for(i = 0; i < 33; i++) {
    itemrow = tablelookuprownum("sp/attachmentTable.csv", 9, i);

    if(itemrow > -1) {
      attachment = tablelookupcolumnforrow("sp/attachmentTable.csv", itemrow, 4);
      anim._total_attachments[anim._total_attachments.size] = attachment;
      anim._attachments_compatible[attachment] = [];
      compatible_attachments = tablelookupcolumnforrow("sp/attachmentTable.csv", itemrow, 11);
      anim._attachments_compatible[attachment] = strtok(compatible_attachments, " ");
    }
  }
}

get_random_weapon_with_attachments_by_class(str_faction, str_class) {
  str_weapon_with_attachment = self.primaryweapon;
  str_weapon = self get_random_weapon_by_class(str_faction, str_class);

  if(isDefined(str_weapon))
    str_weapon_with_attachment = self get_weapon_with_attachments(str_weapon, str_faction, str_class);

  return str_weapon_with_attachment;
}

get_random_weapon_by_class(str_faction, str_class) {
  if(isDefined(anim._assignable_weapons[str_faction]) && isDefined(anim._assignable_weapons[str_faction][str_class])) {
    if(anim._assignable_weapons[str_faction][str_class].size > 0) {
      a_weapon_keys = getarraykeys(anim._assignable_weapons[str_faction][str_class]);
      n_weapon_index = randomint(anim._assignable_weapons[str_faction][str_class].size);
      str_weapon = a_weapon_keys[n_weapon_index];
    }
  }

  return str_weapon;
}

get_weapon_with_attachments(str_weapon, str_faction, str_class) {
  if(!isDefined(str_faction))
    return str_weapon + "_sp";

  str_weapon_with_attachments = str_weapon + "_sp";
  num_attachments = select_number_of_attachments(str_faction, str_class);
  str_weapon_with_attachments = assemble_attachments_for_weapon(str_weapon, str_faction, str_class, num_attachments);

  forced_attachment = get_forced_attachment(str_weapon, str_faction, str_class);

  if(isDefined(forced_attachment))
    assert(issubstr(str_weapon_with_attachments, forced_attachment));

  banned_attachment = get_banned_attachment(str_weapon, str_faction, str_class);

  if(isDefined(banned_attachment))
    assert(!issubstr(str_weapon_with_attachments, banned_attachment));

  return str_weapon_with_attachments;
}

select_number_of_attachments(str_faction, str_class) {
  perc = randomint(100);

  if(isDefined(anim._attachment_percentage[str_faction][str_class])) {
    if(perc <= anim._attachment_percentage[str_faction][str_class][0])
      num_attachments = 0;

    if(perc > anim._attachment_percentage[str_faction][str_class][0] && perc <= anim._attachment_percentage[str_faction][str_class][1])
      num_attachments = 1;

    if(perc > anim._attachment_percentage[str_faction][str_class][1] && perc <= anim._attachment_percentage[str_faction][str_class][2])
      num_attachments = 2;

    if(perc > anim._attachment_percentage[str_faction][str_class][2] && perc <= anim._attachment_percentage[str_faction][str_class][3])
      num_attachments = 3;

    if(num_attachments < 1) {
      if(isDefined(get_forced_attachment(undefined, str_faction, str_class)))
        num_attachments = 1;
    }

    return num_attachments;
  } else
    num_attachments = randomintrange(0, 3);

  self._assigned_num_attachments = num_attachments;

  return num_attachments;
}

assemble_attachments_for_weapon(str_weapon, str_faction, str_class, num_attachments) {
  total_attachments = [];
  str_weapon_with_attachments = str_weapon + "_sp";

  if(num_attachments == 0)
    return str_weapon_with_attachments;

  if(!isDefined(anim._assignable_attachments[str_weapon]))
    return str_weapon_with_attachments;

  if(anim._assignable_attachments[str_weapon].size <= 0)
    return str_weapon_with_attachments;

  weapon_attachments = arraycopy(anim._assignable_attachments[str_weapon]);
  banned_attachment = get_banned_attachment(str_weapon, str_faction, str_class);

  if(isDefined(banned_attachment))
    weapon_attachments = array_exclude(weapon_attachments, banned_attachment);

  forced_attachment = get_forced_attachment(str_weapon, str_faction, str_class);

  if(isDefined(forced_attachment))
    attachment1 = forced_attachment;
  else
    attachment1 = random(weapon_attachments);

  weapon_attachments = array_exclude(weapon_attachments, attachment1);

  if(attachment1 == "")
    return str_weapon_with_attachments;

  str_weapon_with_attachments = str_weapon + "_sp+" + attachment1;

  if(num_attachments == 1)
    return str_weapon_with_attachments;

  total_attachments[0] = attachment1;
  attachment2 = get_next_compatible_attachment(weapon_attachments, attachment1, total_attachments);
  weapon_attachments = array_exclude(weapon_attachments, attachment2);

  if(isDefined(attachment2)) {
    if(is_later_in_alphabet(attachment2, attachment1))
      str_weapon_with_attachments = str_weapon + "_sp+" + attachment1 + "+" + attachment2;
    else
      str_weapon_with_attachments = str_weapon + "_sp+" + attachment2 + "+" + attachment1;

    if(num_attachments == 2)
      return str_weapon_with_attachments;
  } else
    return str_weapon_with_attachments;

  total_attachments[1] = attachment2;
  attachment3 = get_next_compatible_attachment(weapon_attachments, attachment2, total_attachments);

  if(isDefined(attachment3)) {
    total_attachments[2] = attachment3;
    total_attachments = alphabetize(total_attachments);
    str_weapon_with_attachments = str_weapon + "_sp+" + total_attachments[0] + "+" + total_attachments[1] + "+" + total_attachments[2];
    return str_weapon_with_attachments;
  }

  return str_weapon_with_attachments;
}

get_forced_attachment(str_weapon, str_faction, str_class) {
  forced_attachment = anim._attachment_forced_banned[str_faction][str_class]["forced"];

  if(!isDefined(str_weapon))
    return forced_attachment;

  if(isDefined(forced_attachment) && isinarray(anim._assignable_attachments[str_weapon], forced_attachment))
    return forced_attachment;

  return undefined;
}

get_banned_attachment(str_weapon, str_faction, str_class) {
  banned_attachment = anim._attachment_forced_banned[str_faction][str_class]["banned"];

  if(isDefined(banned_attachment) && isinarray(anim._assignable_attachments[str_weapon], banned_attachment))
    return banned_attachment;

  return undefined;
}

get_next_compatible_attachment(weapon_attachments, attachment, total_attachments) {
  compatible_attachment = undefined;
  available_compatible_attachments = anim._attachments_compatible[attachment];
  available_compatible_attachments = array_exclude(available_compatible_attachments, attachment);

  if(available_compatible_attachments.size > 0) {
    for(;;) {
      if(weapon_attachments.size <= 0) {
        break;
      }

      temp_attachment = random(weapon_attachments);
      compatibility_score = 0;
      compatibility_score_needed = total_attachments.size + 1;

      if(isinarray(available_compatible_attachments, temp_attachment)) {
        compatibility_score++;

        for(i = 0; i < total_attachments.size; i++) {
          if(isinarray(anim._attachments_compatible[total_attachments[i]], temp_attachment))
            compatibility_score++;
        }

        assert(compatibility_score <= compatibility_score_needed);

        if(compatibility_score == compatibility_score_needed) {
          compatible_attachment = temp_attachment;
          break;
        }
      }

      weapon_attachments = array_exclude(weapon_attachments, temp_attachment);
    }
  }

  return compatible_attachment;
}

add_assignable_camo(assignable_camos) {
  for(i = 0; i < assignable_camos.size; i++) {
    camo_index = get_camo_index_for_camo(assignable_camos[i]);
    anim._assignable_level_camos[i] = camo_index;
  }
}

get_camo_index_for_camo(camo_name) {
  for(i = 0; i < anim._assignable_camos.size; i++) {
    if(anim._assignable_camos[i] == camo_name)
      return anim._assignable_camos_index[i];
  }

  assertmsg("Unsupported camo type " + camo_name);
}

get_camo_name_for_index(camo_index) {
  for(i = 0; i < anim._assignable_camos_index.size; i++) {
    if(anim._assignable_camos_index[i] == camo_index)
      return anim._assignable_camos[i];
  }
}

assign_camo_init() {
  anim._assignable_camos = [];
  anim._assignable_camos_index = [];
  anim._assignable_level_camos = [];

  for(i = 0; i <= 73; i++) {
    if(isDefined(tablelookupcolumnforrow("sp/attachmentTable.csv", i, 1)) && tablelookupcolumnforrow("sp/attachmentTable.csv", i, 1) == "camo") {
      camo_name = tablelookupcolumnforrow("sp/attachmentTable.csv", i, 4);

      if(camo_name != "camo_gold" && camo_name != "camo_carbon" && camo_name != "camo_jungle_tiger") {
        anim._assignable_camos[anim._assignable_camos.size] = camo_name;
        anim._assignable_camos_index[anim._assignable_camos_index.size] = int(tablelookupcolumnforrow("sp/attachmentTable.csv", i, 12));
      }
    }
  }
}

set_random_camo_drop() {
  while(isDefined(self)) {
    self waittill("dropweapon", weapon);

    if(randomint(100) > 25) {
      break;
    }

    if(!isDefined(weapon) || !isDefined(weapon.classname)) {
      break;
    }

    if(anim._assignable_level_camos.size > 0) {
      random_camo_id = anim._assignable_level_camos[randomintrange(0, anim._assignable_level_camos.size)];

      random_camo_name = get_camo_name_for_index(random_camo_id);
      println("Dropping weapon " + weapon.classname + " with camo " + random_camo_name);

      weapon itemweaponsetoptions(random_camo_id);
    } else {
      random_camo_id = random(anim._assignable_camos_index);
      random_camo_name = get_camo_name_for_index(random_camo_id);
      println("Dropping weapon " + weapon.classname + " with camo " + random_camo_name);
      weapon itemweaponsetoptions(random_camo_id);

    }
  }
}