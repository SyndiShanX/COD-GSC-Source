/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\player_rig.gsc
**************************************/

#using scripts\common\anim;
#using scripts\common\values;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\utility;
#namespace namespace_6341d8b435bf1728;
#using_animtree("K_p\x84a\x01");

function init_player_rig(var_1abcf636f8d8b736, var_66e3aea4bca4e89f, var_7af8ee4289fe5086, doprecache) {
  setdvarifuninitialized(@ "hash_36a6e170933fe94b", 0);

  if(!isDefined(doprecache)) {
    doprecache = 1;
  }

  if(istrue(doprecache)) {
    if(isDefined(var_1abcf636f8d8b736)) {
      precachemodel(var_1abcf636f8d8b736);
    }

    if(isDefined(var_66e3aea4bca4e89f)) {
      precachemodel(var_66e3aea4bca4e89f);
    }

    if(isDefined(var_7af8ee4289fe5086)) {
      precachemodel(var_7af8ee4289fe5086);
    }
  }

  level.scr_animtree["\xe0\x1b\x16^+\x9c\xbe\xc9-\xce"] = #animtree;

  if(isDefined(var_1abcf636f8d8b736)) {
    level.scr_model["\xe0\x1b\x16^+\x9c\xbe\xc9-\xce"] = var_1abcf636f8d8b736;
  }

  if(isDefined(var_66e3aea4bca4e89f)) {
    level.scr_animtree["r~2\x17\x1e\x17\xa9\xfe\x10\xb5\x1f"] = #animtree;
    level.scr_model["r~2\x17\x1e\x17\xa9\xfe\x10\xb5\x1f"] = var_66e3aea4bca4e89f;
  } else {
    level.scr_animtree["r~2\x17\x1e\x17\xa9\xfe\x10\xb5\x1f"] = undefined;
    level.scr_model["r~2\x17\x1e\x17\xa9\xfe\x10\xb5\x1f"] = undefined;
  }

  if(isDefined(var_7af8ee4289fe5086)) {
    init_player_body(var_7af8ee4289fe5086);
    return;
  }

  level.scr_animtree["~*\x1c\xd6\xd1\xc0\xa0f5\x16\x1a"] = undefined;
  level.scr_model["~*\x1c\xd6\xd1\xc0\xa0f5\x16\x1a"] = undefined;
}

function init_player_rig_no_precache(var_1abcf636f8d8b736, var_66e3aea4bca4e89f, var_7af8ee4289fe5086) {
  init_player_rig(var_1abcf636f8d8b736, var_66e3aea4bca4e89f, var_7af8ee4289fe5086, 0);
}

#using_animtree("*xmG4\x1e\x14\xb1\xc2u_!\xf5");

function init_player_body(var_7af8ee4289fe5086) {
  level.scr_model["~*\x1c\xd6\xd1\xc0\xa0f5\x16\x1a"] = var_7af8ee4289fe5086;
  level.scr_animtree["~*\x1c\xd6\xd1\xc0\xa0f5\x16\x1a"] = #animtree;
}

function private function_40823ebbe17f1e89() {
  rigentity = self;

  if(!(isDefined(rigentity) && isDefined(rigentity.animname))) {
    return;
  }

  if(rigentity.model != level.scr_model[rigentity.animname]) {
    rigentity setModel(level.scr_model[rigentity.animname]);
  }
}

function get_player_rig(reset_origin, var_a7259fe529ffd1b7) {
  if(!isDefined(level.player_rig)) {
    level.player_rig = utility_sp::spawn_anim_model("\xe0\x1b\x16^+\x9c\xbe\xc9-\xce");
    level.player_rig val::set("\xe0\x1b\x16^+\x9c\xbe\xc9-\xce", "\xeaq\xdfT5\xac\x04\x1d\x89+R", 0);
    level.player_rig.noragdoll = 1;
    reset_origin = 1;

    if(var_a7259fe529ffd1b7 ?? 0) {
      level.player_rig hide(1);
    }
  }

  level.player_rig function_40823ebbe17f1e89();

  if(istrue(reset_origin)) {
    level.player_rig.origin = level.player.origin;
    level.player_rig.angles = level.player.angles;
  }

  level.player_rig thread debug_monitor("<dev string:x24>");

  return level.player_rig;
}

