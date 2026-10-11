/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\player_rig.gsc
***********************************************/

#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\player_rig;
#using scripts\sp\utility;
#namespace player_rig;
#using_animtree("player");

function init_player_rig(var_6aaf40d85156ec33, var_2ae369ca3c8d94ba, player_body_model, doprecache) {
  setdvarifuninitialized(@ "hash_36a6e170933fe94b", 0);

  doprecache = default_to(doprecache, 1);

  if(istrue(doprecache)) {
    if(isDefined(var_6aaf40d85156ec33)) {
      precachemodel(var_6aaf40d85156ec33);
    }

    if(isDefined(var_2ae369ca3c8d94ba)) {
      precachemodel(var_2ae369ca3c8d94ba);
    }

    if(isDefined(player_body_model)) {
      precachemodel(player_body_model);
    }
  }

  if(isDefined(var_6aaf40d85156ec33)) {
    level.scr_animtree["player_rig"] = #animtree;
    level.scr_model["player_rig"] = var_6aaf40d85156ec33;
  } else {
    level.scr_animtree["player_rig"] = undefined;
    level.scr_model["player_rig"] = undefined;
  }

  if(isDefined(var_2ae369ca3c8d94ba)) {
    level.scr_animtree["player_legs"] = #animtree;
    level.scr_model["player_legs"] = var_2ae369ca3c8d94ba;
  } else {
    level.scr_animtree["player_legs"] = undefined;
    level.scr_model["player_legs"] = undefined;
  }

  if(isDefined(player_body_model)) {
    init_player_body(player_body_model);
    return;
  }

  level.scr_animtree["player_body"] = undefined;
  level.scr_model["player_body"] = undefined;
}

function init_player_rig_no_precache(var_6aaf40d85156ec33, var_2ae369ca3c8d94ba, player_body_model) {
  init_player_rig(var_6aaf40d85156ec33, var_2ae369ca3c8d94ba, player_body_model, 0);
}

#using_animtree("generic_human");

function init_player_body(player_body_model) {
  level.scr_model["player_body"] = player_body_model;
  level.scr_animtree["player_body"] = #animtree;
}

function private function_e92e6ad1059c8eec() {
  rigentity = self;

  if(!isDefined(rigentity) || !isDefined(rigentity.animname)) {
    return;
  }

  if(!is_equal(rigentity.model, level.scr_model[rigentity.animname])) {
    rigentity setModel(level.scr_model[rigentity.animname]);
  }
}

function get_player_rig(reset_origin, var_a871c06af7cb87c6) {
  if(!isDefined(level.player_rig)) {
    level.player_rig = spawn_anim_model("player_rig");
    level.player_rig dontcastshadows();
    level.player_rig.noragdoll = 1;
    reset_origin = 1;

    if(default_to(var_a871c06af7cb87c6, 0)) {
      level.player_rig hide();
    }
  }

  level.player_rig function_e92e6ad1059c8eec();

  if(istrue(reset_origin)) {
    level.player_rig.origin = level.player.origin;
    level.player_rig.angles = level.player.angles;
  }

  level.player_rig thread debug_monitor("<dev string:x1c>");

  return level.player_rig;
}

function get_player_legs(reset_origin, var_a871c06af7cb87c6) {
  if(!isDefined(level.player_legs)) {
    level.player_legs = spawn_anim_model("player_legs");
    level.player_legs.noragdoll = 1;
    reset_origin = 1;
  }

  level.player_legs function_e92e6ad1059c8eec();

  if(istrue(reset_origin)) {
    level.player_legs.origin = level.player.origin;
    level.player_legs.angles = level.player.angles;
  }

  level.player_rig thread debug_monitor("<dev string:x27>");

  return level.player_legs;
}

function get_player_body(reset_origin, var_a871c06af7cb87c6) {
  if(!isDefined(level.player_body)) {
    level.player_body = spawn_anim_model("player_body");
    level.player_body.noragdoll = 1;
    reset_origin = 1;
  }

  level.player_body function_e92e6ad1059c8eec();

  if(istrue(reset_origin)) {
    level.player_body.origin = level.player.origin;
    level.player_body.angles = level.player.angles;
  }

  level.player_rig thread debug_monitor("<dev string:x33>");

  return level.player_body;
}

