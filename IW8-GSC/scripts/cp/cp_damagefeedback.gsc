/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_damagefeedback.gsc
***********************************************/

function init() {
  level.hitmarkerpriorities = [];
  level.hitmarkerpriorities["standard"] = 40;
  level.hitmarkerpriorities["standardspread"] = 50;
  level.hitmarkerpriorities["hitequip"] = 30;
}

function gethitmarkerpriority(var0) {
  if(!isDefined(level.hitmarkerpriorities[var0])) {
    return 0;
  }

  return level.hitmarkerpriorities[var0];
}

function hudicontype(var0) {
  var1 = 0;

  if(isDefined(level.damagefeedbacknosound) && level.damagefeedbacknosound) {
    var1 = 1;
  }

  if(!isPlayer(self)) {
    return;
  }

  switch (var0) {
    case "crossbowbolt":
    case "ammobox":
    case "scavenger":
    case "throwingknife":
      if(!var1) {
        self playlocalsound("scavenger_pack_pickup");
      }

      if(!level.hardcoremode) {
        self setclientomnvar("damage_feedback_other", var0);
      }

      break;
    case "eqp_ping":
      if(!level.hardcoremode) {
        self setclientomnvar("damage_feedback_other", var0);
      }

      break;
    case "suppression":
      var0 = "suppression";

      if(!level.hardcoremode) {
        self setclientomnvar("damage_feedback_other", var0);
      }

      break;
  }
}

function process_damage_feedback(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  var11 = isDefined(var1) && isDefined(var1.classname) && isDefined(var1.classname) && !isDefined(var1.gunner) && (var1.classname == "script_vehicle" || var1.classname == "misc_turret" || var1.classname == "script_model");
  var12 = undefined;

  if(var11 && isDefined(var1.gunner)) {
    var12 = var1.gunner;
  } else if(isDefined(var1) && isDefined(var1.owner)) {
    var12 = var1.owner;
  } else {
    var12 = var1;
  }

  var13 = scripts\engine\utility::isbulletdamage(var4);
  var14 = scripts\engine\utility::ter_op(var13 && scripts\cp\cp_weapon::isprimaryweapon(var5), "standardspread", "standard");
  var15 = 0;

  if(isDefined(var1) && isDefined(var1.class) && var1.class == "engineer") {
    if(isDefined(var4) && scripts\engine\utility::isbulletdamage(var4)) {
      var15 = 1;
    }
  }

  if(isDefined(var12) && var12 != var10 && var2 > 0 && (!isDefined(var8) || var8 != "shield")) {
    var16 = !var10 scripts\cp_mp\utility\player_utility::_isalive() || isagent(var10) && var2 >= var10.health;

    if(istrue(var10.isjuggernaut)) {
      var14 = "hitjuggernaut";
    } else if(var3 &level.idflags_stun) {
      var14 = "stun";
    } else if(scripts\cp\cp_damage::istacticaldamage(var5, var4) && var10 scripts\cp\utility::_hasperk("specialty_stun_resistance")) {
      var14 = "hittacresist";
    } else if(isexplosivedamagemod(var4) && var10 scripts\cp\utility::_hasperk("specialty_blastshield") && !scripts\cp\cp_damage::damage_should_ignore_blast_shield(var1, var10, var5, var4, var0, var8)) {
      var14 = "hitblastshield";
    } else if(!var15 && scripts\cp\cp_modular_spawning::is_armored()) {
      var14 = "hitarmorheavy";
    } else if(var10 scripts\cp\utility::_hasperk("specialty_pistoldeath") && isDefined(var10.inlaststand) && var10.inlaststand == 1 && !var10.hasshownlaststandicon) {
      var10.hasshownlaststandicon = 1;
      var14 = "hitlaststand";
    }

    if(isDefined(var10.playerforcespawn) && var10.playerforcespawn.size > 1) {
      var14 = "cp_relic_buff";
    }

    var17 = "standard";
    var18 = weaponclass(var5);
    var19 = var18 == "spread";
    var20 = !var19 && scripts\cp\utility::isheadshot(var5, var8, var4, var1);
    var21 = 1;
    var22 = var4 == "MOD_MELEE";
    var23 = "" + gettime();

    if(!var22 && var19 && isDefined(var12.pelletdmg) && isDefined(var12.pelletdmg[var23]) && isDefined(var12.pelletdmg[var23][var10.guid]) && var12.pelletdmg[var23][var10.guid] > 1) {
      if(var16) {
        var22 = 1;
      } else {
        var21 = 0;
      }
    }

    var24 = undefined;

    if(var10.health <= var2) {
      var24 = 1;
    }

    var20 = scripts\cp\utility::isheadshot(var5, var8, var4, var1);

    if(var21) {
      if(isDefined(var1)) {
        if(isDefined(var1.owner)) {
          thread updatedamagefeedback(var1.owner, var14, var24, var2, var20, 0, var1, var0, var1);
          return;
        }

        thread updatedamagefeedback(var1, var14, var24, var2, var20, 0, var1, var0, var1);
        return;
      }

      return;
    }

    return;
  }
}

