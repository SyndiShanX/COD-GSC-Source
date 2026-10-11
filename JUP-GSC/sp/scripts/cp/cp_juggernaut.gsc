/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\cp_juggernaut.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\challenges_cp;
#using scripts\cp\cp_accessories;
#using scripts\cp\cp_loadout;
#using scripts\cp\loadout;
#using scripts\cp\perks;
#using scripts\cp\persistence;
#using scripts\cp\utility;
#using scripts\cp\utility\player;
#using scripts\cp\weapon;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\execution;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\white_phosphorus;
#using scripts\cp_mp\playerhealth;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace cp_juggernaut;

function init() {
  level.activejuggernauts = [];
  level.var_ed61c38f5c8bb414 = ["pristine", "damaged"];
  level.var_13819795c6ee9ff8 = ["helmet", "neckguard", "backpack", "shoulderpad_l", "shoulderpad_r", "forearmpad_l", "forearmpad_r", "qamis", "thighpad_l", "thighpad_r"];

  setdevdvarifuninitialized(@ "hash_caba4093ed4a5d5d", 0);
  setdevdvarifuninitialized(@ "hash_63bf655a03b825eb", 0);
  setdevdvarifuninitialized(@ "hash_ae2c4f86ffaf24db", 0);
  setdevdvarifuninitialized(@ "hash_4f7da19a233d6916", 0);
}

function jugg_makejuggernaut(juggconfig, streakinfo) {
  assert(scripts\cp_mp\utility\player_utility::_isalive());

  if(!jugg_canresolvestance(juggconfig)) {
    return false;
  }

  self.isjuggernaut = 1;
  self.can_revive = 0;
  self.streakinfo = streakinfo;
  self.var_7269deeba689cd65 = 1;
  self clearhudtutorialmessage();
  customization = scripts\cp\loadout::getcustomization();
  juggcontext = spawnStruct();
  juggcontext.juggconfig = juggconfig;
  juggcontext.prevhealth = self.health;
  juggcontext.prevmaxhealth = self.maxhealth;
  juggcontext.prevclothtype = self.clothtype;
  juggcontext.var_aaac4cd2da0aa927 = self.geartype;
  juggcontext.prevbody = customization["body"];
  juggcontext.prevhead = customization["head"];

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.vm)) {
    juggcontext.prevviewmodel = self.operatorcustomization.vm;
  } else {
    juggcontext.prevviewmodel = self getcustomizationviewmodel();
  }

  juggcontext.prevspeedscale = self.playerstreakspeedscale;
  juggcontext.prevsuit = self.suit;
  juggcontext.prevstartingweap = scripts\cp\utility::getvalidtakeweapon();
  juggcontext.maskomnvar = "ui_gas_mask_juggernaut";
  juggcontext.head_health = ter_op(isDefined(juggconfig.head_health), juggconfig.head_health, 100);
  juggcontext.torso_upper_health = ter_op(isDefined(juggconfig.torso_upper_health), juggconfig.torso_upper_health, 100);
  juggcontext.torso_lower_health = ter_op(isDefined(juggconfig.torso_lower_health), juggconfig.torso_lower_health, 100);
  juggcontext.right_upper_arm_health = ter_op(isDefined(juggconfig.right_upper_arm_health), juggconfig.right_upper_arm_health, 100);
  juggcontext.right_lower_arm_health = ter_op(isDefined(juggconfig.right_lower_arm_health), juggconfig.right_lower_arm_health, 100);
  juggcontext.left_upper_arm_health = ter_op(isDefined(juggconfig.left_upper_arm_health), juggconfig.left_upper_arm_health, 100);
  juggcontext.left_lower_arm_health = ter_op(isDefined(juggconfig.left_lower_arm_health), juggconfig.left_lower_arm_health, 100);
  juggcontext.right_leg_health = ter_op(isDefined(juggconfig.right_leg_health), juggconfig.right_leg_health, 100);
  juggcontext.left_leg_health = ter_op(isDefined(juggconfig.left_leg_health), juggconfig.left_leg_health, 100);
  juggcontext.executionlist = ["execution_mp_juggernaut_01", "execution_mp_juggernaut_02", "execution_mp_juggernaut_03"];
  self.var_a23031c04df01bf = &function_4217f11ffb352425;
  self.disabletakecoverwarning = 1;

  if(!istrue(streakinfo.var_ca56839b2e00edce)) {
    juggconfig.maxhealth = 3000;
    self.playerstreakspeedscale = juggconfig.movespeedscalar;
  } else {
    juggconfig.maxhealth = 400;
    self.playerstreakspeedscale = juggconfig.var_9a0cea8101a4f35c;
  }

  self.jugg_health = juggconfig.maxhealth - juggcontext.prevmaxhealth;
  self.maxhealth = juggconfig.maxhealth;
  self.health = self.maxhealth;

  if(istrue(level.relic_vampire) || istrue(level.relic_healthpacks)) {
    entity_num = self getentitynumber();
    scripts\cp\persistence::setcoopplayerdata_for_everyone("EoGPlayer", entity_num, "playerMaxHealth", self.maxhealth);
  }

  jugg_handlestancechange(juggconfig);

  if(isDefined(juggconfig.classstruct) && !istrue(streakinfo.var_ca56839b2e00edce)) {
    give_minigun(juggcontext, juggconfig, 1);
  } else {
    juggconfig.allows["reload"] = 0;
    juggconfig.allows["weapon_pickup"] = 0;
    juggconfig.allows["offhand_weapons"] = 0;
    juggconfig.allows["slide"] = 0;
    juggconfig.allows["supers"] = 0;
    juggconfig.allows["prone"] = 0;
    juggconfig.allows["killstreaks"] = 0;
    juggconfig.allows["usability"] = 0;
    self setclientomnvar("ui_assault_suit_on", 1);
    self.var_ca56839b2e00edce = 1;
    scripts\cp_mp\armor::setarmorhealth(self.maxarmorhealth);
  }

  thread start_regen_early();
  jugg_toggleallows(juggconfig.allows, 0);
  scripts\cp\utility::allow_player_basejumping(0, "juggernaut");
  scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudiosupression();
  scripts\cp\loadout::updatemovespeedscale();

  if(istrue(streakinfo.var_ca56839b2e00edce)) {
    if(soundexists("cp_assault_suit_on")) {
      self playlocalsound("cp_assault_suit_on");
    }

    self forceplaygestureviewmodel("ges_magma_gas_mask_on");
    wait 0.338;
    assert(scripts\cp_mp\utility\player_utility::_isalive());
  }

  if(isDefined(juggconfig.classstruct) && !istrue(streakinfo.var_ca56839b2e00edce)) {
    jugg_setModel();
    scripts\cp\utility\player::_setsuit(juggconfig.suit);
    self.suit = juggconfig.suit;
    self setclothtype(getxhash(juggconfig.clothtype));
  } else {
    self setclothtype(#"vestheavy");
    viewmodelname = self getcustomizationviewmodel();
    scripts\cp\loadout::setcharactermodels("body_sp_opforce_shadow_company_elite_3_1", "head_sp_opforce_shadow_company_elite_1_1", "mp_vm_arms_jugg_aq_iw9_1_1");
  }

  jugg_enableoverlay(juggcontext);
  function_6afa1766e507e9d6();

  if(juggconfig.infiniteammo && !istrue(streakinfo.var_ca56839b2e00edce)) {
    thread infiniteammothread(juggconfig.infiniteammoupdaterate);
  }

  self.juggcontext = juggcontext;
  self notify("juggernaut_start");
  self notify("munitions_used", "juggernaut");
  thread carryobjects_onjuggernaut();

  if(!istrue(streakinfo.var_ca56839b2e00edce)) {
    thread jugg_watchmusictoggle();
  }

  thread jugg_watchfordeath();
  thread jugg_watchforgameend();
  thread jugg_watchfordisconnect();
  thread jugg_watchforfire();
  thread jugg_watchherodrop();
  thread function_5b7c34dbc50c3c4e();
  thread jugg_watchfordamage();
  thread jugg_watchearlyexit();

  if(!istrue(streakinfo.var_ca56839b2e00edce)) {
    thread jugg_watchfordoors();
  }

  thread function_8e8605e7b6739834();
  thread jugg_watchoverlaydamagestates(juggcontext);
  thread jugg_watchforoverlayexecutiontoggle(juggcontext);
  return true;
}

