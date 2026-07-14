/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\cp_mp\damagefeedback.gsc
********************************************/

#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;
#namespace damagefeedback;

function damagefeedback_init() {
  level.hitmarkerpriorities = [];
  level.hitmarkerpriorities["standard"] = 40;
  level.hitmarkerpriorities["standardspread"] = 50;
  level.hitmarkerpriorities["standardspreadarmor"] = 70;
  level.hitmarkerpriorities["standardspreadarmorbreak"] = 71;
  level.hitmarkerpriorities["standardarmor"] = 60;
  level.hitmarkerpriorities["standardarmorbreak"] = 61;
  level.hitmarkerpriorities["threeplatearmorbreak"] = 1;
  level.hitmarkerpriorities["temperedarmorbreak"] = 1;
  level.hitmarkerpriorities["hitequip"] = 30;
  level.hitmarkerpriorities["capturebotcapture"] = 1;
  utility::registersharedfunc(#"hitmarker", #"updatehitmarker_sharedfunc", &updatehitmarker);
  utility::registersharedfunc(#"hitmarker", #"updateDamageFeedback_SharedFunc", &updatedamagefeedback);

  if(isusingstackablehitmarker()) {
    function_30b4ab641bd454c5();
    utility::callsharedfunc(#"hud", #"initstackablehitmarker");
  }
}

function function_df1b63a8a4a2a089(marker, priority) {
  level.hitmarkerpriorities[marker] = priority;
}

function updatedamagefeedback(icontype, killingblow, headshot, hitmarkertype, suppressaudio, nonplayer, targetentnum, armorPlateCount, var_795e8a31194a39ac, var_7731d58f6f82f082, var_a45d01a8e66488b2) {
  if(!isPlayer(self)) {
    return;
  }

  if(isDefined(var_7731d58f6f82f082.victim.var_f03e89372b1412a0)) {
    icontype = var_7731d58f6f82f082.victim.var_f03e89372b1412a0;
  }

  if(isDefined(var_7731d58f6f82f082.victim.var_e6f66612af155250)) {
    hitmarkertype = var_7731d58f6f82f082.victim.var_e6f66612af155250;
  }

  if(!isDefined(hitmarkertype)) {
    hitmarkertype = "standard";
  }

  var_8212907cdf7799d9 = !level.damagefeedbacknosound && !suppressaudio;
  bhflags = killingblow ? 80 : 64;

  if(var_7731d58f6f82f082.victim.var_bdc51be80cbeef82) {
    bhflags |= 8192;
  }

  if(getdvarint(@ "hash_7382dc98a4169f32", 0) == 1 && icontype == "hitequip") {
    bhflags |= 4096;
  }

  if(var_8212907cdf7799d9) {
    if(isDefined(var_7731d58f6f82f082)) {
      self function_272b0be3269613f8(var_7731d58f6f82f082.victim, var_7731d58f6f82f082.objweapon, var_7731d58f6f82f082.point, var_7731d58f6f82f082.direction_vec, bhflags, var_7731d58f6f82f082.mod);
      var_8212907cdf7799d9 = 0;
    }
  }

  switch (icontype) {
    case #"hash_db653a4972b3c13b":
      break;
    case #"hash_c1715405ce8d27ea":
      if(utility::issharedfuncdefined(#"supers", #"hasAPRRounds")) {
        if(self[[utility::getsharedfunc(#"supers", #"hasAPRRounds")]]()) {
          var_31e07bf8b693436f = "hitsuppression";
          updatehitmarker(hitmarkertype, killingblow, headshot, nonplayer, var_31e07bf8b693436f, targetentnum, undefined, var_795e8a31194a39ac, var_a45d01a8e66488b2);
          break;
        }
      }
    case #"hash_567a00990919afc":
    case #"hash_1693bdac7164b529":
    case #"hash_174b8ab0916524d8":
    case #"hash_1c6e430811861ac0":
    case #"hash_1d1421f4263e7b65":
    case #"hash_21506e0eab793b6d":
    case #"hash_251e2c7ad46ab2a1":
    case #"hash_286b270eeb92acab":
    case #"hash_29d29edc3c4bd21f":
    case #"hash_2f87b65a1756fbc1":
    case #"hash_2fc100f2b74f0620":
    case #"hash_302bdfe2981fa111":
    case #"hash_350f19f266bbb791":
    case #"hash_3b8a7e998825e7c0":
    case #"hash_3c687341f7275bb2":
    case #"hash_3d2b6e8b2936b300":
    case #"hash_3dfff68d08667b7e":
    case #"hash_3f1bede7caeea324":
    case #"hash_425f5f52214e9881":
    case #"hash_447c3e0533ff2b55":
    case #"hash_4b4056ee5e5c3555":
    case #"hash_4b428ac967c333aa":
    case #"hash_4bdab969a8904cac":
    case #"hash_51b7478301339f8a":
    case #"hash_5b770c686e85a82a":
    case #"hash_5c035610dbc2c193":
    case #"hash_6145e54d4160575d":
    case #"hash_635a3ba72a0e2577":
    case #"hash_645b9186bb9ba5b1":
    case #"hash_6ca451135b296dca":
    case #"hash_6caa86fc10182857":
    case #"hash_6d93a8d02d1b75e1":
    case #"hash_6eb75fd530d36be9":
    case #"hash_74931d6ea2a2d532":
    case #"hash_753c5278c6fb3112":
    case #"hash_7bee0512ecd80819":
    case #"hash_7df4cd93173dca7c":
    case #"hash_83edb350494625b7":
    case #"hash_93712eceeb1ff510":
    case #"hash_94b62a4a3d5fefb8":
    case #"hash_94d5b36d557e08cd":
    case #"hash_9bddb43d21e0ec36":
    case #"hash_a1c8ae5eec4e0bc2":
    case #"hash_a38fa9efabd2c0a4":
    case #"hash_a48aa23549bc0fc0":
    case #"hash_a54ca25c946c6e33":
    case #"hash_ae0ffa69a3ca10d8":
    case #"hash_b3b5fb9c8c5f3e09":
    case #"hash_bd3b02ce8ef8b988":
    case #"hash_be79ab05413f45a6":
    case #"hash_beb8699c16cf0ed1":
    case #"hash_c31893d5dff560f7":
    case #"hash_c58cc85ba9fb86d4":
    case #"hash_c72aef7372cb1718":
    case #"hash_c78eafc8bcf110e9":
    case #"hash_c7a63d2736f184a3":
    case #"hash_caf75edba093ff2d":
    case #"hash_cbc78f7c7ad72ad1":
    case #"hash_cbe306d411da2893":
    case #"hash_d0337e5728a0b33f":
    case #"hash_d10b855589d3c416":
    case #"hash_d5081dfa38c24b32":
    case #"hash_d5fcf5b86ed9ef29":
    case #"hash_18392ddb8b61cb4":
    case #"hash_dc64d86a5dcc42d3":
    case #"hash_e0acb4f805778e36":
    case #"hash_e60a54e34fede587":
    case #"hash_f1e8cac7ec85e5bc":
    case #"hash_f35badfafbc16a9e":
    case #"hash_ff1e12935aa62b10":
      updatehitmarker(hitmarkertype, killingblow, headshot, nonplayer, icontype, targetentnum, armorPlateCount, var_795e8a31194a39ac, var_8212907cdf7799d9, var_a45d01a8e66488b2);
      break;
    case #"hash_43044138cc3dd49b":
      icontype = "hitarmorlight";
      updatehitmarker(hitmarkertype, killingblow, headshot, nonplayer, icontype, targetentnum, armorPlateCount, var_795e8a31194a39ac, var_8212907cdf7799d9, var_a45d01a8e66488b2);
      break;
    default:
      updatehitmarker(hitmarkertype, killingblow, headshot, nonplayer, undefined, targetentnum, armorPlateCount, var_795e8a31194a39ac, var_8212907cdf7799d9, var_a45d01a8e66488b2);
      break;
  }
}

function updatehitmarker(markertype, killingblow, headshot, nonplayer, icontype, targetentnum, armorPlateCount, var_795e8a31194a39ac, var_8212907cdf7799d9, var_a45d01a8e66488b2) {
  if(function_8f265b6101baf2bb()) {
    return;
  }

  var_32dbca3143d9c4a5 = level.sharedfuncs[#"damage"][#"hash_b78ec0f2ad4cfbe1"];

  if(var_32dbca3143d9c4a5 && self[[var_32dbca3143d9c4a5]]()) {
    return;
  }

  if(!isDefined(markertype)) {
    return;
  }

  if(!isDefined(killingblow)) {
    killingblow = 0;
  }

  if(!isDefined(headshot)) {
    headshot = 0;
  }

  if(!isDefined(nonplayer)) {
    nonplayer = 0;
  }

  if(!isDefined(targetentnum)) {
    targetentnum = -1;
  }

  if(!isDefined(armorPlateCount)) {
    armorPlateCount = 0;
  }

  if(!isDefined(var_8212907cdf7799d9)) {
    var_8212907cdf7799d9 = 0;
  }

  hitmarkertypestring = markertype;

  if(!isDefined(hitmarkertypestring) || !isstring(hitmarkertypestring)) {
    hitmarkertypestring = "standard";
  }

  self setclientomnvar("damage_feedback_is_armor_intact", istrue(var_a45d01a8e66488b2));

  if(getdvarint(@ "hash_1db87c3b655b5645", 0) == 1) {
    hitmarkernotif = spawnStruct();
    hitmarkernotif.markertype = hitmarkertypestring;
    hitmarkernotif.killingblow = killingblow;
    hitmarkernotif.headshot = headshot;
    hitmarkernotif.nonplayer = nonplayer;
    hitmarkernotif.icontype = icontype;
    hitmarkernotif.targetentnum = targetentnum;
    hitmarkernotif.timestamp = gettime();

    if(!isDefined(self.hitmarkerstack)) {
      self.hitmarkerstack = [];
    }

    self.hitmarkerstack[self.hitmarkerstack.size] = hitmarkernotif;
    thread function_33722a6a7155bedc();
    return;
  }

  if(isusingstackablehitmarker()) {
    markerflag = 0;

    if(!isint(markertype)) {
      switch (markertype ?? "") {
        case #"hash_c15005fd82d7fc78":
        case #"hash_c1715405ce8d27ea":
          markertype = 3;
          break;
        case #"hash_4956ba874a13f6a8":
          markertype = 1;
          break;
      }
    }

    switch (markertype) {
      case 1:
        markerflag |= 1;

        if(killingblow) {
          markerflag |= 2;
        }

        if(var_795e8a31194a39ac.isfriendlyhit) {
          markerflag |= 4;
        }

        if(headshot) {
          markerflag |= 8;
        }

        isarmorhit = 0;
        isarmorbreak = 0;

        if(isDefined(icontype)) {
          switch (icontype) {
            case #"hash_286b270eeb92acab":
            case #"hash_2f87b65a1756fbc1":
            case #"hash_c58cc85ba9fb86d4":
            case #"hash_dc64d86a5dcc42d3":
              markerflag |= 16;
              isarmorhit = 1;
              break;
            case #"hash_3dfff68d08667b7e":
            case #"hash_635a3ba72a0e2577":
            case #"hash_9bddb43d21e0ec36":
            case #"hash_a38fa9efabd2c0a4":
            case #"hash_a54ca25c946c6e33":
              markerflag |= 32;
              isarmorbreak = 1;
              break;
            case #"hash_29d29edc3c4bd21f":
              markerflag |= 16;
              markerflag |= 128;
              isarmorhit = 1;
              break;
            case #"hash_567a00990919afc":
              markerflag |= 32;
              markerflag |= 128;
              isarmorbreak = 1;
              break;
          }
        }

        if(var_795e8a31194a39ac.isenemydown) {
          markerflag |= 64;
        }

        if(var_8212907cdf7799d9 && var_795e8a31194a39ac.var_f561a4dd442b0d91 && !isarmorhit && !isarmorbreak) {
          var_32dbca3143d9c4a5 = level.sharedfuncs[#"hud"][#"hash_43bff838e7c0cf81"];

          if(isDefined(var_32dbca3143d9c4a5)) {
            soundtype = self[[var_32dbca3143d9c4a5]](killingblow, var_795e8a31194a39ac.isfriendlyhit, headshot, var_795e8a31194a39ac.isenemydown, isarmorhit, isarmorbreak);
          } else {
            soundtype = undefined;
          }

          var_32dbca3143d9c4a5 = level.sharedfuncs[#"hud"][#"hash_84d4f784de00c6af"];

          if(isDefined(var_32dbca3143d9c4a5)) {
            self[[var_32dbca3143d9c4a5]](soundtype, var_795e8a31194a39ac, killingblow);
          }
        }

        var_32dbca3143d9c4a5 = level.sharedfuncs[#"hud"][#"hash_82fe4f75d53751e1"];

        if(isDefined(var_32dbca3143d9c4a5)) {
          self[[var_32dbca3143d9c4a5]]("damage_feedback_weapon", markerflag, killingblow);
        }

        break;
      case 2:
        markerflag |= 1;

        if(killingblow) {
          markerflag |= 2;
        }

        if(var_795e8a31194a39ac.isfriendly) {
          markerflag |= 4;
        }

        if(var_8212907cdf7799d9 && var_795e8a31194a39ac.var_f561a4dd442b0d91) {
          soundtype = utility::callsharedfunc(#"hud", #"hash_eb86447382b1de03", killingblow, var_795e8a31194a39ac);
          utility::callsharedfunc(#"hud", #"hash_84d4f784de00c6af", soundtype, var_795e8a31194a39ac, killingblow);
        }

        var_32dbca3143d9c4a5 = level.sharedfuncs[#"hud"][#"hash_82fe4f75d53751e1"];

        if(isDefined(var_32dbca3143d9c4a5)) {
          self[[var_32dbca3143d9c4a5]]("damage_feedback_equip", markerflag, killingblow);
        }

        break;
      case 3:
        markerflag |= 1;

        if(killingblow) {
          markerflag |= 2;
        }

        if(var_8212907cdf7799d9 && istrue(var_795e8a31194a39ac.var_f561a4dd442b0d91) && var_795e8a31194a39ac.var_4dba57e6e29ded8e) {
          soundtype = utility::callsharedfunc(#"hud", #"hash_c8c81e6b434c4313", killingblow);
          utility::callsharedfunc(#"hud", #"hash_84d4f784de00c6af", soundtype, var_795e8a31194a39ac);
        }

        var_32dbca3143d9c4a5 = level.sharedfuncs[#"hud"][#"hash_82fe4f75d53751e1"];

        if(isDefined(var_32dbca3143d9c4a5)) {
          self[[var_32dbca3143d9c4a5]]("damage_feedback_hardobject", markerflag, killingblow);
        }

        break;
    }

    if(isDefined(icontype)) {
      laststandoverride = getdvarint(@ "hash_3a945552f73f4e02", 1) == 1 && self getclientomnvar("damage_feedback_icon") == "hitlaststand" && self getclientomnvar("damage_feedback_icon_notify") == gettime();

      if(!killingblow && !laststandoverride) {
        self setclientomnvar("damage_feedback_icon", icontype);
        self setclientomnvar("damage_feedback_icon_notify", gettime());
      }

      if(icontype == "hitheadhunter") {
        self setclientomnvar("damage_feedback_icon", icontype);
        self setclientomnvar("damage_feedback_icon_notify", gettime());
      } else if(icontype == "hitveharmorbreak") {
        self setclientomnvar("damage_feedback_icon", icontype);
        self setclientomnvar("damage_feedback_icon_notify", gettime());
      }
    }

    return;
  }

  priority = gethitmarkerpriority(markertype);

  if(self.lasthitmarkertime == gettime() && priority <= self.lasthitmarkerpriority && !killingblow) {
    return;
  }

  self.lasthitmarkertime = gettime();
  self.lasthitmarkerpriority = priority;

  if(isDefined(icontype)) {
    if(!killingblow) {
      self setclientomnvar("damage_feedback_icon", icontype);
      self setclientomnvar("damage_feedback_icon_notify", gettime());
    }

    if(icontype == "hitheadhunter") {
      self setclientomnvar("damage_feedback_icon", icontype);
      self setclientomnvar("damage_feedback_icon_notify", gettime());
    } else if(icontype == "hitveharmorbreak") {
      self setclientomnvar("damage_feedback_icon", icontype);
      self setclientomnvar("damage_feedback_icon_notify", gettime());
    }
  }

  if(!isDefined(icontype) || icontype != "hitnobulletdamage" && icontype != "capturebotcapture") {
    self setclientomnvar("damage_feedback", markertype);
    self setclientomnvar("damage_feedback_notify", gettime());
  }

  if(killingblow) {
    self setclientomnvar("damage_feedback_kill", 1);
  } else {
    self setclientomnvar("damage_feedback_kill", 0);
  }

  if(headshot) {
    self setclientomnvar("damage_feedback_headshot", 1);
  } else {
    self setclientomnvar("damage_feedback_headshot", 0);
  }

  if(nonplayer) {
    self setclientomnvar("damage_feedback_nonplayer", 1);
  } else {
    self setclientomnvar("damage_feedback_nonplayer", 0);
  }

  self setclientomnvar("damage_feedback_armor", int(min(armorPlateCount, 3)));

  if(targetentnum > -1) {
    self setclientomnvar("damage_feedback_entity", targetentnum);
    self setclientomnvar("damage_feedback_entity_notify", gettime());
  }
}

function gethitmarkerpriority(hitmarkertype) {
  if(!isDefined(level.hitmarkerpriorities[hitmarkertype])) {
    return 0;
  }

  return level.hitmarkerpriorities[hitmarkertype];
}

function hudicontype(typehit) {
  nosound = 0;

  if(isDefined(level.damagefeedbacknosound) && level.damagefeedbacknosound) {
    nosound = 1;
  }

  if(!isPlayer(self)) {
    return;
  }

  switch (typehit) {
    case #"hash_271ec2370f46ea":
    case #"hash_7a494a6441a8df6":
    case #"hash_18144547f6b061d8":
    case #"hash_5c57b61aa79410db":
    case #"hash_b8d1ac6e6b8e3230":
    case #"hash_d6a7d182fd397b0a":
      if(!nosound) {
        self playlocalsound("scavenger_pack_pickup");
      }

      self setclientomnvar("damage_feedback_other", typehit);
      break;
    case #"hash_530ba8d82158ca97":
      if(!nosound) {
        self playlocalsound("eqp_combat_axe_pickup_plr");
      }

      self setclientomnvar("damage_feedback_other", typehit);
      break;
    case #"hash_8747706404533493":
    case #"hash_2610981e9f5db54f":
    case #"hash_2ab98cab4066a74e":
      if(!nosound) {
        self playlocalsound("weap_pickup_knife_plr");
      }

      self setclientomnvar("damage_feedback_other", typehit);
      break;
    case #"hash_1041aa27487b00f8":
      self setclientomnvar("damage_feedback_other", typehit);
      break;
    case #"hash_23cdc38a2fa78bb4":
    case #"hash_23f2c68a2fc41281":
    case #"hash_11b2f521291b9664":
    case #"hash_36b7174a04de8799":
    case #"hash_4900f95643f06fb5":
    case #"hash_5d11ac1131cddab1":
    case #"hash_66bc333667dfeb53":
    case #"hash_7983828e72e83a3e":
    case #"hash_7da1870a0ffb921d":
    case #"hash_80c5f88142053bf4":
    case #"hash_85d7e1863dca54c4":
    case #"hash_96dd9dc314bcbb3c":
    case #"hash_9d11909dc5bbaa26":
    case #"hash_9d57562863499a06":
    case #"hash_a0319e349a692b8f":
    case #"hash_a68c414683465b09":
    case #"hash_a8e4a914fb03a4d5":
    case #"hash_acd2c79dce3b9907":
    case #"hash_d8f795eb14c75e6":
    case #"hash_c9a436974fe60919":
    case #"hash_dae956a4a82da2d7":
    case #"hash_d4c33f35d7b04f87":
    case #"hash_d5db533de9b14785":
    case #"hash_1d28d8c7a5e03548":
    case #"hash_fa1e80f6bd5b8e72":
    case #"hash_e7803d9decd089c2":
    case #"hash_e91729d4ef79ca26":
    case #"hash_ed1356899cfee3ed":
      self setclientomnvar("damage_feedback_other", typehit);
      break;
    case #"hash_cd8e1c59636518f2":
      self setclientomnvar("damage_feedback_other", typehit);
      break;
    case #"hash_cbe9eb1aab764cbc":
      self setclientomnvar("damage_feedback_other", typehit);
      break;
    case #"hash_2fa014aa1b7da22":
      self setclientomnvar("damage_feedback_other", typehit);
      break;
    case #"hash_e815145ef7ef1ae7":
      self setclientomnvar("damage_feedback_other", typehit);
      break;
  }

  thread function_a20cfa55eacc50f8();
}

function function_a20cfa55eacc50f8() {
  self notify("hitIconReset");
  self endon("disconnect");
  self endon("hitIconReset");
  waitframe();
  self setclientomnvar("damage_feedback_other", "standard");
}

function function_8f265b6101baf2bb() {
  if(getdvarint(@ "hash_6735e9fcb3e821b9", 0)) {
    return true;
  }

  return istrue(level.disablehitmarkers);
}

function function_33722a6a7155bedc() {
  self notify("hitmarkerStack_singleton");
  self endon("hitmarkerStack_singleton");

  while(isDefined(self.hitmarkerstack) && self.hitmarkerstack.size != 0) {
    waitframe();

    if(!isDefined(self)) {
      println("<dev string:x24>");
      break;
    }

    if(!isDefined(self.hitmarkerstack)) {
      println("<dev string:x89>");
      continue;
    }

    var_709db3290851c12 = self.hitmarkerstack[0];
    self.hitmarkerstack[0] = undefined;
    self.hitmarkerstack = function_5713d46873b29625(self.hitmarkerstack);

    if(!isDefined(var_709db3290851c12)) {
      continue;
    }

    if(isDefined(var_709db3290851c12.icontype) && !var_709db3290851c12.killingblow) {
      self setclientomnvar("damage_feedback_icon", var_709db3290851c12.icontype);
      self setclientomnvar("damage_feedback_icon_notify", var_709db3290851c12.timestamp);
    }

    if(var_709db3290851c12.icontype == "hitheadhunter") {
      self setclientomnvar("damage_feedback_icon", var_709db3290851c12.icontype);
      self setclientomnvar("damage_feedback_icon_notify", var_709db3290851c12.timestamp);
    }

    if(var_709db3290851c12.icontype == "hitveharmorbreak") {
      self setclientomnvar("damage_feedback_icon", var_709db3290851c12.icontype);
      self setclientomnvar("damage_feedback_icon_notify", var_709db3290851c12.timestamp);
    }

    self setclientomnvar("damage_feedback", var_709db3290851c12.markertype);
    self setclientomnvar("damage_feedback_notify", var_709db3290851c12.timestamp);

    if(var_709db3290851c12.killingblow) {
      self setclientomnvar("damage_feedback_kill", 1);
    } else {
      self setclientomnvar("damage_feedback_kill", 0);
    }

    if(var_709db3290851c12.headshot) {
      self setclientomnvar("damage_feedback_headshot", 1);
    } else {
      self setclientomnvar("damage_feedback_headshot", 0);
    }

    if(var_709db3290851c12.nonplayer) {
      self setclientomnvar("damage_feedback_nonplayer", 1);
    } else {
      self setclientomnvar("damage_feedback_nonplayer", 0);
    }

    if(var_709db3290851c12.targetentnum > -1) {
      self setclientomnvar("damage_feedback_entity", var_709db3290851c12.targetentnum);
      self setclientomnvar("damage_feedback_entity_notify", gettime());
    }
  }
}

function function_5a9c0fdbdf609949(attacker, objweapon, meansofdeath, isbulletdamage, isweaponkillstreak, isweaponprimaryweapon, isweaponwonderweapon, var_f2e6ca28742a084a) {
  var_9513430aa2e14653 = !attacker.var_f92369164340ad6e && (isbulletdamage && isweaponprimaryweapon || meansofdeath == "MOD_EXPLOSIVE_BULLET" && isweaponprimaryweapon || utility::ismeleedamage(meansofdeath) || weapon_utility::function_c1972d0d01397a22(objweapon) && (var_f2e6ca28742a084a || !isweaponkillstreak) || utility::isweaponthrowingknife(objweapon) || var_f2e6ca28742a084a || isweaponkillstreak && attacker vehicle::is_vehicle() && isDefined(attacker.owner) && attacker.owner utility::isusingremote() || utility::isimpactdamage(meansofdeath) || utility::ismeatshielddamage(meansofdeath) || isweaponwonderweapon);

  if(var_9513430aa2e14653) {
    return 1;
  }

  return 2;
}

function isusingstackablehitmarker() {
  return istrue(level.gamemodebundle.var_ff5875c91bf48d60);
}

function function_63bdec1d3fd95d25(isfriendlyhit, victimentity, isbulletdamage, objweapon, isexecution, isexplosivebullet, isweaponkillstreak, var_c3b5e08c98a28e3a) {
  if(isDefined(objweapon.var_4d2c06f650e96f3c) && objweapon.var_4d2c06f650e96f3c != 0) {
    soundtypeoverride = objweapon.var_4d2c06f650e96f3c;
  }

  isbulletdamage = isbulletdamage || isexplosivebullet && !isweaponkillstreak;
  var_9a81e3064446ab3b = isweaponkillstreak && !var_c3b5e08c98a28e3a;
  var_f561a4dd442b0d91 = !isexecution && (!isbulletdamage || objweapon.isbeam || isbulletdamage && var_9a81e3064446ab3b);

  if(isDefined(victimentity.var_1f5c3835df679814) || victimentity.var_aab5beb67c1704ec) {
    var_f561a4dd442b0d91 = 1;
  }

  return {
    #soundtypeoverride: soundtypeoverride, #var_f561a4dd442b0d91: var_f561a4dd442b0d91, #victimentity: victimentity, #isfriendlyhit: isfriendlyhit
  };
}

function function_30b4ab641bd454c5() {
  setDvar(@ "hash_2951db54014fba41", 6);
  setDvar(@ "hash_94b34d23bf532a3f", 6);
  setDvar(@ "hash_cfad6a44e0c5cf8f", 6);
  setDvar(@ "hash_2974ed540176298f", 3);
  setDvar(@ "hash_94903b23bf2cbaf1", 3);
  setDvar(@ "hash_cf8a7844e09fa6a1", 3);
}