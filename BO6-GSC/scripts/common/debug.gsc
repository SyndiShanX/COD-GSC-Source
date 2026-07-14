/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\debug.gsc
**************************************/

#using scripts\engine\utility;
#namespace debug;

function function_4496bef4cfc0d07(ent) {
  if(!isDefined(ent)) {
    return "<dev string:x24>";
  }

  text = "<dev string:x28>" + "<dev string:x2d>" + ent getentitynumber();

  if(isDefined(ent.classname)) {
    text = text + "<dev string:x33>" + ent.classname + "<dev string:x42>";
  }

  if(isDefined(ent.model)) {
    text = text + "<dev string:x47>" + ent.model + "<dev string:x42>";
  }

  text += "<dev string:x52>";
  return text;
}

function function_b94568e3a7672460(corpse) {
  setdvarifuninitialized(@ "hash_f806a3434286263f", 0);

  if(getdvarint(@ "hash_f806a3434286263f", 0) != 0) {
    level.var_b94568e3a7672460 = 1;

    if(isDefined(corpse)) {
      entnum = corpse getentitynumber();
      cmd = "<dev string:x57>" + entnum + "<dev string:x74>" + entnum;
      adddebugcommand(cmd + "<dev string:x8f>");
    }

    return;
  }

  if(isDefined(level.var_b94568e3a7672460) && level.var_b94568e3a7672460) {
    adddebugcommand("<dev string:x94>");
    level.var_b94568e3a7672460 = undefined;
  }
}

function function_a8ee5e70fb7d68d0(ent) {
  if(!isDefined(ent)) {
    return "<dev string:x24>";
  }

  if(isent(ent)) {
    return ("<dev string:x2d>" + ent getentitynumber());
  }
}

function get_text_safe(variable, undefined_return) {
  if(isDefined(variable)) {
    return (variable + "");
  }

  if(isDefined(undefined_return)) {
    return undefined_return;
  }

  return "";
}