function get_player_legs(reset_origin, var_a7259fe529ffd1b7) {
  if(!isDefined(level.player_legs)) {
    level.player_legs = utility_sp::spawn_anim_model("r~2\x17\x1e\x17\xa9\xfe\x10\xb5\x1f");
    level.player_legs.noragdoll = 1;
    reset_origin = 1;
  }

  level.player_legs function_40823ebbe17f1e89();

  if(istrue(reset_origin)) {
    level.player_legs.origin = level.player.origin;
    level.player_legs.angles = level.player.angles;
  }

  level.player_legs thread debug_monitor("<dev string:x32>");

  return level.player_legs;
}

function get_player_body(reset_origin, var_a7259fe529ffd1b7) {
  if(!isDefined(level.player_body)) {
    level.player_body = utility_sp::spawn_anim_model("~*\x1c\xd6\xd1\xc0\xa0f5\x16\x1a");
    level.player_body.noragdoll = 1;
    reset_origin = 1;
  }

  level.player_body function_40823ebbe17f1e89();

  if(istrue(reset_origin)) {
    level.player_body.origin = level.player.origin;
    level.player_body.angles = level.player.angles;
  }

  level.player_body thread debug_monitor("<dev string:x41>");

  return level.player_body;
}

function function_fb87031dd45ca4df(reset_origin, var_a7259fe529ffd1b7, forceanimtree) {
  result = [];

  if(isDefined(level.scr_model["\xe0\x1b\x16^+\x9c\xbe\xc9-\xce"])) {
    result["\xe0\x1b\x16^+\x9c\xbe\xc9-\xce"] = get_player_rig(reset_origin, var_a7259fe529ffd1b7);
  }

  if(isDefined(level.scr_model["r~2\x17\x1e\x17\xa9\xfe\x10\xb5\x1f"])) {
    result["r~2\x17\x1e\x17\xa9\xfe\x10\xb5\x1f"] = get_player_legs();
  }

  if(isDefined(level.scr_model["~*\x1c\xd6\xd1\xc0\xa0f5\x16\x1a"])) {
    result["~*\x1c\xd6\xd1\xc0\xa0f5\x16\x1a"] = get_player_body();
  }

  if(isDefined(forceanimtree)) {
    foreach(entity in result) {
      entity useanimtree(forceanimtree);
    }
  }

  return result;
}

function link_player_to_arms(r, l, u, d, linktag = "\xf6\xfc\xad\x9di\xb9)\xac/K") {
  if(!isDefined(r)) {
    r = 30;
  }

  if(!isDefined(l)) {
    l = 30;
  }

  if(!isDefined(u)) {
    u = 30;
  }

  if(!isDefined(d)) {
    d = 30;
  }

  player_rig = get_player_rig();
  player_rig show();
  level.player playerlinktoabsolute(player_rig, linktag);
  level.player playerlinktodelta(player_rig, linktag, 1, r, l, u, d, 1);
}

function blend_player_to_arms(time, linktag = "\xf6\xfc\xad\x9di\xb9)\xac/K") {
  if(!isDefined(time)) {
    time = 0.7;
  }

  player_rig = get_player_rig();
  player_rig show();
  level.player playerlinktoblend(player_rig, linktag, time);
}

function set_player_rig_allows(allows) {
  assert(isDefined(level.player_rig));

  if(!isDefined(allows)) {
    if(isDefined(level.var_3cbcd9bddea14420)) {
      allows = level.var_3cbcd9bddea14420;
    } else {
      allows = ["\xe5\x06\xb0\bE\x16", "54\x8b\xe9\x17 \xa4\xeb\xf3jQV\xc1\xc3w", "mV\x8d+e", "\x05\xb1\x1c\x86\x11\xc7", "\\y\xb8\x8e\xd8K\xfd\v\v\xd8", "\x9a\xe3\xe4\xff\x81%"];
    }
  }

  level.player_rig.allows = allows;
}