function give_minigun(juggcontext, juggconfig, var_b69f99a7a0012317) {
  if(istrue(var_b69f99a7a0012317)) {
    jugg_strip_old_weapons(self, juggcontext);
    scripts\cp\cp_loadout::assign_loadout_weapons(self, juggconfig.classstruct);
  }

  self giveweapon(self.starting_weapon);
  self setweaponammoclip(self.starting_weapon, weaponclipsize(self.starting_weapon));
  self setweaponammostock(self.starting_weapon, weaponmaxammo(self.starting_weapon));
  scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self.starting_weapon);
}

function function_8e6b2de818370baa(parts, state) {
  if(!isDefined(state)) {
    assertmsg("<dev string:x1c>");
    return;
  }

  partstoset = [];

  if(isarray(parts)) {
    partstoset = array_combine(partstoset, parts);
  } else {
    partstoset[partstoset.size] = parts;
  }

  foreach(part in partstoset) {
    self setscriptablepartstate(part, state, 0);

    iprintln("<dev string:x41>" + part + "<dev string:x4a>" + state + "<dev string:x56>");
  }
}

function private function_5b7c34dbc50c3c4e() {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  level endon("game_ended");
  function_8e6b2de818370baa(level.var_13819795c6ee9ff8, "pristine");

  childthread function_5e9c6b97e4c3c059();
  childthread function_59469cc44ca7fa81();
}

function private function_1e84eeb2a6f4129d(index) {
  return level.var_13819795c6ee9ff8[index];
}

