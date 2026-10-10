/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\common\debug.gsc
***********************************************/

#using scripts\engine\utility;
#namespace debug;

function function_a2eaafb222316a2(ent) {
  if(!isDefined(ent)) {
    return "<dev string:x1c>";
  }

  text = "<dev string:x1d>" + "<dev string:x1f>" + ent getentitynumber();

  if(isDefined(ent.classname)) {
    text = text + "<dev string:x22>" + ent.classname + "<dev string:x2e>";
  }

  if(isDefined(ent.model)) {
    text = text + "<dev string:x30>" + ent.model + "<dev string:x2e>";
  }

  text += "<dev string:x38>";
  return text;
}

function function_57f3a2089db4a571(corpse) {
  if(getdvarint(@ "hash_f806a3434286263f", 0) != 0) {
    level.var_57f3a2089db4a571 = 1;

    if(isDefined(corpse)) {
      entnum = corpse getentitynumber();
      cmd = "<dev string:x3a>" + entnum + "<dev string:x54>" + entnum;
      adddebugcommand(cmd + "<dev string:x6c>");
    }

    return;
  }

  if(isDefined(level.var_57f3a2089db4a571) && level.var_57f3a2089db4a571) {
    adddebugcommand("<dev string:x6e>");
    level.var_57f3a2089db4a571 = undefined;
  }
}

function function_600b37e8cf3f2de9(ent) {
  if(!isDefined(ent)) {
    return "<dev string:x1c>";
  }

  if(isent(ent)) {
    return ("<dev string:x1f>" + ent getentitynumber());
  }
}

function function_e8ee861a699bea81(variable, undefined_return) {
  if(isDefined(variable)) {
    return (variable + "");
  }

  if(isDefined(undefined_return)) {
    return undefined_return;
  }

  return "";
}

function function_f9304b74bdeafdb0(button, before_text, after_text) {
  self endon("death");

  while(true) {
    if(!self buttonPressed(button)) {
      break;
    }

    waitframe();
  }

  while(true) {
    if(isDefined(before_text)) {
      printtoscreen2d(10, 100, "<dev string:xa4>" + button + "<dev string:xab>" + before_text, (1, 1, 1), 2);
    }

    if(self buttonPressed(button)) {
      break;
    }

    waitframe();
  }

  if(isDefined(after_text)) {
    iprintlnbold(after_text);
    return;
  }

  if(isDefined(before_text)) {
    iprintlnbold("Performed:" + before_text);
  }
}

function function_7320cd1e4f724899(text, color, duration, x, y, scale) {
  if(!isDefined(level.var_252b0cb021ff0964)) {
    level.var_e28e2fe7eef54cc2 = [];
    level.var_44bacfb643ca44f = [];
    level.var_1ed355bf4419acb4 = [];
    level.var_252b0cb021ff0964 = 0;
    level thread function_64f6fe11a0db2eef(x, y, scale);
  }

  if(!isDefined(text)) {
    text = "<dev string:xb1>";
    return;
  }

  if(!isDefined(color)) {
    color = (1, 1, 1);
  }

  if(!isDefined(duration)) {
    duration = getdvarfloat(@ "hash_e7c6b5ac109cff25", 2);
  }

  level.var_e28e2fe7eef54cc2[level.var_252b0cb021ff0964] = text;
  level.var_44bacfb643ca44f[level.var_252b0cb021ff0964] = gettime() + duration * 1000;
  level.var_1ed355bf4419acb4[level.var_252b0cb021ff0964] = color;
  level.var_252b0cb021ff0964++;
}