function function_e97539bbe302cd26(allows) {
  assert(isDefined(level.player_rig));
  assert(isDefined(level.player_rig.allows));
  level.player val::reset_all("\xe0\x1b\x16^+\x9c\xbe\xc9-\xce");
  level.player val::set_array("\xe0\x1b\x16^+\x9c\xbe\xc9-\xce", level.player_rig.allows, 0);
}

function function_d7a178b1da631962(stance, animblending, var_c346a4fe04914db2, var_f2913a999b683c0c, simultaneous) {
  rig = self;

  if(istrue(animblending)) {
    if(!isDefined(stance)) {
      stance = "\x8b\x90\xb5\xc4W";
    }

    curstance = level.player getstance();
    var_236d51aea5dfc7d2 = 0;

    if(istrue(simultaneous) || istrue(var_c346a4fe04914db2) || istrue(var_f2913a999b683c0c)) {
      var_236d51aea5dfc7d2 = level.blendinfo["\xc1\xd1U`:\xf5r\x1d\xb2\x19\xdc\x1a\x81S"];
    }

    if(curstance != stance) {
      stancechangetime = 0;

      switch (curstance) {
        case #"hash_d91940431ed7c605":
          switch (stance) {
            case #"hash_3fed0cbd303639eb":
              stancechangetime = 0.5;
              break;
            case #"hash_c6775c88e38f7803":
              stancechangetime = 0.75;
              break;
          }

          break;
        case #"hash_3fed0cbd303639eb":
          if(stance == "\x8b\x90\xb5\xc4W") {
            stancechangetime = 0.2;
          }

          break;
      }

      var_236d51aea5dfc7d2 = max(var_236d51aea5dfc7d2, stancechangetime);
    }

    rig utility::delaycall(var_236d51aea5dfc7d2, &show);
    return;
  }

  rig show();
}

function function_c858e306d2e2e7b7(anime, restrictcamera, rightarc, leftarc, toparc, bottomarc, usetagangles, rigspawnfunc, var_3de3e3b26ddf860, linktag) {
  return link_player_to_rig(anime, undefined, 1, 0.5, restrictcamera, rightarc, leftarc, toparc, bottomarc, usetagangles, rigspawnfunc, var_3de3e3b26ddf860, 1, undefined, undefined, undefined, undefined, linktag);
}

