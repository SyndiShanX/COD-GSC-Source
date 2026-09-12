/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\damage.gsc
***********************************************/

function get_damageable_player(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.isplayer = 1;
  var_2.isadestructable = 0;
  var_2.entity = var_0;
  var_2.damagecenter = var_1;
  return var_2;
}

function get_damageable_sentry(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.isplayer = 0;
  var_2.isadestructable = 0;
  var_2.issentry = 1;
  var_2.entity = var_0;
  var_2.damagecenter = var_1;
  return var_2;
}

function get_damageable_grenade(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.isplayer = 0;
  var_2.isadestructable = 0;
  var_2.entity = var_0;
  var_2.damagecenter = var_1;
  return var_2;
}

function get_damageable_mine(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.isplayer = 0;
  var_2.isadestructable = 0;
  var_2.entity = var_0;
  var_2.damagecenter = var_1;
  return var_2;
}

function get_damageable_player_pos(var_0) {
  return var_0.origin + (0, 0, 32);
}

function get_damageable_grenade_pos(var_0) {
  return var_0.origin;
}

function istacticaldamage(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isDefined(var_1) || var_1 == "MOD_IMPACT") {
    return 0;
  }

  switch (var_0.basename) {
    case "blackout_grenade_mp":
    case "smoke_grenade_mp":
    case "cryo_mine_mp":
    case "concussion_grenade_mp":
      return 1;
    case "deployable_cover_mp":
    case "trophy_mp":
      return 0;
    default:
      return 0;
  }
}

function isfmjdamage(var_0, var_1, var_2) {
  if(istrue(var_2) && unset_relic_dfa(var_0, var_1)) {
    return 1;
  }

  var_3 = 0;

  if(isDefined(var_1) && scripts\engine\utility::isbulletdamage(var_1)) {
    var_4 = scripts\mp\utility\weapon::getweaponattachmentsbasenames(var_0);

    foreach(var_6 in var_4) {
      if(var_6 == "fmj" || var_6 == "reflect") {
        var_3 = 1;
        break;
      }
    }
  }

  return var_3;
}

function unset_relic_dfa(var_0, var_1) {
  return var_0 method_87b6();
}

function isheadshot(var_0, var_1, var_2) {
  if(!validshotcheck(var_1, var_2)) {
    return false;
  }

  return var_0 == "head" || var_0 == "helmet";
}

function istorsoshot(var_0, var_1, var_2) {
  if(!validshotcheck(var_1, var_2)) {
    return false;
  }

  return var_0 == "neck" || var_0 == "torso_upper" || var_0 == "torso_lower";
}

function istorsouppershot(var_0, var_1, var_2) {
  if(!validshotcheck(var_1, var_2)) {
    return false;
  }

  return var_0 == "neck" || var_0 == "torso_upper";
}

function isupperbodyshot(var_0, var_1, var_2) {
  if(!validshotcheck(var_1, var_2)) {
    return false;
  }

  switch (var_0) {
    case "left_arm_lower":
    case "right_arm_lower":
    case "left_arm_upper":
    case "right_arm_upper":
    case "neck":
    case "torso_upper":
    case "right_leg_upper":
    case "left_leg_upper":
    case "torso_lower":
      return true;
  }

  return false;
}

function islowerbodyshot(var_0, var_1, var_2) {
  if(!validshotcheck(var_1, var_2)) {
    return false;
  }

  switch (var_0) {
    case "right_foot":
    case "left_foot":
    case "right_leg_lower":
    case "right_leg_upper":
    case "left_leg_lower":
    case "left_leg_upper":
      return true;
  }

  return false;
}

function validshotcheck(var_0, var_1) {
  if(isDefined(var_1)) {
    if(isDefined(var_1.owner)) {
      switch (var_1.code_classname) {
        case "misc_turret":
        case "script_model":
        case "script_vehicle":
          return false;
      }
    }
  }

  switch (var_0) {
    case "MOD_CRUSH":
    case "MOD_FIRE":
    case "MOD_EXPLOSIVE":
    case "MOD_IMPACT":
    case "MOD_MELEE":
      return false;
  }

  return true;
}