function function_64f6fe11a0db2eef(x, y, scale) {
  level notify("<dev string:xe4>");
  level endon("<dev string:xe4>");

  if(!isDefined(x)) {
    x = getdvarint(@ "scr_debug_print_x", 850);
  }

  if(!isDefined(y)) {
    y = getdvarint(@ "scr_debug_print_y", 100);
  }

  if(!isDefined(scale)) {
    scale = getdvarfloat(@ "scr_debug_print_scale", 2);
  }

  while(true) {
    waittillframeend();

    if(getdvarint(@ "hash_e4ceb718c4811e97", 1)) {
      keys = getarraykeys(level.var_44bacfb643ca44f);

      if(keys.size > 0) {
        var_aaaa8a8df8f5c537 = getdvarint(@ "hash_b7c9a158890bce5a");
        var_ab5696f7e031e1ba = getdvarint(@ "hash_9139b4ad2f235c95");
        var_39c991ead8822d9b = getdvarint(@ "hash_b7c9a158890bce5a") / 1920;
        var_3f109f5aaf427a = getdvarint(@ "hash_9139b4ad2f235c95") / 1080;
        base_x = x * var_39c991ead8822d9b;
        base_y = y * var_3f109f5aaf427a;
        base_scale = scale * var_3f109f5aaf427a;
      }

      time = gettime();
      linecount = 0;

      foreach(i in keys) {
        if(time > level.var_44bacfb643ca44f[i]) {
          level.var_44bacfb643ca44f[i] = undefined;
          level.var_e28e2fe7eef54cc2[i] = undefined;
          level.var_1ed355bf4419acb4[i] = undefined;
          continue;
        }

        linecount++;
        printtoscreen2d(base_x, base_y + base_scale * 12 * linecount, level.var_e28e2fe7eef54cc2[i], level.var_1ed355bf4419acb4[i], base_scale);
      }
    }

    waitframe();
  }
}

function debug_sphere(target, radius, color, seconds, level_endon, target_endon) {
  level thread function_2061efdf2b62dcdc(target, radius, color, seconds, level_endon, target_endon);
}

function function_2061efdf2b62dcdc(target, radius, color, seconds, level_endon, target_endon) {
  if(!isDefined(radius)) {
    radius = 10;
  }

  target_vector = undefined;

  if(isvector(target)) {
    target_vector = target;
  }

  if(isDefined(color) && isstring(color)) {
    color = get_color(color);
  }

  if(!isDefined(color)) {
    color = (1, 1, 1);
  }

  end_time = undefined;

  if(isDefined(seconds)) {
    end_time = gettime() + seconds * 1000;
  }

  if(isDefined(level_endon)) {
    level endon(level_endon);
  }

  if(isDefined(target_endon)) {
    assertex(!isvector(target), "<dev string:xff>");
    target endon(target_endon);
  }

  while(isDefined(target)) {
    if(isDefined(end_time) && end_time < gettime()) {
      return;
    }

    if(!isvector(target)) {
      target_vector = target.origin;
    }

    sphere(target_vector, radius, color, 0, 1);
    waitframe();
  }
}

function debug_line(target, target2, color, seconds, level_endon, target_endon, target2_endon) {
  level thread function_43a9c3a623a796bd(target, target2, color, seconds, level_endon, target_endon, target2_endon);
}

function function_43a9c3a623a796bd(target, target2, color, seconds, level_endon, target_endon, target2_endon) {
  target_vector = undefined;

  if(isvector(target)) {
    target_vector = target;
  }

  target2_vector = undefined;

  if(isvector(target2)) {
    target2_vector = target2;
  }

  if(isDefined(color) && isstring(color)) {
    color = get_color(color);
  }

  if(!isDefined(color)) {
    color = (1, 1, 1);
  }

  end_time = undefined;

  if(isDefined(seconds)) {
    end_time = gettime() + seconds * 1000;
  }

  if(isDefined(level_endon)) {
    level endon(level_endon);
  }

  if(isDefined(target_endon)) {
    assertex(!isvector(target), "<dev string:xff>");
    target endon(target_endon);
  }

  if(isDefined(target2_endon)) {
    assertex(!isvector(target2), "<dev string:xff>");
    target2 endon(target2_endon);
  }

  while(isDefined(target) && isDefined(target2)) {
    if(isDefined(end_time) && end_time < gettime()) {
      return;
    }

    if(!isvector(target)) {
      target_vector = target.origin;
    }

    if(!isvector(target2)) {
      target2_vector = target2.origin;
    }

    line(target_vector, target2_vector, color, 1, 0, 1);
    waitframe();
  }
}

function draw_angles(target, angles, radius, seconds, level_endon, target_endon) {
  level thread function_3a97db5a17888208(target, angles, radius, seconds, level_endon, target_endon);
}