function link_player_to_rig(anime, stance, var_fdb37482eb79d8ca, blendtime, restrictcamera, rightarc, leftarc, toparc, bottomarc, usetagangles, rigspawnfunc, var_3de3e3b26ddf860, smart, animblending, var_c346a4fe04914db2, var_f2913a999b683c0c, simultaneous, linktag = "\xf6\xfc\xad\x9di\xb9)\xac/K", var_88f6eefe677179a6, arcenabled) {
  rig = get_player_rig(1);
  rig endon("\x03,s@\xbaB%_\x9b{\xaf\xbb\xca");
  rig.linktag = linktag;
  playerstartpos = level.player.origin;

  if(isDefined(rigspawnfunc)) {
    rig[[rigspawnfunc]]();
  }

  if(!isDefined(rig.allows)) {
    if(istrue(var_c346a4fe04914db2)) {
      set_player_rig_allows(["54\x8b\xe9\x17 \xa4\xeb\xf3jQV\xc1\xc3w", "mV\x8d+e", "\x05\xb1\x1c\x86\x11\xc7", "\\y\xb8\x8e\xd8K\xfd\v\v\xd8", "\x9a\xe3\xe4\xff\x81%"]);
    } else {
      set_player_rig_allows();
    }
  }

  hideshowrigs = [rig];

  if(isDefined(var_88f6eefe677179a6)) {
    hideshowrigs = utility::array_combine(hideshowrigs, var_88f6eefe677179a6);
  }

  foreach(hsrig in hideshowrigs) {
    hsrig.origin = level.player.origin;
    hsrig.angles = level.player.angles;
    hsrig hide(1);
  }

  if(!istrue(var_3de3e3b26ddf860)) {
    thread utility_sp::delete_live_grenades();
  }

  level.player setcinematicmotionoverride("\xd23\x8e5\x83\xe4\xc5X");

  if(isDefined(anime) && !istrue(animblending)) {
    thread animation::anim_first_frame_solo(rig, anime);
  }

  if(isDefined(anime) && (istrue(smart) || istrue(animblending))) {
    animation::function_c94f0d9e5f4bce9f(anime, rig.animname, var_c346a4fe04914db2, var_f2913a999b683c0c, simultaneous);
    blendtime = level.blendinfo["\xe0E\xcfm\x1e\x8c\x11N\xa6"];

    if(istrue(level.blendinfo["\xe50\xc2\x02QX\xd7\xeb[z\x8c\xb7\xe3rG"])) {
      level.player enablequickweaponswitch(1);
    }
  } else {
    level.player enablequickweaponswitch(1);
  }

  rig.ogstance = level.player getstance();

  if(!isDefined(stance)) {
    stance = "\x8b\x90\xb5\xc4W";
  }

  if(isDefined(level.blendinfo) && isDefined(level.blendinfo["\x9b\x1dX\xdc\x8de\xe6"])) {
    if(level.blendinfo["\x9b\x1dX\xdc\x8de\xe6"][0] != "\r+x5") {
      stance = level.blendinfo["\x9b\x1dX\xdc\x8de\xe6"][0];
    }

    if(level.blendinfo["\x9b\x1dX\xdc\x8de\xe6"][1] != "\r+x5") {
      rig.exitstance = level.blendinfo["\x9b\x1dX\xdc\x8de\xe6"][1];
    }
  }

  rig.stance = stance;

  switch (stance) {
    case #"hash_c6775c88e38f7803":
      rig.allows = utility::array_combine_unique(rig.allows, ["1x\xc5\xb4\xabx", "GX\xa9]\x82"]);
      break;
    case #"hash_3fed0cbd303639eb":
      rig.allows = utility::array_combine_unique(rig.allows, ["\x8b\x90\xb5\xc4W", "GX\xa9]\x82"]);
      break;
    case #"hash_d91940431ed7c605":
      rig.allows = utility::array_combine_unique(rig.allows, ["1x\xc5\xb4\xabx", "\x8b\x90\xb5\xc4W"]);
      break;
  }

  level.player setstance(stance, 1, 1);
  level.player function_e97539bbe302cd26();

  if(istrue(var_c346a4fe04914db2)) {
    level.player thread utility_sp::player_gesture_force(" \xcc\xfbg\xa0\xdf\xee\xd9\xa42V\xbb\x04\xe1\x98\x9f\xbcE\xcd\xa3\xbb\xbc\x81\xe5\xe4");
    gesturelength = level.player getgestureanimlength(" \xcc\xfbg\xa0\xdf\xee\xd9\xa42V\xbb\x04\xe1\x98\x9f\xbcE\xcd\xa3\xbb\xbc\x81\xe5\xe4");
    level.player utility::delaythread(gesturelength - 0.05, &utility_sp::player_gesture_force, "\x99{\xa0wv\xde\x1b\xc4\x848\xd9\xf5\xf0\xdb\xbb\x1b\x9d\xb9\xf3\xb7\xe8z1\x86g");
  }

  if(!isDefined(var_fdb37482eb79d8ca)) {
    var_fdb37482eb79d8ca = 1;
  }

  if(!isDefined(blendtime)) {
    blendtime = 0.2;
  }

  if(!isDefined(rightarc)) {
    rightarc = 45;
  }

  if(!isDefined(leftarc)) {
    leftarc = 45;
  }

  if(!isDefined(toparc)) {
    toparc = 15;
  }

  if(!isDefined(bottomarc)) {
    bottomarc = 15;
  }

  if(!isDefined(arcenabled)) {
    arcenabled = 1;
  }

  if(!isDefined(restrictcamera)) {
    restrictcamera = 0;
  }

  if(!isDefined(usetagangles)) {
    usetagangles = 0;
  }

  if(arcenabled) {
    if(var_fdb37482eb79d8ca) {
      if(rightarc == 0 && leftarc == 0 && toparc == 0 && bottomarc == 0) {
        level.player val::set("\x06\x93\xbaL4y\x8d61\xfdOP*\xee\x8f\xed\x86\xe3\xe6\xd0ny\x81#", "\xd2s\x01\xd5\xe6\xf1\xa8\xb6t\xba&\xc4\x98\x9b\xa1:8\xe1\xb7\xdd\xa4\xc4Y;", 1);
      }

      level.player playerlinktoblend(rig, linktag, blendtime);
      wait blendtime;
      waitframe();
    }

    if(istrue(restrictcamera)) {
      level.player playerlinktoabsolute(rig, linktag);
    } else if(blendtime > 0 || istrue(animblending)) {
      playerangles = level.player getplayerangles();
      tagangles = rig gettagangles(linktag);
      maxpitch = min(170, anglesdelta((tagangles[0], 0, 0), (playerangles[0], 0, 0)));
      maxyaw = min(170, anglesdelta((0, tagangles[1], 0), (0, playerangles[1], 0)));
      level.player playerlinktodelta(rig, linktag, 1, maxyaw, maxyaw, maxpitch, maxpitch, usetagangles);
      level.player lerpviewangleclamp(blendtime, blendtime * 0.5, blendtime * 0.25, 0, 0, 0, 0, 1);

      if(rightarc || leftarc || toparc || bottomarc) {
        level.player utility::delaycall(blendtime, &lerpviewangleclamp, 1, 0.5, 0.25, rightarc, leftarc, toparc, bottomarc, 1);
      }
    } else {
      level.player playerlinktoabsolute(rig, linktag);
      level.player utility::delaycall(0.05, &playerlinktodelta, rig, linktag, 1, rightarc, leftarc, toparc, bottomarc, usetagangles);
    }
  } else {
    if(var_fdb37482eb79d8ca) {
      level.player playerlinktoblend(rig, linktag, blendtime);
      wait blendtime;
      waitframe();
    }

    if(istrue(restrictcamera)) {
      level.player playerlinktoabsolute(rig, linktag);
    } else {
      wait blendtime;
      level.player playerlinktodelta(rig, linktag, 1, 0, 0, 0, 0, usetagangles, 1, 1, 0, 0, 0, 0, 0, 0);
    }
  }

  foreach(hsrig in hideshowrigs) {
    hsrig thread function_d7a178b1da631962(stance, animblending, var_c346a4fe04914db2, var_f2913a999b683c0c, simultaneous);
  }

  level.player utility::delaythread(blendtime, &val::reset_all, "\x06\x93\xbaL4y\x8d61\xfdOP*\xee\x8f\xed\x86\xe3\xe6\xd0ny\x81#");
  utility_sp::nvidiaansel_scriptdisable(1);

  if(getdvarint(@ "hash_398da46238160a6", 0)) {
    if(playerstartpos != level.player.origin) {
      utility::draw_arrow_time(playerstartpos, level.player.origin, (1, 1, 1), 20);
      print3d(playerstartpos + (0, 0, -2), "<dev string:x50>" + distance2d(playerstartpos, level.player.origin), (1, 1, 1), 1, 0.1, 400, 1);
    }

    print3d(playerstartpos, "<dev string:x5a>" + blendtime, (1, 1, 1), 1, 0.1, 400, 1);
  }

  level.player notify("\xf4!\"\xdb\xf9\xa3\xf6e\xf1]\x03I\xbc");
  return rig;
}

