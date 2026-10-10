/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\cp_merits.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp\cp_hud_message;
#using scripts\cp\cp_hud_util;
#using scripts\cp\persistence;
#using scripts\cp\rank;
#using scripts\cp\utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;
#namespace cp_merits;

function init() {
  precachestring(&"CP_MERIT_COMPLETED");

  if(!mayprocessmerits()) {
    return;
  }

  level.meritcallbacks = [];
  registermeritcallback("enemyKilled", &mt_kills);
  level thread onplayerconnect();
}

function mayprocessmerits() {
  return false;
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", player);

    if(!isDefined(player.pers["postGameMerits"])) {
      player.pers["postGameMerits"] = 0;
    }

    player thread initmeritdata();

    if(isai(player)) {
      continue;
    }

    player thread monitoradstime();
  }
}

function initmeritdata() {
  self.pers["lastBulletKillTime"] = 0;
  self.pers["bulletStreak"] = 0;
  self.explosiveinfo = [];
}

function registermeritcallback(callback, func) {
  if(!isDefined(level.meritcallbacks[callback])) {
    level.meritcallbacks[callback] = [];
  }

  level.meritcallbacks[callback][level.meritcallbacks[callback].size] = func;
}

function getmeritstatus(name) {
  assertex(isDefined(self.meritdata), "Player: " + self.name + " doesnt have merit data.");

  if(isDefined(self.meritdata[name])) {
    return self.meritdata[name];
  }

  return 0;
}

function mt_kills(data, time) {
  player = data.attacker;
  victim = data.victim;

  if(!isDefined(player) || !isPlayer(player)) {
    return;
  }

  player processmerit("mt_kills");
}

function enemykilled(einflictor, attacker, idamage, smeansofdeath, sweapon, sprimaryweapon, shitloc, modifiers) {
  self endon("disconnect");
  data = spawnStruct();
  data.victim = self;
  data.einflictor = einflictor;
  data.attacker = attacker;
  data.idamage = idamage;
  data.smeansofdeath = smeansofdeath;
  data.sweapon = sweapon;
  data.sprimaryweapon = sprimaryweapon;
  data.shitloc = shitloc;
  data.time = gettime();
  data.modifiers = modifiers;
  data.victimonground = data.victim isonground();
  domeritcallback("enemyKilled", data);
  data.attacker notify("playerKilledMeritsProcessed");
}

function domeritcallback(callback, data) {
  if(!mayprocessmerits()) {
    return;
  }

  if(isDefined(data)) {
    player = data.player;

    if(!isDefined(player)) {
      player = data.attacker;
    }

    if(isDefined(player) && isai(player)) {
      return;
    }
  }

  if(getdvarint(@ "hash_d498f433e251489") > 0) {
    return;
  }

  if(!isDefined(level.meritcallbacks[callback])) {
    return;
  }

  if(isDefined(data)) {
    for(i = 0; i < level.meritcallbacks[callback].size; i++) {
      thread[[level.meritcallbacks[callback][i]]](data);
    }

    return;
  }

  for(i = 0; i < level.meritcallbacks[callback].size; i++) {
    thread[[level.meritcallbacks[callback][i]]]();
  }
}