function private function_59469cc44ca7fa81() {
  armorstate = "pristine";

  while(true) {
    var_d131f91d9bea09f3 = getdvarint(@ "hash_ae2c4f86ffaf24db", 0);

    if(!var_d131f91d9bea09f3) {
      waitframe();
      continue;
    }

    armorpart = function_1e84eeb2a6f4129d(var_d131f91d9bea09f3 - 1);

    if(armorstate == "pristine") {
      armorstate = "damaged";

      if(armorpart == "helmet") {
        armorstate = "off";
      }
    } else {
      armorstate = "pristine";
    }

    function_8e6b2de818370baa(armorpart, armorstate);
    setDvar(@ "hash_ae2c4f86ffaf24db", 0);
    waitframe();
  }
}

function private function_354f191d8b1ec22d(index) {
  return level.var_ed61c38f5c8bb414[index];
}

function private function_5e9c6b97e4c3c059() {
  juggcontext = self.juggcontext;
  juggconfig = juggcontext.juggconfig;

  while(true) {
    armorstateindex = getdvarint(@ "hash_63bf655a03b825eb", 0);

    if(!armorstateindex) {
      waitframe();
      continue;
    }

    armorstate = function_354f191d8b1ec22d(armorstateindex - 1);
    var_f05a031dc1df54df = "head_health";
    var_5aa83db0e5d721db = armorstate;

    if(armorstate == "damaged") {
      var_5aa83db0e5d721db = "destroyed";
    }

    function_8e6b2de818370baa(var_f05a031dc1df54df, var_5aa83db0e5d721db);
    helmetpart = "helmet";
    var_e0aad72b2cb25382 = armorstate;

    if(armorstate == "damaged") {
      var_e0aad72b2cb25382 = "off";
    }

    function_8e6b2de818370baa(helmetpart, var_e0aad72b2cb25382);
    partstoset = ["torso_upper_health", "torso_lower_health", "right_upper_arm_health", "right_lower_arm_health", "left_upper_arm_health", "left_lower_arm_health", "right_leg_health", "left_leg_health", "neckguard", "backpack", "shoulderpad_l", "shoulderpad_r", "forearmpad_l", "forearmpad_r", "qamis", "thighpad_l", "thighpad_r"];
    function_8e6b2de818370baa(partstoset, armorstate);

    if(armorstate == "pristine") {
      juggcontext.partshealth["head_health"] = ter_op(isDefined(juggconfig.head_health), juggconfig.head_health, 100);
      juggcontext.partshealth["torso_upper_health"] = ter_op(isDefined(juggconfig.torso_upper_health), juggconfig.torso_upper_health, 100);
      juggcontext.partshealth["torso_lower_health"] = ter_op(isDefined(juggconfig.torso_lower_health), juggconfig.torso_lower_health, 100);
      juggcontext.partshealth["right_upper_arm_health"] = ter_op(isDefined(juggconfig.right_upper_arm_health), juggconfig.right_upper_arm_health, 100);
      juggcontext.partshealth["right_lower_arm_health"] = ter_op(isDefined(juggconfig.right_lower_arm_health), juggconfig.right_lower_arm_health, 100);
      juggcontext.partshealth["left_upper_arm_health"] = ter_op(isDefined(juggconfig.left_upper_arm_health), juggconfig.left_upper_arm_health, 100);
      juggcontext.partshealth["left_lower_arm_health"] = ter_op(isDefined(juggconfig.left_lower_arm_health), juggconfig.left_lower_arm_health, 100);
      juggcontext.partshealth["right_leg_health"] = ter_op(isDefined(juggconfig.right_leg_health), juggconfig.right_leg_health, 100);
      juggcontext.partshealth["left_leg_health"] = ter_op(isDefined(juggconfig.left_leg_health), juggconfig.left_leg_health, 100);
    } else {
      juggcontext.partshealth["head_health"] = undefined;
      juggcontext.partshealth["torso_upper_health"] = undefined;
      juggcontext.partshealth["torso_lower_health"] = undefined;
      juggcontext.partshealth["right_upper_arm_health"] = undefined;
      juggcontext.partshealth["right_lower_arm_health"] = undefined;
      juggcontext.partshealth["left_upper_arm_health"] = undefined;
      juggcontext.partshealth["left_lower_arm_health"] = undefined;
      juggcontext.partshealth["right_leg_health"] = undefined;
      juggcontext.partshealth["left_leg_health"] = undefined;
    }

    setDvar(@ "hash_63bf655a03b825eb", 0);
    waitframe();
  }
}

function private function_6afa1766e507e9d6() {
  var_e56a42f6a435e1ba = ["helmet", "neckguard", "backpack", "shoulderpad_r", "shoulderpad_l", "forearmpad_r", "forearmpad_l", "qamis", "thighpad_r", "thighpad_l"];

  foreach(part in var_e56a42f6a435e1ba) {
    self setscriptablepartstate(part, "pristine", 0);
  }
}

function private function_28bda29e7db3b4ea() {
  var_e56a42f6a435e1ba = ["helmet", "neckguard", "backpack", "shoulderpad_r", "shoulderpad_l", "forearmpad_r", "forearmpad_l", "qamis", "thighpad_r", "thighpad_l"];

  foreach(part in var_e56a42f6a435e1ba) {
    self setscriptablepartstate(part, "off", 0);
  }
}

function jugg_modifyfalldamage() {
  if(istrue(self.var_ca56839b2e00edce)) {
    return;
  }

  if(self isskydiving()) {
    self skydive_interrupt();
  }

  self notify("perform_hero_drop");
  return 0;
}