function function_3a97db5a17888208(target, angles, radius, seconds, level_endon, target_endon) {
  if(!isDefined(radius)) {
    radius = 100;
  }

  target_vector = undefined;

  if(isvector(target)) {
    target_vector = target;
  }

  end_time = undefined;

  if(isDefined(seconds)) {
    end_time = gettime() + seconds * 1000;
  }

  if(isDefined(level_endon)) {
    level endon(level_endon);
  }

  if(isDefined(target_endon)) {
    assertex(!isvector(target), "<dev string:xff>");
    target endon(target_endon);
  }

  while(isDefined(target)) {
    if(isDefined(end_time) && end_time < gettime()) {
      return;
    }

    if(!isvector(target)) {
      target_vector = target.origin;
      angles = target.angles;
    }

    forward = anglesToForward(angles);
    right = anglestoright(angles);
    up = anglestoup(angles);
    line(target_vector, target_vector + forward * radius, (1, 0, 0), 1, 0, 1);
    line(target_vector, target_vector + right * radius, (0, 1, 0), 1, 0, 1);
    line(target_vector, target_vector + up * radius, (0, 0, 1), 1, 0, 1);
    waitframe();
  }
}

function interact(target, text, on_use_func, var_38669543a34ecd14, end_on_use, level_endon, target_endon, color, z_offset, alpha, scale) {
  level thread interact_internal(target, text, on_use_func, var_38669543a34ecd14, end_on_use, level_endon, target_endon, color, z_offset, alpha, scale);
}

function interact_internal(target, text, on_use_func, var_38669543a34ecd14, end_on_use, level_endon, target_endon, color, z_offset, alpha, scale) {
  if(!isDefined(end_on_use)) {
    end_on_use = 0;
  }

  if(!isDefined(z_offset)) {
    z_offset = 10;
  }

  if(!isDefined(alpha)) {
    alpha = 1;
  }

  if(!isDefined(scale)) {
    scale = 1;
  }

  v_target = undefined;

  if(isvector(target)) {
    v_target = target;
  } else {
    v_target = target.origin;
  }

  interact = undefined;

  if(issharedfuncdefined("<dev string:x12b>", "<dev string:x130>")) {
    interact = [[getsharedfunc("<dev string:x12b>", "<dev string:x130>")]](v_target, "<dev string:x141>", undefined, undefined, 5, "<dev string:x14d>", "<dev string:x15c>", 100, 90, 100, 90);
  } else {
    assertmsg("<dev string:x161>");
  }

  if(isent(target)) {
    interact linkTo(target);
    interact thread utility::function_fe32d769b4bbd6a1(target, "<dev string:x1b0>");
    target endon("<dev string:x1b0>");
  }

  if(isDefined(level_endon)) {
    level endon(level_endon);
    interact thread utility::function_fe32d769b4bbd6a1(level, level_endon);
  }

  if(isDefined(target_endon)) {
    assertex(!isvector(target), "<dev string:xff>");
    target endon(target_endon);
    interact thread utility::function_fe32d769b4bbd6a1(target, target_endon);
  }

  if(isDefined(color) && isstring(color)) {
    color = get_color(color);
  }

  if(!isDefined(color)) {
    color = (1, 1, 1);
  }

  if(isDefined(text)) {
    childthread function_bbc7faeb2e19df2d(interact, text, color, undefined, undefined, undefined, alpha, scale, z_offset);
  }

  childthread function_2061efdf2b62dcdc(interact, 2, color);

  while(isDefined(target)) {
    interact waittill("<dev string:x1be>", player);

    if(isDefined(on_use_func)) {
      if(isDefined(var_38669543a34ecd14)) {
        if(!isarray(var_38669543a34ecd14)) {
          var_38669543a34ecd14 = [var_38669543a34ecd14];
        }

        level thread utility::single_func_argarray(player, on_use_func, var_38669543a34ecd14);
      } else {
        player thread[[on_use_func]]();
      }
    }

    if(end_on_use) {
      interact delete();
      return;
    }
  }
}

function debug_print3d(target, text, color, seconds, level_endon, target_endon, alpha, scale, z_offset) {
  level thread function_bbc7faeb2e19df2d(target, text, color, seconds, level_endon, target_endon, alpha, scale, z_offset);
}