function unlink_player_from_rig(resetstance, exitstance, setstanceimmediate, retainplayerrig, instantunlink) {
  rig = level.player_rig;
  rig notify("\x03,s@\xbaB%_\x9b{\xaf\xbb\xca");

  if(level.player getlinkedparent() != rig) {
    assert(!isDefined(rig), "<dev string:x69>");
    return;
  }

  level.player val::reset_all("\xe0\x1b\x16^+\x9c\xbe\xc9-\xce");

  if(istrue(resetstance)) {
    exitstance = rig.ogstance;
  }

  if(isDefined(rig.exitstance)) {
    exitstance = rig.exitstance;
  }

  if(isDefined(exitstance)) {
    if(istrue(setstanceimmediate)) {
      level.player setstance(exitstance, 1, 1, 1);
      up = anglestoup(level.player.angles);
      viewheight = level.player getplayerviewheight(rig.ogstance);

      if((rig.linktag ?? "\xf6\xfc\xad\x9di\xb9)\xac/K") == "<\xd7\x93\xbf-\xe8NE\x19\xcd") {
        new_origin = utility::drop_to_ground(level.player.origin, 0, (viewheight + 5) * -1, up);
      } else {
        new_origin = utility::drop_to_ground(level.player.origin + up * viewheight, 0, viewheight * -1, up);
      }

      level.player setOrigin(new_origin, 1);
    } else if(exitstance != rig.stance) {
      level.player setstance(exitstance);
    }
  }

  if(istrue(instantunlink)) {
    level.player unlink();
  } else {
    level.player playerunlinkblend(0.2);
  }

  level.player enablequickweaponswitch(0);
  level.player clearcinematicmotionoverride();
  level.player notify("2ecV\xa3\xb2}\xc6\xd2v\x95}g\xc9\xcan\xb0de\xcd\xaf\x851\xedr:");

  if(!istrue(retainplayerrig)) {
    rig delete();
  }

  utility_sp::nvidiaansel_scriptdisable(0);
}

