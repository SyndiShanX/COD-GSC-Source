/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\damagefeedback.gsc
***********************************************/

#using scripts\common\devgui;
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
  function_25f98f1b652f57ec();

  level thread function_a76226d272200c64();

  registersharedfunc("hitmarker", "updateHitMarker_SharedFunc", &updatehitmarker);
  registersharedfunc("hitmarker", "updateDamageFeedback_SharedFunc", &updatedamagefeedback);
}

function function_7bc7c3983cef0956(marker, priority) {
  level.hitmarkerpriorities[marker] = priority;
}

function updatedamagefeedback(icontype, killingblow, headshot, hitmarkertype, suppressaudio, nonplayer, targetentnum, armorplatecount, var_203066c6662e1f2d) {
  if(!isPlayer(self)) {
    return;
  }

  if(!isDefined(hitmarkertype)) {
    hitmarkertype = "standard";
  }

  if(!isDefined(suppressaudio)) {
    suppressaudio = 0;
  }

  if((!isDefined(level.damagefeedbacknosound) || !level.damagefeedbacknosound) && !suppressaudio) {
    if(!isDefined(self.hitmarkeraudioevents)) {
      self.hitmarkeraudioevents = 0;
    }

    self.hitmarkeraudioevents++;
    self setclientomnvar("ui_hitmarker_audio_events", self.hitmarkeraudioevents % 16);
  }

  switch (icontype) {
    case #"hash_db653a4972b3c13b":
      break;
    case #"hash_c1715405ce8d27ea":
      if(issharedfuncdefined("supers", "hasAPRRounds")) {
        if(self[[getsharedfunc("supers", "hasAPRRounds")]]()) {
          var_7a8a48132995d0fc = "hitsuppression";
          updatehitmarker(hitmarkertype, killingblow, headshot, nonplayer, var_7a8a48132995d0fc, targetentnum, undefined, var_203066c6662e1f2d);
          break;
        }
      }
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
    case #"hash_3dfff68d08667b7e":
    case #"hash_3f1bede7caeea324":
    case #"hash_425f5f52214e9881":
    case #"hash_42a56e29d7636b5d":
    case #"hash_4b4056ee5e5c3555":
    case #"hash_4bdab969a8904cac":
    case #"hash_5b770c686e85a82a":
    case #"hash_5c035610dbc2c193":
    case #"hash_6145e54d4160575d":
    case #"hash_635a3ba72a0e2577":
    case #"hash_645b9186bb9ba5b1":
    case #"hash_6caa86fc10182857":
    case #"hash_6d93a8d02d1b75e1":
    case #"hash_6eb75fd530d36be9":
    case #"hash_7bee0512ecd80819":
    case #"hash_7df4cd93173dca7c":
    case #"hash_93712eceeb1ff510":
    case #"hash_94d5b36d557e08cd":
    case #"hash_9bddb43d21e0ec36":
    case #"hash_a1c8ae5eec4e0bc2":
    case #"hash_a38fa9efabd2c0a4":
    case #"hash_a54ca25c946c6e33":
    case #"hash_b3b5fb9c8c5f3e09":
    case #"hash_bd3b02ce8ef8b988":
    case #"hash_18392ddb8b61cb4":
    case #"hash_c58cc85ba9fb86d4":
    case #"hash_cbc78f7c7ad72ad1":
    case #"hash_d10b855589d3c416":
    case #"hash_d5081dfa38c24b32":
    case #"hash_d5fcf5b86ed9ef29":
    case #"hash_567a00990919afc":
    case #"hash_dc64d86a5dcc42d3":
    case #"hash_e0acb4f805778e36":
    case #"hash_ff1e12935aa62b10":
      updatehitmarker(hitmarkertype, killingblow, headshot, nonplayer, icontype, targetentnum, armorplatecount, var_203066c6662e1f2d);
      break;
    default:
      updatehitmarker(hitmarkertype, killingblow, headshot, nonplayer, undefined, targetentnum, armorplatecount, var_203066c6662e1f2d);
      break;
  }
}