function function_bbc7faeb2e19df2d(target, text, color, seconds, level_endon, target_endon, alpha, scale, z_offset) {
  if(!isDefined(alpha)) {
    alpha = 1;
  }

  if(!isDefined(scale)) {
    scale = 1;
  }

  if(!isDefined(z_offset)) {
    z_offset = 0;
  }

  v_target = undefined;

  if(isvector(target)) {
    v_target = target;
  }

  if(isDefined(color) && isstring(color)) {
    color = get_color(color);
  }

  if(!isDefined(color)) {
    color = (1, 1, 1);
  }

  end_time = undefined;

  if(isDefined(seconds)) {
    end_time = gettime() + seconds * 1000;
  }

  if(isDefined(level_endon)) {
    level endon(level_endon);
  }

  if(isDefined(target_endon)) {
    assertex(!isvector(target), "<dev string:xff>");
    target endon(target_endon);
  }

  while(isDefined(target)) {
    if(isDefined(end_time) && end_time < gettime()) {
      return;
    }

    if(!isvector(target)) {
      v_target = target.origin;
    }

    print3d(v_target + (0, 0, z_offset), text, color, alpha, scale, 1, 1);
    waitframe();
  }
}

function get_color(color) {
  switch (color) {
    case #"hash_97430f6c58e61cbc":
      return (1, 0, 0);
    case #"hash_35bb3bd014c77f4b":
      return (1, 0.5, 0);
    case #"hash_2ac407c1cd5943a9":
      return (1, 1, 0);
    case #"hash_883ff07272b4f9c":
      return (0, 1, 0);
    case #"hash_6686d129776d649a":
      return (0, 1, 1);
    case #"hash_778bb52ecd08072d":
      return (0, 0, 1);
    case #"hash_40fc63173753ec52":
      return (1, 0.5, 1);
    case #"hash_598a30e44f53045f":
      return (0.5, 0, 1);
    case #"hash_6eb69eb2e91f9fc8":
      return (1, 0, 1);
    case #"hash_8c6e8e84936881cd":
      return (1, 0.75, 0.75);
    case #"hash_1393412d7401c646":
      return (1, 1, 1);
    case #"hash_a4324aac758f0a84":
      return (0, 0, 0);
    case #"hash_dd71850f436e7706":
    case #"hash_dd7e8d0f437910fa":
      return (0.75, 0.75, 0.75);
    case #"hash_2748da0737956f91":
    case #"hash_82bae0726e5ab95":
      return (0.1, 0.1, 0.1);
    case #"hash_82bab0726e5a6dc":
    case #"hash_2748d70737956ad8":
      return (0.2, 0.2, 0.2);
    case #"hash_82bac0726e5a86f":
    case #"hash_2748d80737956c6b":
      return (0.3, 0.3, 0.3);
    case #"hash_82ba90726e5a3b6":
    case #"hash_2748dd073795744a":
      return (0.4, 0.4, 0.4);
    case #"hash_82baa0726e5a549":
    case #"hash_2748de07379575dd":
      return (0.5, 0.5, 0.5);
    case #"hash_2748db0737957124":
    case #"hash_82ba70726e5a090":
      return (0.6, 0.6, 0.6);
    case #"hash_82ba80726e5a223":
    case #"hash_2748dc07379572b7":
      return (0.7, 0.7, 0.7);
    case #"hash_82bb50726e5b69a":
    case #"hash_2748d10737956166":
      return (0.8, 0.8, 0.8);
    case #"hash_82bb60726e5b82d":
    case #"hash_2748d207379562f9":
      return (0.9, 0.9, 0.9);
    default:
      assertmsg("<dev string:x285>");
      return undefined;
  }
}