function process_agent_on_killed_merits(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration) {
  if(!isDefined(eattacker)) {
    return;
  }

  if(!isPlayer(eattacker)) {
    if(isDefined(eattacker.owner) && isPlayer(eattacker.owner)) {
      eattacker = eattacker.owner;
    } else {
      return;
    }
  }

  weapclass = getweaponclass(sweapon);
  islaststand = istrue(eattacker.inlaststand);
  bulletdamage = isbulletdamage(smeansofdeath);
  stance = eattacker getstance();
  species = self.species;
  iscrouched = stance == "crouch";
  var_30c9316fab2dde21 = stance == "prone" && !islaststand;
  isexplosive = isexplosivedamagemod(smeansofdeath);
  ismelee = smeansofdeath == "MOD_MELEE";
  var_a299bfe05dff1299 = (istrue(self.is_burning) || istrue(self.is_chem_burning)) && (!bulletdamage || sweapon.basename == "incendiary_ammo_mp");
  iscrawler = istrue(self.dismember_crawl);
  var_dac3f5acb59ac043 = istrue(self.shockmelee);
  issliding = eattacker issprintsliding();
  var_14325ba4de8139af = istrue(self.faf_burned_out);

  if(isDefined(einflictor.owner)) {
    var_ca9c5794324e530a = eattacker is_trap(einflictor, sweapon) && einflictor.owner == eattacker;
  } else {
    var_ca9c5794324e530a = eattacker is_trap(einflictor, sweapon);
  }

  var_8dc6916f38c01584 = 0;

  if(isDefined(level.all_magic_weapons)) {
    foreach(weapon in getarraykeys(level.all_magic_weapons)) {
      if(getrawbaseweaponname(sweapon) == weapon) {
        var_8dc6916f38c01584 = 1;
        break;
      }
    }
  }

  isworweapon = isDefined(sweapon) && (sweapon.basename == "iw7_dischorddummy_zm" || sweapon.basename == "iw7_facemelterdummy_zm" || sweapon.basename == "iw7_headcutterdummy_zm" || sweapon.basename == "iw7_shredderdummy_zm");
  var_5fd80a11f88edce0 = undefined;

  if(isDefined(sweapon)) {
    var_5fd80a11f88edce0 = getrawbaseweaponname(sweapon);
  }

  var_bfe7efc478e5ce70 = isDefined(var_5fd80a11f88edce0) && (var_5fd80a11f88edce0 == "harpoon1" || var_5fd80a11f88edce0 == "harpoon2" || var_5fd80a11f88edce0 == "harpoon3" || var_5fd80a11f88edce0 == "harpoon4");

  if(var_8dc6916f38c01584) {
    if(issubstr(sweapon.basename, "g18_")) {
      var_8dc6916f38c01584 = isDefined(eattacker.has_replaced_starting_pistol);
    }
  }

  if(isexplosive) {
    if(issubstr(sweapon.basename, "shuriken")) {
      isexplosive = 0;
    } else if(istrue(eattacker.kung_fu_mode)) {
      isexplosive = 0;
    }
  }

  var_1c2f77baf47fdc46 = sweapon.classname == "weapon_sniper" && bulletdamage;
  headshot = bulletdamage && isheadshot(sweapon, shitloc, smeansofdeath, eattacker);

  if(!ismelee) {
    switch (weapclass) {
      case #"hash_8af0086b038622b5":
      case #"hash_dd616da0b395a0b0":
        eattacker processmerit("mt_ar_kills");
        break;
      case #"hash_ab10f9c080fe4faf":
        eattacker processmerit("mt_smg_kills");
        break;
      case #"hash_bef5ec0b3e197ae":
        eattacker processmerit("mt_lmg_kills");
        break;
      case #"hash_16cf6289ab06bd30":
        eattacker processmerit("mt_shotgun_kills");
        break;
      case #"hash_47368bc0d2ef1565":
      case #"hash_c095d67337b1f5a1":
        eattacker processmerit("mt_sniper_kills");
        break;
      case #"hash_34340d457a63e7f1":
        eattacker processmerit("mt_pistol_kills");
        break;
      case #"hash_f4cd588fc5c3d2d5":
        if(isworweapon) {
          eattacker processmerit("mt_pistol_kills");
        }

        break;
      default:
        break;
    }
  }

  if(isexplosive) {
    eattacker processmerit("mt_explosive_kills");
  }

  if(ismelee) {
    eattacker processmerit("mt_melee_kills");
  }

  if(var_a299bfe05dff1299) {
    eattacker processmerit("mt_fire_kills");
  }

  if(var_ca9c5794324e530a) {
    eattacker processmerit("mt_trap_kills");
  }

  if(var_8dc6916f38c01584) {
    eattacker processmerit("mt_magic_weapon_kills");
  }

  if(headshot) {
    eattacker processmerit("mt_headshot_kills");
  }

  if(iscrawler) {
    eattacker processmerit("mt_crawler_kills");
  }

  if(var_dac3f5acb59ac043) {
    eattacker processmerit("mt_faf_shock_melee_kills");
  }

  if(issliding) {
    eattacker processmerit("mt_sliding_kills");
  }

  if(isworweapon || var_bfe7efc478e5ce70) {
    eattacker processmerit("mt_quest_weapon_kills");
  }

  if(var_14325ba4de8139af && var_a299bfe05dff1299) {
    eattacker processmerit("mt_faf_burned_out_kills");
  }

  var_1cdde5644733a935 = sweapon.basename;

  if(getDvar(@ "ui_mapname") == "cp_rave") {
    if(isDefined(self.agent_type) && self.agent_type == "zombie_sasquatch") {
      eattacker processmerit("mt_dlc1_sasquatch_kills");
    }

    if(ismelee) {
      if(var_1cdde5644733a935 == "iw7_golf_club_mp" || var_1cdde5644733a935 == "iw7_golf_club_mp_pap1" || var_1cdde5644733a935 == "iw7_golf_club_mp_pap2") {
        eattacker processmerit("mt_dlc1_golf_kills");
      } else if(var_1cdde5644733a935 == "iw7_spiked_bat_mp" || var_1cdde5644733a935 == "iw7_spiked_bat_mp_pap1" || var_1cdde5644733a935 == "iw7_spiked_bat_mp_pap2") {
        eattacker processmerit("mt_dlc1_bat_kills");
      } else if(var_1cdde5644733a935 == "iw7_machete_mp" || var_1cdde5644733a935 == "iw7_machete_mp_pap1" || var_1cdde5644733a935 == "iw7_machete_mp_pap2") {
        eattacker processmerit("mt_dlc1_machete_kills");
      } else if(var_1cdde5644733a935 == "iw7_two_headed_axe_mp" || var_1cdde5644733a935 == "iw7_two_headed_axe_mp_pap1" || var_1cdde5644733a935 == "iw7_two_headed_axe_mp_pap2") {
        eattacker processmerit("mt_dlc1_axe_kills");
      } else if(var_1cdde5644733a935 == "iw7_lawnmower_zm") {
        eattacker processmerit("mt_dlc1_lawnmower_kills");
      }
    }

    if(issubstr(var_1cdde5644733a935, "harpoon")) {
      eattacker processmerit("mt_dlc1_harpoon_kills");
    }

    if(istrue(eattacker.rave_mode)) {
      eattacker processmerit("mt_dlc1_kills_in_rave");
    }
  }

  if(getDvar(@ "ui_mapname") == "cp_disco") {
    if(var_1cdde5644733a935 == "iw7_katana_zm_pap2+camo222" || var_1cdde5644733a935 == "iw7_katana_windforce_zm") {
      eattacker processmerit("mt_dlc2_pap2_katana");
    } else if(var_1cdde5644733a935 == "iw7_nunchucks_zm_pap2+camo222") {
      eattacker processmerit("mt_dlc2_pap2_nunchucks");
    } else if(var_1cdde5644733a935 == "heart_cp") {
      eattacker processmerit("mt_dlc2_heart_kills");
    }

    if(isDefined(self.agent_type) && self.agent_type == "skater") {
      eattacker processmerit("mt_dlc2_roller_skaters");
    }

    if(var_ca9c5794324e530a) {
      eattacker processmerit("mt_dlc2_trap_kills");
      return;
    }

    if(istrue(eattacker.kung_fu_mode) && !is_crafted_trap_damage(var_1cdde5644733a935)) {
      if(eattacker.kungfu_style == "dragon") {
        eattacker processmerit("mt_dlc2_dragon_kills");
        return;
      }

      if(eattacker.kungfu_style == "crane") {
        eattacker processmerit("mt_dlc2_crane_kills");
        return;
      }

      if(eattacker.kungfu_style == "snake") {
        eattacker processmerit("mt_dlc2_snake_kills");
        return;
      }

      if(eattacker.kungfu_style == "tiger") {
        eattacker processmerit("mt_dlc2_tiger_kills");
      }
    }
  }
}