function function_8ded956fcab6f73a(reset_origin, var_a871c06af7cb87c6, forceanimtree) {
  result = [];

  if(isDefined(level.scr_model["player_rig"])) {
    result["player_rig"] = get_player_rig(reset_origin, var_a871c06af7cb87c6);
  }

  if(isDefined(level.scr_model["player_legs"])) {
    result["player_legs"] = get_player_legs();
  }

  if(isDefined(level.scr_model["player_body"])) {
    result["player_body"] = get_player_body();
  }

  if(isDefined(forceanimtree)) {
    foreach(entity in result) {
      entity useanimtree(forceanimtree);
    }
  }

  return result;
}

function link_player_to_arms(r, l, u, d, linktag) {
  linktag = default_to(linktag, "tag_player");

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

function blend_player_to_arms(time, linktag) {
  linktag = default_to(linktag, "tag_player");

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
    if(isDefined(level.var_102b18b5f7ed65ed)) {
      allows = level.var_102b18b5f7ed65ed;
    } else {
      allows = ["weapon", "offhand_weapons", "melee", "sprint", "allow_jump", "mantle"];

      if(isDefined(level.crafting)) {
        allows = array_add(allows, "crafting");
      }
    }
  }

  level.player_rig.allows = allows;
}

function function_73341653f76b4e43(allows) {
  assert(isDefined(level.player_rig));
  assert(isDefined(level.player_rig.allows));
  level.player val::reset_all("player_rig");
  level.player val::set_array("player_rig", level.player_rig.allows, 0);
}

function function_3a20b806b3b70617(stance, animblending, var_ec165a067af34f8f, var_8831fc7320076829, simultaneous) {
  rig = self;

  if(istrue(animblending)) {
    stance = default_to(stance, "stand");
    curstance = level.player getstance();
    var_c9da1b495d3ed8f = 0;

    if(istrue(simultaneous) || istrue(var_ec165a067af34f8f) || istrue(var_8831fc7320076829)) {
      var_c9da1b495d3ed8f = level.blendinfo["weaponDropTime"];
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
          if(stance == "stand") {
            stancechangetime = 0.2;
          }

          break;
      }

      var_c9da1b495d3ed8f = max(var_c9da1b495d3ed8f, stancechangetime);
    }

    rig delaycall(var_c9da1b495d3ed8f, &show);
    return;
  }

  rig show();
}

function function_6feda95d063a745e(anime, restrictcamera, rightarc, leftarc, toparc, bottomarc, usetagangles, rigspawnfunc, var_26967d556f885965, linktag) {
  return link_player_to_rig(anime, undefined, 1, 0.5, restrictcamera, rightarc, leftarc, toparc, bottomarc, usetagangles, rigspawnfunc, var_26967d556f885965, 1, undefined, undefined, undefined, undefined, linktag);
}