function function_8245dce28f1f395c(dmg_data, original_damage, pre_final, display_time, display_scale, var_3b3652114fdefa9f) {
  if(!isDefined(display_time)) {
    display_time = 5;
  }

  if(!isDefined(display_scale)) {
    display_scale = 0.25;
  }

  if(!isDefined(var_3b3652114fdefa9f)) {
    var_3b3652114fdefa9f = 1;
  }

  if(!isDefined(dmg_data) || isDefined(dmg_data) && !isarray(dmg_data)) {
    return;
  }

  if(!isDefined(self)) {
    return;
  }

  einflictor = isDefined(dmg_data["<dev string:x2f0>"]) ? dmg_data["<dev string:x2f0>"] : undefined;
  eattacker = isDefined(dmg_data["<dev string:x2fb>"]) ? dmg_data["<dev string:x2fb>"] : undefined;
  idamage = isDefined(dmg_data["<dev string:x305>"]) ? dmg_data["<dev string:x305>"] : 0;
  smod = isDefined(dmg_data["<dev string:x30d>"]) ? dmg_data["<dev string:x30d>"] : undefined;
  sweapon = isDefined(dmg_data["<dev string:x31b>"]) ? dmg_data["<dev string:x31b>"] : undefined;
  vpoint = isDefined(dmg_data["<dev string:x323>"]) ? dmg_data["<dev string:x323>"] : undefined;
  vdir = isDefined(dmg_data["<dev string:x32a>"]) ? dmg_data["<dev string:x32a>"] : undefined;
  shitloc = isDefined(dmg_data["<dev string:x32f>"]) ? dmg_data["<dev string:x32f>"] : undefined;
  objweapon = isDefined(dmg_data["<dev string:x337>"]) ? dmg_data["<dev string:x337>"] : undefined;
  partname = isDefined(dmg_data["<dev string:x341>"]) ? dmg_data["<dev string:x341>"] : undefined;
  tagname = isDefined(dmg_data["<dev string:x34a>"]) ? dmg_data["<dev string:x34a>"] : undefined;

  if(istrue(var_3b3652114fdefa9f)) {
    if(!isDefined(eattacker) || isDefined(eattacker) && !isPlayer(eattacker) && (!isDefined(einflictor) || isDefined(einflictor) && !isPlayer(einflictor))) {
      return;
    }
  }

  if(is_equal(display_time, -1)) {
    display_time = undefined;
  }

  s = "<dev string:x352>" + self getentitynumber();

  if(isDefined(einflictor)) {
    s += "<dev string:x35e>" + einflictor getentitynumber();
  }

  if(isDefined(eattacker)) {
    s += "<dev string:x367>" + eattacker getentitynumber();
  }

  if(isDefined(shitloc)) {
    s += "<dev string:x370>" + shitloc;
  }

  s2 = "<dev string:x1c>";
  s2 += "<dev string:x377>" + idamage;

  if(isDefined(original_damage) && original_damage != idamage) {
    s2 += "<dev string:x37d>" + original_damage;
  }

  if(isDefined(smod)) {
    s2 += "<dev string:x389>" + smod;
  }

  s3 = "<dev string:x1c>";

  if(isDefined(self) && isDefined(self.health) && isDefined(self.maxhealth)) {
    if(istrue(pre_final)) {
      s3 = "<dev string:x38f>" + self.health - idamage + "<dev string:x398>" + self.maxhealth;
    } else {
      s3 = "<dev string:x38f>" + self.health + "<dev string:x398>" + self.maxhealth;
    }
  }

  s4 = "<dev string:x1c>";

  if(isDefined(sweapon)) {
    if(isstring(sweapon)) {
      s4 = "<dev string:x39c>" + sweapon;
    } else if(isDefined(sweapon.basename)) {
      s4 = "<dev string:x39c>" + sweapon.basename;
    }
  } else if(isDefined(objweapon)) {
    if(isDefined(objweapon.basename)) {
      s4 = "<dev string:x39c>" + objweapon.basename;
    }
  }

  if(isDefined(einflictor) && isDefined(einflictor.weapon_name)) {
    s4 += "<dev string:x3a5>" + einflictor.weapon_name;
    weap_name = einflictor.weapon_name;
  }

  s5 = "<dev string:x3be>";
  printloc = undefined;

  if(isDefined(vpoint)) {
    printloc = vpoint;
  } else if(isDefined(self.origin)) {
    printloc = self.origin;
  }

  if(getdvarint(@ "hash_81d89e4abec64203", 0) == 1 && isDefined(printloc)) {
    debug_print3d(printloc, s, undefined, display_time, undefined, undefined, undefined, display_scale);
    debug_print3d(printloc, s2, undefined, display_time, undefined, undefined, undefined, display_scale, -5);
    debug_print3d(printloc, s3, undefined, display_time, undefined, undefined, undefined, display_scale, -10);
    debug_print3d(printloc, s4, undefined, display_time, undefined, undefined, undefined, display_scale, -15);
    return;
  }

  if(isDefined(display_time)) {
    function_7320cd1e4f724899(s5, undefined, display_time);
    function_7320cd1e4f724899(s4, undefined, display_time);
    function_7320cd1e4f724899(s3, undefined, display_time);
    function_7320cd1e4f724899(s2, undefined, display_time);
    function_7320cd1e4f724899(s, undefined, display_time);
    return;
  }

  function_7320cd1e4f724899(s5, undefined, 300);
  function_7320cd1e4f724899(s4, undefined, 300);
  function_7320cd1e4f724899(s3, undefined, 300);
  function_7320cd1e4f724899(s2, undefined, 300);
  function_7320cd1e4f724899(s, undefined, 300);
}

# /