function is_crafted_trap_damage(sweapon) {
  if(!isDefined(sweapon)) {
    return false;
  }

  switch (sweapon) {
    case #"hash_2b93c036ba32774e":
    case #"hash_2bf090abb36a3851":
    case #"hash_a08e43b62451b1cc":
    case #"hash_c564d8bb6646922a":
    case #"hash_d0e66ab0917dc223":
      return true;
  }

  return false;
}

function processmerit(basename, var_5547e31d3c38b912, var_d1de6d2762880aa3) {
  if(!mayprocessmerits()) {
    return;
  }

  if(!isPlayer(self) || isai(self)) {
    return;
  }

  if(!isDefined(var_5547e31d3c38b912)) {
    var_5547e31d3c38b912 = 1;
  }

  if(!havedataformerit(basename)) {
    return;
  }

  meritstatus = getmeritstatus(basename);

  if(meritstatus == 5) {
    return;
  }

  var_b9654b45cf962022 = isDefined(level.meritinfo[basename]["operation"]);

  if(meritstatus > level.meritinfo[basename]["targetval"].size) {
    var_855ad017459d2163 = meritstatus == level.meritinfo[basename]["targetval"].size + 1;
    var_525fbd5628b3cdfc = isDefined(self.operationsmaxed) && isDefined(self.operationsmaxed[basename]);

    if(var_855ad017459d2163 && !var_525fbd5628b3cdfc) {
      meritstatus = level.meritinfo[basename]["targetval"].size;
    } else {
      return;
    }
  }

  if(getdvarint(@ "hash_8e049fc95397bd80")) {
    println("<dev string:x1c>" + basename + "<dev string:x2e>" + var_5547e31d3c38b912);
  }

  currentprogress = mt_getprogress(basename);
  var_51c6029a1deceecf = level.meritinfo[basename]["targetval"][meritstatus];

  if(!isDefined(var_51c6029a1deceecf)) {
    return;
  }

  if(isDefined(var_d1de6d2762880aa3) && var_d1de6d2762880aa3) {
    newprogress = var_5547e31d3c38b912;
    assertex(newprogress >= currentprogress, "Attempted progress regression (forceSet) for merit '" + basename + "' - from " + currentprogress + " to " + newprogress + " for player " + self.name);
  } else {
    newprogress = currentprogress + var_5547e31d3c38b912;
    assertex(newprogress >= currentprogress, "Attempted progress regression (inc) for merit '" + basename + "' - from " + currentprogress + " to " + newprogress + " for player " + self.name);
  }

  var_9a878a363b637930 = 0;

  if(newprogress >= var_51c6029a1deceecf) {
    var_d3249e7c7b32f8a5 = 1;
    var_9a878a363b637930 = newprogress - var_51c6029a1deceecf;
    newprogress = var_51c6029a1deceecf;
    assertex(newprogress >= currentprogress, "Attempted progress regression (tiered up) for merit '" + basename + "' - from " + currentprogress + " to " + newprogress + " for player " + self.name);
  } else {
    var_d3249e7c7b32f8a5 = 0;
  }

  if(currentprogress < newprogress) {
    mt_setprogress(basename, newprogress);
  }

  if(var_d3249e7c7b32f8a5) {
    thread giverankxpafterwait(basename, meritstatus);
    storecompletedmerit(basename);
    givemeritscore(level.meritinfo[basename]["score"][meritstatus]);
    meritstatus++;
    mt_setstate(basename, meritstatus);
    self.meritdata[basename] = meritstatus;
    thread scripts\cp\cp_hud_message::showchallengesplash(basename);

    if(areallmerittierscomplete(basename)) {
      processmastermerit(basename);
    }
  }
}