function carryobjects_onjuggernaut() {
  waittillframeend();
  scripts\cp\challenges_cp::function_15c867e400749a3b();

  if(isDefined(self.carryobject)) {
    assert(self.carryobject.carrier == self);
    self switchtoweapon("iw9_lm_dblmg2_cp");
  }
}

function jugg_strip_old_weapons(player, juggcontext) {
  player scripts\cp\utility::store_weapons_status();
  player scripts\cp\cp_accessories::clearplayeraccessory();
  player takeallweapons();
}

function jugg_watchmusictoggle() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("juggernaut_end");
  audio_waittime = 0;
  self notifyonplayercommand("toggle_music", "+actionslot 3");
  self notifyonplayercommand("toggle_music", "killstreak_wheel");
  var_e5c8d9d7e001af68 = makeweapon("ks_gesture_jugg_music_mp");
  gesturefiretime = weaponfiretime(var_e5c8d9d7e001af68);

  if(!isDefined(self.musicplaying)) {
    var_aa73ba383f8079ea = self getjuggdefaultmusicenabled();
    self.musicplaying = var_aa73ba383f8079ea;
  }

  if(!istrue(self.musicplaying)) {
    self setscriptablepartstate("juggernaut", "neutral", 0);
  } else {
    self setscriptablepartstate("juggernaut", "music", 0);
  }

  while(true) {
    self waittill("toggle_music");

    if(self isonladder() || self ismantling()) {
      continue;
    }

    self giveandfireoffhand(var_e5c8d9d7e001af68);
    self playsoundonmovingent("mp_jugg_mus_toggle_foley");
    self playlocalsound("mp_jugg_mus_toggle_button");
    var_6e79fbf50c8ea64f = 0.2;

    if(istrue(self.musicplaying)) {
      var_6e79fbf50c8ea64f = 0.65;
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_6e79fbf50c8ea64f);

    if(istrue(self.musicplaying)) {
      self.musicplaying = 0;
      self setscriptablepartstate("juggernaut", "neutral", 0);
    } else {
      self.musicplaying = 1;
      self setscriptablepartstate("juggernaut", "music", 0);
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1.5);
  }
}

function function_c0aa811f7b45687c(shitloc, smeansofdeath, attacker) {
  var_1f48003b8e69560c = undefined;

  if(isheadshot(shitloc, smeansofdeath, attacker)) {
    var_1f48003b8e69560c = "head_health";
  } else if(istorsouppershot(shitloc, smeansofdeath, attacker)) {
    var_1f48003b8e69560c = "torso_upper_health";
  } else if(function_77ed09d75c0c7165(shitloc, smeansofdeath, attacker)) {
    var_1f48003b8e69560c = "torso_lower_health";
  } else if(function_24278eb0ec1e2953(shitloc, smeansofdeath, attacker)) {
    var_1f48003b8e69560c = "right_upper_arm_health";
  } else if(function_bf1efc7185168448(shitloc, smeansofdeath, attacker)) {
    var_1f48003b8e69560c = "right_lower_arm_health";
  } else if(function_82850161196df912(shitloc, smeansofdeath, attacker)) {
    var_1f48003b8e69560c = "left_upper_arm_health";
  } else if(function_d7395809e0049a49(shitloc, smeansofdeath, attacker)) {
    var_1f48003b8e69560c = "left_lower_arm_health";
  } else if(isrightlegshot(shitloc, smeansofdeath, attacker)) {
    var_1f48003b8e69560c = "right_leg_health";
  } else if(isleftlegshot(shitloc, smeansofdeath, attacker)) {
    var_1f48003b8e69560c = "left_leg_health";
  }

  if(isDefined(shitloc) && isDefined(attacker) && isPlayer(attacker)) {
    attacker iprintlnbold("<dev string:x58>" + shitloc);
  }

  return var_1f48003b8e69560c;
}

function function_4217f11ffb352425(damage, shitloc, smeansofdeath, attacker) {
  var_1f48003b8e69560c = function_c0aa811f7b45687c(shitloc, smeansofdeath, attacker);

  if(!isDefined(var_1f48003b8e69560c)) {
    if(isDefined(attacker) && isDefined(shitloc) && isPlayer(attacker)) {
      attacker iprintln("<dev string:x6f>" + shitloc);
    }

    return;
  }

  function_b47072bcd58c0c99(var_1f48003b8e69560c, damage);
}

function private function_b47072bcd58c0c99(part, damage) {
  if(isDefined(self.juggcontext.var_5f03cad2b199e1bc)) {
    self[[self.juggcontext.var_5f03cad2b199e1bc]](part, damage);
  }

  if(isDefined(self.juggcontext.partshealth[part])) {
    self.juggcontext.partshealth[part] -= damage;

    if(part == "head_health") {
      if(self.juggcontext.partshealth[part] <= 0) {
        self.juggcontext.partshealth[part] = undefined;
        function_8e6b2de818370baa(part, "destroyed");
      } else if(self.juggcontext.partshealth[part] <= 50) {
        function_8e6b2de818370baa(part, "damaged");
      }

      return;
    }

    if(self.juggcontext.partshealth[part] <= 0) {
      self.juggcontext.partshealth[part] = undefined;
      function_8e6b2de818370baa(part, "damaged");
    }
  }
}