function updatehitmarker(markertype, killingblow, headshot, nonplayer, icontype, targetentnum, armorplatecount, var_203066c6662e1f2d) {
  if(function_fa167eb35ec0eeea()) {
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

  if(!isDefined(armorplatecount)) {
    armorplatecount = 0;
  }

  if(getdvarint(@ "hash_1db87c3b655b5645", 0) == 1) {
    hitmarkernotif = spawnStruct();
    hitmarkernotif.markertype = markertype;
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
    thread function_6a07ef2910dea0e5();
    return;
  }

  if(getdvarint(@ "hash_2909726ff0e12a7d", 0) == 1 && isDefined(level.gamemodebundle) && istrue(level.gamemodebundle.var_e76a5e57e1ff6b9b)) {
    markerflag = 0;

    if(!isint(markertype)) {
      if(markertype == "hitequip" || isDefined(icontype) && icontype == "hitequip") {
        markertype = 3;
      } else if(markertype == "standard") {
        markertype = 1;
      }
    }

    switch (markertype) {
      case 1:
        markerflag |= 1 << 0;

        if(killingblow) {
          markerflag |= 1 << 1;
        }

        if(isDefined(var_203066c6662e1f2d) && istrue(var_203066c6662e1f2d.isfriendly)) {
          markerflag |= 1 << 2;
        }

        if(headshot) {
          markerflag |= 1 << 3;
        }

        if(isDefined(icontype)) {
          switch (icontype) {
            case #"hash_286b270eeb92acab":
            case #"hash_2f87b65a1756fbc1":
            case #"hash_c58cc85ba9fb86d4":
            case #"hash_dc64d86a5dcc42d3":
              markerflag |= 1 << 4;
              break;
            case #"hash_3dfff68d08667b7e":
            case #"hash_635a3ba72a0e2577":
            case #"hash_9bddb43d21e0ec36":
            case #"hash_a38fa9efabd2c0a4":
            case #"hash_a54ca25c946c6e33":
              markerflag |= 1 << 5;
              break;
          }
        }

        if(isDefined(var_203066c6662e1f2d) && istrue(var_203066c6662e1f2d.isenemydown)) {
          markerflag |= 1 << 6;
        }

        function_697d593ebcb428dd("damage_feedback_weapon", markerflag);
        break;
      case 2:
        markerflag |= 1 << 0;

        if(killingblow) {
          markerflag |= 1 << 1;
        }

        if(isDefined(var_203066c6662e1f2d) && istrue(var_203066c6662e1f2d.isfriendly)) {
          markerflag |= 1 << 2;
        }

        function_697d593ebcb428dd("damage_feedback_equip", markerflag);
        break;
      case 3:
        markerflag |= 1 << 0;

        if(killingblow) {
          markerflag |= 1 << 1;
        }

        function_697d593ebcb428dd("damage_feedback_hardobject", markerflag);
        break;
    }

    if(isDefined(icontype) && !istrue(killingblow)) {
      self setclientomnvar("damage_feedback_icon", icontype);
      self setclientomnvar("damage_feedback_icon_notify", gettime());
    }

    if(isDefined(icontype) && icontype == "hitheadhunter") {
      self setclientomnvar("damage_feedback_icon", icontype);
      self setclientomnvar("damage_feedback_icon_notify", gettime());
    }

    if(isDefined(icontype) && icontype == "hitveharmorbreak") {
      self setclientomnvar("damage_feedback_icon", icontype);
      self setclientomnvar("damage_feedback_icon_notify", gettime());
    }

    return;
  }

  priority = gethitmarkerpriority(markertype);

  if(isDefined(self.lasthitmarkertime) && self.lasthitmarkertime == gettime() && priority <= self.lasthitmarkerpriority && !killingblow) {
    return;
  }

  self.lasthitmarkertime = gettime();
  self.lasthitmarkerpriority = priority;

  if(isDefined(icontype) && !istrue(killingblow)) {
    self setclientomnvar("damage_feedback_icon", icontype);
    self setclientomnvar("damage_feedback_icon_notify", gettime());
  }

  if(isDefined(icontype) && icontype == "hitheadhunter") {
    self setclientomnvar("damage_feedback_icon", icontype);
    self setclientomnvar("damage_feedback_icon_notify", gettime());
  }

  if(isDefined(icontype) && icontype == "hitveharmorbreak") {
    self setclientomnvar("damage_feedback_icon", icontype);
    self setclientomnvar("damage_feedback_icon_notify", gettime());
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

  self setclientomnvar("damage_feedback_armor", int(min(armorplatecount, 3)));

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
    case #"hash_b8d1ac6e6b8e3230":
    case #"hash_7a494a6441a8df6":
    case #"hash_5c57b61aa79410db":
    case #"hash_18144547f6b061d8":
    case #"hash_d6a7d182fd397b0a":
      if(!nosound) {
        self playlocalsound("scavenger_pack_pickup");
      }

      self setclientomnvar("damage_feedback_other", typehit);
      break;
    case #"hash_530ba8d82158ca97":
      if(!nosound) {
        self playlocalsound("wpn_combat_axe_pickup_plr");
      }

      self setclientomnvar("damage_feedback_other", typehit);
      break;
    case #"hash_2610981e9f5db54f":
    case #"hash_2ab98cab4066a74e":
    case #"hash_8747706404533493":
      if(!nosound) {
        self playlocalsound("weap_pickup_knife_plr");
      }

      self setclientomnvar("damage_feedback_other", typehit);
      break;
    case #"hash_1041aa27487b00f8":
      self setclientomnvar("damage_feedback_other", typehit);
      break;
    case #"hash_1d28d8c7a5e03548":
    case #"hash_23cdc38a2fa78bb4":
    case #"hash_23f2c68a2fc41281":
    case #"hash_11b2f521291b9664":
    case #"hash_36b7174a04de8799":
    case #"hash_5d11ac1131cddab1":
    case #"hash_7983828e72e83a3e":
    case #"hash_7da1870a0ffb921d":
    case #"hash_80c5f88142053bf4":
    case #"hash_85d7e1863dca54c4":
    case #"hash_66bc333667dfeb53":
    case #"hash_96dd9dc314bcbb3c":
    case #"hash_9d11909dc5bbaa26":
    case #"hash_9d57562863499a06":
    case #"hash_a0319e349a692b8f":
    case #"hash_a68c414683465b09":
    case #"hash_a8e4a914fb03a4d5":
    case #"hash_acd2c79dce3b9907":
    case #"hash_c9a436974fe60919":
    case #"hash_dae956a4a82da2d7":
    case #"hash_d4c33f35d7b04f87":
    case #"hash_d5db533de9b14785":
    case #"hash_d8f795eb14c75e6":
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

  thread function_7a129dca534be5f9();
}

function function_7a129dca534be5f9() {
  self notify("hitIconReset");
  self endon("disconnect");
  self endon("hitIconReset");
  waitframe();
  self setclientomnvar("damage_feedback_other", "standard");
}

function function_fa167eb35ec0eeea() {
  if(getdvarint(@ "hash_6735e9fcb3e821b9", 0)) {
    return true;
  }

  return istrue(level.var_f4b090dbbd2b125b);
}

function function_6a07ef2910dea0e5() {
  self notify("hitmarkerStack_singleton");
  self endon("hitmarkerStack_singleton");

  while(isDefined(self.hitmarkerstack) && self.hitmarkerstack.size != 0) {
    waitframe();
    var_237ea2fb76bea663 = self.hitmarkerstack[0];
    self.hitmarkerstack[0] = undefined;
    self.hitmarkerstack = array_removeundefined(self.hitmarkerstack);

    if(isDefined(var_237ea2fb76bea663.icontype) && !istrue(var_237ea2fb76bea663.killingblow)) {
      self setclientomnvar("damage_feedback_icon", var_237ea2fb76bea663.icontype);
      self setclientomnvar("damage_feedback_icon_notify", var_237ea2fb76bea663.timestamp);
    }

    if(isDefined(var_237ea2fb76bea663.icontype) && var_237ea2fb76bea663.icontype == "hitheadhunter") {
      self setclientomnvar("damage_feedback_icon", var_237ea2fb76bea663.icontype);
      self setclientomnvar("damage_feedback_icon_notify", var_237ea2fb76bea663.timestamp);
    }

    if(isDefined(var_237ea2fb76bea663.icontype) && var_237ea2fb76bea663.icontype == "hitveharmorbreak") {
      self setclientomnvar("damage_feedback_icon", var_237ea2fb76bea663.icontype);
      self setclientomnvar("damage_feedback_icon_notify", var_237ea2fb76bea663.timestamp);
    }

    self setclientomnvar("damage_feedback", var_237ea2fb76bea663.markertype);
    self setclientomnvar("damage_feedback_notify", var_237ea2fb76bea663.timestamp);

    if(var_237ea2fb76bea663.killingblow) {
      self setclientomnvar("damage_feedback_kill", 1);
    } else {
      self setclientomnvar("damage_feedback_kill", 0);
    }

    if(var_237ea2fb76bea663.headshot) {
      self setclientomnvar("damage_feedback_headshot", 1);
    } else {
      self setclientomnvar("damage_feedback_headshot", 0);
    }

    if(var_237ea2fb76bea663.nonplayer) {
      self setclientomnvar("damage_feedback_nonplayer", 1);
    } else {
      self setclientomnvar("damage_feedback_nonplayer", 0);
    }

    if(var_237ea2fb76bea663.targetentnum > -1) {
      self setclientomnvar("damage_feedback_entity", var_237ea2fb76bea663.targetentnum);
      self setclientomnvar("damage_feedback_entity_notify", gettime());
    }
  }
}

function function_697d593ebcb428dd(omnvarname, flag) {
  self setclientomnvar(omnvarname, flag);
  notifyname = omnvarname + "_notify";
  notifyvalue = self getclientomnvar(notifyname);
  self setclientomnvar(notifyname, !notifyvalue);

  logstring("<dev string:x1c>" + omnvarname + "<dev string:x48>" + flag);
}

function function_25f98f1b652f57ec() {
  setDvar(@ "hash_2951db54014fba41", 6);
  setDvar(@ "hash_94b34d23bf532a3f", 6);
  setDvar(@ "hash_cfad6a44e0c5cf8f", 6);
  setDvar(@ "hash_2974ed540176298f", 3);
  setDvar(@ "hash_94903b23bf2cbaf1", 3);
  setDvar(@ "hash_cf8a7844e09fa6a1", 3);
}

function function_a76226d272200c64() {
  if(getdvarint(@ "hash_2909726ff0e12a7d", 0) == 1 && isDefined(level.gamemodebundle) && istrue(level.gamemodebundle.var_e76a5e57e1ff6b9b)) {
    scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x53>");
    scripts\common\devgui::function_df648211d66cd3dd("<dev string:x6c>", "<dev string:x8a>");
    scripts\common\devgui::function_df648211d66cd3dd("<dev string:xa9>", "<dev string:xc7>");
    scripts\common\devgui::function_df648211d66cd3dd("<dev string:xe5>", "<dev string:x109>");
    scripts\common\devgui::function_df648211d66cd3dd("<dev string:x12c>", "<dev string:x14b>");
    scripts\common\devgui::function_df648211d66cd3dd("<dev string:x16a>", "<dev string:x188>");
    scripts\common\devgui::function_df648211d66cd3dd("<dev string:x1a6>", "<dev string:x1c9>");
    scripts\common\devgui::function_a9a864379a098ad6("<dev string:x1ec>", "<dev string:x1ff>", &function_f4137b4aff2d357f);
    scripts\common\devgui::function_a9a864379a098ad6("<dev string:x221>", "<dev string:x235>", &function_244f7ed1bde7a922);
    scripts\common\devgui::function_a9a864379a098ad6("<dev string:x258>", "<dev string:x274>", &function_9b3b346bf41b42ec);
    scripts\common\devgui::function_a9a864379a098ad6("<dev string:x29e>", "<dev string:x2bb>", &function_dedbab246909a68b);
    scripts\common\devgui::function_a9a864379a098ad6("<dev string:x2e6>", "<dev string:x302>", &function_e9943edf01fae246);
    scripts\common\devgui::function_a9a864379a098ad6("<dev string:x32c>", "<dev string:x349>", &function_12f0988382364fc5);
    scripts\common\devgui::function_a9a864379a098ad6("<dev string:x374>", "<dev string:x38d>", &function_aad4b8e06fba7712);
    scripts\common\devgui::function_a9a864379a098ad6("<dev string:x3b4>", "<dev string:x3cf>", &function_5ccbb72c64ed64b0);
    scripts\common\devgui::function_a9a864379a098ad6("<dev string:x3f8>", "<dev string:x412>", &function_a481845bd08b83ea);
    scripts\common\devgui::function_a9a864379a098ad6("<dev string:x43a>", "<dev string:x44c>", &function_3cef16eb6c7ab7f5);
    scripts\common\devgui::function_a9a864379a098ad6("<dev string:x46d>", "<dev string:x480>", &function_4a73df03aaeb1f40);
    scripts\common\devgui::function_a9a864379a098ad6("<dev string:x4a2>", "<dev string:x4bd>", &function_4b5b7c47cb916820);
    scripts\common\devgui::function_a9a864379a098ad6("<dev string:x4e6>", "<dev string:x502>", &function_7d67bfa0977275ef);
    scripts\common\devgui::function_a9a864379a098ad6("<dev string:x52c>", "<dev string:x543>", &function_5ba699d40ad475b5);
    scripts\common\devgui::function_a9a864379a098ad6("<dev string:x569>", "<dev string:x584>", &function_847c3a90c31506da);
    scripts\common\devgui::function_a9a864379a098ad6("<dev string:x5ae>", "<dev string:x5d4>", &function_ff8a5baefaf2044);
    scripts\common\devgui::function_a9a864379a098ad6("<dev string:x60e>", "<dev string:x62b>", &function_f1c42880c41252b3);
    scripts\common\devgui::function_a9a864379a098ad6("<dev string:x65c>", "<dev string:x67e>", &function_c98bce4a7d0771f5);
    scripts\common\devgui::function_a9a864379a098ad6("<dev string:x6b4>", "<dev string:x6d0>", &function_21d0791f2931f95);
    scripts\common\devgui::function_a9a864379a098ad6("<dev string:x700>", "<dev string:x71d>", &function_a319100f1b453a35);
    scripts\common\devgui::function_a9a864379a098ad6("<dev string:x74e>", "<dev string:x76b>", &function_fc755361ba8bc81);
    scripts\common\devgui::function_a9a864379a098ad6("<dev string:x79d>", "<dev string:x7be>", &function_fb89825e361fc1f0);
    scripts\common\devgui::function_fe953f000498048f();
  }
}

function function_f4137b4aff2d357f() {
  markerflag = 0;
  markerflag |= 1 << 0;

  foreach(player in level.players) {
    player function_697d593ebcb428dd("<dev string:x7f3>", markerflag);
  }
}

function function_244f7ed1bde7a922() {
  markerflag = 0;
  markerflag |= 1 << 0;
  markerflag |= 1 << 1;

  foreach(player in level.players) {
    player function_697d593ebcb428dd("<dev string:x7f3>", markerflag);
  }
}

function function_9b3b346bf41b42ec() {
  markerflag = 0;
  markerflag |= 1 << 0;
  markerflag |= 1 << 3;

  foreach(player in level.players) {
    player function_697d593ebcb428dd("<dev string:x7f3>", markerflag);
  }
}

function function_dedbab246909a68b() {
  markerflag = 0;
  markerflag |= 1 << 0;
  markerflag |= 1 << 3;
  markerflag |= 1 << 1;

  foreach(player in level.players) {
    player function_697d593ebcb428dd("<dev string:x7f3>", markerflag);
  }
}

function function_e9943edf01fae246() {
  markerflag = 0;
  markerflag |= 1 << 0;
  markerflag |= 1 << 2;

  foreach(player in level.players) {
    player function_697d593ebcb428dd("<dev string:x7f3>", markerflag);
  }
}

function function_12f0988382364fc5() {
  markerflag = 0;
  markerflag |= 1 << 0;
  markerflag |= 1 << 2;
  markerflag |= 1 << 1;

  foreach(player in level.players) {
    player function_697d593ebcb428dd("<dev string:x7f3>", markerflag);
  }
}

function function_aad4b8e06fba7712() {
  markerflag = 0;
  markerflag |= 1 << 0;
  markerflag |= 1 << 4;

  foreach(player in level.players) {
    player function_697d593ebcb428dd("<dev string:x7f3>", markerflag);
  }
}

function function_5ccbb72c64ed64b0() {
  markerflag = 0;
  markerflag |= 1 << 0;
  markerflag |= 1 << 5;

  foreach(player in level.players) {
    player function_697d593ebcb428dd("<dev string:x7f3>", markerflag);
  }
}

function function_a481845bd08b83ea() {
  markerflag = 0;
  markerflag |= 1 << 0;
  markerflag |= 1 << 6;

  foreach(player in level.players) {
    player function_697d593ebcb428dd("<dev string:x7f3>", markerflag);
  }
}

function function_3cef16eb6c7ab7f5() {
  markerflag = 0;
  markerflag |= 1 << 0;

  foreach(player in level.players) {
    player function_697d593ebcb428dd("<dev string:x80d>", markerflag);
  }
}

function function_4a73df03aaeb1f40() {
  markerflag = 0;
  markerflag |= 1 << 0;
  markerflag |= 1 << 1;

  foreach(player in level.players) {
    player function_697d593ebcb428dd("<dev string:x80d>", markerflag);
  }
}

function function_4b5b7c47cb916820() {
  markerflag = 0;
  markerflag |= 1 << 0;
  markerflag |= 1 << 2;

  foreach(player in level.players) {
    player function_697d593ebcb428dd("<dev string:x80d>", markerflag);
  }
}

function function_7d67bfa0977275ef() {
  markerflag = 0;
  markerflag |= 1 << 0;
  markerflag |= 1 << 2;
  markerflag |= 1 << 1;

  foreach(player in level.players) {
    player function_697d593ebcb428dd("<dev string:x80d>", markerflag);
  }
}

function function_5ba699d40ad475b5() {
  markerflag = 0;
  markerflag |= 1 << 0;

  foreach(player in level.players) {
    player function_697d593ebcb428dd("<dev string:x826>", markerflag);
  }
}

function function_847c3a90c31506da() {
  markerflag = 0;
  markerflag |= 1 << 0;
  markerflag |= 1 << 1;

  foreach(player in level.players) {
    player function_697d593ebcb428dd("<dev string:x826>", markerflag);
  }
}

function function_ff8a5baefaf2044() {
  function_847c3a90c31506da();
  function_4a73df03aaeb1f40();
}

function function_f1c42880c41252b3() {
  function_f4137b4aff2d357f();
  function_4a73df03aaeb1f40();
}

function function_c98bce4a7d0771f5() {
  function_244f7ed1bde7a922();
  function_5ba699d40ad475b5();
}

function function_21d0791f2931f95() {
  function_3cef16eb6c7ab7f5();
  function_aad4b8e06fba7712();
}

function function_a319100f1b453a35() {
  function_3cef16eb6c7ab7f5();
  function_244f7ed1bde7a922();
}

function function_fc755361ba8bc81() {
  function_3cef16eb6c7ab7f5();
  function_244f7ed1bde7a922();
}

function function_fb89825e361fc1f0() {
  function_3cef16eb6c7ab7f5();
  function_5ba699d40ad475b5();
}

# /