function areallmerittierscomplete(baseref) {
  if(self.meritdata[baseref] >= level.meritinfo[baseref]["targetval"].size) {
    return true;
  }

  return false;
}

function get_table_name() {
  return "mp/splashtable.csv";
}

function storecompletedmerit(basename) {
  if(!isDefined(self.meritscompleted)) {
    self.meritscompleted = [];
  }

  var_4db060099c213256 = 0;

  foreach(merit in self.meritscompleted) {
    if(merit == basename) {
      var_4db060099c213256 = 1;
    }
  }

  if(!var_4db060099c213256) {
    self.meritscompleted[self.meritscompleted.size] = basename;
  }
}

function storecompletedoperation(basename) {
  if(!isDefined(self.operationscompleted)) {
    self.operationscompleted = [];
  }

  var_4db060099c213256 = 0;

  foreach(merit in self.operationscompleted) {
    if(merit == basename) {
      var_4db060099c213256 = 1;
      break;
    }
  }

  if(!var_4db060099c213256) {
    self.operationscompleted[self.operationscompleted.size] = basename;
  }
}

function giverankxpafterwait(basename, meritstatus) {
  self endon("disconnect");
  wait 0.25;
  scripts\cp\persistence::give_player_xp(int(level.meritinfo[basename]["reward"][meritstatus]));
  event = basename;

  if(!isxhash(event)) {
    event = function_1823ff50bb28148d(event);
  }

  scripts\cp\rank::giverankxp(event, level.meritinfo[basename]["reward"][meritstatus], undefined);
}