function updatedamagefeedback(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  if(isDefined(level.friendly_damage_check) && [[level.friendly_damage_check]](var5, var6, var7)) {
    return;
  }

  if(!isPlayer(self)) {
    return;
  }

  if(!isDefined(var0)) {
    var0 = "standard";
  }

  if(!isDefined(var8)) {
    var8 = 0;
  }

  if((!isDefined(level.damagefeedbacknosound) || !level.damagefeedbacknosound) && !var8) {
    if(!isDefined(self.hitmarkeraudioevents)) {
      self.hitmarkeraudioevents = 0;
    }

    self.hitmarkeraudioevents++;
    self setclientomnvar("ui_hitmarker_audio_events", self.hitmarkeraudioevents % 16);
  }

  switch (var0) {
    case "none":
      break;
    case "hitcritical":
      var0 = "standard";
      var3 = 1;
      break;
    case "hitnooutline":
    case "hithelmetheavybreak":
    case "hithelmetheavy":
    case "hithelmetlightbreak":
    case "hithelmetlight":
    case "hitarmorheavybreak":
    case "hitarmorlightbreak":
    case "hitarmorlight":
    case "hittrophysystem":
    case "hitadrenaline":
    case "hitspawnprotect":
    case "hitlaststand":
    case "hitarmorheavy":
    case "hitblastshield":
    case "hittacresist":
    case "hitjuggernaut":
    case "hitequip":
      if(!istrue(var1)) {
        self setclientomnvar("damage_feedback_icon", var0);
        self setclientomnvar("damage_feedback_icon_notify", gettime());
      }

      break;
    default:
      break;
  }

  updatehitmarker(var0, var3, var2, var4, var1, 0);
}

function updatehitmarker(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var0)) {
    return;
  }

  if(var0 == "") {
    var0 = "standard";
  }

  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(var4)) {
    var4 = 0;
  }

  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(!isDefined(var3)) {
    var3 = 0;
  }

  if(!isDefined(var5)) {
    var5 = 0;
  }

  if(!isPlayer(self)) {
    if(isDefined(self.owner) && isPlayer(self.owner)) {
      return;
    }
  }

  var6 = gethitmarkerpriority(var0);

  if(isDefined(self.lasthitmarkertime) && self.lasthitmarkertime == gettime() && var6 <= self.lasthitmarkerpriority && !var4) {
    return;
  }

  self.lasthitmarkertime = gettime();
  self.lasthitmarkerpriority = var6;
  self setclientomnvar("damage_feedback", var0);
  self setclientomnvar("damage_feedback_notify", gettime());

  if(var4) {
    self setclientomnvar("damage_feedback_kill", 1);
  } else {
    self setclientomnvar("damage_feedback_kill", 0);
  }

  if(var1) {
    self setclientomnvar("damage_feedback_headshot", 1);
  } else {
    self setclientomnvar("damage_feedback_headshot", 0);
  }

  if(var5) {
    self setclientomnvar("damage_feedback_nonplayer", 1);
  } else {
    self setclientomnvar("damage_feedback_nonplayer", 0);
  }

  if(isDefined(var2)) {
    self setclientomnvar("ui_damage_amount", int(var2));
    return;
  }
}