function jugg_watchherodrop() {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  level endon("game_ended");
  juggconfig = self.juggcontext.juggconfig;
  juggconfig.herodrop = 0;

  while(true) {
    thread function_12928f267a4a789c(juggconfig);
    self waittill("perform_hero_drop");

    if(!istrue(juggconfig.herodrop)) {
      juggconfig.herodrop = 1;
      self radiusdamage(self.origin, 300, 2000, 500, self, "MOD_CRUSH");
      thread jugg_setherodropscriptable(juggconfig);
    }
  }
}

function jugg_setherodropscriptable(juggconfig) {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  level endon("game_ended");
  self setscriptablepartstate("heroDiveVfx", "impact", 0);
  wait 1;
  self setscriptablepartstate("heroDiveVfx", "off", 0);
  juggconfig.herodrop = 0;
}

function function_12928f267a4a789c(juggconfig) {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  self endon("perform_hero_drop");
  level endon("game_ended");
  droploop = 0;
  var_87bd779b6eb7ebb5 = 0.5;
  delaycounter = var_87bd779b6eb7ebb5;
  var_29c3e7e659ebd38c = getdvarint(@ "bg_falldamageminheight");

  if(!isDefined(var_29c3e7e659ebd38c)) {
    var_29c3e7e659ebd38c = 225;
  }

  while(true) {
    if(function_ba71f6475f1c75d9()) {
      delaycounter -= level.framedurationseconds;

      if(delaycounter <= 0) {
        delaycounter = 0;

        if(!istrue(droploop)) {
          var_c2d7296c1d69dc0f = scripts\engine\trace::ray_trace_passed(self.origin, self.origin - (0, 0, var_29c3e7e659ebd38c), self);

          if(istrue(var_c2d7296c1d69dc0f)) {
            droploop = 1;
            self setscriptablepartstate("heroDiveVfx", "falling", 0);
          }
        }
      }
    } else if(istrue(droploop) && !istrue(juggconfig.herodrop)) {
      droploop = 0;
      delaycounter = var_87bd779b6eb7ebb5;
      self setscriptablepartstate("heroDiveVfx", "off", 0);
    }

    waitframe();
  }
}

function function_ba71f6475f1c75d9() {
  if(self ismantling()) {
    return false;
  }

  if(self isonladder()) {
    return false;
  }

  if(scripts\cp_mp\utility\player_utility::isinvehicle(1)) {
    return false;
  }

  if(!self isonground()) {
    if(self isparachuting()) {
      return false;
    }

    if(self isswimming()) {
      return false;
    }

    return true;
  }

  return false;
}

function jugg_watchforgameend() {
  self endon("juggernaut_end");
  juggcontext = self.juggcontext;
  level waittill("game_ended");
  self.maxhealth = juggcontext.prevmaxhealth;
  self.health = juggcontext.prevhealth;
  jugg_disableoverlay(juggcontext);
}

function jugg_watchfordisconnect() {
  self endon("juggernaut_end");
  juggcontext = self.juggcontext;
  self waittill("disconnect");

  if(isDefined(self)) {
    self.maxhealth = juggcontext.prevmaxhealth;
    self.health = juggcontext.prevhealth;
  }
}

function jugg_watchforfire() {
  self endon("juggernaut_end");

  while(true) {
    self waittill("weapon_fired");
    self.streakinfo.shots_fired++;
  }
}