function givemeritscore(score) {
  oldscore = self getplayerdata("cp", "challengeScore");

  if(isDefined(oldscore)) {
    self setplayerdata("cp", "challengeScore", oldscore + score);
  }
}

function updatemerits() {
  self.meritdata = [];
  self endon("disconnect");

  if(!mayprocessmerits()) {
    return;
  }

  var_c3f135bd4e0369d = 0;

  foreach(var_6018f069f73d44ef, var_edbadd21d896c7f6 in level.meritinfo) {
    var_c3f135bd4e0369d++;

    if(var_c3f135bd4e0369d % 20 == 0) {
      wait 0.05;
    }

    self.meritdata[var_6018f069f73d44ef] = 0;
    assertex(isDefined(var_edbadd21d896c7f6["type"]), "merit type not defined: " + var_6018f069f73d44ef + " for player " + self.name + " from " + level.meritinfo.size + " total merits");
    assertex(isDefined(var_edbadd21d896c7f6["index"]), "merit index not defined: " + var_6018f069f73d44ef + " for player " + self.name + " from " + level.meritinfo.size + " total merits");
    var_4a7c87e047957cc2 = var_edbadd21d896c7f6["index"];
    status = mt_getstate(var_6018f069f73d44ef);
    self.meritdata[var_6018f069f73d44ef] = status;
  }
}

function getmeritfilter(var_3f4fbf6dc9b74f9d) {
  return tablelookup("cp/allMeritsTable.csv", 0, var_3f4fbf6dc9b74f9d, 5);
}

function isweaponmerit(var_3f4fbf6dc9b74f9d) {
  if(!isDefined(var_3f4fbf6dc9b74f9d)) {
    return false;
  }

  var_2bb98e30b07f3168 = getmeritfilter(var_3f4fbf6dc9b74f9d);

  if(isDefined(var_2bb98e30b07f3168)) {
    return true;
  }

  return false;
}

function getweaponfrommerit(var_6018f069f73d44ef) {
  assertex(isweaponmerit(var_6018f069f73d44ef), var_6018f069f73d44ef + " is not a weapon merit!");
  return getmeritfilter(var_6018f069f73d44ef);
}

