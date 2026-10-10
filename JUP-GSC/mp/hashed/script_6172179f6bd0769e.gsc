/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6172179f6bd0769e.gsc
*************************************************/

#using script_24fbedba9a7a1ef4;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\utility\game_utility;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\gametypes\br_bosses;
#using scripts\mp\juggernaut;
#namespace namespace_66419bf0e1470e9d;

function function_4c60c607a6e7b9ae() {
  bossdetails = spawnStruct();
  bossdetails.spawnlocs = [];
  bossdetails.name = "mi8jugg";
  bossdetails.uiname = "MP_DMZ_MISSIONS/DMZ_BOSS_JUGG_NAME";
  bossdetails.initfunc = &function_d05835744ff53415;
  bossdetails.spawnfunc = &function_7f6818be5068dd4e;
  bossdetails.var_e68429b39c75b6ee = &function_7f6818be5068dd4e;
  bossdetails.var_4ea49a8926593523 = &function_b97f2c6555713007;
  scripts\mp\gametypes\br_bosses::registerboss(bossdetails);
}

function function_d05835744ff53415(bossdetails) {
  level.var_7d967b9b6bb9f893 = getdvarint(@ "hash_6fed3b4aab176fe6", 2);
  level.var_e533ab5ac1ba434b = 0;
  level.var_1ab6cf2d7f3a688 = getdvarfloat(@ "hash_1099eba3fc541217", 0);
  level.var_1ab6cf2d7f3a688 *= level.var_1ab6cf2d7f3a688;
  level.var_5463147f04a33d36 = getdvarfloat(@ "hash_86e760e453e4b70b", 2500);
  level.var_a4123e1a53dea557 = getdvarint(@ "hash_86c85cfc843c0b68", 1);
  level.var_d49c99ad85354bd6 = getdvarint(@ "hash_a433661e4f79e427", 100);
}

function function_7f6818be5068dd4e(node, category) {
  if(!isDefined(category)) {
    category = "elites";
  }

  aitype = undefined;
  var_bdab149ba0058e5a = level.var_13819795c6ee9ff8;

  if(category == "gulag") {
    aitype = "enemy_mp_jugg_gulag";
    var_bdab149ba0058e5a = ["neckguard", "backpack", "shoulderpad_l", "shoulderpad_r", "qamis", "thighpad_l", "thighpad_r"];
  } else {
    aitype = scripts\mp\ai_mp_controller::function_7f1a2e2ebe0c1693("jugg");
  }

  jugg = scripts\mp\ai_mp_controller::ai_mp_requestspawnagent(aitype, node.origin, node.angles, "absolute", category, "jugg", undefined, undefined, undefined, node.poi, 1, 0, 0);
  weapon = undefined;
  scripts\cp_mp\agents\agent_utils::function_e43f4000cac35ba2(jugg, weapon);
  jugg scripts\cp_mp\agents\agent_utils::function_1c3709e864d4e8d5(1);
  juggcontext = spawnStruct();
  juggcontext.partshealth = [];
  juggcontext.partshealth["head_health"] = 100;
  juggcontext.partshealth["damaged_helmet_health"] = 100;
  juggcontext.partshealth["torso_upper_health"] = 100;
  juggcontext.partshealth["torso_lower_health"] = 100;
  juggcontext.partshealth["right_upper_arm_health"] = 100;
  juggcontext.partshealth["right_lower_arm_health"] = 100;
  juggcontext.partshealth["left_upper_arm_health"] = 100;
  juggcontext.partshealth["left_lower_arm_health"] = 100;
  juggcontext.partshealth["right_leg_health"] = 100;
  juggcontext.partshealth["left_leg_health"] = 100;
  juggcontext.var_5f03cad2b199e1bc = &function_504b9ffb4562c0bc;
  juggcontext.lastpaintime = 0;
  juggcontext.paindamage = 0;
  juggcontext.var_1bea7c00eb868a40 = 6000;
  juggcontext.paincooldown = 20000;
  juggcontext.paindecay = 10;
  juggcontext.paindecaytime = 0.1;
  juggcontext.lastdamagedtime = 0;
  juggcontext.var_a4dceeab66ec6a3c = 250;
  jugg.juggcontext = juggcontext;
  jugg scripts\mp\juggernaut::function_8e6b2de818370baa(var_bdab149ba0058e5a, "pristine");
  jugg.bosstype = "mi8jugg";
  jugg scripts\mp\gametypes\br_bosses::function_720c3b7abf4baac8("mi8jugg");
  return jugg;
}

function function_b97f2c6555713007() {
  level endon("game_ended");
  scripts\mp\gametypes\br_bosses::function_c0d4fda4400b5a08("mi8jugg");
}

function function_9188f360f73c894a(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  if(level.var_a4123e1a53dea557 == 1) {
    overflow = idamage - level.var_d49c99ad85354bd6;

    if(overflow > 0) {
      idamage = level.var_d49c99ad85354bd6 + sqrt(overflow);
    }
  } else {
    idamage = min(idamage, level.var_d49c99ad85354bd6);
  }

  remaininghealth = self.health - idamage;

  if(remaininghealth <= 0) {
    self notify("mi8jugg_fatal_damage");
  }

  scripts\mp\juggernaut::function_4217f11ffb352425(idamage, shitloc, smeansofdeath, eattacker);
  namespace_daa149ca485fd50a::function_dffac413ed66bcd0(einflictor, eattacker, int(idamage), idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
}

function function_504b9ffb4562c0bc(part, damage) {
  if(isDefined(part) && part == "head_health" && !isDefined(self.juggcontext.partshealth[part])) {
    if(isDefined(self.juggcontext.partshealth["damaged_helmet_health"])) {
      self.juggcontext.partshealth["damaged_helmet_health"] = self.juggcontext.partshealth["damaged_helmet_health"] - damage;

      if(self.juggcontext.partshealth["damaged_helmet_health"] <= 0) {
        self.juggcontext.partshealth["damaged_helmet_health"] = undefined;
        scripts\mp\juggernaut::function_8e6b2de818370baa("head_health", "destroyed");
      }
    }
  }
}