function jugg_removejuggernaut() {
  if(!isDefined(self)) {
    return;
  }

  assert(istrue(self.isjuggernaut));
  assert(isDefined(self.juggcontext));

  if(istrue(self.streakinfo.var_ca56839b2e00edce)) {
    if(soundexists("cp_assault_suit_off")) {
      self playlocalsound("cp_assault_suit_off");
    }

    if(soundexists("cp_assault_suit_on")) {
      self stoplocalsound("cp_assault_suit_on");
    }

    self forceplaygestureviewmodel("ges_magma_gas_mask_off");
    wait 0.521;
  }

  self notify("juggernaut_end_damage");
  self notify("juggernaut_end");
  juggcontext = self.juggcontext;
  juggconfig = juggcontext.juggconfig;
  self.musicplaying = undefined;
  self.var_a23031c04df01bf = undefined;

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    self.maxhealth = juggcontext.prevmaxhealth;
    self.health = juggcontext.prevhealth;

    if(istrue(level.relic_vampire) || istrue(level.relic_healthpacks)) {
      entity_num = self getentitynumber();
      scripts\cp\persistence::setcoopplayerdata_for_everyone("EoGPlayer", entity_num, "playerMaxHealth", self.maxhealth);
    }

    scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudiosupression();
    jugg_toggleallows(juggconfig.allows, 1);

    if(isDefined(juggconfig.classstruct)) {
      scripts\cp\loadout::respawnitems_assignrespawnitems(juggcontext.respawnitems);
    }

    foreach(unused in juggconfig.perks) {
      scripts\cp\utility::_unsetperk(perk);
    }

    if(juggconfig.infiniteammo) {
      stopinfiniteammothread();
    }
  }

  jugg_restoremodel(juggcontext);
  self.playerstreakspeedscale = juggcontext.prevspeedscale;
  scripts\cp\loadout::updatemovespeedscale();
  function_28bda29e7db3b4ea();
  scripts\cp\utility\player::_setsuit(juggcontext.prevsuit);
  self.suit = juggcontext.prevsuit;

  if(isDefined(self.prevclothtype)) {
    self setclothtype(getxhash(juggcontext.prevclothtype));
  }

  if(!istrue(self.streakinfo.var_ca56839b2e00edce)) {
    self takeallweapons();
    scripts\cp\utility::restore_weapons_status();
  } else {
    self setclientomnvar("ui_assault_suit_on", 0);
    scripts\cp\utility::function_98f7ca3781dac77c(self, "assault_suit");
    self.var_ca56839b2e00edce = 0;
  }

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.execution)) {
    scripts\cp_mp\execution::_giveexecution(self.operatorcustomization.execution);
  }

  if(scripts\cp\utility::is_specops_gametype() || scripts\cp\utility::function_a3577e8e6c88a56b() || scripts\cp\utility::function_f620e996a1d7d81a() || scripts\cp\utility::function_240f7f4e57340e8f()) {
    if(isDefined(self.loadoutaccessorydata) && isDefined(self.loadoutaccessoryweapon) && self.loadoutaccessoryweapon != "none") {
      scripts\cp\cp_accessories::giveplayeraccessory(self.loadoutaccessorydata, self.loadoutaccessoryweapon, self.loadoutaccessorylogic);
    }
  } else if(isDefined(self.classstruct.loadoutaccessorydata) && isDefined(self.classstruct.loadoutaccessoryweapon) && self.classstruct.loadoutaccessoryweapon != "none") {
    scripts\cp\cp_accessories::giveplayeraccessory(self.classstruct.loadoutaccessorydata, self.classstruct.loadoutaccessoryweapon, self.classstruct.loadoutaccessorylogic);
  }

  jugg_disableoverlay(juggcontext);
  self setscriptablepartstate("juggernaut", "neutral", 0);

  if(!scripts\cp\utility::is_raid_gamemode()) {
    scripts\cp\utility::allow_player_basejumping(1, "juggernaut");
  }

  self.damageshieldexpiretime = gettime() + 3000;
  self.isjuggernaut = undefined;
  self.can_revive = 1;
  self.juggcontext = undefined;
  self.disabletakecoverwarning = undefined;
  self.jugg_health = undefined;
  self.var_5d43389756907528 = undefined;
  thread start_regen_early();
  self.streakinfo = undefined;
  self notify("stop_hostagecarrier_watching_for_doors");
  self notify("juggernaut_end");
}

function start_regen_early() {
  wait 0.1;
  self notify("force_regeneration");
  scripts\cp_mp\playerhealth::function_19b9bb9cef6a2d3();
}

function infiniteammothread(waittime, weapons) {
  self endon("death_or_disconnect");
  self endon("stop_infinite_ammo_thread");

  if(!isDefined(waittime)) {
    waittime = level.framedurationseconds;
  }

  while(true) {
    if(!scripts\cp\weapon::player_has_minigun(self)) {
      wait waittime;
      continue;
    }

    if(!isDefined(weapons)) {
      weapons = self.equippedweapons;
    }

    foreach(weapon in weapons) {
      self givemaxammo(weapon);
      self setweaponammoclip(weapon, weaponclipsize(weapon));
    }

    wait waittime;
  }
}

function stopinfiniteammothread() {
  self notify("stop_infinite_ammo_thread");
}

function jugg_createconfig(skipallows, additionalallows) {
  config = spawnStruct();
  config.maxhealth = 3000;
  config.startinghealth = config.maxhealth;
  config.movespeedscalar = -0.2;
  config.var_9a0cea8101a4f35c = -0;
  config.forcetostand = 1;
  config.suit = "iw9_juggernaut_mp";
  config.infiniteammo = 1;
  config.infiniteammoupdaterate = undefined;
  config.classstruct = jugg_getdefaultclassstruct();
  config.allows = [];
  config.allows["stick_kill"] = 1;
  config.allows["one_hit_melee_victim"] = 1;
  config.allows["flashed"] = 1;
  config.allows["stunned"] = 1;
  config.allows["prone"] = 1;
  config.allows["health_regen"] = 1;
  config.allows["supers"] = 1;
  config.allows["killstreaks"] = 1;
  config.allows["slide"] = 1;
  config.allows["execution_victim"] = 1;
  config.allows["cough_gesture"] = 1;
  config.allows["offhand_throwback"] = 1;
  config.perks = [];
  return config;
}

function jugg_toggleallows(allows, allowed) {
  if(!allowed) {
    foreach(allow_name, used in allows) {
      if(used) {
        allow_name = tolower(allow_name);
        val::set("juggernaut", allow_name, 0);
      }
    }

    if(!istrue(level.disablemount)) {
      val::set("juggernaut", "mount_top", 0);
      val::set("juggernaut", "mount_side", 0);
    }

    if(!istrue(self.streakinfo.var_ca56839b2e00edce)) {
      val::set("juggernaut", "weapon_switch", 0);
    }

    val::set("juggernaut", "vehicle_use", 0);
    return;
  }

  val::reset_all("juggernaut");
}

