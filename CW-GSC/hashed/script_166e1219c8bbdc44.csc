/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_166e1219c8bbdc44.csc
***********************************************/

#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\beam_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;
#namespace namespace_b376a999;

function private autoexec __init__system__() {
  system::register(#"hash_36cdf1547e49b57a", &preinit, &postinit, undefined, "zm_weapons");
}

function private preinit() {
  clientfield::register("actor", "" + # "hash_77e641a4db48ad0f", 1, 2, "int", &function_8964c489, 0, 0);
  clientfield::register("allplayers", "" + # "hash_492f4817c4296ddf", 1, 1, "counter", &function_4df1985a, 0, 0);
  clientfield::register("allplayers", "" + # "hash_89386ef1bb99cdf", 1, 2, "int", &function_4264d325, 0, 0);
  clientfield::register("actor", "" + # "hash_380d2d329a41c90e", 1, 1, "int", &function_ab048a51, 0, 0);
  clientfield::register("actor", "" + # "hash_7e9eb1c31cf618f0", 1, 1, "int", &function_86ab58c7, 0, 0);
  clientfield::register("actor", "" + # "hash_306339376ad218f0", 1, 1, "int", &function_d31198e7, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_4061bf5adf6ebd2", 1, 3, "int", &function_97f75611, 0, 0);
  clientfield::register("allplayers", "" + # "hash_392d4dd36fe37ce7", 1, 1, "counter", &function_ddb51446, 0, 0);
  clientfield::register("allplayers", "" + # "hash_7c865b5dcfbe46c0", 1, 1, "int", &function_20c975a8, 0, 0);
  clientfield::register("allplayers", "" + # "hash_40635c43f5d87929", 1, 3, "int", &function_f06d4b4, 0, 0);
  clientfield::register("actor", "" + # "hash_6dca42b5563953ef", 1, 1, "int", &function_6832bb19, 0, 0);
  clientfield::register("actor", "" + # "hash_2a7b72235f0b387e", 1, 1, "int", &function_6c72aae7, 0, 0);
  clientfield::register("actor", "" + # "hash_1709a7bbfac5e1e0", 1, 1, "int", &function_e807cd32, 0, 0);
  clientfield::register("actor", "" + # "hash_3a35110e6ccc5486", 1, 1, "int", &function_11695595, 0, 0);
  clientfield::register("actor", "" + # "hash_48257c0dba76b140", 1, 1, "int", &function_c5d4038a, 0, 0);
  clientfield::register("actor", "" + # "hash_97d03a2a0786ba6", 1, 2, "int", &function_cd07a2bb, 0, 0);
  clientfield::register("allplayers", "" + # "hash_3c92af57fde1f8f7", 1, 4, "int", &function_c72e22ff, 0, 0);
  clientfield::register("missile", "" + # "hash_685e6cfaf658518e", 1, 1, "int", &function_48f0fe69, 0, 0);
  clientfield::register("allplayers", "" + # "hash_2eb1021a0e4110d1", 1, 2, "int", &function_656016f4, 0, 1);
}

function postinit() {
  zm_weapons::function_8389c033(#"ww_ieu_shockwave_t9", #"ww_ieu_shockwave_t9");
  zm_weapons::function_8389c033(#"ww_ieu_shockwave_t9", #"ww_ieu_plasma_t9");
  zm_weapons::function_8389c033(#"ww_ieu_shockwave_t9", #"ww_ieu_gas_t9");
  zm_weapons::function_8389c033(#"ww_ieu_shockwave_t9", #"ww_ieu_electric_t9");
  zm_weapons::function_8389c033(#"ww_ieu_shockwave_t9", #"ww_ieu_acid_t9");
  zm_weapons::function_8389c033(#"ww_ieu_plasma_t9", #"ww_ieu_shockwave_t9");
  zm_weapons::function_8389c033(#"ww_ieu_plasma_t9", #"ww_ieu_plasma_t9");
  zm_weapons::function_8389c033(#"ww_ieu_plasma_t9", #"ww_ieu_gas_t9");
  zm_weapons::function_8389c033(#"ww_ieu_plasma_t9", #"ww_ieu_electric_t9");
  zm_weapons::function_8389c033(#"ww_ieu_plasma_t9", #"ww_ieu_acid_t9");
  zm_weapons::function_8389c033(#"ww_ieu_gas_t9", #"ww_ieu_shockwave_t9");
  zm_weapons::function_8389c033(#"ww_ieu_gas_t9", #"ww_ieu_plasma_t9");
  zm_weapons::function_8389c033(#"ww_ieu_gas_t9", #"ww_ieu_gas_t9");
  zm_weapons::function_8389c033(#"ww_ieu_gas_t9", #"ww_ieu_electric_t9");
  zm_weapons::function_8389c033(#"ww_ieu_gas_t9", #"ww_ieu_acid_t9");
  zm_weapons::function_8389c033(#"ww_ieu_electric_t9", #"ww_ieu_shockwave_t9");
  zm_weapons::function_8389c033(#"ww_ieu_electric_t9", #"ww_ieu_plasma_t9");
  zm_weapons::function_8389c033(#"ww_ieu_electric_t9", #"ww_ieu_gas_t9");
  zm_weapons::function_8389c033(#"ww_ieu_electric_t9", #"ww_ieu_electric_t9");
  zm_weapons::function_8389c033(#"ww_ieu_electric_t9", #"ww_ieu_acid_t9");
  zm_weapons::function_8389c033(#"ww_ieu_acid_t9", #"ww_ieu_shockwave_t9");
  zm_weapons::function_8389c033(#"ww_ieu_acid_t9", #"ww_ieu_plasma_t9");
  zm_weapons::function_8389c033(#"ww_ieu_acid_t9", #"ww_ieu_gas_t9");
  zm_weapons::function_8389c033(#"ww_ieu_acid_t9", #"ww_ieu_electric_t9");
  zm_weapons::function_8389c033(#"ww_ieu_acid_t9", #"ww_ieu_acid_t9");
}

function function_8964c489(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_da783696)) {
    self function_f6e99a8d(self.var_da783696);
    self.var_da783696 = undefined;
  }

  if(isDefined(self.var_12b59dee)) {
    self function_f6e99a8d(self.var_12b59dee, "j_head");
    self.var_12b59dee = undefined;
  }

  var_a04a4858 = [#"hash_16d59f099e418f4f", #"hash_726534103985846c", #"hash_7417f2cd52314463"];

  if(bwastimejump && bwastimejump < var_a04a4858.size + 1) {
    self.var_da783696 = var_a04a4858[bwastimejump - 1];
    self playrenderoverridebundle(self.var_da783696);
  }
}

function function_4df1985a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self playrumbleonentity(bwastimejump, #"hash_37176262d696964e");
}

function function_4264d325(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 2) {
    if(isDefined(self.var_83da6d17)) {
      killfx(fieldname, self.var_83da6d17);
      self.var_83da6d17 = undefined;
    }

    return;
  }

  if(bwastimejump == 1) {
    if(self zm_utility::function_f8796df3(fieldname)) {
      if(viewmodelhastag(fieldname, "tag_plasma_01_fx")) {
        self.var_83da6d17 = playviewmodelfx(fieldname, #"hash_19446bd83d662102", "tag_plasma_01_fx");
      }
    }

    return;
  }

  if(bwastimejump == 0) {
    if(isDefined(self.var_83da6d17)) {
      stopfx(fieldname, self.var_83da6d17);
      self.var_83da6d17 = undefined;
    }
  }
}

function function_ab048a51(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  fx_tag = "J_Spine4";

  if(is_true(self.isdog)) {
    fx_tag = "J_Spine1";
  } else if(self.archetype !== # "zombie") {
    fx_tag = "tag_origin";
  }

  if(bwastimejump == 1) {
    if(!isDefined(self.var_76f19917)) {
      self.var_76f19917 = util::spawn_model(fieldname, "tag_origin", self.origin);
      self.var_76f19917 linkto(self, fx_tag);
      self.var_76f19917 thread function_d8e166f1(self);
    }

    self.var_76f19917.var_292ce710 = util::playFXOnTag(fieldname, #"hash_445bd994065c63af", self.var_76f19917, "tag_origin");
    return;
  }

  if(isDefined(self.var_76f19917.var_292ce710)) {
    stopfx(fieldname, self.var_76f19917.var_292ce710);
  }

  if(isDefined(self.var_76f19917)) {
    self.var_76f19917 delete();
  }
}

function function_564170b7(localclientnum) {
  self endon(#"death");
  player = function_5c10bd79(localclientnum);

  while(isDefined(player) && isDefined(self.var_c437eded)) {
    dir = vectornormalize(player.origin - self.origin);
    var_96517510 = self gettagorigin("J_Spine4");

    if(!isDefined(var_96517510)) {
      return;
    }

    self.var_c437eded.origin = var_96517510;
    self.var_c437eded.angles = vectortoangles(dir);
    waitframe(1);
  }
}

function function_86ab58c7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    if(!isDefined(self.var_c437eded)) {
      self.var_c437eded = util::spawn_model(fieldname, "tag_origin", self.origin);
      self thread function_564170b7(fieldname);
      self.var_c437eded thread function_d8e166f1(self);
    }

    self.var_c437eded.var_d58aca35 = util::playFXOnTag(fieldname, "zm_weapons/fx9_ww_ieu_impact_glow_1p", self.var_c437eded, "tag_origin");
    return;
  }

  if(isDefined(self.var_c437eded.var_d58aca35)) {
    stopfx(fieldname, self.var_c437eded.var_d58aca35);
  }

  if(isDefined(self.var_c437eded)) {
    self.var_c437eded delete();
  }
}

function function_d31198e7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    util::playFXOnTag(fieldname, "zm_weapons/fx9_ww_ieu_death", self, "J_Spine4");
    self playSound(fieldname, #"hash_140d306061d4e40c");
  }
}

function function_ba2d251(localclientnum, target, val) {
  self endon(#"death");

  if(!isDefined(target)) {
    return;
  }

  var_f8796df3 = target zm_utility::function_f8796df3(localclientnum);

  if(var_f8796df3) {
    target_pos = function_8cb7ea7(localclientnum, "tag_flash");
  } else {
    target_pos = target gettagorigin(isPlayer(target) ? "tag_flash" : "tag_origin");
  }

  if(!isDefined(target_pos)) {
    return;
  }

  distance = distance(self.origin, target_pos);
  fxname = "";

  switch (val) {
    case 1:
      fxname = distance > 200 ? # "hash_4b01f025eb7e47d8" : # "hash_16c7c4d7f14d97a3";
      break;
    case 2:
      fxname = distance > 200 ? # "hash_402f9042dc87f055" : # "hash_4381a516acca3cfa";
      break;
    case 3:
      fxname = # "hash_794f3c866e2f2c33";
      break;
    case 4:
      fxname = # "hash_e3fb468d5dacb91";
      break;
    case 5:
      fxname = # "hash_4cca54a0f0586d88";
      break;
    default:
      return;
  }

  self.var_2516545b = util::playFXOnTag(localclientnum, fxname, self, "tag_orgin");
  target_dir = vectornormalize(target_pos - self.origin);
  self.angles = vectortoangles(target_dir);
  plane_vec = perpendicularvector(target_dir);
  rotation = randomint(360);
  var_7e699c66 = 0.8;
  var_69c56b33 = 1.8;
  max_speed = 18;

  var_7e699c66 = getdvarfloat(#"hash_6d7131b127a25daf", 0.8);
  var_69c56b33 = getdvarfloat(#"hash_23bfbcbc77bc48db", 1.8);
  max_speed = getdvarfloat(#"hash_759d15e761e768c", 18);

  start_speed = randomfloat(var_7e699c66) * distance / 20;
  start_dir = rotatepointaroundaxis(plane_vec, target_dir, rotation);
  var_d785526d = 0;
  var_4f217ff7 = start_speed;
  var_725ea2c9 = var_69c56b33;
  var_a6c0e687 = var_4f217ff7 < 0.0001 ? 0 : 2 * var_4f217ff7 / sqrt(2 * distance / var_725ea2c9);

  while(distance > 8) {
    move_vec = target_dir * var_d785526d + start_dir * var_4f217ff7;

    if(length(move_vec) < distance) {
      self moveto(self.origin + move_vec, 0.016);
    } else {
      self.origin = target_pos;
    }

    waitframe(1);

    if(!isDefined(target)) {
      break;
    }

    if(var_f8796df3) {
      target_pos = function_8cb7ea7(localclientnum, "tag_flash");
    } else {
      target_pos = target gettagorigin(isPlayer(target) ? "tag_flash" : "tag_origin");
    }

    if(!isDefined(target_pos)) {
      break;
    }

    distance = distance(self.origin, target_pos);
    target_dir = vectornormalize(target_pos - self.origin);
    var_4f217ff7 = var_4f217ff7 < 0 ? 0 : var_4f217ff7 - var_a6c0e687;
    var_d785526d = var_d785526d > max_speed ? max_speed : var_d785526d + var_725ea2c9;
  }

  if(isDefined(self.var_2516545b)) {
    stopfx(localclientnum, self.var_2516545b);
    self.var_2516545b = undefined;
  }

  self delete();
}

function function_97f75611(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    target = self getlinkedent();

    if(!isDefined(target)) {
      return;
    }

    var_f8796df3 = target zm_utility::function_f8796df3(fieldname);

    if(!isDefined(level.var_e2b22b89)) {
      level.var_e2b22b89 = [];
    }

    if(level.var_e2b22b89.size > 48) {
      arrayremovevalue(level.var_e2b22b89, undefined);

      if(level.var_e2b22b89.size > 48) {
        if(isPlayer(target) && !var_f8796df3) {
          return;
        }
      }
    }

    self.var_4a03779e = util::spawn_model(fieldname, "tag_origin", self.origin);
    self.var_4a03779e thread function_ba2d251(fieldname, target, bwastimejump);
    self.var_4a03779e thread function_d8e166f1(self);

    if(!isDefined(level.var_e2b22b89)) {
      level.var_e2b22b89 = [];
    } else if(!isarray(level.var_e2b22b89)) {
      level.var_e2b22b89 = array(level.var_e2b22b89);
    }

    level.var_e2b22b89[level.var_e2b22b89.size] = self.var_4a03779e;

    if(!isPlayer(target)) {
      return;
    }

    var_51bf08db = "";

    switch (bwastimejump) {
      case 1:
        var_51bf08db = var_f8796df3 ? # "hash_54388e35e14b68e5" : # "hash_543f9a35e1519bf7";
        break;
      case 2:
        var_51bf08db = var_f8796df3 ? # "hash_38586b2eb5ef5caa" : # "hash_38515f2eb5e92998";
        break;
      case 3:
        var_51bf08db = var_f8796df3 ? # "hash_1c2d03ee3e4b2130" : # "hash_1c340fee3e515442";
        break;
      case 4:
        var_51bf08db = var_f8796df3 ? # "hash_3ab7539c0b05dba9" : # "hash_3abe5f9c0b0c0ebb";
        break;
      case 5:
      default:
        return;
    }

    if(var_f8796df3) {
      if(viewmodelhastag(fieldname, "tag_flash")) {
        self.var_8bfbfae5 = playviewmodelfx(fieldname, var_51bf08db, "tag_flash");
      }
    } else {
      self.var_8bfbfae5 = util::playFXOnTag(fieldname, var_51bf08db, target, "tag_flash");
    }

    return;
  }

  if(isDefined(self.var_4a03779e.var_2516545b)) {
    stopfx(fieldname, self.var_4a03779e.var_2516545b);
  }

  if(isDefined(self.var_4a03779e)) {
    self.var_4a03779e delete();
  }

  if(isDefined(self.var_8bfbfae5)) {
    stopfx(fieldname, self.var_8bfbfae5);
    self.var_8bfbfae5 = undefined;
  }
}

function function_ddb51446(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self playrumbleonentity(bwastimejump, #"hash_6fed0a32376b64b2");

  if(self zm_utility::function_f8796df3(bwastimejump)) {
    if(viewmodelhastag(bwastimejump, "tag_flash")) {
      playviewmodelfx(bwastimejump, #"hash_13bc1c868864fd1e", "tag_flash");
    }

    return;
  }

  util::playFXOnTag(bwastimejump, #"hash_13b51086885eca0c", self, "tag_flash");
}

function function_f06d4b4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    if(self zm_utility::function_f8796df3(fieldname)) {
      self thread function_f63c933e(fieldname, bwastimejump);
    } else {
      self thread function_7a17571a(fieldname, bwastimejump);
    }

    return;
  }

  if(self zm_utility::function_f8796df3(fieldname)) {
    self notify(#"hash_6c344a5f126eed34");

    if(isDefined(self.var_e4927fc7)) {
      killfx(fieldname, self.var_e4927fc7);
    }

    self.var_e4927fc7 = undefined;
    return;
  }

  self notify(#"hash_64ba35091b98a4a7");

  if(isDefined(self.var_8790ae67)) {
    killfx(fieldname, self.var_8790ae67);
  }

  self.var_8790ae67 = undefined;
}

function function_f63c933e(localclientnum, newval) {
  self notify(#"hash_6c344a5f126eed34");
  self endon(#"death", #"hash_6c344a5f126eed34");

  while(isDefined(self) && viewmodelhastag(localclientnum, "tag_flash")) {
    self.var_e4927fc7 = playviewmodelfx(localclientnum, "zm_weapons/fx9_ww_ieu_muz_1p", "tag_flash");

    for(i = 1; i < newval; i++) {
      self.var_a3606f1e = playviewmodelfx(localclientnum, "zm_weapons/fx9_ww_ieu_muz_chunk_1p", "tag_flash");
    }

    wait 0.2;
  }
}

function function_7a17571a(localclientnum, newval) {
  self notify(#"hash_64ba35091b98a4a7");
  self endon(#"death", #"hash_64ba35091b98a4a7");

  while(isDefined(self)) {
    self.var_8790ae67 = util::playFXOnTag(localclientnum, "zm_weapons/fx9_ww_ieu_muz_3p", self, "tag_flash");

    for(i = 1; i < newval; i++) {
      self.var_357dfad4 = util::playFXOnTag(localclientnum, "zm_weapons/fx9_ww_ieu_muz_chunk_3p", self, "tag_flash");
    }

    wait 0.2;
  }
}

function function_20c975a8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  var_fa5b0a8f = # "hash_432baacca32a077d";

  if(bwastimejump) {
    self playrumblelooponentity(fieldname, var_fa5b0a8f);

    if(!isDefined(self.var_7f00319)) {
      self playSound(fieldname, #"hash_36f125178fca6dff");
      self.var_7f00319 = self playLoopSound(#"hash_3b6bb4f25791844b");
    }

    return;
  }

  self stoprumble(fieldname, var_fa5b0a8f);

  if(isDefined(self.var_7f00319)) {
    self playSound(fieldname, #"hash_461a2262ec6f2125");
    self stoploopsound(self.var_7f00319);
    self.var_7f00319 = undefined;
  }
}

function function_6832bb19(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self thread function_fb35f102(bwastimejump);
  self thread function_bf3da63d(bwastimejump);
  self util::playFXOnTag(bwastimejump, #"hash_3da4857b4b1553dc", self, "J_SpineLower");
  self hide();
}

function function_6c72aae7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self thread function_fb35f102(bwastimejump);
  self thread function_bf3da63d(bwastimejump);
  self util::playFXOnTag(bwastimejump, #"hash_28d7ab1759f0b761", self, "J_SpineLower");
  playrumbleonposition(bwastimejump, #"hash_28b45e4b4d42f3f8", self.origin);
  self hide();
}

function function_e807cd32(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self thread function_7dce2661(fieldname);
    return;
  }

  self thread function_bf3da63d(fieldname);
}

function function_7dce2661(localclientnum) {
  if(!isDefined(self.var_228aab91)) {
    self.var_228aab91 = [];
  }

  if(isDefined(self.var_228aab91[localclientnum])) {
    return;
  }

  self.var_228aab91[localclientnum] = [];
  function_cc7d3ff(localclientnum, #"hash_50599e96f376b4fa", "torso", "j_spinelower");

  if(!self gibclientutils::isgibbed(localclientnum, self, 8)) {
    function_cc7d3ff(localclientnum, #"hash_7af6b9564f0fbeca", "chin", "j_head");
  }

  if(!self gibclientutils::isgibbed(localclientnum, self, 16)) {
    function_cc7d3ff(localclientnum, #"hash_58c964b815e4f69e", "right_arm", "j_elbow_ri");
  }

  if(!self gibclientutils::isgibbed(localclientnum, self, 32)) {
    function_cc7d3ff(localclientnum, #"hash_58c96eb815e5079c", "left_arm", "j_elbow_le");
  }

  if(!self gibclientutils::isgibbed(localclientnum, self, 128)) {
    function_cc7d3ff(localclientnum, #"hash_432cd0cd340f2644", "right_leg", "j_knee_ri");
  }

  if(!self gibclientutils::isgibbed(localclientnum, self, 256)) {
    function_cc7d3ff(localclientnum, #"hash_434ed0cd342c0caa", "left_leg", "j_knee_le");
  }
}

function function_cc7d3ff(localclientnum, fx, key, tag) {
  self.var_228aab91[localclientnum][key] = util::playFXOnTag(localclientnum, fx, self, tag);
}

function function_bf3da63d(localclientnum) {
  self endon(#"death");

  if(isDefined(self.var_228aab91) && isDefined(self.var_228aab91[localclientnum])) {
    keys = getarraykeys(self.var_228aab91[localclientnum]);

    for(i = 0; i < keys.size; i++) {
      function_c587b012(localclientnum, keys[i]);
    }

    self.var_228aab91[localclientnum] = undefined;
  }
}

function function_c587b012(localclientnum, key) {
  deletefx(localclientnum, self.var_228aab91[localclientnum][key]);
}

function function_11695595(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self thread function_2eaa501a(fieldname);
    return;
  }

  self thread function_fb35f102(fieldname);
}

function function_2eaa501a(localclientnum) {
  if(!isDefined(self.var_36d7ee48)) {
    self.var_36d7ee48 = [];
  }

  if(isDefined(self.var_36d7ee48[localclientnum])) {
    return;
  }

  self.var_36d7ee48[localclientnum] = [];
  var_18e19c80 = # "hash_7bd6bc3aea3ff42f";

  if(!self gibclientutils::isgibbed(localclientnum, self, 16)) {
    function_e2c3df2f(localclientnum, var_18e19c80, "right_arm", "j_elbow_ri");
  }

  if(!self gibclientutils::isgibbed(localclientnum, self, 32)) {
    function_e2c3df2f(localclientnum, var_18e19c80, "left_arm", "j_elbow_le");
  }

  if(!self gibclientutils::isgibbed(localclientnum, self, 128)) {
    function_e2c3df2f(localclientnum, var_18e19c80, "right_leg", "j_knee_ri");
  }

  if(!self gibclientutils::isgibbed(localclientnum, self, 256)) {
    function_e2c3df2f(localclientnum, var_18e19c80, "left_leg", "j_knee_le");
  }
}

function function_e2c3df2f(localclientnum, fx, key, tag) {
  self.var_36d7ee48[localclientnum][key] = util::playFXOnTag(localclientnum, fx, self, tag);
}

function function_fb35f102(localclientnum) {
  self endon(#"death");

  if(isDefined(self.var_36d7ee48)) {
    keys = getarraykeys(self.var_36d7ee48[localclientnum]);

    for(i = 0; i < keys.size; i++) {
      function_5f8032a3(localclientnum, keys[i]);
    }
  }
}

function function_5f8032a3(localclientnum, key) {
  deletefx(localclientnum, self.var_36d7ee48[localclientnum][key]);
}

function function_c5d4038a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self thread function_f8ed548c(1);
    return;
  }

  self thread function_f8ed548c(0);
}

function function_f8ed548c(b_freeze) {
  self notify(#"hash_5654a29843e044e7");
  self endon(#"hash_5654a29843e044e7");

  if(b_freeze) {
    wait 0.1;

    if(isDefined(self)) {
      self playrenderoverridebundle("rob_test_character_ice");
    }
  }

  if(isDefined(self) && !isDefined(self.var_82fb67e7)) {
    self.var_82fb67e7 = 0;
  }

  while(isDefined(self)) {
    self function_78233d29("rob_test_character_ice", "", "Threshold", self.var_82fb67e7);

    if(b_freeze) {
      self.var_82fb67e7 += 0.2;
    } else {
      self.var_82fb67e7 -= 0.05;
    }

    if(b_freeze && self.var_82fb67e7 >= 1) {
      break;
    } else if(self.var_82fb67e7 <= 0) {
      self stoprenderoverridebundle("rob_test_character_ice");
      break;
    }

    wait 0.1;
  }
}

function private function_cd07a2bb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  fx_tag = "J_Spine4";

  if(is_true(self.isdog)) {
    fx_tag = "J_Spine1";
  } else if(self.archetype !== # "zombie") {
    fx_tag = "tag_origin";
  }

  if(bwastimejump == 1) {
    if(!isDefined(self.var_48531c81)) {
      self.var_48531c81 = util::spawn_model(fieldname, "tag_origin", self.origin);
      self.var_48531c81 linkto(self, fx_tag);
      self.var_48531c81 thread function_d8e166f1(self);
    }

    self.var_48531c81.var_5e09354d = util::playFXOnTag(fieldname, #"hash_3e184ca7b210cca5", self.var_48531c81, "tag_origin");
    return;
  }

  if(bwastimejump == 2) {
    if(isDefined(self.var_48531c81.var_5e09354d)) {
      stopfx(fieldname, self.var_48531c81.var_5e09354d);

      if(isDefined(self.var_48531c81)) {
        self.var_48531c81 delete();
      }
    }

    var_e09ff13a = util::spawn_model(fieldname, "tag_origin", self.origin);
    var_e09ff13a.var_cc0e9e52 = util::playFXOnTag(fieldname, #"hash_4b9be18c0ce06e50", var_e09ff13a, "tag_origin");
    var_e09ff13a linkto(self, fx_tag);
    var_e09ff13a thread function_bf22dbf0(fieldname, self);
    return;
  }

  if(isDefined(self.var_48531c81.var_5e09354d)) {
    stopfx(fieldname, self.var_48531c81.var_5e09354d);
  }

  if(isDefined(self.var_48531c81)) {
    self.var_48531c81 delete();
  }
}

function private function_bf22dbf0(localclientnum, parent) {
  level endon(#"end_game");
  self endon(#"death");
  parent waittilltimeout(15, #"death");

  if(isDefined(self.var_cc0e9e52)) {
    stopfx(localclientnum, self.var_cc0e9e52);

    if(isDefined(self)) {
      self delete();
    }
  }
}

function private function_c72e22ff(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.var_1d9be360)) {
    self.var_1d9be360 = [];
  }

  if(bwastimejump == 9) {
    for(var_dd6fbcf0 = fieldname; var_dd6fbcf0 > 0; var_dd6fbcf0--) {
      if(isDefined(self.var_1d9be360[var_dd6fbcf0])) {
        killfx(binitialsnap, self.var_1d9be360[var_dd6fbcf0]);
        self.var_1d9be360[var_dd6fbcf0] = undefined;
      }
    }

    return;
  }

  if(fieldname == 9 && bwastimejump != fieldname) {
    for(var_dd6fbcf0 = 1; var_dd6fbcf0 <= bwastimejump; var_dd6fbcf0++) {
      var_9051360a = function_12050e71(var_dd6fbcf0);

      if(self zm_utility::function_f8796df3(binitialsnap)) {
        if(viewmodelhastag(binitialsnap, var_9051360a)) {
          self.var_1d9be360[var_dd6fbcf0] = playviewmodelfx(binitialsnap, #"hash_16c90556892a0ab7", var_9051360a);
        }

        continue;
      }

      self.var_1d9be360[var_dd6fbcf0] = util::playFXOnTag(binitialsnap, #"hash_16c1f9568923d7a5", self, var_9051360a);
    }

    return;
  }

  if(bwastimejump > fieldname) {
    for(var_dd6fbcf0 = fieldname + 1; var_dd6fbcf0 <= bwastimejump; var_dd6fbcf0++) {
      var_9051360a = function_12050e71(var_dd6fbcf0);

      if(self zm_utility::function_f8796df3(binitialsnap)) {
        if(viewmodelhastag(binitialsnap, var_9051360a)) {
          self.var_1d9be360[var_dd6fbcf0] = playviewmodelfx(binitialsnap, #"hash_16c90556892a0ab7", var_9051360a);
        }

        continue;
      }

      self.var_1d9be360[var_dd6fbcf0] = util::playFXOnTag(binitialsnap, #"hash_16c1f9568923d7a5", self, var_9051360a);
    }

    return;
  }

  if(bwastimejump < fieldname) {
    for(var_dd6fbcf0 = fieldname; var_dd6fbcf0 > bwastimejump; var_dd6fbcf0--) {
      if(isDefined(self.var_1d9be360[var_dd6fbcf0])) {
        stopfx(binitialsnap, self.var_1d9be360[var_dd6fbcf0]);
        self.var_1d9be360[var_dd6fbcf0] = undefined;
      }
    }
  }
}

function private function_12050e71(var_dd6fbcf0) {
  str_tag = "tag_condenser_0" + var_dd6fbcf0 + "_fx";
  return str_tag;
}

function function_48f0fe69(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self.var_7c1596d6 = util::playFXOnTag(fieldname, "zm_weapons/fx9_ww_ieu_shockwave_trail_1p", self, "tag_origin");
    var_fa5b0a8f = # "hash_165ad2675780cb74";
    self playrumblelooponentity(fieldname, var_fa5b0a8f);

    if(!isDefined(self.var_d7319ee)) {
      self.var_d7319ee = self playLoopSound(#"hash_2689de11fa4c6d62");
    }

    self thread function_e7b3d40a(fieldname);
  }
}

function function_e7b3d40a(localclientnum) {
  level endon(#"end_game");
  self waittill(#"death");

  if(isDefined(self.var_7c1596d6)) {
    killfx(localclientnum, self.var_7c1596d6);
    self.var_7c1596d6 = undefined;
  }

  if(isDefined(self.var_d7319ee)) {
    self playSound(localclientnum, #"hash_392fc912529fa6b4");
    self stoploopsound(self.var_d7319ee);
    self.var_d7319ee = undefined;
  }
}

function function_656016f4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_72b81df3(fieldname);

  if(bwastimejump > 0) {
    self thread function_aaa79dd8(fieldname, bwastimejump);
  }
}

function function_aaa79dd8(localclientnum, newval) {
  if(!isDefined(self)) {
    return;
  }

  self endon(#"death", #"hash_7b232faa08bb9788");
  str_beam = "beam9_zm_ieu_electrical_lv1";

  switch (newval) {
    default:
      break;
    case 2:
      str_beam = "beam9_zm_ieu_electrical_lv2";
      break;
    case 3:
      str_beam = "beam9_zm_ieu_electrical";
      break;
  }

  if(!self zm_utility::function_f8796df3(localclientnum)) {
    str_beam += "_3p";
    self.var_59e057ab = level beam::function_cfb2f62a(localclientnum, self, "tag_flash", undefined, "tag_origin", str_beam);

    while(isDefined(self.var_59e057ab)) {
      waitframe(1);
    }

    return;
  }

  cam_pos = self getcampos();
  target_location = (isDefined(cam_pos) ? cam_pos : self.origin) + 1000 * anglesToForward(self getplayerangles());
  self.var_f28be0bb = util::spawn_model(localclientnum, "tag_origin", target_location);
  self.var_59e057ab = level beam::function_cfb2f62a(localclientnum, self, "tag_flash", self.var_f28be0bb, "tag_origin", str_beam);

  while(isDefined(self.var_f28be0bb)) {
    cam_pos = self getcampos();
    target_location = (isDefined(cam_pos) ? cam_pos : self.origin) + 1000 * anglesToForward(self getplayerangles());
    self.var_f28be0bb.origin = target_location;
    waitframe(1);
  }
}

function function_72b81df3(localclientnum) {
  if(!isDefined(self)) {
    return;
  }

  self notify(#"hash_7b232faa08bb9788");

  if(isDefined(self.var_59e057ab)) {
    beamkill(localclientnum, self.var_59e057ab);
    self.var_59e057ab = undefined;
  }

  if(isDefined(self.var_f28be0bb)) {
    self.var_f28be0bb delete();
  }
}

function function_d8e166f1(parent) {
  level endon(#"end_game");
  self endon(#"death");
  parent waittill(#"death");

  if(isDefined(self)) {
    self delete();
  }
}