function islethalmeleeweapon(var_0, var_1, var_2, var_3) {
  if(var_3 != "MOD_MELEE") {
    return false;
  }

  if(!isDefined(var_1) || !isPlayer(var_1)) {
    return false;
  }

  if(var_1 scripts\mp\heavyarmor::hasheavyarmor()) {
    return false;
  }

  if(!scripts\mp\utility\player::is_one_hit_melee_victim_allowed()) {
    return false;
  }

  if(scripts\mp\utility\weapon::isfistsonly(var_2.basename)) {
    return false;
  }

  if(scripts\mp\utility\weapon::update_health_bar_to_player(var_2)) {
    return true;
  }

  if(scripts\mp\utility\weapon::isknifeonly(var_2.basename)) {
    return true;
  }

  if(scripts\mp\utility\weapon::isballweapon(var_2)) {
    return true;
  }

  if(var_2.basename == "iw8_defibrillator_mp") {
    return true;
  }

  if(scripts\mp\utility\weapon::isaxeweapon(var_2.basename) && var_0 getweaponammoclip(var_2) > 0) {
    return true;
  }

  foreach(var_5 in var_2.attachments) {
    if(scripts\engine\utility::string_starts_with(var_5, "bayonet") || scripts\engine\utility::string_starts_with(var_5, "tacknife")) {
      return true;
    }
  }

  return false;
}

function attackerishittingteam(var_0, var_1) {
  if(isDefined(var_1) && isDefined(var_1.owner)) {
    var_1 = var_1.owner;
  }

  if(!level.teambased) {
    return 0;
  }

  if(!isDefined(var_1) || !isDefined(var_0)) {
    return 0;
  }

  if(!isDefined(var_0.team) || !isDefined(var_1.team)) {
    return 0;
  }

  if(var_0 == var_1) {
    return 0;
  }

  if(scripts\mp\utility\game::getgametype() == "infect" && var_0.pers["team"] == var_1.team && isDefined(var_1.teamchangedthisframe)) {
    return 0;
  }

  if(scripts\mp\utility\game::getgametype() == "infect" && var_0.pers["team"] != var_1.team && isDefined(var_1.teamchangedthisframe)) {
    return 1;
  }

  if(isDefined(var_1.scrambled) && var_1.scrambled) {
    return 0;
  }

  if(scripts\mp\utility\player::isplayerproxyagent(var_0, var_1)) {
    return 0;
  }

  if(isagent(var_0) && istrue(var_0.ref_133D2)) {
    return 0;
  }

  if(isagent(var_0) && isDefined(var_0.owner) && var_0.owner == var_1) {
    return 0;
  }

  if(var_0.team == var_1.team) {
    return 1;
  }

  return 0;
}

function _validateattacker(var_0) {
  if(isagent(var_0) && (!isDefined(var_0.isactive) || !var_0.isactive)) {
    return undefined;
  }

  if(isagent(var_0) && !isDefined(var_0.classname)) {
    return undefined;
  }

  return var_0;
}

function _validatevictim(var_0) {
  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return undefined;
  }

  return var_0;
}

function damage_should_ignore_blast_shield(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_0, var_1, undefined, var_2, var_3, var_4);

  if(!isexplosivedamagemod(var_3) && var_3 != "MOD_FIRE") {
    return true;
  }

  if(var_3 == "MOD_GRENADE") {
    return true;
  }

  if(var_3 == "MOD_PROJECTILE") {
    return true;
  }

  if(isDefined(var_0) && var_0 == var_1) {
    return true;
  }

  if(var_1 scripts\cp_mp\utility\damage_utility::isstuckdamage(var_6)) {
    return true;
  }

  if(scripts\mp\utility\weapon::weaponignoresblastshield(var_2, var_5)) {
    return true;
  }

  if(level.gametype == "br" && isDefined(var_1) && istrue(var_1.isjuggernaut) && isDefined(var_4) && isDefined(var_4.vehiclename)) {
    return true;
  }

  return false;
}

function _radiusdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self radiusdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

function radiusplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_9)) {
    var_9 = 0;
  }

  var_10 = scripts\engine\trace::create_character_contents();
  var_11 = scripts\engine\trace::create_contents(0, 1, 1, 0, 1, 0);
  var_12 = [];

  foreach(var_14 in level.characters) {
    if(!isDefined(var_14)) {
      continue;
    }

    if(!var_14 scripts\cp_mp\utility\player_utility::_isalive()) {
      var_12 = var_14;
      continue;
    }

    if(var_9 && var_14 == var_5) {
      var_12 = var_14;
      continue;
    }

    if(level.teambased && var_14.team == var_5.team) {
      var_12 = var_14;
    }
  }

  var_16 = physics_querypoint(var_5.origin, var_2, var_10, var_12, "physicsquery_all");

  if(isDefined(var_16) && var_16.size > 0) {
    for(var_17 = 0; var_17 < var_16.size; var_17++) {
      var_18 = var_16[var_17]["entity"];
      var_19 = var_16[var_17]["distance"];
      var_20 = var_16[var_17]["position"];

      if(!isDefined(var_18)) {
        continue;
      }

      var_21 = physics_raycast(var_0, var_20, var_11, undefined, 0, "physicsquery_closest");

      if(isDefined(var_21) && var_21.size > 0) {
        continue;
      }

      var_22 = max(var_19, var_1) / var_2;
      var_23 = var_3 + (var_4 - var_3) * var_22;
      var_18 dodamage(var_23, var_0, var_5, var_6, var_7, var_8);
    }

    return;
  }
}