function jugg_getdefaultclassstruct() {
  classstruct = scripts\cp\loadout::loadout_getclassstruct();
  classstruct.loadoutarchetype = "archetype_assault";
  classstruct.loadoutprimary = "iw9_lm_dblmg2_cp";
  classstruct.loadoutsecondary = "none";
  return classstruct;
}

function jugg_watchfordeath() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("juggernaut_end");
  self waittill("last_stand");
  thread jugg_removejuggernaut();
}

function jugg_watchfordamage() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("juggernaut_end");
  self endon("juggernaut_early_exit");
  self waittill("juggernaut_end_damage");

  if(!istrue(self.var_e180981362944a17)) {
    thread jugg_removejuggernaut();
  }
}

function jugg_watchearlyexit() {
  self endon("disconnect");
  self endon("juggernaut_end");
  self.owner = self;
  thread scripts\cp\utility::allowridekillstreakplayerexit();
  self waittill("killstreakExit");

  if(istrue(self.no_jugg_early_exit)) {
    thread jugg_watchearlyexit();
    return;
  }

  self notify("juggernaut_early_exit");
  thread jugg_removejuggernaut();
}

function jugg_watchfordoors() {
  self endon("disconnect");
  self endon("juggernaut_end");
  self endon("stop_hostagecarrier_watching_for_doors");
  self.owner = self;
  scripts\cp\utility::watch_and_open_scriptable_doors_in_radius();
}

function function_8e8605e7b6739834() {
  self endon("disconnect");
  self endon("juggernaut_end");
  mindistsq = squared(300);

  while(true) {
    wait 0.2;
    var_5231b925a8261fca = 0;

    if(isDefined(level.var_c0df98e7900066b7)) {
      foreach(entity in level.var_c0df98e7900066b7) {
        if(isDefined(entity.radius)) {
          if(distance(self.origin, entity.origin) < float(entity.radius)) {
            var_5231b925a8261fca = 1;
          }

          continue;
        }

        if(!isDefined(entity)) {
          var_5231b925a8261fca = 0;
          continue;
        }

        if(distancesquared(self.origin, entity.origin) < mindistsq) {
          var_5231b925a8261fca = 1;
          break;
        }
      }
    }

    foreach(player in level.players) {
      if(istrue(player.inlaststand) || isDefined(player.dogtag)) {
        if(distancesquared(self.origin, player.origin) < mindistsq) {
          var_5231b925a8261fca = 1;
        }
      }
    }

    if(var_5231b925a8261fca) {
      self.var_5d43389756907528 = 1;
      continue;
    }

    self.var_5d43389756907528 = undefined;
  }
}

function function_91ed8c25c9b88686() {
  if(!isDefined(level.var_c0df98e7900066b7)) {
    level.var_c0df98e7900066b7 = [];
  }

  level.var_c0df98e7900066b7[level.var_c0df98e7900066b7.size] = self;
}

function function_84bae1e96a725ec5(delay) {
  if(isDefined(delay)) {
    wait delay;
  }

  level.var_c0df98e7900066b7 = array_remove(level.var_c0df98e7900066b7, self);
}

function jugg_getjuggmodels() {
  models = [];
  models["body"] = "body_sp_opforce_aq_jugg_basebody";
  models["head"] = "head_sp_opforce_aq_jugg";
  models["view"] = "mp_vm_arms_jugg_aq_iw9_1_1";
  return models;
}

function jugg_setModel() {
  models = jugg_getjuggmodels();
  bodymodelname = models["body"];
  headmodelname = models["head"];
  viewmodelname = models["view"];
  scripts\cp\loadout::setcharactermodels(bodymodelname, headmodelname, viewmodelname);
}

function jugg_restoremodel(juggcontext) {
  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    if(isDefined(self.operator_struct) && istrue(self.operator_struct.skip_customization)) {
      scripts\cp\loadout::setcharactermodels(self.operatorcustomization.defaultbody, self.operatorcustomization.defaulthead, self.operatorcustomization.defaultvm);
      return;
    }

    self setcustomization(juggcontext.prevbody, juggcontext.prevhead);
    bodymodelname = default_to(self.operatorcustomization.defaultbody, self getcustomizationbody());
    headmodelname = default_to(self.operatorcustomization.defaulthead, self getcustomizationhead());
    viewmodelname = default_to(self.operatorcustomization.defaultvm, self getcustomizationviewmodel());
    scripts\cp\loadout::setcharactermodels(bodymodelname, headmodelname, viewmodelname);
  }
}

function jugg_needtochangestance(juggconfig) {
  needtochangestance = 0;
  curstance = self getstance();

  switch (curstance) {
    case #"hash_c6775c88e38f7803":
      needtochangestance = 0;
      break;
    case #"hash_3fed0cbd303639eb":
      if(juggconfig.forcetostand || !juggconfig.allowcrouch) {
        needtochangestance = 1;
        break;
      }

      break;
    case #"hash_d91940431ed7c605":
      if(juggconfig.forcetostand || !juggconfig.allowprone) {
        needtochangestance = 1;
        break;
      }

      break;
  }

  return needtochangestance;
}