function isoperationmerit(var_6018f069f73d44ef) {
  if(!isDefined(var_6018f069f73d44ef)) {
    return false;
  }

  var_2bb98e30b07f3168 = getmeritfilter(var_6018f069f73d44ef);

  if(isDefined(var_2bb98e30b07f3168)) {
    if(var_2bb98e30b07f3168 == "perk_slot_0" || var_2bb98e30b07f3168 == "perk_slot_1" || var_2bb98e30b07f3168 == "perk_slot_2" || var_2bb98e30b07f3168 == "proficiency" || var_2bb98e30b07f3168 == "equipment" || var_2bb98e30b07f3168 == "special_equipment" || var_2bb98e30b07f3168 == "attachment" || var_2bb98e30b07f3168 == "prestige" || var_2bb98e30b07f3168 == "final_killcam" || var_2bb98e30b07f3168 == "basic" || var_2bb98e30b07f3168 == "humiliation" || var_2bb98e30b07f3168 == "precision" || var_2bb98e30b07f3168 == "revenge" || var_2bb98e30b07f3168 == "elite" || var_2bb98e30b07f3168 == "intimidation" || var_2bb98e30b07f3168 == "operations" || isstrstart(var_2bb98e30b07f3168, "killstreaks_")) {
      return true;
    }
  }

  if(isweaponmerit(var_6018f069f73d44ef)) {
    return true;
  }

  return false;
}

function merit_targetval(tablename, refstring, var_f1d895eb26aebad0) {
  value = tablelookup(tablename, 0, refstring, 10 + var_f1d895eb26aebad0 * 3);
  return int(value);
}

function merit_rewardval(tablename, refstring, var_f1d895eb26aebad0) {
  value = tablelookup(tablename, 0, refstring, 11 + var_f1d895eb26aebad0 * 3);
  return int(value);
}

function merit_scoreval(tablename, refstring, var_f1d895eb26aebad0) {
  value = tablelookup(tablename, 0, refstring, 12 + var_f1d895eb26aebad0 * 3);
  return int(value);
}

function buildmerittableinfo(tablename, typeid) {
  index = 0;
  var_94cabb8b012f1dd6 = 0;

  for(index = 0; true; index++) {
    refstring = tablelookupbyrow(tablename, index, 0);

    if(refstring == "") {
      break;
    }

    assertex(issubstr(refstring, "mt_"), "Invalid merit name: " + refstring + " found in " + tablename);
    mastermerit = getmeritmasterchallenge(refstring);
    level.meritinfo[refstring] = [];
    level.meritinfo[refstring]["index"] = index;
    level.meritinfo[refstring]["type"] = typeid;
    level.meritinfo[refstring]["targetval"] = [];
    level.meritinfo[refstring]["reward"] = [];
    level.meritinfo[refstring]["score"] = [];
    level.meritinfo[refstring]["filter"] = getmeritfilter(refstring);
    level.meritinfo[refstring]["master"] = mastermerit;

    if(isoperationmerit(refstring)) {
      level.meritinfo[refstring]["operation"] = 1;
      level.meritinfo[refstring]["spReward"] = [];

      if(isweaponmerit(refstring)) {
        baseweapon = getweaponfrommerit(refstring);

        if(isDefined(baseweapon)) {
          level.meritinfo[refstring]["weapon"] = baseweapon;
        }
      }
    }

    for(var_f1d895eb26aebad0 = 0; var_f1d895eb26aebad0 < 5; var_f1d895eb26aebad0++) {
      targetval = merit_targetval(tablename, refstring, var_f1d895eb26aebad0);
      rewardval = merit_rewardval(tablename, refstring, var_f1d895eb26aebad0);
      scoreval = merit_scoreval(tablename, refstring, var_f1d895eb26aebad0);

      if(targetval == 0) {
        break;
      }

      level.meritinfo[refstring]["targetval"][var_f1d895eb26aebad0] = targetval;
      level.meritinfo[refstring]["reward"][var_f1d895eb26aebad0] = rewardval;
      level.meritinfo[refstring]["score"][var_f1d895eb26aebad0] = scoreval;
      var_94cabb8b012f1dd6 += rewardval;
    }

    refstring = tablelookupbyrow(tablename, index, 0);
  }

  println("<dev string:x31>" + index - 1 + "<dev string:x38>" + tablename);
  return int(var_94cabb8b012f1dd6);
}