function hashealthshield(var_0) {
  return isDefined(var_0) && isDefined(var_0.healthshield);
}

function gethealthshielddamage(var_0) {
  return int(var_0 * self.healthshieldmod);
}

function sethealthshield(var_0) {
  self.healthshield = 1;

  if(!isDefined(self.healthshieldmod)) {
    self.healthshieldmod = 1;
  }

  var_0 = int(clamp(var_0, 0, 100));
  var_1 = (100 - var_0) / 100;

  if(var_1 < self.healthshieldmod) {
    self.healthshieldmod = var_1;
    return;
  }
}

function clearhealthshield() {
  self.healthshield = undefined;
  self.healthshieldmod = undefined;
}

function _suicide(var_0) {
  if(self.sessionstate != "playing") {
    return;
  }

  if(playershoulddofauxdeath(var_0) && !isDefined(self.fauxdead)) {
    thread scripts\mp\damage::playerkilled_internal(self, self, self, 10000, 0, "MOD_SUICIDE", isundefinedweapon(), (0, 0, 0), "none", 0, 1116, 1);
    return;
  }

  if(!playershoulddofauxdeath(var_0) && !isDefined(self.fauxdead) && !isDefined(self.vehicle)) {
    self suicide();
    return;
  }
}

function ref_13966() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("stopped_using_remote");
  thread ref_13965();
}

function ref_13965() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("suicide_on_alive");
  self endon("suicide_on_alive");

  while(!scripts\mp\utility\player::isreallyalive(self) || self.sessionstate != "playing") {
    waitframe();
  }

  _suicide();
}

function playershoulddofauxdeath(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(istrue(var_0) && scripts\mp\utility\player::isusingremote()) {
    return true;
  }

  if(isDefined(level.modeshoulddofauxdeathfunc) && self[[level.modeshoulddofauxdeathfunc]]()) {
    return true;
  }

  return false;
}

function isprojectiledamage(var_0) {
  var_1 = "MOD_PROJECTILE MOD_IMPACT MOD_GRENADE MOD_HEAD_SHOT";

  if(issubstr(var_1, var_0)) {
    return true;
  }

  return false;
}

function non_player_log_attacker_data(var_0, var_1) {
  if(var_0.damage == 0) {
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = var_0.attacker;
  }

  if(!isDefined(var_1) || !isPlayer(var_1)) {
    var_2 = var_0.inflictor;

    if(isDefined(var_2)) {
      if(isPlayer(var_2)) {
        var_1 = var_2;
      } else {
        var_1 = var_2.owner;
      }
    } else {
      var_1 = undefined;
    }
  }

  if(!isDefined(var_1) || !isPlayer(var_1)) {
    return;
  }

  if(isDefined(self.owner)) {
    if(!scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_1)) {
      return;
    }
  } else if(level.teambased && isDefined(self.team) && self.team == var_1.team) {
    return;
  }

  non_player_add_attacker_data(var_0, var_1);
}

function non_player_add_attacker_data(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = var_0.attacker;
  }

  var_2 = undefined;
  var_3 = non_player_get_attacker_data(var_1);

  if(!isDefined(var_3)) {
    var_3 = non_player_get_attacker_data(var_1, 1);
    var_2 = gettime();
  }

  var_3.damage += var_0.damage;
  var_3.objweapon = var_0.objweapon;
  var_3.point = var_0.point;
  var_3.direction = var_0.direction_vec;
  var_3.partname = var_0.partname;
  var_3.meansofdeath = var_0.meansofdeath;
  var_3.lasttimedamaged = gettime();
  var_3.firsttimedamaged = scripts\engine\utility::ter_op(isDefined(var_2), var_2, var_3.firsttimedamaged);

  if(isDefined(var_1) && isPlayer(var_1) && !nullweapon(var_1 getcurrentprimaryweapon())) {
    var_3.sprimaryweapon = createheadicon(var_1 getcurrentprimaryweapon());
    return;
  }

  var_3.sprimaryweapon = undefined;
}

function non_player_get_attacker_data(var_0, var_1) {
  var_2 = undefined;

  if(!isDefined(self.attackerdata) && istrue(var_1)) {
    self.attackerdata = [];
  }

  if(isDefined(self.attackerdata)) {
    var_3 = var_0.guid;

    if(isDefined(var_3)) {
      var_2 = self.attackerdata[var_3];

      if(isDefined(var_2)) {
        if(var_2.isvalid || level.teambased && var_0.team != var_2.team) {
          var_2 = undefined;
          self.attackerdata[var_3] = undefined;
        }
      }

      if(!isDefined(var_2) && istrue(var_1)) {
        var_2 = spawnStruct();
        var_2.attacker = var_0;
        var_2.team = var_0.team;
        var_2.guid = var_3;
        var_2.isvalid = 1;
        var_2.damage = 0;
        var_2.hitcount = 0;
        var_2.firsttimehit = gettime();
        self.attackerdata[var_3] = var_2;
      }
    }
  }

  return var_2;
}