function function_4be0558f456a7a55(button, before_text, after_text) {
  self endon("death");

  while(true) {
    if(!self buttonPressed(button)) {
      break;
    }

    waitframe();
  }

  while(true) {
    if(isDefined(before_text)) {
      printtoscreen2d(10, 100, "<dev string:xcd>" + button + "<dev string:xd7>" + before_text, (1, 1, 1), 2);
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

function function_9d6fee9cf5908ddc(text, color, duration, x, y, scale) {
  if(!isDefined(level.var_c0c795135a99c953)) {
    level.var_a80a0ef465615ead = [];
    level.var_b9398a72c24761c2 = [];
    level.var_bfbc88e93e9c37d1 = [];
    level.var_c0c795135a99c953 = 0;
    level thread function_a06c9bfa7621ba4a(x, y, scale);
  }

  if(!isDefined(text)) {
    text = "<dev string:xe0>";
    return;
  }

  if(!isDefined(color)) {
    color = (1, 1, 1);
  }

  if(!isDefined(duration)) {
    duration = getdvarfloat(@ "hash_e7c6b5ac109cff25", 2);
  }

  level.var_a80a0ef465615ead[level.var_c0c795135a99c953] = text;
  level.var_b9398a72c24761c2[level.var_c0c795135a99c953] = gettime() + duration * 1000;
  level.var_bfbc88e93e9c37d1[level.var_c0c795135a99c953] = color;
  level.var_c0c795135a99c953++;
}

function function_a06c9bfa7621ba4a(x, y, scale) {
  level notify("<dev string:x116>");
  level endon("<dev string:x116>");

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
      keys = getarraykeys(level.var_b9398a72c24761c2);

      if(keys.size > 0) {
        vid_width = getdvarint(@ "vid_width");
        vid_height = getdvarint(@ "vid_height");
        vid_width_ratio = getdvarint(@ "vid_width") / 1920;
        vid_height_ratio = getdvarint(@ "vid_height") / 1080;
        base_x = x * vid_width_ratio;
        base_y = y * vid_height_ratio;
        base_scale = scale * vid_height_ratio;
      }

      time = gettime();
      linecount = 0;

      foreach(i in keys) {
        if(time > level.var_b9398a72c24761c2[i]) {
          level.var_b9398a72c24761c2[i] = undefined;
          level.var_a80a0ef465615ead[i] = undefined;
          level.var_bfbc88e93e9c37d1[i] = undefined;
          continue;
        }

        linecount++;
        printtoscreen2d(base_x, base_y + base_scale * 12 * linecount, level.var_a80a0ef465615ead[i], level.var_bfbc88e93e9c37d1[i], base_scale);
      }
    }

    waitframe();
  }
}

function sphere(target, radius, color, seconds, level_endon, target_endon) {
  level thread sphere_internal(target, radius, color, seconds, level_endon, target_endon);
}

function sphere_internal(target, radius, color, seconds, level_endon, target_endon) {
  if(!isDefined(radius)) {
    radius = 10;
  }

  target_vector = undefined;

  if(isvector(target)) {
    target_vector = target;
  }

  if(isstring(color)) {
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
    assert(!isvector(target), "<dev string:x134>");
    target endon(target_endon);
  }

  while(isDefined(target)) {
    if(end_time < gettime()) {
      return;
    }

    if(!isvector(target)) {
      target_vector = target.origin;
    }

    sphere(target_vector, radius, color, 0, 1);
    waitframe();
  }
}

function cylinder(target, target2, radius, color, seconds, level_endon, target_endon, target2_endon) {
  level thread cylinder_internal(target, target2, radius, color, seconds, level_endon, target_endon, target2_endon);
}

function cylinder_internal(target, target2, radius, color, seconds, level_endon, target_endon, target2_endon) {
  if(!isDefined(radius)) {
    radius = 10;
  }

  target_vector = undefined;

  if(isvector(target)) {
    target_vector = target;
  }

  target2_vector = undefined;

  if(isvector(target2)) {
    target2_vector = target2;
  }

  if(isstring(color)) {
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
    assert(!isvector(target), "<dev string:x134>");
    target endon(target_endon);
  }

  if(isDefined(target2_endon)) {
    assert(!isvector(target2), "<dev string:x134>");
    target2 endon(target2_endon);
  }

  while(isDefined(target) && isDefined(target2)) {
    if(end_time < gettime()) {
      return;
    }

    if(!isvector(target)) {
      target_vector = target.origin;
    }

    if(!isvector(target2)) {
      if(isnumber(target2)) {
        target2_vector = target.origin + (0, 0, target2);
      } else {
        target2_vector = target2.origin;
      }
    }

    cylinder(target_vector, target2_vector, radius, color, 0, 1);
    waitframe();
  }
}

function line(target, target2, color, seconds, level_endon, target_endon, target2_endon) {
  level thread line_internal(target, target2, color, seconds, level_endon, target_endon, target2_endon);
}

function line_internal(target, target2, color, seconds, level_endon, target_endon, target2_endon) {
  target_vector = undefined;

  if(isvector(target)) {
    target_vector = target;
  }

  target2_vector = undefined;

  if(isvector(target2)) {
    target2_vector = target2;
  }

  if(isstring(color)) {
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
    assert(!isvector(target), "<dev string:x134>");
    target endon(target_endon);
  }

  if(isDefined(target2_endon)) {
    assert(!isvector(target2), "<dev string:x134>");
    target2 endon(target2_endon);
  }

  while(isDefined(target) && isDefined(target2)) {
    if(end_time < gettime()) {
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

function function_76204bee46fa39fd(midpoint, halfsize, angles, drawtimeseconds, color) {
  if(isDefined(angles)) {
    forward = anglesToForward(angles);
    right = anglestoright(angles);
    up = anglestoup(angles);
  } else {
    forward = (1, 0, 0);
    right = (0, 1, 0);
    up = (0, 0, 1);
  }

  localcorners = [];
  localcorners[0] = (halfsize[0] * -1, halfsize[1] * -1, halfsize[2]);
  localcorners[1] = (halfsize[0], halfsize[1] * -1, halfsize[2]);
  localcorners[2] = (halfsize[0] * -1, halfsize[1], halfsize[2]);
  localcorners[3] = (halfsize[0], halfsize[1], halfsize[2]);
  localcorners[4] = (halfsize[0] * -1, halfsize[1] * -1, halfsize[2] * -1);
  localcorners[5] = (halfsize[0], halfsize[1] * -1, halfsize[2] * -1);
  localcorners[6] = (halfsize[0] * -1, halfsize[1], halfsize[2] * -1);
  localcorners[7] = (halfsize[0], halfsize[1], halfsize[2] * -1);
  worldcorners = [];

  for(i = 0; i < 8; i++) {
    x = localcorners[i][0];
    y = localcorners[i][1];
    z = localcorners[i][2];
    worldcorners[i] = midpoint + x * forward + y * right + z * up;
  }

  thread function_5216f7041907b4f3(worldcorners[0], worldcorners[1], worldcorners[2], worldcorners[3], worldcorners[4], worldcorners[5], worldcorners[6], worldcorners[7], drawtimeseconds, color);
}

function function_5216f7041907b4f3(topleftfront, toprightfront, topleftback, toprightback, bottomleftfront, bottomrightfront, bottomleftback, bottomrightback, drawtimeseconds, color) {
  line(topleftfront, toprightfront, color, drawtimeseconds);
  line(topleftfront, bottomleftfront, color, drawtimeseconds);
  line(topleftfront, topleftback, color, drawtimeseconds);
  line(toprightfront, toprightback, color, drawtimeseconds);
  line(toprightfront, bottomrightfront, color, drawtimeseconds);
  line(topleftback, bottomleftback, color, drawtimeseconds);
  line(topleftback, toprightback, color, drawtimeseconds);
  line(toprightback, bottomrightback, color, drawtimeseconds);
  line(bottomleftfront, bottomrightfront, color, drawtimeseconds);
  line(bottomleftfront, bottomleftback, color, drawtimeseconds);
  line(bottomrightfront, bottomrightback, color, drawtimeseconds);
  line(bottomrightback, bottomleftback, color, drawtimeseconds);
}

function draw_angles(target, angles, radius, seconds, level_endon, target_endon) {
  level thread draw_angles_internal(target, angles, radius, seconds, level_endon, target_endon);
}

function draw_angles_internal(target, angles, radius, seconds, level_endon, target_endon) {
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
    assert(!isvector(target), "<dev string:x134>");
    target endon(target_endon);
  }

  while(isDefined(target)) {
    if(end_time < gettime()) {
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

function interact(target, text, on_use_func, var_c1aafa863dab2d81, end_on_use, level_endon, target_endon, color, z_offset, alpha, scale) {
  level thread interact_internal(target, text, on_use_func, var_c1aafa863dab2d81, end_on_use, level_endon, target_endon, color, z_offset, alpha, scale);
}

function interact_internal(target, text, on_use_func, var_c1aafa863dab2d81, end_on_use, level_endon, target_endon, color, z_offset, alpha, scale) {
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

  if(utility::issharedfuncdefined(#"game", #"createhintobject")) {
    interact = [[utility::getsharedfunc(#"game", #"createhintobject")]](v_target, "<dev string:x163>", undefined, undefined, 5, "<dev string:x172>", "<dev string:x184>", 100, 90, 100, 90);
  } else {
    assertmsg("<dev string:x18c>");
  }

  if(isent(target)) {
    interact linkTo(target);
    interact thread utility::function_fb5b19421bb35e50(target, "<dev string:x1e2>");
    target endon("<dev string:x1e2>");
  }

  if(isDefined(level_endon)) {
    level endon(level_endon);
    interact thread utility::function_fb5b19421bb35e50(level, level_endon);
  }

  if(isDefined(target_endon)) {
    assert(!isvector(target), "<dev string:x134>");
    target endon(target_endon);
    interact thread utility::function_fb5b19421bb35e50(target, target_endon);
  }

  if(isstring(color)) {
    color = get_color(color);
  }

  if(!isDefined(color)) {
    color = (1, 1, 1);
  }

  if(isDefined(text)) {
    childthread print3d_internal(interact, text, color, undefined, undefined, undefined, alpha, scale, z_offset);
  }

  childthread sphere_internal(interact, 2, color);

  while(isDefined(target)) {
    interact waittill("<dev string:x1f3>", player);

    if(isDefined(on_use_func)) {
      if(isDefined(var_c1aafa863dab2d81)) {
        if(!isarray(var_c1aafa863dab2d81)) {
          var_c1aafa863dab2d81 = [var_c1aafa863dab2d81];
        }

        level thread utility::single_func_argarray(player, on_use_func, var_c1aafa863dab2d81);
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

function print3d(target, text, color, seconds, level_endon, target_endon, alpha, scale, z_offset) {
  level thread print3d_internal(target, text, color, seconds, level_endon, target_endon, alpha, scale, z_offset);
}

function print3d_internal(target, text, color, seconds, level_endon, target_endon, alpha, scale, z_offset) {
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

  if(isstring(color)) {
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
    assert(!isvector(target), "<dev string:x134>");
    target endon(target_endon);
  }

  while(isDefined(target)) {
    if(end_time < gettime()) {
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
      assertmsg("<dev string:x31d>");
      return undefined;
  }
}

function function_154a142652377d60(amt, player, var_abc62fc97e9490dc) {
  if(!isDefined(self.hit_times)) {
    self.hit_times = 2;
  }

  color = (1, 0, 0);

  if(!var_abc62fc97e9490dc) {
    color = (0, 0, 1);
  }

  start = self.origin + (0, 0, 60);
  extra = 0;
  alpha = 1;
  right = anglestoleft(vectortoangles(player.origin - self.origin));
  my_column = self.hit_times % 5 - 2;
  offset = my_column * 19 * right;
  start += offset * 0.25;
  offset *= 0.75;
  self.hit_times++;

  while(extra < 60) {
    if(extra < 15) {
      alpha = 1;
    } else {
      alpha = clamp(1 - (extra - 15) / 45, 0, 1);
    }

    print3d(start + offset * alpha + (0, 0, extra), string(amt), color, alpha, alpha * 0.75, 1, 1);
    extra += 2;
    waitframe();
  }
}

function function_6044f282cee497bb(dmg_data, original_damage, pre_final, display_time, display_scale, var_4a17dd271bf78234) {
  if(!isDefined(display_time)) {
    display_time = 5;
  }

  if(!isDefined(display_scale)) {
    display_scale = 0.25;
  }

  if(!isDefined(var_4a17dd271bf78234)) {
    var_4a17dd271bf78234 = 1;
  }

  if(!isDefined(dmg_data) || isDefined(dmg_data) && !isarray(dmg_data)) {
    return;
  }

  if(!isDefined(self)) {
    return;
  }

  einflictor = dmg_data["<dev string:x38b>"] ?? undefined;
  eattacker = dmg_data["<dev string:x399>"] ?? undefined;
  idamage = dmg_data["<dev string:x3a6>"] ?? 0;
  smod = dmg_data["<dev string:x3b1>"] ?? undefined;
  sweapon = dmg_data["<dev string:x3c2>"] ?? undefined;
  vpoint = dmg_data["<dev string:x3cd>"] ?? undefined;
  vdir = dmg_data["<dev string:x3d7>"] ?? undefined;
  shitloc = dmg_data["<dev string:x3df>"] ?? undefined;
  objweapon = dmg_data["<dev string:x3ea>"] ?? undefined;
  partname = dmg_data["<dev string:x3f7>"] ?? undefined;
  tagname = dmg_data["<dev string:x403>"] ?? undefined;

  if(var_4a17dd271bf78234) {
    if(!isDefined(eattacker) || isDefined(eattacker) && !isPlayer(eattacker) && (!isDefined(einflictor) || isDefined(einflictor) && !isPlayer(einflictor))) {
      return;
    }
  }

  if(display_time == -1) {
    display_time = undefined;
  }

  s = "<dev string:x40e>" + self getentitynumber();

  if(isDefined(einflictor)) {
    s += "<dev string:x41d>" + einflictor getentitynumber();
  }

  if(isDefined(eattacker)) {
    s += "<dev string:x429>" + eattacker getentitynumber();
  }

  if(isDefined(shitloc)) {
    s += "<dev string:x435>" + shitloc;
  }

  s2 = "<dev string:x24>";
  s2 += "<dev string:x43f>" + idamage;

  if(isDefined(original_damage) && original_damage != idamage) {
    s2 += "<dev string:x448>" + original_damage;
  }

  if(isDefined(smod)) {
    s2 += "<dev string:x457>" + smod;
  }

  s3 = "<dev string:x24>";

  if(isDefined(self.health) && isDefined(self) && isDefined(self.maxhealth)) {
    if(pre_final) {
      s3 = "<dev string:x460>" + self.health - idamage + "<dev string:x46c>" + self.maxhealth;
    } else {
      s3 = "<dev string:x460>" + self.health + "<dev string:x46c>" + self.maxhealth;
    }
  }

  s4 = "<dev string:x24>";

  if(isDefined(sweapon)) {
    if(isstring(sweapon)) {
      s4 = "<dev string:x473>" + sweapon;
    } else if(isDefined(sweapon.basename)) {
      s4 = "<dev string:x473>" + sweapon.basename;
    }
  } else if(isDefined(objweapon)) {
    if(isDefined(objweapon.basename)) {
      s4 = "<dev string:x473>" + objweapon.basename;
    }
  }

  if(isDefined(einflictor) && isDefined(einflictor.weapon_name)) {
    s4 += "<dev string:x47f>" + einflictor.weapon_name;
    weap_name = einflictor.weapon_name;
  }

  s5 = "<dev string:x49b>";
  printloc = undefined;

  if(isDefined(vpoint)) {
    printloc = vpoint;
  } else if(isDefined(self.origin)) {
    printloc = self.origin;
  }

  if(getdvarint(@ "hash_81d89e4abec64203", 0) == 1 && isDefined(printloc)) {
    print3d(printloc, s, undefined, display_time, undefined, undefined, undefined, display_scale);
    print3d(printloc, s2, undefined, display_time, undefined, undefined, undefined, display_scale, -5);
    print3d(printloc, s3, undefined, display_time, undefined, undefined, undefined, display_scale, -10);
    print3d(printloc, s4, undefined, display_time, undefined, undefined, undefined, display_scale, -15);
    return;
  }

  if(isDefined(display_time)) {
    function_9d6fee9cf5908ddc(s5, undefined, display_time);
    function_9d6fee9cf5908ddc(s4, undefined, display_time);
    function_9d6fee9cf5908ddc(s3, undefined, display_time);
    function_9d6fee9cf5908ddc(s2, undefined, display_time);
    function_9d6fee9cf5908ddc(s, undefined, display_time);
    return;
  }

  function_9d6fee9cf5908ddc(s5, undefined, 300);
  function_9d6fee9cf5908ddc(s4, undefined, 300);
  function_9d6fee9cf5908ddc(s3, undefined, 300);
  function_9d6fee9cf5908ddc(s2, undefined, 300);
  function_9d6fee9cf5908ddc(s, undefined, 300);
}

function function_298a6c4895b8935d(start_pos) {
  assert(!isDefined(level.var_4ce8846f2a8daddd), "<dev string:x4b9>");
  var_4ce8846f2a8daddd = spawnStruct();
  var_4ce8846f2a8daddd.origin = start_pos;
  var_4ce8846f2a8daddd.first_print = 0;
  level.var_4ce8846f2a8daddd = var_4ce8846f2a8daddd;
}

function function_ce323c1a383e915(text, color, scale, duration) {
  assert(isDefined(level.var_4ce8846f2a8daddd), "<dev string:x518>");

  if(!isDefined(color)) {
    color = (1, 1, 1);
  }

  if(!isDefined(scale)) {
    scale = 1;
  }

  if(!isDefined(duration)) {
    duration = 1;
  }

  num_lines = strtok(text, "<dev string:x8f>");
  function_73cf360ef9afd65(level.var_4ce8846f2a8daddd, num_lines.size, scale);
  level thread function_cd774040359eeb32(level.var_4ce8846f2a8daddd.origin[0], level.var_4ce8846f2a8daddd.origin[1], text, color, scale, duration);
}

function function_9de8db536c079b2d() {
  level.var_4ce8846f2a8daddd = undefined;
}

function private function_cd774040359eeb32(x, y, text, color, scale, duration_frames) {
  level endon("<dev string:x564>");

  for(_ = 0; _ < duration_frames; _++) {
    printtoscreen2d(x, y, text, color, scale);
    waitframe();
  }
}

function private function_73cf360ef9afd65(var_4ce8846f2a8daddd, lines, scale) {
  if(var_4ce8846f2a8daddd.first_print) {
    var_4ce8846f2a8daddd.origin = (var_4ce8846f2a8daddd.origin[0], var_4ce8846f2a8daddd.origin[1] + 16 * lines * scale, 0);
  }

  var_4ce8846f2a8daddd.first_print = 1;
}

function debug_draw_arrow(start, end, color, alpha, depthtest, duration) {
  if(!isDefined(alpha)) {
    alpha = 1;
  }

  if(!isDefined(depthtest)) {
    depthtest = 1;
  }

  if(!isDefined(duration)) {
    duration = 1;
  }

  forward = vectorNormalize(end - start);
  dist = distance(start, end);
  left = vectorcross((0, 0, 1), forward);
  right = left * -1;
  var_8e72652f37df3928 = end;
  var_68f16d84945b7e82 = var_8e72652f37df3928 - forward * 24;
  line(start, end, color, alpha, depthtest, duration);
  line(var_8e72652f37df3928, var_68f16d84945b7e82 + left * 16, color, alpha, depthtest, duration);
  line(var_8e72652f37df3928, var_68f16d84945b7e82 + right * 16, color, alpha, depthtest, duration);
}

function function_cccfaecda82a4343(origin, forward_dir, length, half_angle, color, duration, num_lines) {
  if(!isDefined(duration)) {
    duration = 1;
  }

  if(!isDefined(num_lines)) {
    num_lines = 12;
  }

  angles = vectortoangles(forward_dir);
  right = anglestoright(angles);
  line(origin, origin + forward_dir * length, color, 1, 0, duration);
  angle_step = half_angle * 2 / (num_lines - 1);

  for(i = 0; i < num_lines; i++) {
    current_angle = half_angle * -1 + i * angle_step;
    sin_val = sin(current_angle);
    cos_val = cos(current_angle);
    rotated_dir = vectorNormalize(forward_dir * cos_val + right * sin_val);
    line(origin, origin + rotated_dir * length, color, 1, 0, duration);
  }
}

# /