function buildmeritinfo() {
  if(getDvar(@ "hash_e6afce2cf5cf7515") == "<dev string:x46>") {
    return;
  }

  level.meritinfo = [];
  var_94cabb8b012f1dd6 = 0;
  var_94cabb8b012f1dd6 += buildmerittableinfo("cp/allMeritsTable.csv", 0);
  println("<dev string:x48>" + var_94cabb8b012f1dd6);
}

function ismeritunlocked(var_3f4fbf6dc9b74f9d) {
  filter = level.meritinfo[var_3f4fbf6dc9b74f9d]["filter"];

  if(!isDefined(filter)) {
    return 1;
  }

  return self isitemunlocked(filter, "challenge");
}

function havedataformerit(var_3f4fbf6dc9b74f9d) {
  return isDefined(level.meritinfo) && isDefined(level.meritinfo[var_3f4fbf6dc9b74f9d]);
}

function getmeritmasterchallenge(challengename) {
  value = tablelookup("cp/allMeritsTable.csv", 0, challengename, 7);

  if(isDefined(value) && value == "") {
    return undefined;
  }

  return value;
}

function processmastermerit(rootname) {
  var_2bb10804512bf4d1 = level.meritinfo[rootname]["master"];

  if(isDefined(var_2bb10804512bf4d1)) {
    thread processmerit(var_2bb10804512bf4d1);
  }
}

function function_8f949f92c28ed2eb(percentage) {
  foreach(var_6018f069f73d44ef, meritdata in level.meritinfo) {
    finaltarget = 0;
    var_3713c3f8a9d51303 = 0;

    for(var_f1d895eb26aebad0 = 1; isDefined(meritdata["<dev string:x60>"][var_f1d895eb26aebad0]); var_f1d895eb26aebad0++) {
      finaltarget = meritdata["<dev string:x60>"][var_f1d895eb26aebad0];
      var_3713c3f8a9d51303 = var_f1d895eb26aebad0 + 1;
    }

    if(percentage != 1) {
      finaltarget--;
      var_3713c3f8a9d51303--;
    }

    if(matchmakinggame()) {
      if(self isitemunlocked(var_6018f069f73d44ef, "<dev string:x6a>") || percentage == 1) {
        self setplayerdata("<dev string:x71>", "<dev string:x74>", var_6018f069f73d44ef, finaltarget);
        self setplayerdata("<dev string:x71>", "<dev string:x82>", var_6018f069f73d44ef, var_3713c3f8a9d51303);
      }
    } else {
      actiondata = spawnStruct();
      actiondata.name = var_6018f069f73d44ef;
      actiondata.type = tablelookup(get_table_name(), 0, var_6018f069f73d44ef, 11);
      actiondata.optionalnumber = var_3713c3f8a9d51303;
      actiondata.sound = tablelookup(get_table_name(), 0, var_6018f069f73d44ef, 9);
      actiondata.slot = 1;
      thread scripts\cp\cp_hud_message::showchallengesplash(var_6018f069f73d44ef);
    }

    wait 0.05;
  }

  println("<dev string:x8d>");
}

function monitoradstime() {
  self endon("disconnect");
  self.adstime = 0;

  while(true) {
    if(self playerads() == 1) {
      self.adstime += 0.05;
    } else {
      self.adstime = 0;
    }

    wait 0.05;
  }
}