function non_player_clear_attacker_data() {
  self.attackerdata = undefined;
}

function non_player_should_ignore_damage(var_0, var_1, var_2, var_3) {
  if(non_player_should_ignore_damage_signature(var_0, var_1, var_2, var_3)) {
    return true;
  }

  if(isDefined(var_1.basename)) {
    if(var_3 != "MOD_MELEE") {
      switch (var_1.basename) {
        case "iw8_spotter_scope_mp":
        case "iw8_spotter_scope_mp_ch3":
        case "iw8_green_beam_mp":
          return true;
      }
    }

    if(var_3 == "MOD_IMPACT") {
      switch (var_1.basename) {
        case "claymore_mp":
        case "at_mine_mp":
        case "c4_mp_p":
        case "semtex_mp":
        case "thermite_mp":
          return true;
      }
    } else {
      switch (var_1.basename) {
        case "gas_mp":
        case "snapshot_grenade_mp":
        case "claymore_radial_mp":
        case "emp_drone_player_mp":
        case "concussion_grenade_mp":
        case "flash_grenade_mp":
        case "thermite_ap_mp":
          return true;
      }
    }
  }

  return false;
}

function non_player_add_ignore_damage_signature(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.ignoredamageid)) {
    self.ignoredamageid = 0;
  }

  if(!isDefined(self.ignoredamagesignatures)) {
    self.ignoredamagesignatures = [];
  }

  var_4 = self.ignoredamageid;
  self.ignoredamageid++;

  if(isDefined(var_1) && isstring(var_1)) {
    var_1 = getcompleteweaponname(var_1);
  }

  var_5 = spawnStruct();
  var_5.id = var_4;
  var_5.attacker = var_0;
  var_5.objweapon = var_1;
  var_5.inflictor = var_2;
  var_5.meansofdeath = var_3;
  var_5.checkattacker = isDefined(var_0);
  var_5.checkobjweapon = isDefined(var_1) && !nullweapon(var_1);
  var_5.checkinflictor = isDefined(var_2);
  var_5.checkmeansofdeath = isDefined(var_3);
  self.ignoredamagesignatures[var_4] = var_5;
  return var_4;
}

function non_player_remove_ignore_damage_signature(var_0) {
  if(!isDefined(self.ignoredamagesignatures)) {
    return;
  }

  self.ignoredamagesignatures[var_0] = undefined;
}

function non_player_clear_ignore_damage_signatures() {
  self.ignoredamagesignatures = undefined;
}

function non_player_should_ignore_damage_signature(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.ignoredamagesignatures)) {
    return false;
  }

  if(isDefined(var_1) && isstring(var_1)) {
    var_1 = getcompleteweaponname(var_1);
  }

  foreach(var_5 in self.ignoredamagesignatures) {
    if(!isDefined(var_5)) {
      return false;
    }

    if(var_5.checkattacker) {
      if(!isDefined(var_5.attacker)) {
        non_player_remove_ignore_damage_signature(var_5.id);
        continue;
      } else if(!isDefined(var_0)) {
        continue;
      } else if(var_0 != var_5.attacker) {
        continue;
      }
    }

    if(var_5.checkobjweapon) {
      if(!isDefined(var_1) || nullweapon(var_1)) {
        continue;
      } else if(var_1 != var_5.objweapon) {
        continue;
      }
    }

    if(var_5.checkinflictor) {
      if(!isDefined(var_5.inflictor)) {
        non_player_remove_ignore_damage_signature(var_5.id);
        continue;
      } else if(!isDefined(var_2)) {
        continue;
      } else if(var_2 != var_5.inflictor) {
        continue;
      }
    }

    if(var_5.checkmeansofdeath) {
      if(!isDefined(var_3)) {
        continue;
      } else if(var_3 != var_5.meansofdeath) {
        continue;
      }
    }

    return true;
  }

  return false;
}

function islauncherdirectimpactdamage(var_0, var_1, var_2) {
  if(scripts\mp\utility\weapon::isaxeweapon(var_0)) {
    return false;
  }

  if(var_0.type != "projectile") {
    return false;
  }

  if(istrue(var_2) && var_0.isalternate && isDefined(var_0.underbarrel)) {
    return false;
  }

  return var_1 == "MOD_IMPACT" || var_1 == "MOD_PROJECTILE" || var_1 == "MOD_GRENADE";
}