function anim_lerp_from_player_pos(anime, move_time, rotate_time, accel_percentage, anim_delay) {
  assert(isDefined(level.player_rig), "<dev string:x9c>");
  rig = level.player_rig;

  if(animation::function_25f089b18d2ffbe7(anime)) {
    animation = animation::function_75a88057a7fff0bb(anime, self.origin, self.angles, rig.animname);
  } else {
    animation = level.scr_anim[rig.animname][anime];
  }

  function_76de433b3dd69d5a(animation, move_time, rotate_time, accel_percentage, anim_delay);
  rig notify(anime + "\x83,\xbb\x1b!5");
  level.lerp_node thread animation::anim_single_solo(rig, anime);
  rig thread utility::waittillmatch_notify("\xb3\\\x97b@19[\x9e\xc1\xd7", "8\xdb\x90", "\x16\xcdZ\xb6}\x9572");
  rig utility::waittill_any("\x16\xcdZ\xb6}\x9572", "\x03,s@\xbaB%_\x9b{\xaf\xbb\xca");
  animation_lerp_from_player_pos_end();
}

function function_76de433b3dd69d5a(animation, move_time, rotate_time, accel_percentage, anim_delay) {
  assert(isDefined(level.player_rig), "<dev string:x9c>");
  animation_lerp_from_player_pos_end();
  rig = level.player_rig;
  anim_origin = getstartorigin(self.origin, self.angles, animation);
  anim_angles = getstartangles(self.origin, self.angles, animation);
  rotation = level.player.angles - anim_angles;
  node_origin = level.player.origin + rotatevector(self.origin - anim_origin, rotation);
  node_angles = level.player.angles + self.angles - anim_angles;
  level.lerp_node = utility::spawn_script_origin(node_origin, node_angles);
  level.lerp_node endon("\x8b\x9dS\xd0~#,.\x96b\x957K\tW\xae/\xe6w\xb1^\x85\xbe\xb0\x80\xf6\xc2!\xaa\x85w\xf4\x90\x88");

  level.lerp_node.playerstartpos = level.player.origin;

  anim_length = getanimlength(animation);

  if(!isDefined(accel_percentage)) {
    accel_percentage = 0.5;
  }

  if(!isDefined(anim_delay)) {
    anim_delay = 0;
  }

  if(!isDefined(move_time)) {
    move_time = anim_length;
  }

  assert(move_time <= anim_length + anim_delay, "<dev string:x126>");
  level.lerp_node moveTo(self.origin, move_time, move_time * accel_percentage, move_time * (1 - accel_percentage));

  if(!isDefined(rotate_time)) {
    rotate_time = anim_length;
  }

  assert(rotate_time <= anim_length + anim_delay, "<dev string:x16d>");
  level.lerp_node rotateTo(self.angles, rotate_time, rotate_time * accel_percentage, rotate_time * (1 - accel_percentage));

  if(anim_delay > 0) {
    rig.origin = level.player.origin;
  }

  rig linkTo(level.lerp_node);
  wait anim_delay;
}