function jugg_canresolvestance(juggconfig) {
  return true;
}

function jugg_handlestancechange(juggconfig) {
  if(jugg_needtochangestance(juggconfig)) {
    self setstance("stand");
  }
}

function jugg_enableoverlay(juggcontext) {
  self notify("jugg_mask_on");

  if(!isDefined(self.juggoverlaystatelabel) && !isDefined(self.juggoverlaystate)) {
    self.juggoverlaystatelabel = "mask_on";
    self.juggoverlaystate = 1;
  }

  scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("juggernaut", self.juggoverlaystatelabel);
  self setclientomnvar(juggcontext.maskomnvar, self.juggoverlaystate);
  thread function_ae8c964eb2ef2486(juggcontext);
}

function function_ae8c964eb2ef2486(juggcontext) {
  self endon("death_or_disconnect");
  self endon("juggernaut_end");
  var_ea0a3076fb747a79 = self.juggoverlaystate;

  while(true) {
    if(self getcamerathirdperson() && self playerads() <= 0.75) {
      jugg_disableoverlay(juggcontext, 1);
      var_ea0a3076fb747a79 = 0;
      wait 0.1;
      continue;
    }

    if(!isDefined(self.juggoverlaystatelabel) && !isDefined(self.juggoverlaystate)) {
      self.juggoverlaystatelabel = "mask_on";
      self.juggoverlaystate = 1;
    }

    if(var_ea0a3076fb747a79 != self.juggoverlaystate) {
      scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("juggernaut", self.juggoverlaystatelabel);
      self setclientomnvar(juggcontext.maskomnvar, self.juggoverlaystate);
      var_ea0a3076fb747a79 = self.juggoverlaystate;
    }

    self setclientomnvar("ui_jugg_overlay_third_person", 0);
    wait 0.1;
    continue;
  }
}

function jugg_watchoverlaydamagestates(juggcontext) {
  self endon("juggernaut_end");
  self endon("death or disconnect");
  level endon("game_ended");
  juggcontext = self.juggcontext;
  startinghealth = self.jugg_health;
  stage1damage = startinghealth - startinghealth * 0.1;
  stage2damage = startinghealth - startinghealth * 0.35;
  stage3damage = startinghealth - startinghealth * 0.6;
  stage4damage = startinghealth - startinghealth * 0.85;
  overlaystate = 1;
  var_ea0a3076fb747a79 = overlaystate;
  overlaystatelabel = "mask_on";

  while(true) {
    waittill_any_3("damage", "jugg_health_regen", "jugg_damage");

    if(self.jugg_health <= stage4damage) {
      overlaystatelabel = "mask_damage_critical";
      overlaystate = 5;
    } else if(self.jugg_health <= stage3damage) {
      overlaystatelabel = "mask_damage_high";
      overlaystate = 4;
    } else if(self.jugg_health <= stage2damage) {
      overlaystatelabel = "mask_damage_med";
      overlaystate = 3;
    } else if(self.jugg_health <= stage1damage) {
      overlaystatelabel = "mask_damage_low";
      overlaystate = 2;
    } else {
      overlaystatelabel = "mask_on";
      overlaystate = 1;
    }

    self.juggoverlaystatelabel = overlaystatelabel;
    self.juggoverlaystate = overlaystate;

    if(var_ea0a3076fb747a79 != overlaystate) {
      scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("juggernaut", "off");
      wait 0.1;
      scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("juggernaut", overlaystatelabel);
      self setclientomnvar(juggcontext.maskomnvar, overlaystate);
      var_ea0a3076fb747a79 = overlaystate;
    }
  }
}

function jugg_watchforoverlayexecutiontoggle(juggcontext) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("juggernaut_end");
  var_2bf9392cab435cdf = 0;

  while(true) {
    if(!self isinexecutionattack()) {
      if(istrue(var_2bf9392cab435cdf)) {
        scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("juggernaut", self.juggoverlaystatelabel);
        self setclientomnvar(juggcontext.maskomnvar, self.juggoverlaystate);
        var_2bf9392cab435cdf = 0;
      }

      waitframe();
      continue;
    }

    if(!istrue(var_2bf9392cab435cdf)) {
      scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("juggernaut", "off");
      self setclientomnvar(juggcontext.maskomnvar, 0);
      var_2bf9392cab435cdf = 1;
    }

    waitframe();
  }
}

function jugg_disableoverlay(juggcontext, var_c953ee526f4bb69f) {
  if(!istrue(var_c953ee526f4bb69f)) {
    var_c953ee526f4bb69f = 0;
    scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("juggernaut", "off");
  }

  self setclientomnvar(juggcontext.maskomnvar, 0);
  self setclientomnvar("ui_jugg_overlay_third_person", var_c953ee526f4bb69f);
  self.juggoverlaystatelabel = undefined;
  self.juggoverlaystate = undefined;
}

function jugg_getmovespeedscalar() {
  return -0.2;
}