function link_player_to_rig(anime, stance, var_e773bead7741b3b3, blendtime, restrictcamera, rightarc, leftarc, toparc, bottomarc, usetagangles, rigspawnfunc, var_26967d556f885965, smart, animblending, var_ec165a067af34f8f, var_8831fc7320076829, simultaneous, linktag, var_765a3c961826133b) {
  linktag = default_to(linktag, "tag_player");
  rig = scripts\sp\player_rig::get_player_rig(1);
  rig endon("unlink_player");
  rig.linktag = linktag;
  playerstartpos = level.player.origin;

  if(isDefined(rigspawnfunc)) {
    rig[[rigspawnfunc]]();
  }

  if(!isDefined(rig.allows)) {
    if(istrue(var_ec165a067af34f8f)) {
      set_player_rig_allows(["offhand_weapons", "melee", "sprint", "allow_jump", "mantle"]);
    } else {
      set_player_rig_allows();
    }
  }

  hideshowrigs = [rig];

  if(isDefined(var_765a3c961826133b)) {
    hideshowrigs = array_combine(hideshowrigs, var_765a3c961826133b);
  }

  foreach(hsrig in hideshowrigs) {
    hsrig.origin = level.player.origin;
    hsrig.angles = level.player.angles;
    hsrig hide();
  }

  if(!istrue(var_26967d556f885965)) {
    thread delete_live_grenades();
  }

  level.player setcinematicmotionoverride("disabled");

  if(isDefined(anime) && !istrue(animblending)) {
    thread scripts\common\anim::anim_first_frame_solo(rig, anime);
  }

  if(isDefined(anime) && (istrue(smart) || istrue(animblending))) {
    function_dba8ec1939d3f1a(anime, rig.animname, var_ec165a067af34f8f, var_8831fc7320076829, simultaneous);
    blendtime = level.blendinfo["blendTime"];

    if(istrue(level.blendinfo["weaponDropQuick"])) {
      level.player enablequickweaponswitch(1);
    }
  } else {
    level.player enablequickweaponswitch(1);
  }

  rig.ogstance = level.player getstance();

  if(!isDefined(stance)) {
    stance = "stand";
  }

  if(isDefined(level.blendinfo) && isDefined(level.blendinfo["stances"])) {
    if(level.blendinfo["stances"][0] != "none") {
      stance = level.blendinfo["stances"][0];
    }

    if(level.blendinfo["stances"][1] != "none") {
      rig.exitstance = level.blendinfo["stances"][1];
    }
  }

  rig.stance = stance;

  switch (stance) {
    case #"hash_c6775c88e38f7803":
      rig.allows = array_combine_unique(rig.allows, ["crouch", "prone"]);
      break;
    case #"hash_3fed0cbd303639eb":
      rig.allows = array_combine_unique(rig.allows, ["stand", "prone"]);
      break;
    case #"hash_d91940431ed7c605":
      rig.allows = array_combine_unique(rig.allows, ["crouch", "stand"]);
      break;
  }

  level.player setstance(stance, 1);
  level.player function_73341653f76b4e43();

  if(istrue(var_ec165a067af34f8f)) {
    level.player thread player_gesture_force("proto_vm_gesture_gun_drop");
    gesturelength = level.player getgestureanimlength("proto_vm_gesture_gun_drop");
    level.player delaythread(gesturelength - 0.05, &player_gesture_force, "proto_vm_gesture_gun_loop");
  }

  if(!isDefined(var_e773bead7741b3b3)) {
    var_e773bead7741b3b3 = 1;
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

  if(var_e773bead7741b3b3) {
    if(rightarc == 0 && leftarc == 0 && toparc == 0 && bottomarc == 0) {
      level.player val::set("link_player_to_rig_blend", "freezecontrols_allowlook", 1);
    }

    level.player playerlinktoblend(rig, linktag, blendtime);
    wait blendtime;
    waitframe();
  }

  if(istrue(restrictcamera)) {
    level.player playerlinktoabsolute(rig, linktag);
  } else {
    if(!isDefined(usetagangles)) {
      usetagangles = 0;
    }

    if(blendtime > 0 || istrue(animblending)) {
      level.player playerlinktodelta(rig, linktag, 1, 170, 170, 170, 170, usetagangles);
      level.player lerpviewangleclamp(blendtime, blendtime * 0.5, blendtime * 0.25, 0, 0, 0, 0, 1);

      if(rightarc || leftarc || toparc || bottomarc) {
        level.player delaycall(blendtime, &lerpviewangleclamp, 1, 0.5, 0.25, rightarc, leftarc, toparc, bottomarc, 1);
      }
    } else {
      level.player playerlinktoabsolute(rig, linktag);
      level.player delaycall(0.05, &playerlinktodelta, rig, linktag, 1, rightarc, leftarc, toparc, bottomarc, usetagangles);
    }
  }

  foreach(hsrig in hideshowrigs) {
    hsrig thread function_3a20b806b3b70617(stance, animblending, var_ec165a067af34f8f, var_8831fc7320076829, simultaneous);
  }

  level.player delaythread(blendtime, &val::reset_all, "link_player_to_rig_blend");
  nvidiaansel_scriptdisable(1);

  if(getdvarint(@ "hash_398da46238160a6", 0)) {
    if(playerstartpos != level.player.origin) {
      draw_arrow_time(playerstartpos, level.player.origin, (1, 1, 1), 20);
      print3d(playerstartpos + (0, 0, -2), "<dev string:x3f>" + distance2d(playerstartpos, level.player.origin), (1, 1, 1), 1, 0.1, 400, 1);
    }

    print3d(playerstartpos, "<dev string:x46>" + blendtime, (1, 1, 1), 1, 0.1, 400, 1);
  }

  level.player notify("linked_to_rig");
  return rig;
}

function unlink_player_from_rig(resetstance, exitstance, setstanceimmediate, retainplayerrig, instantunlink, cinematicmotionoverride) {
  rig = level.player_rig;
  rig notify("unlink_player");

  if(!is_equal(level.player getlinkedparent(), rig)) {
    assert(!isDefined(rig), "Player unlinked from rig, but rig still exists!");
    return;
  }

  level.player val::reset_all("player_rig");

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

      if(default_to(rig.linktag, "tag_player") == "tag_camera") {
        new_origin = drop_to_ground(level.player.origin, 0, (viewheight + 5) * -1, up);
      } else {
        new_origin = drop_to_ground(level.player.origin + up * viewheight, 0, viewheight * -1, up);
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
  cinematicmotionoverride = default_to(cinematicmotionoverride, "iw9_playermotion");
  level.player setcinematicmotionoverride(cinematicmotionoverride);

  if(!istrue(retainplayerrig)) {
    rig delete();
  }

  nvidiaansel_scriptdisable(0);
}

function anim_lerp_from_player_pos(anime, move_time, rotate_time, accel_percentage, anim_delay) {
  assert(isDefined(level.player_rig), "level.player_rig must be defined for anim_lerp_from_player_pos() to work. Try calling link_player_to_rig() before using this function.");
  rig = level.player_rig;

  if(function_f1e7ee8ddeece062(anime)) {
    animation = function_c099f6fd9c19f5a6(anime, self.origin, self.angles, rig.animname);
  } else {
    animation = level.scr_anim[rig.animname][anime];
  }

  function_de21a1093ee0487f(animation, move_time, rotate_time, accel_percentage, anim_delay);
  level.lerp_node thread scripts\common\anim::anim_single_solo(rig, anime);
  rig thread waittillmatch_notify("single anim", "end", "anim_end");
  rig waittill_any("anim_end", "unlink_player");
  animation_lerp_from_player_pos_end();
}

function function_de21a1093ee0487f(animation, move_time, rotate_time, accel_percentage, anim_delay) {
  assert(isDefined(level.player_rig), "level.player_rig must be defined for anim_lerp_from_player_pos() to work. Try calling link_player_to_rig() before using this function.");
  animation_lerp_from_player_pos_end();
  rig = level.player_rig;
  anim_origin = getstartorigin(self.origin, self.angles, animation);
  anim_angles = getstartangles(self.origin, self.angles, animation);
  rotation = level.player.angles - anim_angles;
  node_origin = level.player.origin + rotatevector(self.origin - anim_origin, rotation);
  node_angles = level.player.angles + self.angles - anim_angles;
  level.lerp_node = spawn_script_origin(node_origin, node_angles);
  level.lerp_node endon("animation_lerp_from_player_pos_end");

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

  assert(move_time <= anim_length + anim_delay, "Parameter move_time must be less than or equal to total anim length");
  level.lerp_node moveTo(self.origin, move_time, move_time * accel_percentage, move_time * (1 - accel_percentage));

  if(!isDefined(rotate_time)) {
    rotate_time = anim_length;
  }

  assert(rotate_time <= anim_length + anim_delay, "Parameter rotate_time must be less than or equal to total anim length");
  level.lerp_node rotateTo(self.angles, rotate_time, rotate_time * accel_percentage, rotate_time * (1 - accel_percentage));

  if(anim_delay > 0) {
    rig.origin = level.player.origin;
  }

  rig linkTo(level.lerp_node);
  wait anim_delay;
}

function animation_lerp_from_player_pos_end() {
  if(isDefined(level.lerp_node)) {
    level.lerp_node notify("animation_lerp_from_player_pos_end");

    if(getdvarint(@ "hash_398da46238160a6", 0) && level.lerp_node.playerstartpos != level.player.origin) {
      draw_arrow_time(level.lerp_node.playerstartpos, level.player.origin, (1, 1, 1), 20);
      print3d(level.lerp_node.playerstartpos + (0, 0, -2), "<dev string:x3f>" + distance2d(level.lerp_node.playerstartpos, level.player.origin), (1, 1, 1), 1, 0.1, 400, 1);
    }

    level.lerp_node delete();
    level.lerp_node = undefined;
  }
}

function player_rig_allow_weapon(rig) {
  player_rig_allow_internal(rig, "weapon");
}

function player_rig_allow_internal(rig, allow_name) {
  assert(isDefined(level.player_rig));
  assert(rig == level.player_rig);
  assert(array_contains(rig.allows, allow_name));
  rig.allows = array_remove(rig.allows, allow_name);
  level.player thread val::set("player_rig", allow_name, 1);
}

function function_98fabc06359d4d0c(anime, stance, arcs, unlinkedents, linkedents, var_ec165a067af34f8f, var_8831fc7320076829, simultaneous, var_26967d556f885965) {
  if(!isDefined(level.player_rig)) {
    get_player_rig();
  }

  if(!isDefined(stance)) {
    stance = "stand";
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

  var_ec165a067af34f8f = ter_op(isDefined(var_ec165a067af34f8f), var_ec165a067af34f8f, 1);
  var_8831fc7320076829 = ter_op(isDefined(var_8831fc7320076829), var_8831fc7320076829, 0);
  simultaneous = ter_op(isDefined(simultaneous), simultaneous, 0);
  newanime = anime;

  if(function_f1e7ee8ddeece062(anime)) {
    animation = function_c099f6fd9c19f5a6(anime, self.origin, self.angles, "player_rig");
    newanime = function_56bd620e57a834af(anime, "player_rig", animation);
  }

  anim_first_frame_solo(level.player_rig, newanime);
  link_player_to_rig(newanime, stance, 0, 0, restrictcamera, arcs[0], arcs[1], arcs[2], arcs[3], 1, undefined, var_26967d556f885965, undefined, 1, var_ec165a067af34f8f, var_8831fc7320076829, simultaneous);
  thread anim_lerp_from_player_pos(newanime, level.blendinfo["blendTime"], level.blendinfo["blendTime"], 0.8, level.blendinfo["weaponDropTime"]);

  if(isDefined(unlinkedents)) {
    foreach(model in unlinkedents) {
      if(level.player_rig == model) {
        unlinkedents = array_remove(unlinkedents, model);
      }
    }
  }

  if(isDefined(linkedents)) {
    foreach(model in linkedents) {
      if(level.player_rig == model) {
        linkedents = array_remove(linkedents, model);
        continue;
      }

      model linkTo(level.lerp_node);
    }
  }

  anim_first_frame(unlinkedents, anime);
  delaythread(level.blendinfo["weaponDropTime"], &anim_single, unlinkedents, anime);
  level.lerp_node anim_first_frame(linkedents, anime);
  level.lerp_node delaythread(level.blendinfo["weaponDropTime"], &anim_single, linkedents, anime);
  wait level.blendinfo["weaponDropTime"];
  level.player_rig notify("link_blend_weapon_dropped");

  if(istrue(var_ec165a067af34f8f) && isDefined(level.blendinfo["blendOutTime"])) {
    level.player delaythread(level.blendinfo["blendOutTime"], &player_gesture_force, "proto_vm_gesture_gun_raise");
  }

  level.player_rig waittill_any("anim_end", "unlink_player");

  if(istrue(var_ec165a067af34f8f) && !isDefined(level.blendinfo["blendOutTime"])) {
    level.player thread player_gesture_force("proto_vm_gesture_gun_raise");
  }
}

function private debug_monitor(display) {
  self notify("<dev string:x52>");
  self endon("<dev string:x52>");
  self endon("<dev string:x60>");

  if(!getdvarint(@ "hash_36a6e170933fe94b", 0)) {
    return;
  }

  while(true) {
    waitframe();
    print3d(self.origin, display + "<dev string:x66>" + self getentitynumber() + "<dev string:x69>" + int(self.origin[0]) + "<dev string:x6c>" + int(self.origin[1]) + "<dev string:x6c>" + int(self.origin[2]) + "<dev string:x6f>", (1, 1, 1), 1, 0.5, 1);
  }
}

# /