function animation_lerp_from_player_pos_end() {
  if(isDefined(level.lerp_node)) {
    level.lerp_node notify("\x8b\x9dS\xd0~#,.\x96b\x957K\tW\xae/\xe6w\xb1^\x85\xbe\xb0\x80\xf6\xc2!\xaa\x85w\xf4\x90\x88");

    if(getdvarint(@ "hash_398da46238160a6", 0) && level.lerp_node.playerstartpos != level.player.origin) {
      utility::draw_arrow_time(level.lerp_node.playerstartpos, level.player.origin, (1, 1, 1), 20);
      print3d(level.lerp_node.playerstartpos + (0, 0, -2), "<dev string:x50>" + distance2d(level.lerp_node.playerstartpos, level.player.origin), (1, 1, 1), 1, 0.1, 400, 1);
    }

    level.lerp_node delete();
    level.lerp_node = undefined;
  }
}

function player_rig_allow_weapon(rig) {
  player_rig_allow_internal(rig, "\xe5\x06\xb0\bE\x16");
}

function player_rig_allow_internal(rig, allow_name) {
  assert(isDefined(level.player_rig));
  assert(rig == level.player_rig);
  assert(arraycontains(rig.allows, allow_name));
  rig.allows = arrayremove(rig.allows, allow_name);
  level.player thread val::set("\xe0\x1b\x16^+\x9c\xbe\xc9-\xce", allow_name, 1);
}

