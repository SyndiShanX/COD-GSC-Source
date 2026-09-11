/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\damage.gsc
***********************************************/

function get_damageable_player(var0, var1) {
  var2 = spawnStruct();
  var2.isplayer = 1;
  var2.isadestructable = 0;
  var2.entity = var0;
  var2.damagecenter = var1;
  return var2;
}

function get_damageable_sentry(var0, var1) {
  var2 = spawnStruct();
  var2.isplayer = 0;
  var2.isadestructable = 0;
  var2.issentry = 1;
  var2.entity = var0;
  var2.damagecenter = var1;
  return var2;
}

function get_damageable_grenade(var0, var1) {
  var2 = spawnStruct();
  var2.isplayer = 0;
  var2.isadestructable = 0;
  var2.entity = var0;
  var2.damagecenter = var1;
  return var2;
}

function get_damageable_mine(var0, var1) {
  var2 = spawnStruct();
  var2.isplayer = 0;
  var2.isadestructable = 0;
  var2.entity = var0;
  var2.damagecenter = var1;
  return var2;
}

function get_damageable_player_pos(var0) {
  return var0.origin + (0, 0, 32);
}

function get_damageable_grenade_pos(var0) {
  return var0.origin;
}

function istacticaldamage(var0, var1) {
  if(!isDefined(var0)) {
    return 0;
  }

  if(!isDefined(var1) || var1 == "MOD_IMPACT") {
    return 0;
  }

  switch (var0.basename) {
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

function isfmjdamage(var0, var1, var2) {
  if(istrue(var2) && unset_relic_dfa(var0, var1)) {
    return 1;
  }

  var3 = 0;

  if(isDefined(var1) && scripts\engine\utility::isbulletdamage(var1)) {
    var4 = scripts\mp\utility\weapon::getweaponattachmentsbasenames(var0);

    foreach(var6 in var4) {
      if(var6 == "fmj" || var6 == "reflect") {
        var3 = 1;
        break;
      }
    }
  }

  return var3;
}

function unset_relic_dfa(var0, var1) {
  return var0 method_87b6();
}

function isheadshot(var0, var1, var2) {
  if(!validshotcheck(var1, var2)) {
    return false;
  }

  return var0 == "head" || var0 == "helmet";
}

function istorsoshot(var0, var1, var2) {
  if(!validshotcheck(var1, var2)) {
    return false;
  }

  return var0 == "neck" || var0 == "torso_upper" || var0 == "torso_lower";
}

function istorsouppershot(var0, var1, var2) {
  if(!validshotcheck(var1, var2)) {
    return false;
  }

  return var0 == "neck" || var0 == "torso_upper";
}

function isupperbodyshot(var0, var1, var2) {
  if(!validshotcheck(var1, var2)) {
    return false;
  }

  switch (var0) {
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

function islowerbodyshot(var0, var1, var2) {
  if(!validshotcheck(var1, var2)) {
    return false;
  }

  switch (var0) {
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

function validshotcheck(var0, var1) {
  if(isDefined(var1)) {
    if(isDefined(var1.owner)) {
      switch (var1.code_classname) {
        case "misc_turret":
        case "script_model":
        case "script_vehicle":
          return false;
      }
    }
  }

  switch (var0) {
    case "MOD_CRUSH":
    case "MOD_FIRE":
    case "MOD_EXPLOSIVE":
    case "MOD_IMPACT":
    case "MOD_MELEE":
      return false;
  }

  return true;
}

function islethalmeleeweapon(var0, var1, var2, var3) {
  if(var3 != "MOD_MELEE") {
    return false;
  }

  if(!isDefined(var1) || !isPlayer(var1)) {
    return false;
  }

  if(var1 scripts\mp\heavyarmor::hasheavyarmor()) {
    return false;
  }

  if(!scripts\mp\utility\player::is_one_hit_melee_victim_allowed()) {
    return false;
  }

  if(scripts\mp\utility\weapon::isfistsonly(var2.basename)) {
    return false;
  }

  if(scripts\mp\utility\weapon::update_health_bar_to_player(var2)) {
    return true;
  }

  if(scripts\mp\utility\weapon::isknifeonly(var2.basename)) {
    return true;
  }

  if(scripts\mp\utility\weapon::isballweapon(var2)) {
    return true;
  }

  if(var2.basename == "iw8_defibrillator_mp") {
    return true;
  }

  if(scripts\mp\utility\weapon::isaxeweapon(var2.basename) && var0 getweaponammoclip(var2) > 0) {
    return true;
  }

  foreach(var5 in var2.attachments) {
    if(scripts\engine\utility::string_starts_with(var5, "bayonet") || scripts\engine\utility::string_starts_with(var5, "tacknife")) {
      return true;
    }
  }

  return false;
}

function attackerishittingteam(var0, var1) {
  if(isDefined(var1) && isDefined(var1.owner)) {
    var1 = var1.owner;
  }

  if(!level.teambased) {
    return 0;
  }

  if(!isDefined(var1) || !isDefined(var0)) {
    return 0;
  }

  if(!isDefined(var0.team) || !isDefined(var1.team)) {
    return 0;
  }

  if(var0 == var1) {
    return 0;
  }

  if(scripts\mp\utility\game::getgametype() == "infect" && var0.pers["team"] == var1.team && isDefined(var1.teamchangedthisframe)) {
    return 0;
  }

  if(scripts\mp\utility\game::getgametype() == "infect" && var0.pers["team"] != var1.team && isDefined(var1.teamchangedthisframe)) {
    return 1;
  }

  if(isDefined(var1.scrambled) && var1.scrambled) {
    return 0;
  }

  if(scripts\mp\utility\player::isplayerproxyagent(var0, var1)) {
    return 0;
  }

  if(isagent(var0) && istrue(var0.ref_133d2)) {
    return 0;
  }

  if(isagent(var0) && isDefined(var0.owner) && var0.owner == var1) {
    return 0;
  }

  if(var0.team == var1.team) {
    return 1;
  }

  return 0;
}

function _validateattacker(var0) {
  if(isagent(var0) && (!isDefined(var0.isactive) || !var0.isactive)) {
    return undefined;
  }

  if(isagent(var0) && !isDefined(var0.classname)) {
    return undefined;
  }

  return var0;
}

function _validatevictim(var0) {
  if(!var0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return undefined;
  }

  return var0;
}

function damage_should_ignore_blast_shield(var0, var1, var2, var3, var4, var5) {
  var6 = scripts\cp_mp\utility\damage_utility::packdamagedata(var0, var1, undefined, var2, var3, var4);

  if(!isexplosivedamagemod(var3) && var3 != "MOD_FIRE") {
    return true;
  }

  if(var3 == "MOD_GRENADE") {
    return true;
  }

  if(var3 == "MOD_PROJECTILE") {
    return true;
  }

  if(isDefined(var0) && var0 == var1) {
    return true;
  }

  if(var1 scripts\cp_mp\utility\damage_utility::isstuckdamage(var6)) {
    return true;
  }

  if(scripts\mp\utility\weapon::weaponignoresblastshield(var2, var5)) {
    return true;
  }

  if(level.gametype == "br" && isDefined(var1) && istrue(var1.isjuggernaut) && isDefined(var4) && isDefined(var4.vehiclename)) {
    return true;
  }

  return false;
}

function _radiusdamage(var0, var1, var2, var3, var4, var5, var6) {
  self radiusdamage(var0, var1, var2, var3, var4, var5, var6);
}

function radiusplayerdamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(!isDefined(var9)) {
    var9 = 0;
  }

  var10 = scripts\engine\trace::create_character_contents();
  var11 = scripts\engine\trace::create_contents(0, 1, 1, 0, 1, 0);
  var12 = [];

  foreach(var14 in level.characters) {
    if(!isDefined(var14)) {
      continue;
    }

    if(!var14 scripts\cp_mp\utility\player_utility::_isalive()) {
      var12 = var14;
      continue;
    }

    if(var9 && var14 == var5) {
      var12 = var14;
      continue;
    }

    if(level.teambased && var14.team == var5.team) {
      var12 = var14;
    }
  }

  var16 = physics_querypoint(var5.origin, var2, var10, var12, "physicsquery_all");

  if(isDefined(var16) && var16.size > 0) {
    for(var17 = 0; var17 < var16.size; var17++) {
      var18 = var16[var17]["entity"];
      var19 = var16[var17]["distance"];
      var20 = var16[var17]["position"];

      if(!isDefined(var18)) {
        continue;
      }

      var21 = physics_raycast(var0, var20, var11, undefined, 0, "physicsquery_closest");

      if(isDefined(var21) && var21.size > 0) {
        continue;
      }

      var22 = max(var19, var1) / var2;
      var23 = var3 + (var4 - var3) * var22;
      var18 dodamage(var23, var0, var5, var6, var7, var8);
    }

    return;
  }
}

function hashealthshield(var0) {
  return isDefined(var0) && isDefined(var0.healthshield);
}

function gethealthshielddamage(var0) {
  return int(var0 * self.healthshieldmod);
}

function sethealthshield(var0) {
  self.healthshield = 1;

  if(!isDefined(self.healthshieldmod)) {
    self.healthshieldmod = 1;
  }

  var0 = int(clamp(var0, 0, 100));
  var1 = (100 - var0) / 100;

  if(var1 < self.healthshieldmod) {
    self.healthshieldmod = var1;
    return;
  }
}

function clearhealthshield() {
  self.healthshield = undefined;
  self.healthshieldmod = undefined;
}

function _suicide(var0) {
  if(self.sessionstate != "playing") {
    return;
  }

  if(playershoulddofauxdeath(var0) && !isDefined(self.fauxdead)) {
    thread scripts\mp\damage::playerkilled_internal(self, self, self, 10000, 0, "MOD_SUICIDE", isundefinedweapon(), (0, 0, 0), "none", 0, 1116, 1);
    return;
  }

  if(!playershoulddofauxdeath(var0) && !isDefined(self.fauxdead) && !isDefined(self.vehicle)) {
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

function playershoulddofauxdeath(var0) {
  if(!isDefined(var0)) {
    var0 = 1;
  }

  if(istrue(var0) && scripts\mp\utility\player::isusingremote()) {
    return true;
  }

  if(isDefined(level.modeshoulddofauxdeathfunc) && self[[level.modeshoulddofauxdeathfunc]]()) {
    return true;
  }

  return false;
}

function isprojectiledamage(var0) {
  var1 = "MOD_PROJECTILE MOD_IMPACT MOD_GRENADE MOD_HEAD_SHOT";

  if(issubstr(var1, var0)) {
    return true;
  }

  return false;
}

function non_player_log_attacker_data(var0, var1) {
  if(var0.damage == 0) {
    return;
  }

  if(!isDefined(var1)) {
    var1 = var0.attacker;
  }

  if(!isDefined(var1) || !isPlayer(var1)) {
    var2 = var0.inflictor;

    if(isDefined(var2)) {
      if(isPlayer(var2)) {
        var1 = var2;
      } else {
        var1 = var2.owner;
      }
    } else {
      var1 = undefined;
    }
  }

  if(!isDefined(var1) || !isPlayer(var1)) {
    return;
  }

  if(isDefined(self.owner)) {
    if(!scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var1)) {
      return;
    }
  } else if(level.teambased && isDefined(self.team) && self.team == var1.team) {
    return;
  }

  non_player_add_attacker_data(var0, var1);
}

function non_player_add_attacker_data(var0, var1) {
  if(!isDefined(var1)) {
    var1 = var0.attacker;
  }

  var2 = undefined;
  var3 = non_player_get_attacker_data(var1);

  if(!isDefined(var3)) {
    var3 = non_player_get_attacker_data(var1, 1);
    var2 = gettime();
  }

  var3.damage += var0.damage;
  var3.objweapon = var0.objweapon;
  var3.point = var0.point;
  var3.direction = var0.direction_vec;
  var3.partname = var0.partname;
  var3.meansofdeath = var0.meansofdeath;
  var3.lasttimedamaged = gettime();
  var3.firsttimedamaged = scripts\engine\utility::ter_op(isDefined(var2), var2, var3.firsttimedamaged);

  if(isDefined(var1) && isPlayer(var1) && !nullweapon(var1 getcurrentprimaryweapon())) {
    var3.sprimaryweapon = createheadicon(var1 getcurrentprimaryweapon());
    return;
  }

  var3.sprimaryweapon = undefined;
}

function non_player_get_attacker_data(var0, var1) {
  var2 = undefined;

  if(!isDefined(self.attackerdata) && istrue(var1)) {
    self.attackerdata = [];
  }

  if(isDefined(self.attackerdata)) {
    var3 = var0.guid;

    if(isDefined(var3)) {
      var2 = self.attackerdata[var3];

      if(isDefined(var2)) {
        if(var2.isvalid || level.teambased && var0.team != var2.team) {
          var2 = undefined;
          self.attackerdata[var3] = undefined;
        }
      }

      if(!isDefined(var2) && istrue(var1)) {
        var2 = spawnStruct();
        var2.attacker = var0;
        var2.team = var0.team;
        var2.guid = var3;
        var2.isvalid = 1;
        var2.damage = 0;
        var2.hitcount = 0;
        var2.firsttimehit = gettime();
        self.attackerdata[var3] = var2;
      }
    }
  }

  return var2;
}

function non_player_clear_attacker_data() {
  self.attackerdata = undefined;
}

function non_player_should_ignore_damage(var0, var1, var2, var3) {
  if(non_player_should_ignore_damage_signature(var0, var1, var2, var3)) {
    return true;
  }

  if(isDefined(var1.basename)) {
    if(var3 != "MOD_MELEE") {
      switch (var1.basename) {
        case "iw8_spotter_scope_mp":
        case "iw8_spotter_scope_mp_ch3":
        case "iw8_green_beam_mp":
          return true;
      }
    }

    if(var3 == "MOD_IMPACT") {
      switch (var1.basename) {
        case "claymore_mp":
        case "at_mine_mp":
        case "c4_mp_p":
        case "semtex_mp":
        case "thermite_mp":
          return true;
      }
    } else {
      switch (var1.basename) {
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

function non_player_add_ignore_damage_signature(var0, var1, var2, var3) {
  if(!isDefined(self.ignoredamageid)) {
    self.ignoredamageid = 0;
  }

  if(!isDefined(self.ignoredamagesignatures)) {
    self.ignoredamagesignatures = [];
  }

  var4 = self.ignoredamageid;
  self.ignoredamageid++;

  if(isDefined(var1) && isstring(var1)) {
    var1 = getcompleteweaponname(var1);
  }

  var5 = spawnStruct();
  var5.id = var4;
  var5.attacker = var0;
  var5.objweapon = var1;
  var5.inflictor = var2;
  var5.meansofdeath = var3;
  var5.checkattacker = isDefined(var0);
  var5.checkobjweapon = isDefined(var1) && !nullweapon(var1);
  var5.checkinflictor = isDefined(var2);
  var5.checkmeansofdeath = isDefined(var3);
  self.ignoredamagesignatures[var4] = var5;
  return var4;
}

function non_player_remove_ignore_damage_signature(var0) {
  if(!isDefined(self.ignoredamagesignatures)) {
    return;
  }

  self.ignoredamagesignatures[var0] = undefined;
}

function non_player_clear_ignore_damage_signatures() {
  self.ignoredamagesignatures = undefined;
}

function non_player_should_ignore_damage_signature(var0, var1, var2, var3) {
  if(!isDefined(self.ignoredamagesignatures)) {
    return false;
  }

  if(isDefined(var1) && isstring(var1)) {
    var1 = getcompleteweaponname(var1);
  }

  foreach(var5 in self.ignoredamagesignatures) {
    if(!isDefined(var5)) {
      return false;
    }

    if(var5.checkattacker) {
      if(!isDefined(var5.attacker)) {
        non_player_remove_ignore_damage_signature(var5.id);
        continue;
      } else if(!isDefined(var0)) {
        continue;
      } else if(var0 != var5.attacker) {
        continue;
      }
    }

    if(var5.checkobjweapon) {
      if(!isDefined(var1) || nullweapon(var1)) {
        continue;
      } else if(var1 != var5.objweapon) {
        continue;
      }
    }

    if(var5.checkinflictor) {
      if(!isDefined(var5.inflictor)) {
        non_player_remove_ignore_damage_signature(var5.id);
        continue;
      } else if(!isDefined(var2)) {
        continue;
      } else if(var2 != var5.inflictor) {
        continue;
      }
    }

    if(var5.checkmeansofdeath) {
      if(!isDefined(var3)) {
        continue;
      } else if(var3 != var5.meansofdeath) {
        continue;
      }
    }

    return true;
  }

  return false;
}

function islauncherdirectimpactdamage(var0, var1, var2) {
  if(scripts\mp\utility\weapon::isaxeweapon(var0)) {
    return false;
  }

  if(var0.type != "projectile") {
    return false;
  }

  if(istrue(var2) && var0.isalternate && isDefined(var0.underbarrel)) {
    return false;
  }

  return var1 == "MOD_IMPACT" || var1 == "MOD_PROJECTILE" || var1 == "MOD_GRENADE";
}