function function_8e28d0d1248846d(anime, stance, arcs, unlinkedents, linkedents, var_c346a4fe04914db2, var_f2913a999b683c0c, simultaneous, var_3de3e3b26ddf860) {
  if(!isDefined(level.player_rig)) {
    get_player_rig();
  }

  if(!isDefined(stance)) {
    stance = "\x8b\x90\xb5\xc4W";
  }

  restrictcamera = 1;

  if(!isDefined(arcs)) {
    arcs = [undefined, undefined, undefined, undefined];
  } else {
    restrictcamera = 0;
  }

  if(!isDefined(unlinkedents)) {
    unlinkedents = [];
  }

  if(!isarray(unlinkedents)) {
    unlinkedents = [unlinkedents];
  }

  if(!isDefined(linkedents)) {
    linkedents = [];
  }

  if(!isarray(linkedents)) {
    linkedents = [linkedents];
  }

  if(!isDefined(var_c346a4fe04914db2)) {
    var_c346a4fe04914db2 = 1;
  }

  if(!isDefined(var_f2913a999b683c0c)) {
    var_f2913a999b683c0c = 0;
  }

  if(!isDefined(simultaneous)) {
    simultaneous = 0;
  }

  newanime = anime;

  if(animation::function_25f089b18d2ffbe7(anime)) {
    animation = animation::function_75a88057a7fff0bb(anime, self.origin, self.angles, "\xe0\x1b\x16^+\x9c\xbe\xc9-\xce");
    newanime = animation::function_20222da1dbcd6532(anime, "\xe0\x1b\x16^+\x9c\xbe\xc9-\xce", animation);
  }

  animation::anim_first_frame_solo(level.player_rig, newanime);
  link_player_to_rig(newanime, stance, 0, 0, restrictcamera, arcs[0], arcs[1], arcs[2], arcs[3], 1, undefined, var_3de3e3b26ddf860, undefined, 1, var_c346a4fe04914db2, var_f2913a999b683c0c, simultaneous);
  thread anim_lerp_from_player_pos(newanime, level.blendinfo["\xe0E\xcfm\x1e\x8c\x11N\xa6"], level.blendinfo["\xe0E\xcfm\x1e\x8c\x11N\xa6"], 0.8, level.blendinfo["\xc1\xd1U`:\xf5r\x1d\xb2\x19\xdc\x1a\x81S"]);

  if(isDefined(unlinkedents)) {
    foreach(model in unlinkedents) {
      if(level.player_rig == model) {
        unlinkedents = arrayremove(unlinkedents, model);
      }
    }
  }

  if(isDefined(linkedents)) {
    foreach(model in linkedents) {
      if(level.player_rig == model) {
        linkedents = arrayremove(linkedents, model);
        continue;
      }

      model linkTo(level.lerp_node);
    }
  }

  animation::anim_first_frame(unlinkedents, anime);
  utility::delaythread(level.blendinfo["\xc1\xd1U`:\xf5r\x1d\xb2\x19\xdc\x1a\x81S"], &animation::anim_single, unlinkedents, anime);
  level.lerp_node animation::anim_first_frame(linkedents, anime);
  level.lerp_node utility::delaythread(level.blendinfo["\xc1\xd1U`:\xf5r\x1d\xb2\x19\xdc\x1a\x81S"], &animation::anim_single, linkedents, anime);
  wait level.blendinfo["\xc1\xd1U`:\xf5r\x1d\xb2\x19\xdc\x1a\x81S"];
  level.player_rig notify("\xf4!\"\xdb\x11c\x90\xed\xd1\x84HF\xfc\xa7+,E\xd7U\xd9U Y\xd6\xc8");

  if(istrue(var_c346a4fe04914db2) && isDefined(level.blendinfo["\xd23\x01Ld\x03\x93\xbc{\xae\xc0\xe3"])) {
    level.player utility::delaythread(level.blendinfo["\xd23\x01Ld\x03\x93\xbc{\xae\xc0\xe3"], &utility_sp::player_gesture_force, "\xab\x02\x9f\xfe=S\xe3pZ\xab\xffu3\x1f\xaa\xaaa\xb7\xfc\a\xff+\xa7\x91n\xe2");
  }

  level.player_rig utility::waittill_any("\x16\xcdZ\xb6}\x9572", "\x03,s@\xbaB%_\x9b{\xaf\xbb\xca");

  if(istrue(var_c346a4fe04914db2) && !isDefined(level.blendinfo["\xd23\x01Ld\x03\x93\xbc{\xae\xc0\xe3"])) {
    level.player thread utility_sp::player_gesture_force("\xab\x02\x9f\xfe=S\xe3pZ\xab\xffu3\x1f\xaa\xaaa\xb7\xfc\a\xff+\xa7\x91n\xe2");
  }
}

function private debug_monitor(display) {
  self notify("<dev string:x1b6>");
  self endon("<dev string:x1b6>");
  self endon("<dev string:x1c7>");

  if(!getdvarint(@ "hash_36a6e170933fe94b", 0)) {
    return;
  }

  while(true) {
    waitframe();
    print3d(self.origin, display + "<dev string:x1d0>" + self getentitynumber() + "<dev string:x1d6>" + int(self.origin[0]) + "<dev string:x1dc>" + int(self.origin[1]) + "<dev string:x1dc>" + int(self.origin[2]) + "<dev string:x1e2>", (1, 1, 1), 1, 0.5, 1);
  }
}

# /